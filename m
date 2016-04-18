From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 21:30:14 +0200
Message-ID: <CAOi1vP_vdFj1a7cO+WPuP+PKHNK76LzOac3KguowFsh3K7XxnQ@mail.gmail.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com>
	<20160418174305.GA22875@ultraspiritum.redhat.com>
	<alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com>
	<20160418191934.GC22875@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33766 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbcDRTaQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 15:30:16 -0400
Received: by mail-lf0-f54.google.com with SMTP id e190so229295881lfe.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 12:30:15 -0700 (PDT)
In-Reply-To: <20160418191934.GC22875@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, Apr 18, 2016 at 9:19 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 18/04/2016, Sage Weil wrote:
>> It seems like the sane way to handle this is pools-per-geopolitcal
>> regulatory regime, which is a bounded set.  If it comes down to
>> tenant X doesn't like tenant Y (say, coke vs pepsi), it all falls
>> apart, because we can quickly run out of possible placements.  It
>> kills the logical vs physical (virtualized) placement we have now.
>> I suspect the way to deal with coke v pepsi is client-side
>> encryption with different keys (that is, encryption above rados).
>
> I'm not sure if that works. I do not play any kind of lawyer on TV. My
> understanding is that some regulatory regimes (like HIPAA) enforce a
> Coke vs. Pepsi problem against everyone and require the ability to rip
> a disk out and shred it. I apologizes if I'm mistaken, but I recall
> that being mentioned in a talk at SDC. In that case it seems like the
> only thing you'd be able to do is carve up little subclusters for
> hospitals or anyone else with similar requirements that they get and
> nobody else does.
>
>> Hmm, this is true.  I've been assuming the workload-informed
>> placement would be a tier, not something within a pool.  The
>> fundamental rados property is that the map is enough to find your
>> data... by it's *name*.  The moment the placement depends on who
>> wrote 'foo' (and not the name of 'foo') that doesn't work.
>>
>> Once we move to something where the client decides where to write,
>> you have explicit device ids, and some external metadata to track
>> that.. and then the cluster can't automatically heal around failures
>> or rebalance.
>
> I think this might be an argument for the 'allow lots and lots of
> pools' case. That if you assume each tennant owns a given pool, who
> wrote it is part of the object 'name' (even if not the object ID) and
> can be used to select a set of placement rules.
>
> Adjacent to this, I've thought it would be natural for a placer to
> take both the poolid (or maybe a pool specific UUID, something that
> might be more robustly permanent) as well as the OID. That way if you
> did have a 'lots and lots of pools' case multiple pools using the same
> set of rules wouldn't have everything with the same name go to the
> same place.

It already does?  pg id is a function of both the hash and pool id.

hash(object_name) % pg_num -> ps ("placement seed")
(ps, poolid) -> pgid (hashpspool or ps+poolid)
crush(pgid) -> [set of osds]

Thanks,

                Ilya
