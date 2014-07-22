From: Alex Elsayed <eternaleye@gmail.com>
Subject: RE: Cache tiering read-proxy mode
Date: Tue, 22 Jul 2014 15:50:33 -0700
Message-ID: <lqmprr$glk$1@ger.gmane.org>
References: <06E7D85B3BA36C4DB207FEDE871C534891BC27@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1407180707310.28285@cobra.newdream.net> <06E7D85B3BA36C4DB207FEDE871C534891CD56@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1407201831340.28285@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38283 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbaGVWzH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jul 2014 18:55:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1X9ixc-00041w-U3
	for ceph-devel@vger.kernel.org; Wed, 23 Jul 2014 00:55:04 +0200
Received: from 50.245.141.77 ([50.245.141.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jul 2014 00:55:04 +0200
Received: from eternaleye by 50.245.141.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jul 2014 00:55:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

> [Adding ceph-devel]
> 
> On Mon, 21 Jul 2014, Wang, Zhiqiang wrote:
>> Sage,
>> 
>> I agree with you that promotion on the 2nd read could improve cache
>> tiering's performance for some kinds of workloads. The general idea here
>> is to implement some kinds of policies in the cache tier to measure the
>> warmness of the data. If the cache tier is aware of the data warmness,
>> it could even initiate data movement between the cache tier and the base
>> tier. This means data could be prefetched into the cache tier before
>> reading or writing. But I think this is something we could do in the
>> future.
> 
> Yeah. I suspect it will be challenging to put this sort of prefetching
> intelligence directly into the OSDs, though.  It could possibly be done by
> an external agent, maybe, or could be driven by explicit hints from
> clients ("I will probably access this data soon").
> 
>> The 'promotion on 2nd read' policy is straightforward. Sure it will
>> benefit some kinds of workload, but not all. If it is implemented as a
>> cache tier option, the user needs to decide to turn it on or not. But
>> I'm afraid most of the users don't have the idea of this. This increases
>> the difficulty of using cache tiering.
> 
> I suspect the 2nd read behavior will be something we'll want to do by
> default...  but yeah, there will be a new pool option (or options) that
> controls the behavior.
> 
>> One question for the implementation of 'promotion on 2nd read': what do
>> we do for the 1st read? Does the cache tier read the object from base
>> tier but not doing replication, or just redirecting it?
> 
> For the first read, we just redirect the client.  The on the second read,
> we call promote_object().  See maybe_handle_cache() in ReplicatedPG.cc.
> We can pretty easily tell the difference by checking the in-memory HitSet
> for a match.
> 
> Perhaps the option in the pool would be something like
> min_read_recency_for_promote?  If we measure "recency" as "(avg) seconds
> since last access" (loosely), 0 would mean it would promote on first read,
> and anything <= the HitSet interval would mean promote if the object is in
> the current HitSet.  > than that would mean we'd need to keep additional
> previous HitSets in RAM.
> 
> ...which leads us to a separate question of how to describe access
> frequency vs recency.  We keep N HitSets, each covering a time period of T
> seconds.  Normally we only keep the most recent HitSet in memory, unless
> the agent is active (flushing data).  So what I described above is
> checking how recently the last access was (within how many multiples of T
> seconds).  Additionally, though, we could describe the frequency of
> access: was the object accesssed at least once in every N interval of T
> seconds?  Or some fraction of them?  That is probably best described as
> "temperature?"  I'm not to fond of the term "recency," tho I can't
> think of anything better right now.
> 
> Anyway, for the read promote behavior, recency is probably sufficient, but
> for the tiering agent flush/evict behavior temperature might be a good
> thing to consider...
> 
> sage

It might be worth looking at the MQ (Multi-Queue) caching policy[1], which 
was explicitly designed for second-level caches (which applies here) - the 
client is very likely to be doing caching, whether they use CephFS 
(FSCache), RBD (client caching), or RADOS (application-level); that causes 
some interesting changes in terms of the statistical behavior of the second-
level cache.

[1] 
https://www.usenix.org/legacy/event/usenix01/full_papers/zhou/zhou_html/node9.html

