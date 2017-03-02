From: Tiger Hu <hufh2004@gmail.com>
Subject: Re: explicitly mapping pgs in OSDMap
Date: Fri, 3 Mar 2017 03:40:57 +0800
Message-ID: <E308F5C0-6058-4446-AFEA-8B7E680D7CE5@gmail.com>
References: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal> <362CBE0D-E1C6-4068-92AE-62CF5EDD836D@TERADATA.COM> <alpine.DEB.2.11.1703021737440.651@piezo.novalocal> <F6F90D3B-5362-48D1-B786-2191E5B98331@gmail.com> <alpine.DEB.2.11.1703021804520.651@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35371 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdCBUKj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 15:10:39 -0500
Received: by mail-oi0-f68.google.com with SMTP id x195so1944923oia.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 12:10:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1703021804520.651@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,

Thanks for your reply. Looking forward to explicit mapping.

Tiger
> =D4=DA 2017=C4=EA3=D4=C23=C8=D5=A3=AC=C9=CF=CE=E72:09=A3=ACSage Weil =
<sweil@redhat.com> =D0=B4=B5=C0=A3=BA
>=20
> On Fri, 3 Mar 2017, Tiger Hu wrote:
>> Hi Sage,
>> I am very glad to know you raised this issue. In some cases, user may =
want
>> to accurately control the PG numbers in every OSDs. Is it possible to
>> add/implement a new policy to support fixed-mapping? This may be =
useful for
>> performance tuning or test purpose. Thanks.
>=20
> In principle this could be used to map every pg explicitly without =
regard=20
> for CRUSH.  In think in practice, though, we can have CRUSH map 80-90% =
of=20
> the PGs, and then have explicit mappings for 10-20% in order to =
achieve=20
> the same "perfect" balance of PGs.
>=20
> The result is a smaller OSDMap.  It might not matter that much for =
small=20
> clusters, but for large clusters, it is helpful to keep the OSDMap =
small.
>=20
> OTOH, maybe through all of this we end up in a place where the OSDMap =
is=20
> just an explicit map and the mgr agent that's managing it is using =
CRUSH=20
> to generate it; who knows!  That might make for faster mappings on the=20=

> clients since it's a table lookup instead of a mapping calculation.
>=20
> I'm thinking that if we implement the ability to have the explicit=20
> mappings in the OSDMap we open up both possibilities.  The hard part =
is=20
> always getting the mapping compatbility into the client, so if we do =
that=20
> right, luminous+ clients will support explicit mapping (overrides) in=20=

> OSDMap and would be able to work with future versions that go all-in =
on=20
> explicit...
>=20
> sage
>=20
>=20
>>=20
>> Tiger
>>      =D4=DA 2017=C4=EA3=D4=C23=C8=D5=A3=AC=C9=CF=CE=E71:40=A3=ACSage =
Weil <sweil@redhat.com> =D0=B4=B5=C0=A3=BA
>>=20
>> On Thu, 2 Mar 2017, Kamble, Nitin A wrote:
>>      Hi Sage,
>>       The crush algorithm handles mapping of pgs, and it will
>>      even with the
>>      addition of explicit mappings. I presume, finding which
>>      pgs belong to
>>      which OSDs will involve addition computation for each
>>      additional
>>      explicit mapping.=20
>>=20
>>      What would be penalty of this additional computation?=20
>>=20
>>      For small number of explicit mappings such penalty would
>>      be small,=20
>>      IMO it can get quite expensive with large number of
>>      explicit mappings.
>>      The implementation will need to manage the count of
>>      explicit mappings,
>>      by reverting some of the explicit mappings as the
>>      distribution changes.
>>      The understanding of additional overhead of the explicit
>>      mappings would
>>      had great influence on the implementation.
>>=20
>>=20
>> Yeah, we'll want to be careful with the implementation, e.g., by =
using
>> an=20
>> unordered_map (hash table) for looking up the mappings (an rbtree
>> won't=20
>> scale particularly well).
>>=20
>> Note that pg_temp is already a map<pg_t,vector<int>> and can get big
>> when=20
>> you're doing a lot of rebalancing, resulting on O(log n) lookups.  If
>> we=20
>> do something optimized here we should use the same strategy for
>> pg_temp=20
>> too.
>>=20
>> sage
>>=20
>>=20
>>=20
>>      Nitin
>>=20
>>=20
>>=20
>>=20
>>      On 3/1/17, 11:44 AM, "ceph-devel-owner@vger.kernel.org on
>>      behalf of Sage Weil" <ceph-devel-owner@vger.kernel.org on
>>      behalf of sweil@redhat.com> wrote:
>>=20
>>         There's been a longstanding desire to improve the
>>      balance of PGs and data=20
>>         across OSDs to better utilize storage and balance
>>      workload.  We had a few=20
>>         ideas about this in a meeting last week and I wrote up
>>      a summary/proposal=20
>>         here:
>>=20
>>          http://pad.ceph.com/p/osdmap-explicit-mapping
>>=20
>>         The basic idea is to have the ability to explicitly map
>>      individual PGs=20
>>         to certain OSDs so that we can move PGs from overfull
>>      to underfull=20
>>         devices.  The idea is that the mon or mgr would do this
>>      based on some=20
>>         heuristics or policy and should result in a better
>>      distribution than teh=20
>>         current osd weight adjustments we make now with
>>      reweight-by-utilization.
>>=20
>>         The other key property is that one reason why we need
>>      as many PGs as we do=20
>>         now is to get a good balance; if we can remap some of
>>      them explicitly, we=20
>>         can get a better balance with fewer.  In essense, CRUSH
>>      gives an=20
>>         approximate distribution, and then we correct to make
>>      it perfect (or close=20
>>         to it).
>>=20
>>         The main challenge is less about figuring out when/how
>>      to remap PGs to=20
>>         correct balance, but figuring out when to remove those
>>      remappings after=20
>>         CRUSH map changes.  Some simple greedy strategies are
>>      obvious starting=20
>>         points (e.g., to move PGs off OSD X, first adjust or
>>      remove existing remap=20
>>         entries targetting OSD X before adding new ones), but
>>      there are a few=20
>>         ways we could structure the remap entries themselves so
>>      that they=20
>>         more gracefully disappear after a change.
>>=20
>>         For example, a remap entry might move a PG from OSD A
>>      to B if it maps to=20
>>         A; if the CRUSH topology changes and the PG no longer
>>      maps to A, the entry=20
>>         would be removed or ignored.  There are a few ways to
>>      do this in the pad;=20
>>         I'm sure there are other options.
>>=20
>>         I put this on the agenda for CDM tonight.  If anyone
>>      has any other ideas=20
>>         about this we'd love to hear them!
>>=20
>>         sage
>>         --
>>         To unsubscribe from this list: send the line
>>      "unsubscribe ceph-devel" in
>>         the body of a message to majordomo@vger.kernel.org
>>         More majordomo info at
>>       http://vger.kernel.org/majordomo-info.html
>>=20
>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>>=20
>>=20

