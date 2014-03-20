From: "Zhang, Jian" <jian.zhang@intel.com>
Subject: FW: CURSH optimization for unbalanced pg distribution
Date: Thu, 20 Mar 2014 03:54:01 +0000
Message-ID: <51FC7A40FB29414D88A121A7FFEF9A4710DC3018@SHSMSX104.ccr.corp.intel.com>
References: <51FC7A40FB29414D88A121A7FFEF9A4710DC2188@SHSMSX104.ccr.corp.intel.com>
 <53299E33.5060809@inktank.com>
 <alpine.DEB.2.00.1403190814520.316@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17526 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaCTDyG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 23:54:06 -0400
In-Reply-To: <alpine.DEB.2.00.1403190814520.316@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Sage Weil (sage@inktank.com)" <sage@inktank.com>, "Mark Nelson (mark.nelson@inktank.com) (mark.nelson@inktank.com)" <mark.nelson@inktank.com>, "Duan, Jiangang" <jiangang.duan@intel.com>, "Zhang, Jian" <jian.zhang@intel.com>

Forwarding per Sage's suggestion. 


-----Original Message-----
From: Sage Weil [mailto:sage@inktank.com] 
Sent: Wednesday, March 19, 2014 11:29 PM
To: Mark Nelson
Cc: Zhang, Jian; Duan, Jiangang; He, Yujie
Subject: Re: CURSH optimization for unbalanced pg distribution

On Wed, 19 Mar 2014, Mark Nelson wrote:
> On 03/19/2014 03:24 AM, Zhang, Jian wrote:
> > For more detail data, please refer to the *Testing results* part.
> > 
> > *Optimization proposals: *
> > 
> > After we dived into the source code of CRUSH and related papers, we 
> > proposed two possible optimizations:
> > 
> > 1.Add different hash algorithms, as an alternative for the Jenkin's 
> > hash, e.g. algorithm that will produce even values when range of 
> > input value (pg#) is relatively small. Or add new bucket type at the 
> > same time if necessary.

This *might* work, but I don't have a strong intuition about it.  The modeling we've done now has essentially assumed a statistically uniform distribution, which has some inherent inbalance for low values of n (num pgs in our case).  I have generally assumed we can't do better than "random", and still have the other properties we want (independent, deterministic placement), but it may be possible.

> > 
> > 2.Find a better replica placement strategy instead of current retry
> > logic of crush_choose_firstn, which may cause CRUSH to behave badly.
> > 
> > We find there are several threshold of retry times by referring to code,
> > choose_total_tries, choose_local_tries and choose_local_fallback_tries.
> > They are used to decide whether to do a retry_bucket, retry_descent or
> > use permutation to do an exhaustive bucket search. We are wondering if
> > there is another retry strategy:
> > 
> > a)Backtracking retry. Now the logic of crush_choose_firstn can only
> > issue an retry either from the initial bucket(retry_descent) or from the
> > current bucket (retry_bucket), how about retrying the intervening buckets?
> > 
> > b)Adjust threshold of retry times by other values. We do noticed that
> > the 'optimal' crush tunable could be used to make it, but we still
> > encounter unbalanced [g distribution by using the optimal strategy.
> > Please refer to 4 of the Testing results part.
> > 
> > c)Add an mechanism that can adjust above mentioned thresholds
> > adaptively. Maybe we can record the retry times of the previous call for
> > CRUSH, and adjust retry thresholds automatically according to the record.

I suggest ignoring all of this retry logic.  The original version of CRUSH 
has the local retries to try to make data move "less far", but when we 
went back a year ago and did a statistical analysis of the distribution we 
found that *all* of these hacks degraded the quality of the placement,a nd 
by turning them all off (setting the 'optimal' values which zeroes them 
all out excent for total_retries) we got something that was 
indistinguishable from a uniform distribution.

> > 3.Add soft link for pg directories. During pg creation, we can create
> > soft links for the pgs if pg# on the selected osd is more than some
> > threshold, say 10% more than desired average number, to move objects
> > that will be stored in this pg to another osd. Balanced disk utilization
> > may be gained in this way.

I think you need to be careful, but yes, this is an option.  There is a 
similar exception mechanism in place that is used for other purposes and 
something similar could be done here.  The main challenge will be in 
ensuring that the soft links/exceptions follow the same overall policy 
that CRUSH does after the raw mapping is performed.  This is an option, 
but I would put it toward the bottom of the list...

> > 4.Change placement strategy only for step of selecting devices from
> > hosts. We found in our testing results that pg distribution was balanced
> > among hosts, which is reasonable since pg# of each host is above 1K
> > (according to the current BKM that pg# per osd should be about 100). So
> > how about we apply CRUSH only on the interval buckets and find another
> > simple but more balanced method to choose osd from host?

This idea has a lot of potential.  For example:

If you know the chassis can hold 12 disks, you can force the bucket size 
to twelve and somehow prevent users from adjusting the structure of the 
tree.  Then you can use a simple mapping that is truly flat (like a linear 
mapping, disk = x % num_disks) for that bucket/subtree.  The downside of 
course is that if you remove a disk *everything* reshuffles, hence some 
sort of guardrails to prevent a user from inadvertantly doing that.  If a 
disk *does* fail, you just need to make sure the disk is marked "out" but 
not removed from the CRUSH hierarchy and the normal retry will kick in.

Note that all this is reall doing is increasing the size of the "buckets" 
that we are (pseudo)randomly distribution over.  It is still a 
random/uniform distribution, but the N value is 12 times bigger (for a 12 
disk chassis) and as a result the variance is substantially lower.

I would suggest making a new bucket type that is called 'linear' and does 
a simple modulo and trying this out.  We will need a bunch of additional 
safety checks to help users avoid doing silly things (like adjusting the 
number of items in the linear buckets, which reshuffle everything) but 
that wouldn't be needed for an initial analysis of the performance impact.

Do you mind if we shift this thread over to ceph-devel?  I think there are 
lots of people who would be interested in this discussion.  We can of 
course leave off your attachment if you prefer.

Thanks!
sage
