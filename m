From: Sage Weil <sage@newdream.net>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 14:33:33 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com> <20160418174305.GA22875@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57053 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbcDRSdd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 14:33:33 -0400
In-Reply-To: <20160418174305.GA22875@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, 18 Apr 2016, Adam C. Emerson wrote:
> On 18/04/2016, Sage Weil wrote:
> > On Fri, 15 Apr 2016, Adam C. Emerson wrote: I'm not sure I'm
> > convinced.  The mon is doing way more than it should right now, but
> > we are about to rip all/most of the PGMonitor work out of ceph-mon
> > and move it into ceph-mgr. At that point, the OSDMap is a pretty
> > small burden for the mon to manage.  Even if we have clusters that
> > are 2 orders of magnitude larger (100,000 OSDs), that's maybe a
> > 100MB data structure at most.  Why do we need to partition it?
> 
> Clients keeping 100MB of state just to talk to the cluster seems a bit
> much to me, especially if we ever want anything embedded to be able to
> use it.

Fair enough
 
> Also, it's not just the size. One worry is how well the monitor will
> be able to hold up if we have a bunch of OSDs going up and down at a
> fast rate (which becomes a bit more likely the bigger our clusters get.)

but this bit at least I don't worry about much.  The only piece that does 
worry me is the newish feature where the mon is calculating all mappings 
to prime the pg_temp mappings, but this is trivially parallel: I think we 
can leverage many cores here (vs doing the signle-threaded loop we do 
now).

> > I get that pools are heavyweight, but I think that derivse from the
> > fact that it is a *placement* function, and we *want* placement to
> > be an administrative property, not a tentant/user property that can
> > proliferate.  Placement should depend on the hardware that comprises
> > the cluster, and that doesn't change so quickly, and the scale does
> > not change quickly.  Tenants want to create their own workspaces to
> > do their thing, but I think needs to remain a slice within the
> > existing placement primitives so they do't have direct control.
> > e.g., rados namespaces, or something more powerful if we need it,
> > because we'll have anywhere from 1 tenant to a million tenants, and
> > we can't have them spamming the cluster placement topology.
> >
> > At least, I think that's true on the OSD side of things.  On the
> > client side, might make sense to limit the client's view to certain
> > pools.  Maybe.
> >
> > Anyway, assuming we have some tenant primitive (like namespace slice
> > of a pool), I don't see the motivation for the huge complexity of
> > breaking apart OSDMap.  What am I missing?
> 
> Three things, I think. Please tell me if I'm missing anything obvious
> or getting anything wrong.
> 
> First, the gigantic bullsey intersection between tennancy and
> placement would be cases where regulatory regimes or contracts require
> isolation. (The whole "My data can't be stored on the same disk as
> anyone else's data." thing.)

It seems like the sane way to handle this is pools-per-geopolitcal 
regulatory regime, which is a bounded set.  If it comes down to tenant X 
doesn't like tenant Y (say, coke vs pepsi), it all falls apart, because we 
can quickly run out of possible placements.  It kills the logical vs 
physical (virtualized) placement we have now.  I suspect the way to deal 
with coke v pepsi is client-side encryption with different keys (that is, 
encryption above rados).
 
> Second, I've always been working under the assumption that placement
> is a function of workload as well as hardware. At least there's a lot
> of interesting space in the 'placement function choice'/'workload
> optimization' intersection.

Hmm, this is true.  I've been assuming the workload-informed placement  
would be a tier, not something within a pool.  The fundamental rados 
property is that the map is enough to find your data... by it's *name*.  
The moment the placement depends on who wrote 'foo' (and not the name of 
'foo') that doesn't work.

Once we move to something where the client decides where to write, you 
have explicit device ids, and some external metadata to track that.. and 
then the cluster can't automatically heal around failures or rebalance.

> Third, I think Namespaces and Pools as you describe them miss a
> piece. Users almost always want to be able to make collections of
> objects that can be treated like a unit. Sure, RADOSGW can make
> buckets, but I don't think we want to base the fundamental design of
> our system around the idea that people will be using legacy protocols
> like S3.

What do you mean by 'treated as a unit'?

sage
