From: Mark Nelson <mnelson@redhat.com>
Subject: Re: hashing variation in rados bench runs
Date: Mon, 20 Apr 2015 08:15:29 -0500
Message-ID: <5534FBF1.5050909@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166429CD5@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43905 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbbDTNPh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Apr 2015 09:15:37 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166429CD5@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/20/2015 07:37 AM, Deneau, Tom wrote:
> I have been trying to run rados bench runs and I've noticed a lot of variations from run to run.
> The runs generally write data with --no-cleanup then read it back (seq), dropping the caches in between
> I admit this is on a single node "cluster" with 5 data disks so maybe not realistic but...
>
> In my runs I also collect disk activity traces.  When I look at the seq read scores, I've noticed
> the low scoring runs always have a "hot" disk which maxes out while others might be at 30% to 40% usage.
> Whereas in the high scoring runs the disk activity is much more evenly distributed.
> I realize the hashing of objects to primary osds depends on the object names which are different for each run
> (in rados bench, the object names include the pid).  But I was surprised at the sometimes marked unevenness
> in the hashing.
>
> Have others seen this and is there a good workaround?

So I'd start by narrowing down why that one disk is hot.  First step is 
to just look at the amount of data on the disks and see if that one disk 
has a lot more than the others.  Next might be to try our pool 
distribution quality script and see how the PG distribution looks:

https://github.com/ceph/cbt/blob/master/tools/readpgdump.py

run it like:

ceph pg dump | ./readpgdump.py

That will give you a ton of statistics on pool distribution quality and 
possible OSD weighting strategies.

Beyond that, like you said there is some inherent randomness not just in 
the PG distribution but in the way that objects are distributed to PGs. 
  There is a test that would be very interesting to do but I'm not sure 
anyone has done it yet for crush/straw.  Basically the idea is that if 
you have very similar names for objects with only 1 input bit flipped, 
how does the mapping change.  IE say you have objects with names 
[object1,object2,object3...objectN].  Even if the distribution is random 
for inputs up to N, how much clumpiness is there as you iterate over 
objects within the distribution?  This kind of testing is often done for 
hashing algorithms and folks have done it for Jenkins, but it might be 
nice to see something like this repeated for Ceph/Crush.

Beyond that, there's also the concern that at the OS or even hardware 
level there is some contention for IOs as request come in for multiple 
disks that could cause some to end up waiting more than others.  We've 
seen this with network gear, and suspect we've seen it with disks on SAS 
expander backplanes, especially with SATA drives mixed in.  On the other 
hand we've seen setups that work well too so there's no easy answer.

Mark

>
> -- Tom Deneau, AMD
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
