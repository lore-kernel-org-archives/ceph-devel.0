From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd export to stdout ?
Date: Mon, 22 Oct 2012 19:18:21 +0200 (CEST)
Message-ID: <385825fb-6c8d-4710-8a79-312e1caf4cb6@mailpro>
References: <24E144B8C0207547AD09C467A8259F75576E8022@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:53407 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634Ab2JVRSu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 13:18:50 -0400
In-Reply-To: <24E144B8C0207547AD09C467A8259F75576E8022@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: ceph-devel@vger.kernel.org, Wido den Hollander <wido@widodh.nl>

>>I thought we should extend 'qemu-img', adding import/export there? Th=
at=20
>>way it would work for all qemu storage drivers?=20

seem to be already possible:

http://ceph.com/wiki/QEMU-RBD

"qemu-img convert -f qcow2 -O rbd /data/debian_lenny_amd64_small.qcow2 =
rbd:data/lenny"



----- Mail original -----=20

De: "Dietmar Maurer" <dietmar@proxmox.com>=20
=C3=80: "Wido den Hollander" <wido@widodh.nl>, "Alexandre DERUMIER" <ad=
erumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 22 Octobre 2012 16:31:00=20
Objet: RE: rbd export to stdout ?=20

> Subject: Re: rbd export to stdout ?=20
>=20
> On 10/22/2012 12:41 PM, Alexandre DERUMIER wrote:=20
> > Hi,=20
> >=20
> > I'm looking for use "rbd export " to stdout and not a file.=20

I thought we should extend 'qemu-img', adding import/export there? That=
=20
way it would work for all qemu storage drivers?=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
