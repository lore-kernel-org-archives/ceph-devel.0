From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Reproducing allocator performance differences
Date: Fri, 2 Oct 2015 13:25:51 +0200 (CEST)
Message-ID: <1776582364.131415259.1443785151896.JavaMail.zimbra@oxygem.tv>
References: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net> <90559C83A9C7FA45B5846C975DFA612DDB563EB271@ABGEX73E.FSC.NET> <1962244090.129462825.1443768919473.JavaMail.zimbra@oxygem.tv> <90559C83A9C7FA45B5846C975DFA612DDB563EB36E@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55596 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbJBLZy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 07:25:54 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB563EB36E@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?RGHFgmVrLA==?= Piotr <Piotr.Dalek@ts.fujitsu.com>
Cc: "Curley, Matthew" <matthew.curley@hpe.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>I use rados bench -t 128 for that :)

I'm not sure it's exactly the same

on my rados bench tests,
I need to launch multiple "rados bench" process in parallel to scale at=
 high speed.

(like fio -numjobs which create multiple fio process )







----- Mail original -----
De: "Da=C5=82ek, Piotr" <Piotr.Dalek@ts.fujitsu.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "Curley, Matthew" <matthew.curley@hpe.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>
Envoy=C3=A9: Vendredi 2 Octobre 2015 09:24:24
Objet: RE: Reproducing allocator performance differences

> -----Original Message-----=20
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-=20
> owner@vger.kernel.org] On Behalf Of Alexandre DERUMIER=20
> Sent: Friday, October 02, 2015 8:55 AM=20
>=20
> >>also - more clients would be better (or worse, depending on how you=
 look=20
> at it).=20
>=20
> It's quite possible, if I remember, I could trigger more easily with =
fio with a lot=20
> of numjobs (30-40)=20

I use rados bench -t 128 for that :)=20

With best regards / Pozdrawiam=20
Piotr Da=C5=82ek=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
