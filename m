From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 15:19:35 -0400
Message-ID: <20160418191934.GC22875@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com>
 <20160418174305.GA22875@ultraspiritum.redhat.com>
 <alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbcDRTTh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Apr 2016 15:19:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 18/04/2016, Sage Weil wrote:
> It seems like the sane way to handle this is pools-per-geopolitcal
> regulatory regime, which is a bounded set.  If it comes down to
> tenant X doesn't like tenant Y (say, coke vs pepsi), it all falls
> apart, because we can quickly run out of possible placements.  It
> kills the logical vs physical (virtualized) placement we have now.
> I suspect the way to deal with coke v pepsi is client-side
> encryption with different keys (that is, encryption above rados).

I'm not sure if that works. I do not play any kind of lawyer on TV. My
understanding is that some regulatory regimes (like HIPAA) enforce a
Coke vs. Pepsi problem against everyone and require the ability to rip
a disk out and shred it. I apologizes if I'm mistaken, but I recall
that being mentioned in a talk at SDC. In that case it seems like the
only thing you'd be able to do is carve up little subclusters for
hospitals or anyone else with similar requirements that they get and
nobody else does.

> Hmm, this is true.  I've been assuming the workload-informed
> placement would be a tier, not something within a pool.  The
> fundamental rados property is that the map is enough to find your
> data... by it's *name*.  The moment the placement depends on who
> wrote 'foo' (and not the name of 'foo') that doesn't work.
>
> Once we move to something where the client decides where to write,
> you have explicit device ids, and some external metadata to track
> that.. and then the cluster can't automatically heal around failures
> or rebalance.

I think this might be an argument for the 'allow lots and lots of
pools' case. That if you assume each tennant owns a given pool, who
wrote it is part of the object 'name' (even if not the object ID) and
can be used to select a set of placement rules.

Adjacent to this, I've thought it would be natural for a placer to
take both the poolid (or maybe a pool specific UUID, something that
might be more robustly permanent) as well as the OID. That way if you
did have a 'lots and lots of pools' case multiple pools using the same
set of rules wouldn't have everything with the same name go to the
same place.

> What do you mean by 'treated as a unit'?

I mean, to be able to address a set of objects as a data set. Right
now I can give pools a name. But pools are heavy and, currently, we
don't want people making more of them. If I'm an auto company I might
have several datasets I'm interested in like CurrentOrders
PastAccounts PossiblySillyPlan. Even if they all have exactly the same
placement, I would like to be able to enumerate PastAccounts and get
all the objects or decide PossiblySillyPlan is DefinitelySilly and
delete all the objects by just that name or, if I had some other Ceph
cluster, to have a management tool that would allow me to copy the
'PastAccounts' dataset into another cluster.

These are all things Pools can do now, except we don't want people
creating too many pools.

I think a natural way to solve this problem might be to take all the
placement/erasureCoding configuration of a pool out of the pool and
make it a PoolClass or PoolType and then make lots of pools each of
which just references a PoolClass or PoolType. Especially if you
combine it with the idea above of having a pool identifier get fed
into your placer.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
