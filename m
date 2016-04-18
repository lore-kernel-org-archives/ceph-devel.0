From: Sage Weil <sage@newdream.net>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 15:53:46 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604181542340.4797@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com> <20160418174305.GA22875@ultraspiritum.redhat.com> <alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com> <20160418191934.GC22875@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57730 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbcDRTxr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 15:53:47 -0400
In-Reply-To: <20160418191934.GC22875@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, 18 Apr 2016, Adam C. Emerson wrote:
> On 18/04/2016, Sage Weil wrote:
> > It seems like the sane way to handle this is pools-per-geopolitcal
> > regulatory regime, which is a bounded set.  If it comes down to
> > tenant X doesn't like tenant Y (say, coke vs pepsi), it all falls
> > apart, because we can quickly run out of possible placements.  It
> > kills the logical vs physical (virtualized) placement we have now.
> > I suspect the way to deal with coke v pepsi is client-side
> > encryption with different keys (that is, encryption above rados).
> 
> I'm not sure if that works. I do not play any kind of lawyer on TV. My
> understanding is that some regulatory regimes (like HIPAA) enforce a
> Coke vs. Pepsi problem against everyone and require the ability to rip
> a disk out and shred it. I apologizes if I'm mistaken, but I recall
> that being mentioned in a talk at SDC. In that case it seems like the
> only thing you'd be able to do is carve up little subclusters for
> hospitals or anyone else with similar requirements that they get and
> nobody else does.

I guess if you have a tenant with a hardware-level requirement (i.e., I 
must have dedicated disks), then the number of such tenants is bounded by 
the scale of your cluster (in terms of disks), and using pools (as they 
exist now) is fine.

> > Hmm, this is true.  I've been assuming the workload-informed
> > placement would be a tier, not something within a pool.  The
> > fundamental rados property is that the map is enough to find your
> > data... by it's *name*.  The moment the placement depends on who
> > wrote 'foo' (and not the name of 'foo') that doesn't work.
> >
> > Once we move to something where the client decides where to write,
> > you have explicit device ids, and some external metadata to track
> > that.. and then the cluster can't automatically heal around failures
> > or rebalance.
> 
> I think this might be an argument for the 'allow lots and lots of
> pools' case. That if you assume each tennant owns a given pool, who
> wrote it is part of the object 'name' (even if not the object ID) and
> can be used to select a set of placement rules.

If it's part of the name, it can be part of the pool too.  I.e., little 
real difference between <pool=foo object=bar> and <pool=overhere 
object=foo/bar>.  Except that you can't migrate the user to pool=overthere 
independently... that requires per-tenant metadata at the clsuter level, 
which is exactly what we want to avoid.

Unless.. we really flip things around and make the mapping process 
non-atomic.  Right now if I have OSDMap I can map anything.  If OSDMap 
were just the root of a process that may require multiple network 
lookups and indirections to get to something that will let me find my 
data, then that is a whole 'nother thing.  Do we want to go there?

> Adjacent to this, I've thought it would be natural for a placer to
> take both the poolid (or maybe a pool specific UUID, something that
> might be more robustly permanent) as well as the OID. That way if you
> did have a 'lots and lots of pools' case multiple pools using the same
> set of rules wouldn't have everything with the same name go to the
> same place.
> 
> > What do you mean by 'treated as a unit'?
> 
> I mean, to be able to address a set of objects as a data set. Right
> now I can give pools a name. But pools are heavy and, currently, we
> don't want people making more of them. If I'm an auto company I might
> have several datasets I'm interested in like CurrentOrders
> PastAccounts PossiblySillyPlan. Even if they all have exactly the same
> placement, I would like to be able to enumerate PastAccounts and get
> all the objects or decide PossiblySillyPlan is DefinitelySilly and
> delete all the objects by just that name or, if I had some other Ceph
> cluster, to have a management tool that would allow me to copy the
> 'PastAccounts' dataset into another cluster.
> 
> These are all things Pools can do now, except we don't want people
> creating too many pools.

Pool namespaces can do all of these things too.  The only thing you 
*can't* do with namespaces is enumerate them (natively).  I.e., there 
isn't a registry of namespaces.  Any namespace consumer can do that on its 
own, or we could cooperatively maintain a namespace registry in rados 
somewhere, but, again, we don't have global per-tenant (i.e. 
per-namespace) metadata in the OSDMap, so they don't have to be 'created' 
before being used.

The other main namespace limitation is that enumerating objects within a 
namespace is O(size of pool) not O(size of namespace).  I still think this 
is okay, given that rados enumeration tends to be an administrative 
action.  We could add some additional metadata to the ObjectStore backend 
to accellerate this, though, if we changed our mind.

> I think a natural way to solve this problem might be to take all the
> placement/erasureCoding configuration of a pool out of the pool and
> make it a PoolClass or PoolType and then make lots of pools each of
> which just references a PoolClass or PoolType. Especially if you
> combine it with the idea above of having a pool identifier get fed
> into your placer.

This... is sort of what pools and namespaces do now, except that a 
namepsace isn't created or destroy and doesn't have properties.  Which is 
what we need (from an OSDMap perspective) in order to avoid bounding the 
number of tenants.

Are there properties/capabilities that we're missing?

sage
