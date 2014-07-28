From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: Cache tiering read-proxy mode
Date: Mon, 28 Jul 2014 07:35:03 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C534891D764@SHSMSX101.ccr.corp.intel.com>
References: <06E7D85B3BA36C4DB207FEDE871C534891BC27@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1407180707310.28285@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C534891CD56@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1407201831340.28285@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C534891CDD2@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1407202051490.28285@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C534891CE44@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1407210715230.28285@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C534891D15F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13369 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbaG1Hf2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 03:35:28 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C534891D15F@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Sage Weil' <sweil@redhat.com>
Cc: "Zhang, Jian" <jian.zhang@intel.com>, "'icolle@redhat.com'" <icolle@redhat.com>, "'sam.just@inktank.com'" <sam.just@inktank.com>, "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

Hi Sage,

I made this change in https://github.com/wonzhq/ceph/commit/924e418abb831338e2df7f4a4ec9409b02ee5524 and unit tested it. Could you take a review and give comments? Thanks.

-----Original Message-----
From: Wang, Zhiqiang 
Sent: Tuesday, July 22, 2014 9:38 AM
To: Sage Weil
Cc: Zhang, Jian; icolle@redhat.com; sam.just@inktank.com; ceph-devel@vger.kernel.org
Subject: RE: Cache tiering read-proxy mode

Since we can't be accurate at the seconds level, how about making the min_read_recency_for_promote option as the number of 'hit set intervals' instead of number of seconds? So that, when min_read_recency_for_promote is
1) 0, promotion on first read
2) 1, promotion on second read, checking only the current hit set
3) any other number, promotion on second read, keep this number (including the current one) of hit sets in memory, checking object existence in these hit sets regardless of hit set rotation

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Monday, July 21, 2014 10:20 PM
To: Wang, Zhiqiang
Cc: Zhang, Jian; icolle@redhat.com; sam.just@inktank.com; ceph-devel@vger.kernel.org
Subject: RE: Cache tiering read-proxy mode

On Mon, 21 Jul 2014, Wang, Zhiqiang wrote:
> In the current code, when the evict mode is idle, we just keep the 
> current hit set in memory. All the other hit sets (hit_set_count-1) 
> are on disks. And when the evict mode is not idle, all the hit sets 
> are loaded into memory. When the current hit set is full or exceeds 
> its interval, it is persisted to disk. A new hit set is created to act 
> as the current and the oldest is removed from disk.
> 
> So, if we introduce the min_read_recency_for_promote option, say the 
> user sets its value to 200, and the value of 'hit set interval' to 60, 
> does it mean we need to always keep 200/60+1=4 latest hit sets in 
> memory (Assuming 'hit set count' is greater than 4, number of 'hit set count'
> if not), even if the evict mode is idle? And when persisting the 
> current hit set, it is still kept in memory, but the oldest in-memory 
> hit set is removed from memory?

Exactly.  We can probably just make helper that loads these into memory for the tiering agent sufficiently generic (if it isn't already) so that it keeps the right number of them in memory when the agent is inactive.

> Btw, I don't quite get what you said on the normal hit set rotation part.

If we set the tunable to, say, one hour, and the HitSet interval is also an hour, then does this mean we always have 2 HitSet's in RAM, so that we cover *at least* an hour while the newest is being populated?  If we decide to check the first and second HitSets, then we are actually covering up to double the configured period.

sage


> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Monday, July 21, 2014 11:55 AM
> To: Wang, Zhiqiang
> Cc: Zhang, Jian; icolle@redhat.com; sam.just@inktank.com; 
> ceph-devel@vger.kernel.org
> Subject: RE: Cache tiering read-proxy mode
> 
> On Mon, 21 Jul 2014, Wang, Zhiqiang wrote:
> > For the min_read_recency_for_promote option, it's easy to understand 
> > the '0' and '<= hit set interval' cases. But for the '> hit set interval'
> > case, do you mean we always keep all the hit sets in RAM and check 
> > for the object's existence in all of them, or just load all the hit 
> > sets and check for object existence before the read? In another 
> > word, when min_read_recency_for_promote is greater than 'hit set 
> > interval', we always keep all the hit sets in RAM?
> 
> I'm thinking we would keep any many HitSets as are needed to cover whatever the configured interval is.  Setting the option to the same value as the hitset interval (or just '1'?) would be the simplest thing, and probably the default?
> 
> We would need to decide what behavior we want with respect to the normal HitSet rotation, though.  If they each cover, say, one hour, then on average they will half of that, and sometimes almost no time at all (if they just rotated).  So probably we'd want to keep the next-most-recent in memory for some period?  It'll always be a bit imprecise, though, but hopefully it won't really matter...
> 
> sage
> 
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Monday, July 21, 2014 9:44 AM
> > To: Wang, Zhiqiang
> > Cc: Zhang, Jian; icolle@redhat.com; sam.just@inktank.com; 
> > ceph-devel@vger.kernel.org
> > Subject: RE: Cache tiering read-proxy mode
> > 
> > [Adding ceph-devel]
> > 
> > On Mon, 21 Jul 2014, Wang, Zhiqiang wrote:
> > > Sage,
> > > 
> > > I agree with you that promotion on the 2nd read could improve 
> > > cache tiering's performance for some kinds of workloads. The 
> > > general idea here is to implement some kinds of policies in the 
> > > cache tier to measure the warmness of the data. If the cache tier 
> > > is aware of the data warmness, it could even initiate data 
> > > movement between the cache tier and the base tier. This means data 
> > > could be prefetched into the cache tier before reading or writing.
> > > But I think this is something we could do in the future.
> > 
> > Yeah. I suspect it will be challenging to put this sort of prefetching intelligence directly into the OSDs, though.  It could possibly be done by an external agent, maybe, or could be driven by explicit hints from clients ("I will probably access this data soon").
> > 
> > > The 'promotion on 2nd read' policy is straightforward. Sure it 
> > > will benefit some kinds of workload, but not all. If it is 
> > > implemented as a cache tier option, the user needs to decide to 
> > > turn it on or not. But I'm afraid most of the users don't have the 
> > > idea of this. This increases the difficulty of using cache tiering.
> > 
> > I suspect the 2nd read behavior will be something we'll want to do by default...  but yeah, there will be a new pool option (or options) that controls the behavior.
> > 
> > > One question for the implementation of 'promotion on 2nd read': 
> > > what do we do for the 1st read? Does the cache tier read the 
> > > object from base tier but not doing replication, or just redirecting it?
> > 
> > For the first read, we just redirect the client.  The on the second read, we call promote_object().  See maybe_handle_cache() in ReplicatedPG.cc.  
> > We can pretty easily tell the difference by checking the in-memory HitSet for a match.
> > 
> > Perhaps the option in the pool would be something like min_read_recency_for_promote?  If we measure "recency" as "(avg) seconds since last access" (loosely), 0 would mean it would promote on first read, and anything <= the HitSet interval would mean promote if the object is in the current HitSet.  > than that would mean we'd need to keep additional previous HitSets in RAM.
> > 
> > ...which leads us to a separate question of how to describe access 
> > frequency vs recency.  We keep N HitSets, each covering a time 
> > period of T seconds.  Normally we only keep the most recent HitSet 
> > in memory, unless the agent is active (flushing data).  So what I 
> > described above is checking how recently the last access was (within 
> > how many multiples of T seconds).  Additionally, though, we could 
> > describe the frequency of
> > access: was the object accesssed at least once in every N interval of T seconds?  Or some fraction of them?  That is probably best described as "temperature?"  I'm not to fond of the term "recency," tho I can't think of anything better right now.
> > 
> > Anyway, for the read promote behavior, recency is probably sufficient, but for the tiering agent flush/evict behavior temperature might be a good thing to consider...
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
