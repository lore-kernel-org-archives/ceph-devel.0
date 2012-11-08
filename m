From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 10:05:03 +0100 (CET)
Message-ID: <d0e5e2d7-0ffa-4f0e-8cb8-fa9717cd051e@mailpro>
References: <509B751F.8000900@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49455 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab2KHJFd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 04:05:33 -0500
In-Reply-To: <509B751F.8000900@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

> Do you have tried to compare virtio-blk and virtio-scsi ?=20
>>How to change? Right now i'm using the PVE defaults =3D> scsi-hd.=20

(virtio-blk is "classic" virtio ;)

>> Do you have tried directly from the host with the rbd kernel module =
?=20
>>No don't know how to use ;-)=20
http://ceph.com/docs/master/rbd/rbd-ko/
#modprobe rbd
#sudo rbd map {image-name} --pool {pool-name} --id {user-name}

(then you'll have a /dev/rbd1)




----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Joao Eduardo Luis" <joao.luis@inktank.com>, ceph-devel@vger.kernel=
=2Eorg, "Mark Nelson" <mark.nelson@inktank.com>=20
Envoy=C3=A9: Jeudi 8 Novembre 2012 10:02:23=20
Objet: Re: less cores more iops / speed=20

Am 08.11.2012 09:58, schrieb Alexandre DERUMIER:=20
>>> What do you mean by that? I'm talking about the KVM guest not about=
 the=20
>>> ceph nodes.=20
>=20
> Do you have tried to compare virtio-blk and virtio-scsi ?=20
How to change? Right now i'm using the PVE defaults =3D> scsi-hd.=20

> Do you have tried directly from the host with the rbd kernel module ?=
=20
No don't know how to use ;-)=20

Stefan=20


> ----- Mail original -----=20
>=20
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
> =C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
> Cc: "Joao Eduardo Luis" <joao.luis@inktank.com>, ceph-devel@vger.kern=
el.org=20
> Envoy=C3=A9: Jeudi 8 Novembre 2012 09:45:17=20
> Objet: Re: less cores more iops / speed=20
>=20
> Am 08.11.2012 01:59, schrieb Mark Nelson:=20
>> There's also the context switching overhead. It'd be interesting to=20
>> know how much the writer processes were shifting around on cores.=20
> What do you mean by that? I'm talking about the KVM guest not about t=
he=20
> ceph nodes.=20
>=20
>> Stefan, what tool were you using to do writes?=20
> as always: fio ;-)=20
>=20
> Stefan=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
