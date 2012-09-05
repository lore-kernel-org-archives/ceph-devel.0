From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 05 Sep 2012 16:00:35 +0200 (CEST)
Message-ID: <a904f44f-1aa0-45c6-9d5c-62c3a26eff0b@mailpro>
References: <50474704.2000800@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56694 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2IEOBD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 10:01:03 -0400
In-Reply-To: <50474704.2000800@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Thanks for the infos.

I dind't have documented the ceph.conf feature,it's more a workaround f=
or now for users which want to tune some values.

Indeed,I'm planning to add the cache size options to the proxmox storag=
e.cfg.


Thanks

Alexandre


----- Mail original -----=20

De: "Wido den Hollander" <wido@widodh.nl>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 5 Septembre 2012 14:35:16=20
Objet: Re: rbd 0.48 storage support for kvm proxmox distribution availa=
ble=20

On 09/05/2012 11:30 AM, Alexandre DERUMIER wrote:=20
>>> Proxmox doesn't use libvirt, does it?=20
> Yes, we don't use libvirt.=20
>=20
>>> Any plans to implement the RBD caching?=20
>=20
> It's already implemented (cache=3Dwriteback), patched qemu-kvm 1.1. (=
and qemu-kvm 1.2 is coming in the next days)=20
>=20
> Tunning of cache size can be done with a /etc/ceph.conf file=20
>=20

That is kind of dangerous imho and for a couple of reasons.=20

=46or configuring the storage you have /etc/pve/storage.cfg where you c=
an=20
add the RBD pool, configure the monitors and cephx, but for caching you=
=20
rely in librbd reading ceph.conf?=20

That is hidden from the user, reading /etc/ceph/ceph.conf will go=20
without your knowledge. I'd opt for passing down all the options to Qem=
u=20
and being able to run without a ceph.conf=20

I've ran into the same problems with libvirt and CloudStack. I couldn't=
=20
figure out why libvirt was still able to connect to a specific cluster=20
until I found out my ceph.conf was still in place.=20

I also thought it is on the roadmap to not read /etc/ceph/ceph.conf by=20
default with librbd/librados to take away these kind of issues.=20

And you would also have this weird situation where the ceph.conf could=20
have a couple of monitor entries and your "storage.cfg", how will that=20
work out?=20

I would try not to rely on the ceph.conf at all and have Proxmox pass=20
all the configuration options down to Qemu.=20

Wido=20

>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Wido den Hollander" <wido@widodh.nl>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Mercredi 5 Septembre 2012 11:11:27=20
> Objet: Re: rbd 0.48 storage support for kvm proxmox distribution avai=
lable=20
>=20
> On 09/05/2012 06:31 AM, Alexandre DERUMIER wrote:=20
>> Hi List,=20
>>=20
>> We have added rbd 0.48 support to the proxmox 2.1 kvm distribution=20
>> http://www.proxmox.com/products/proxmox-ve=20
>>=20
>>=20
>> Proxmox setup:=20
>>=20
>> edit the /etc/pve/storage.cfg and add the configuration (gui creatio=
n is not available yet)=20
>>=20
>> rbd: mycephcluster=20
>> monhost 192.168.0.1:6789;192.168.0.2:6789;192.168.0.3:6789=20
>> pool rbd=20
>> username admin=20
>> authsupported cephx;none=20
>> content images=20
>>=20
>=20
> Proxmox doesn't use libvirt, does it?=20
>=20
> Any plans to implement the RBD caching?=20
>=20
> Nice work though!=20
>=20
> Wido=20
>=20
>>=20
>> then you need to copy the keyring file from ceph to proxmox=20
>>=20
>> scp cephserver1:/etc/ceph/client.admin.keyring /etc/pve/priv/ceph/my=
cephcluster.keyring=20
>>=20
>>=20
>>=20
>> For now, you can add/delete/resize rbd volumes from gui.=20
>> Snapshots/cloning will be added soon (when layering will be availabl=
e)=20
>>=20
>>=20
>> Regards,=20
>>=20
>> Alexandre Derumier=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>=20
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
