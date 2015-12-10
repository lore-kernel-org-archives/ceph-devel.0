From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Blocked requests after "osd in"
Date: Thu, 10 Dec 2015 10:58:46 +0100
Message-ID: <E90D6B3B-2F4A-4F7C-B85E-A4FF319AAC2F@schermer.cz>
References: <5667FC6E.5080600@flyingcircus.io> <B0751415-538E-471E-B310-76812C3C374C@schermer.cz> <56683B9E.8070201@flyingcircus.io> <CAANLjFqUoGTFSYrdwCwRw0apfXJN61SeS7FiXb0A_Bxtu4PJJg@mail.gmail.com> <56693FF7.8050708@flyingcircus.io>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33162 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbbLJJ6u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Dec 2015 04:58:50 -0500
Received: by lfaz4 with SMTP id z4so52963718lfa.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Dec 2015 01:58:48 -0800 (PST)
In-Reply-To: <56693FF7.8050708@flyingcircus.io>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Kauhaus <kc@flyingcircus.io>
Cc: Robert LeBlanc <robert@leblancnet.us>, Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Just try to give the booting OSD and all MONs the resources they ask fo=
r (CPU, memory).
Yes, it causes disruption but only for a select group of clients, and o=
nly for a moment (<20s with my extremely high number of PGs).
=46rom a service provider perspective this might break SLAs, but until =
you get to >60s blocked requests if will not manifest in clients (VM gu=
ests) directly.

Ad fixing it - I still think that the only way to achieve any form of S=
LA I/O should never hang if one of the acting OSDs is acting up. In oth=
er words, doing a write to min_size OSDs should always be enough, let t=
he the rest of the writes buffer somewhere for a while.
Even if you fix this one case, there are other situations where one OSD=
 can block I/O unnecessarily.

Jan


> On 10 Dec 2015, at 10:03, Christian Kauhaus <kc@flyingcircus.io> wrot=
e:
>=20
> Am 10.12.2015 um 06:38 schrieb Robert LeBlanc:
>> I noticed this a while back and did some tracing. As soon as the PGs
>> are read in by the OSD (very limited amount of housekeeping done), t=
he
>> OSD is set to the "in" state so that peering with other OSDs can
>> happen and the recovery process can begin. The problem is that when
>> the OSD is "in", the clients also see that and start sending request=
s
>> to the OSDs before it has had a chance to actually get its bearings
>> and is able to even service the requests. After discussion with some
>> of the developers, there is no easy way around this other than let t=
he
>> PGs recover to other OSDs and then bring in the OSDs after recovery =
(a
>> ton of data movement).
>=20
> Many thanks for your detailed analysis. It's a bit disappointing that=
 there
> seems to be no easy way around. Any work to improve the situation is =
much
> appreciated.
>=20
> In the meantime, I'll be experimenting with pre-seeding the VFS cache=
 to speed
> things up at least a little bit.
>=20
> Regards
>=20
> Christian
>=20
> --=20
> Dipl-Inf. Christian Kauhaus <>< =C2=B7 kc@flyingcircus.io =C2=B7 +49 =
345 219401-0
> Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
> Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
> HR Stendal 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
