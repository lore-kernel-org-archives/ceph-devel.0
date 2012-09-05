From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 05 Sep 2012 11:30:35 +0200 (CEST)
Message-ID: <de08e94f-aa29-4ff7-b3a2-98ead9463886@mailpro>
References: <5047173F.9030501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41081 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab2IEJbC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 05:31:02 -0400
In-Reply-To: <5047173F.9030501@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

>>Proxmox doesn't use libvirt, does it?=20
Yes, we don't use libvirt.=20

>>Any plans to implement the RBD caching?=20

It's already implemented (cache=3Dwriteback), patched qemu-kvm 1.1. (an=
d qemu-kvm 1.2 is coming in the next days)

Tunning of cache size can be done with a /etc/ceph.conf file



----- Mail original -----=20

De: "Wido den Hollander" <wido@widodh.nl>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 5 Septembre 2012 11:11:27=20
Objet: Re: rbd 0.48 storage support for kvm proxmox distribution availa=
ble=20

On 09/05/2012 06:31 AM, Alexandre DERUMIER wrote:=20
> Hi List,=20
>=20
> We have added rbd 0.48 support to the proxmox 2.1 kvm distribution=20
> http://www.proxmox.com/products/proxmox-ve=20
>=20
>=20
> Proxmox setup:=20
>=20
> edit the /etc/pve/storage.cfg and add the configuration (gui creation=
 is not available yet)=20
>=20
> rbd: mycephcluster=20
> monhost 192.168.0.1:6789;192.168.0.2:6789;192.168.0.3:6789=20
> pool rbd=20
> username admin=20
> authsupported cephx;none=20
> content images=20
>=20

Proxmox doesn't use libvirt, does it?=20

Any plans to implement the RBD caching?=20

Nice work though!=20

Wido=20

>=20
> then you need to copy the keyring file from ceph to proxmox=20
>=20
> scp cephserver1:/etc/ceph/client.admin.keyring /etc/pve/priv/ceph/myc=
ephcluster.keyring=20
>=20
>=20
>=20
> For now, you can add/delete/resize rbd volumes from gui.=20
> Snapshots/cloning will be added soon (when layering will be available=
)=20
>=20
>=20
> Regards,=20
>=20
> Alexandre Derumier=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
