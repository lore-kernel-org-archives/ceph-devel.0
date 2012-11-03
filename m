From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: slow fio random read benchmark: last librbd git : 20000iops !
Date: Sat, 03 Nov 2012 11:01:39 +0100 (CET)
Message-ID: <ade81beb-3b5c-4457-ba54-8e799449af28@mailpro>
References: <2a0895f2-f8df-4ea7-956a-e617750d5322@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:57029 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab2KCKCK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 06:02:10 -0400
In-Reply-To: <2a0895f2-f8df-4ea7-956a-e617750d5322@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Dietmar Maurer <dietmar@proxmox.com>, Josh Durgin <josh.durgin@inktank.com>, Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

Hi Everybody,

I have just recompiled my qemu-kvm package with last librbd git,

my iops have jumped from 5000 to 20000iops for a single fio randread be=
nchmark !=20
cpu of the client seem to be the bottleneck,I'll test on a bigger cpu t=
his week.


Qemu-kvm was previously compiled with librbd 0.53.


I don't know what have change ? (I don't have used stripping feature, a=
nd I have same result for image format 1 or 2).


Regards,

Alexandre

----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
Cc: "Dietmar Maurer" <dietmar@proxmox.com>, "Josh Durgin" <josh.durgin@=
inktank.com>, "Marcus Sorensen" <shadowsor@gmail.com>, "Sage Weil" <sag=
e@inktank.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Gregory Far=
num" <greg@inktank.com>=20
Envoy=C3=A9: Vendredi 2 Novembre 2012 10:38:42=20
Objet: Re: slow fio random read benchmark, need help=20

>>Same results with rbd kernel driver without QEMU involved.=20

I confirm , I have same result wirh rbd kernel driver,so it not a qemu =
problem.=20


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Gregory Farnum" <greg@inktank.com>=20
Cc: "Dietmar Maurer" <dietmar@proxmox.com>, "Josh Durgin" <josh.durgin@=
inktank.com>, "Alexandre DERUMIER" <aderumier@odiso.com>, "Marcus Soren=
sen" <shadowsor@gmail.com>, "Sage Weil" <sage@inktank.com>, "ceph-devel=
" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Jeudi 1 Novembre 2012 11:54:03=20
Objet: Re: slow fio random read benchmark, need help=20

Am 01.11.2012 11:40, schrieb Gregory Farnum:=20
> I'm not sure that latency addition is quite correct. Most use cases=20
> cases do multiple IOs at the same time, and good benchmarks tend to=20
> reflect that.=20
>=20
> I suspect the IO limitations here are a result of QEMU's storage=20
> handling (or possibly our client layer) more than anything else =E2=80=
=94 Josh=20
> can talk about that more than I can, though!=20
> -Greg=20

Same results with rbd kernel driver without QEMU involved.=20

Stefan=20
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
