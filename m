From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 09:58:01 +0100 (CET)
Message-ID: <97ae038a-a5ae-4df4-acf6-c87cb80020aa@mailpro>
References: <509B711D.3070206@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47204 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab2KHI6b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 03:58:31 -0500
In-Reply-To: <509B711D.3070206@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

>>What do you mean by that? I'm talking about the KVM guest not about t=
he=20
>>ceph nodes.=20

Do you have tried to compare virtio-blk and virtio-scsi ?

Do you have tried directly from the host with the rbd kernel module ?



----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Joao Eduardo Luis" <joao.luis@inktank.com>, ceph-devel@vger.kernel=
=2Eorg=20
Envoy=C3=A9: Jeudi 8 Novembre 2012 09:45:17=20
Objet: Re: less cores more iops / speed=20

Am 08.11.2012 01:59, schrieb Mark Nelson:=20
> There's also the context switching overhead. It'd be interesting to=20
> know how much the writer processes were shifting around on cores.=20
What do you mean by that? I'm talking about the KVM guest not about the=
=20
ceph nodes.=20

> Stefan, what tool were you using to do writes?=20
as always: fio ;-)=20

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
