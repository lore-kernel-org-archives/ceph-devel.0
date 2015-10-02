From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Reproducing allocator performance differences
Date: Fri, 2 Oct 2015 08:55:19 +0200 (CEST)
Message-ID: <1962244090.129462825.1443768919473.JavaMail.zimbra@oxygem.tv>
References: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net> <90559C83A9C7FA45B5846C975DFA612DDB563EB271@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58435 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbbJBGzV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 02:55:21 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB563EB271@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?RGHFgmVrLA==?= Piotr <Piotr.Dalek@ts.fujitsu.com>
Cc: "Curley, Matthew" <matthew.curley@hpe.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>also - more clients would be better (or worse, depending on how you l=
ook at it).

It's quite possible, if I remember, I could trigger more easily with fi=
o with a lot of numjobs (30-40)

----- Mail original -----
De: "Da=C5=82ek, Piotr" <Piotr.Dalek@ts.fujitsu.com>
=C3=80: "Curley, Matthew" <matthew.curley@hpe.com>, "ceph-devel" <ceph-=
devel@vger.kernel.org>
Envoy=C3=A9: Vendredi 2 Octobre 2015 08:07:01
Objet: RE: Reproducing allocator performance differences

> -----Original Message-----=20
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-=20
> owner@vger.kernel.org] On Behalf Of Curley, Matthew=20
> Sent: Thursday, October 01, 2015 5:33 PM=20
>=20
> We've been trying to reproduce the allocator performance impact on 4K=
=20
> random reads seen in the Hackathon (and more recent tests). At this p=
oint=20
> though, we're not seeing any significant difference between tcmalloc =
and=20
> jemalloc so we're looking for thoughts on what we're doing wrong. Or =
at=20
> least some suggestions to try out.=20
>=20
> More detail here:=20
> https://drive.google.com/file/d/0B2kp18maR7axTmU5WG9WclNKQlU/view?=20
> usp=3Dsharing=20
>=20
> Thanks for any input!=20

This problem is more obvious on writes than reads (I noticed that CPU u=
sage on writes is way more erratic than on reads, where it's pretty muc=
h constant), also - more clients would be better (or worse, depending o=
n how you look at it).=20
And finally, this gets more serious with time, once tcmalloc caches get=
 filled, it starts to slow down.=20


With best regards / Pozdrawiam=20
Piotr Da=C5=82ek=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
