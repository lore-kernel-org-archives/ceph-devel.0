From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Re[2]: xio messenger prelim benchmark
Date: Fri, 6 Feb 2015 08:24:45 +0100 (CET)
Message-ID: <263943518.7885801.1423207485470.JavaMail.zimbra@oxygem.tv>
References: <em6177ec76-17b1-49c2-98e2-f90dcb485305@lt-vu-6500>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41108 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbBFHYr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 02:24:47 -0500
In-Reply-To: <1932531757.7885800.1423207476086.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vu Pham <vuhuong@mellanox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>Yes, xio messenger which is implemented over Accelio can run over rdm=
a=20
>>transport (Infiniband, RoCE) and TCP. Please note that we have not=20
>>enabled xio messenger / Accelio-tcp yet.=20

Oh, ok, Great !


>>xio messenger is currently working with user mode clients. We only=20
>>validated/tested user mode rbd client.=20
>>Sandisk are working on krbd over kAccelio implementation. As of last=20
>>week, SanDisk have basic I/Os working.=20
>>Hopefully krbd/kAccelio will be available soon.=20

Great, so we can expect even better results :)


BTW, do you have some client side cpu usage benchmark ?



----- Mail original -----
De: "Vu Pham" <vuhuong@mellanox.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Jeudi 5 F=C3=A9vrier 2015 19:15:21
Objet: Re[2]: xio messenger prelim benchmark

>Hi,=20
>=20
>I'm going to use same mellanox switchs in production next month,=20
>=20
>Isn't them ethernet switchs ?=20
>How xio messenger is working, if they are not infiband ?=20
>=20
>Maybe with RoCE ?=20
>=20

Yes, xio messenger which is implemented over Accelio can run over rdma=20
transport (Infiniband, RoCE) and TCP. Please note that we have not=20
enabled xio messenger / Accelio-tcp yet.=20

>=20
>I'll try to benchmark xio messenger too.=20
>=20
Great. Let us know.=20

>=20
>=20
>BTW, do you have tried to bench with fio + krbd instead fio-librbd ?=20
>I think you should have better results with numjobs=3D1.=20
>=20
>=20
xio messenger is currently working with user mode clients. We only=20
validated/tested user mode rbd client.=20
Sandisk are working on krbd over kAccelio implementation. As of last=20
week, SanDisk have basic I/Os working.=20
Hopefully krbd/kAccelio will be available soon.=20

@Mark, I'll try out disabling auth, in-memory debugging & RHEL.=20

-vu=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
