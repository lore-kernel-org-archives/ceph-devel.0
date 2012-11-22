From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 15:20:46 +0100 (CET)
Message-ID: <0a4a4396-60cd-4782-8743-b2bbba2d2488@mailpro>
References: <50AE289F.2040403@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:53427 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab2KVSfh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:35:37 -0500
In-Reply-To: <50AE289F.2040403@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>

>>We need something like tmpfs - running in local memory but support di=
o.=20

Maybe with ramdisk, /dev/ram0  ?=20

we can format it with standard filesystem (ext3,ext4,...) so maybe dio =
works with it ?



----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER" <ader=
umier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Mark Kamp=
e" <mark.kampe@inktank.com>=20
Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03=20
Objet: Re: RBD fio Performance concerns=20

Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:=20
> And RAMDISK devices are too expensive.=20
>=20
> It would make sense in your infra, but yes they are really expensive.=
=20

We need something like tmpfs - running in local memory but support dio.=
=20

Stefan=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
