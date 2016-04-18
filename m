From: Sage Weil <sage@newdream.net>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 16:27:52 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604181617270.4797@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com> <20160418174305.GA22875@ultraspiritum.redhat.com> <alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com> <387701643.14364473.1461009721370.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57959 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcDRU1w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 16:27:52 -0400
In-Reply-To: <387701643.14364473.1461009721370.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, 18 Apr 2016, Matt Benjamin wrote:
> ----- Original Message -----
> 
> > > Second, I've always been working under the assumption that placement
> > > is a function of workload as well as hardware. At least there's a lot
> > > of interesting space in the 'placement function choice'/'workload
> > > optimization' intersection.
> 
> A lot of the CohortFS work after incorporating Ceph was indeed about 
> adapting Ceph abstractions to provide first-class support for workload 
> and tenant isolation, it is for me difficult to imagine not needing this 
> in a system that addresses the problems Ceph does, at the intended 
> scale.
> 
> > 
> > Hmm, this is true.  I've been assuming the workload-informed placement
> > would be a tier, not something within a pool.  The fundamental rados
> > property is that the map is enough to find your data... by it's *name*.
> > The moment the placement depends on who wrote 'foo' (and not the name of
> > 'foo') that doesn't work.
> 
> Tiers are great, but they represent another compositional primitive, not
> an alternative to an ability to fundamentally construct the data/server
> aggregate 

I keep getting stuck on something here, I think, that is keeping me from 
following the logic.  Maybe someone else can tell what it is?

I think I understand what you mean by 'fundamentally construct teh 
data/server aggregate'.  Maybe you want distributed replicated globally 
shared foo.  Maybe you want low-latency immutable bar (new pool type).  
But maybe you want more direct layout control over these 16 nvme cards 
over here, and the ability to define a tenant policy that let's me use it.  
Part of me thinks if you want direct control over layout, don't use 
ceph--just access those cards directly (stripe with dm or something).  But 
maybe you do want global/shared access.  In that case, you want Ceph 
involved.  If you want isolation but shared access, pools are fine--we are 
talking about hardware and are O(size of cluster).  If you are O(tenants), 
you can't have hardware-level isolation, and namespaces work.

Maybe my hang-up is that you're thinking about things that aren't shared, 
or aren't redundant (e.g., this locally attached nvme card on a client 
node)?  Or maybe we're missing a portable abstraction for a local-y thing.  
Like, I am a user on host A and want local-dataset-A on this local nvme.  
But if I move, I want to seamlessly migrate that dataset to my new host B.  
That we can't do.. because it means *global* naming/indirection for a 
per-tenant thing.  If we have a small enough number of tenants that we can 
use a pool, all is well.  But if we want man tenants to be able to do 
this, namespaces in their current form aren't sufficient.

> In addition to workload, there is isolation.  While geopolitical/regulatory
> scale segregation is important in cloud, more fine-grained isolation of
> all different kinds is important for policy contorl within data centers.

Again, it *seems* like the isolation you're talking about is 
hardware-level, which is O(size of cluster), and can be addressed by 
pools.  Beyond that, we also want *virtual isolation* (i.e., QoS), which 
we'll be tackling with something like dmclock.

Maybe a concrete example of how one might 'fundamentally construct a 
data/server aggregate' would be helpful?

Not trying to be difficult, just trying to understand the what and why.

Thanks!
sage
