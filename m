From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: slow fio random read benchmark, need help
Date: Fri, 02 Nov 2012 10:38:42 +0100 (CET)
Message-ID: <2a0895f2-f8df-4ea7-956a-e617750d5322@mailpro>
References: <509254CB.1080604@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38210 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab2KBJjM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 05:39:12 -0400
In-Reply-To: <509254CB.1080604@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Dietmar Maurer <dietmar@proxmox.com>, Josh Durgin <josh.durgin@inktank.com>, Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

>>Same results with rbd kernel driver without QEMU involved.=20

I confirm , I have same result wirh rbd kernel driver,so it not a qemu =
problem.


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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
