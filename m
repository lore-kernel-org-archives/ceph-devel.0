From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu-rdb questions
Date: Mon, 21 May 2012 10:52:58 +0200 (CEST)
Message-ID: <4970da32-93a4-4d79-a17e-9e0a0249b659@mailpro>
References: <4FB9DBBF.5070107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45152 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab2EUIxV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 04:53:21 -0400
In-Reply-To: <4FB9DBBF.5070107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks Josh, this is very clear !



----- Mail original -----=20

De: "Josh Durgin" <josh.durgin@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 21 Mai 2012 08:07:59=20
Objet: Re: qemu-rdb questions=20

On 05/19/2012 09:33 PM, Alexandre DERUMIER wrote:=20
> Hi,=20
> i'm planning to do rdb integration in proxmox2 kvm distribution (not =
using libvirt).=20
>=20
> I found some doc here=20
> http://ceph.com/wiki/QEMU-RBD=20
> and also in libvirt mailing list.=20
>=20
>=20
> some questions:=20
>=20
> qemu drive command line :=20
> -------------------------=20
> -drive file=3Drbd:pool/image:id=3Dmyname:key=3DQVFDVm41aE82SHpGQWhBQX=
EwTkN2OGp0SmNJY0UrSE9CbE1RMUE=3D:auth_supported=3Dcephx none:mon_host=3D=
mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,=
if=3Dvirtio,format=3Draw=20
>=20
> is it the right syntax ?=20

Newer qemu doesn't like the space in auth_supported, so you'll want to=20
use a semicolon instead:=20

-drive=20
file=3Drbd:pool/image:id=3Dmyname:key=3DQVFDVm41aE82SHpGQWhBQXEwTkN2OGp=
0SmNJY0UrSE9CbE1RMUE=3D:auth_supported=3Dcephx;none:mon_host=3Dmon1.exa=
mple.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,if=3Dvir=
tio,format=3Draw=20

The key/value pairs separated by colons are Ceph configuration options.=
=20
The above drive line is equivalent the following settings:=20

/path/to/myname.keyring containing the keyring for myname, as shown by=20
'ceph auth list'.=20

/etc/ceph/ceph.conf containing:=20

[client.myname]=20
keyring =3D /path/to/myname.keyring=20
auth supported =3D cephx none=20
mon host =3D=20
mon1.example.org:6321;mon2.example.org:6322;mon3.example.org:6322=20

And a drive line like:=20

-drive file=3Drbd:pool/image:id=3Dmyname,if=3Dvirtio,format=3Draw=20

Qemu reads the from the ceph.conf file if it exists. Any extra=20
options you add override those from the configuration file.=20

You can have it read from another file by adding ':conf=3D/path/to/file=
'.=20

>=20
>=20
> for image management, what is the best way ? qemu-img or rdb ?=20
>=20
> rdb creation with qemu-img:=20
> ----------------------------=20
> qemu-img create -f rbd rbd:data/foo 10G=20
>=20
> how to specify monitor, authentification,.... ?=20
>=20
> rdb delete/resize with qemu-img?=20
> --------------------------------=20
> don't find any infos.=20

The rbd tool has more features. As you noticed, qemu doesn't know how=20
to delete images. It also can't rename them. I'm not sure if qemu-img=20
lets you resize them. The monitor and auth options for qemu-img are the=
=20
same as for qemu's -drive syntax. You can configure them in=20
/etc/ceph/ceph.conf, or on the command line.=20

=46or the rbd tool, if you don't want to use a configuration file, the=20
options would be:=20

rbd --mon-host=20
'mon1.example.org:6321;mon2.example.org:6322;mon3.example.org:6322'=20
--keyring /path/to/keyring --id myname --auth-supported 'cephx;none'=20

These are generic ceph options, and work with any ceph command. They ca=
n=20
also be set in the CEPH_ARGS environment variable.=20

>=20
>=20
> rdb commands=20
> ------------=20
> Is the rdb kernel module require to use rdb command ?=20

Nope, it's only needed if you want to have /dev/rbd devices on your=20
hosts.=20

> Also,I would like to not have any /dev/rdbx device on my client.=20

qemu goes directly through the userspace librbd to access rbd images.=20
The rbd kernel module isn't involved at all, and no devices appear on=20
the host. The guest does not know it's using rbd; it sees a block=20
device, just as if you were using e.g. a qcow2 file.=20

Josh=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
