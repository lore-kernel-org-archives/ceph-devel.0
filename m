From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd import from stdin
Date: Fri, 23 Nov 2012 15:15:30 +0100 (CET)
Message-ID: <4a5bbe34-b808-497a-ac9e-696ac7c9aeb7@mailpro>
References: <50AF832E.9050402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56916 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab2KWOQB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 09:16:01 -0500
In-Reply-To: <50AF832E.9050402@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

the target rbd volume must not exist.=20


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 23 Novembre 2012 15:07:42=20
Objet: Re: rbd import from stdin=20

Hi,=20

even with size it does not work:=20

Am 23.11.2012 11:43, schrieb Stefan Priebe - Profihost AG:=20
> ah so right now the size parameter is needed. But i don't know the si=
ze=20
> ;-) file is gzip compressed ;-)=20

gzip -d -c vm-101-disk-1.img.gz | rbd import --size=3D42945478656 -=20
kvmpool1/vm-101-disk-1=20
rbd: image creation failed=20
2012-11-23 15:05:49.300363 7f5a599cc760 -1 librbd: rbd image=20
vm-101-disk-1 already existsrbd: import failed:=20
(17) File exists=20

Greets,=20
Stefan=20

> Stefan=20
> Am 23.11.2012 11:25, schrieb Alexandre DERUMIER:=20
>>=20
>> import for stdin already work like this:=20
>>=20
>> rbd import --size=3Dxxx - image < stdin=20
>>=20
>> from this patch=20
>>=20
>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/6315=20
>>=20
>>=20
>> (so I think you just need to specify --size)=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>>=20
>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
>> =C3=80: ceph-devel@vger.kernel.org=20
>> Envoy=C3=A9: Vendredi 23 Novembre 2012 11:15:11=20
>> Objet: rbd import from stdin=20
>>=20
>> Hello,=20
>>=20
>> i was looking at the wip-rbd-export-stdout branch which also allows =
to=20
>> import from stdin.=20
>>=20
>> But it doesn't seem to work:=20
>>=20
>> gzip -d -c vm-101-disk-1.img.gz | rbd import - kvmpool1/vm-101-disk-=
1=20
>> rbd: unable to get size of file/block device: (25) Inappropriate ioc=
tl=20
>> for device=20
>> rbd: import failed: (25) Inappropriate ioctl for device=20
>>=20
>> Greets,=20
>> Stefan=20
>>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
