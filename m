From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: Cache tiering slow request issue: currently waiting for rw locks
Date: Fri, 5 Sep 2014 07:20:40 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348938051@SHSMSX101.ccr.corp.intel.com>
References: <06E7D85B3BA36C4DB207FEDE871C53489375E2@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408290717260.28218@cobra.newdream.net>
 <alpine.DEB.2.00.1408291928410.13709@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C53489377A6@SHSMSX101.ccr.corp.intel.com>
 <06E7D85B3BA36C4DB207FEDE871C5348937A78@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5419 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbaIEHVC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Sep 2014 03:21:02 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348937A78@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "'sam.just@inktank.com'" <sam.just@inktank.com>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

I made some comments based on your comments of the pull request https://github.com/ceph/ceph/pull/2374. Can you take a look? Thx.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wang, Zhiqiang
Sent: Tuesday, September 2, 2014 2:54 PM
To: Sage Weil
Cc: 'ceph-devel@vger.kernel.org'
Subject: RE: Cache tiering slow request issue: currently waiting for rw locks

Tried the pull request, checking the object is blocked or not doesn't work. Actually this check is already done in function agent_work.

I tried to make a fix to add a field/flag to the object context. This is not a good idea for the following reasons:
1) If making this filed/flag to be a persistent one, when resetting/clearing this flag, we need to persist it. This is not good for read request.
2) If making this field/flag not to be a persistent one, when the object context is removed from the cache ' object_contexts', this field/flag is removed as well. This object is removed in the later evicting. The same issue still exists.

So, I came up with a fix to add a set in the class ReplicatedPG to hold all the promoting objects. This fix is at https://github.com/ceph/ceph/pull/2374. It is tested and works well. Pls review and comment, thx.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wang, Zhiqiang
Sent: Monday, September 1, 2014 9:33 AM
To: Sage Weil
Cc: 'ceph-devel@vger.kernel.org'
Subject: RE: Cache tiering slow request issue: currently waiting for rw locks

I don't think the object context is blocked at that time. It is un-blocked after the copying of data from base tier. It doesn't address the problem here. Anyway, I'll try it and see.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Saturday, August 30, 2014 10:29 AM
To: Wang, Zhiqiang
Cc: 'ceph-devel@vger.kernel.org'
Subject: Re: Cache tiering slow request issue: currently waiting for rw locks

Hi,

Can you take a look at https://github.com/ceph/ceph/pull/2363 and see if that addresses the behavior you saw?

Thanks!
sage


On Fri, 29 Aug 2014, Sage Weil wrote:

> Hi,
> 
> I've opened http://tracker.ceph.com/issues/9285 to track this.
> 
> I think you're right--we need a check in agent_maybe_evict() that will 
> skip objects that are being promoted.  I suspect a flag on the 
> ObjectContext is enough?
> 
> sage
> 
> 
> On Fri, 29 Aug 2014, Wang, Zhiqiang wrote:
> 
> > Hi all,
> > 
> > I've ran into this slow request issue some time ago. The problem is like this: when running with cache tieing, there are 'slow request' warning messages in the log file like below.
> > 
> > 2014-08-29 10:18:24.669763 7f9b20f1b700  0 log [WRN] : 1 slow 
> > requests, 1 included below; oldest blocked for > 30.996595 secs
> > 2014-08-29 10:18:24.669768 7f9b20f1b700  0 log [WRN] : slow request
> > 30.996595 seconds old, received at 2014-08-29 10:17:53.673142: 
> > osd_op(client.114176.0:144919 rb.0.17f56.6b8b4567.000000000935 
> > [sparse-read 3440640~4096] 45.cf45084b ack+read e26168) v4 currently 
> > waiting for rw locks
> > 
> > Recently I made some changes to the log, captured this problem, and finally figured out its root cause. You can check the attachment for the logs.
> > 
> > Here is the root cause:
> > There is a cache miss when doing read. During promotion, after copying the data from base tier osd, the cache tier primary osd replicates the data to other cache tier osds. Some times this takes quite a long time. During this period of time, the promoted object may be evicted because the cache tier is full. When the primary osd finally gets the replication response and restarts the original read request, it doesn't find the object in the cache tier, and do promotion again. This loops for several times, and we'll see the 'slow request' in the logs. Theoretically, this could loops forever, and the request from the client would never be finished.
> > 
> > There is a simple fix for this:
> > Add a field in the object state, indicating the status of the promotion. It's set to true after the copy of data from base tier and before the replication. It's reset to false after the replication and the original client request starts to execute. Evicting is not allowed when this field is true.
> > 
> > What do you think?
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
