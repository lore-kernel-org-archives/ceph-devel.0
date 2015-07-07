From: Loic Dachary <loic@dachary.org>
Subject: Re: Cloud images for OpenStack & libvirt
Date: Tue, 07 Jul 2015 19:25:04 +0200
Message-ID: <559C0B70.2060400@dachary.org>
References: <559C0923.7000202@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IPjdkDPxgnbX8XMROpRRJAwtE7LXRDcVs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46171 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757746AbbGGRZW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 13:25:22 -0400
In-Reply-To: <559C0923.7000202@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IPjdkDPxgnbX8XMROpRRJAwtE7LXRDcVs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

You found that the Debian GNU/Linux 8 official image had a race condition=
 causing problems with systemd. You fixed it by building your own image a=
t

http://odisoweb1.odiso.net/debian-jessie-amd64-150620.raw

but maybe the problem is fixed in the most recent image (dated june 6 201=
5) ?

Cheers

On 07/07/2015 19:15, Loic Dachary wrote:
> Hi Ceph,
>=20
> Here is a summary of how to acquire cloud images where we presumably wa=
nt Ceph to build. I did not research Debian GNU/Linux squeeze nor OpenSUS=
E 12. And I added a few (Fedora 21, OpenSUSE 13.2 and Ubuntu 15.04).
>=20
> glance image-download --file debian-7.4.qcow2 --progress 'GNU/Linux Deb=
ian 7.4 Wheezy x64' # http://www.entercloudsuite.com/
> wget -O debian-8.0.qcow2  http://cdimage.debian.org/cdimage/openstack/c=
urrent/debian-8.1.0-openstack-amd64.qcow2
> wget -O ubuntu-12.04.qcow2 https://cloud-images.ubuntu.com/precise/curr=
ent/precise-server-cloudimg-amd64-disk1.img
> wget -O ubuntu-12.04-i386.qcow2 https://cloud-images.ubuntu.com/precise=
/current/precise-server-cloudimg-i386-disk1.img
> wget -O ubuntu-14.04.qcow2 https://cloud-images.ubuntu.com/trusty/curre=
nt/trusty-server-cloudimg-amd64-disk1.img
> wget -O ubuntu-14.04-i386.qcow2 https://cloud-images.ubuntu.com/trusty/=
current/trusty-server-cloudimg-i386-disk1.img
> wget -O ubuntu-15.04.qcow2 https://cloud-images.ubuntu.com/vivid/curren=
t/vivid-server-cloudimg-arm64-disk1.img
> wget -O ubuntu-15.04-i386.qcow2 https://cloud-images.ubuntu.com/vivid/c=
urrent/vivid-server-cloudimg-i386-disk1.img
> wget -O opensuse-13.2 http://download.opensuse.org/repositories/Cloud:/=
Images:/openSUSE_13.2/images/openSUSE-13.2-OpenStack-Guest.x86_64.qcow2
> glance image-download --file centos-7.0.qcow2 --progress 'GNU/Linux Cen=
tOS 7 x64' # http://www.entercloudsuite.com/
> wget -O centos-7.0.qcow2 http://cloud.centos.org/centos/7/images/CentOS=
-7-x86_64-GenericCloud.qcow2                                             =
                                                                   =20
> glance image-download --file centos-6.5.qcow2 --progress 'GNU/Linux Cen=
tOS 6.5 x64' # http://www.entercloudsuite.com/
> wget -O fedora-22.qcow2 https://download.fedoraproject.org/pub/fedora/l=
inux/releases/22/Cloud/x86_64/Images/Fedora-Cloud-Base-22-20150521.x86_64=
=2Eqcow2
> wget -O fedora-21.qcow2 http://fedora.mirrors.ovh.net/linux/releases/21=
/Cloud/Images/x86_64/Fedora-Cloud-Base-20141203-21.x86_64.qcow2
> wget -O fedora-20.qcow2 http://fedora.mirrors.ovh.net/linux/releases/20=
/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2
>=20
> If you don't have access to an ttp://www.entercloudsuite.com/ OpenStack=
 tenant, you can find a copy at http://ecs.dachary.org/images/. Note howe=
ver that you can also create an account there and run the glance command,=
 you won't be charged for it.
>=20
> These images can be used with kvm from the command line as explained at=
 http://dachary.org/?p=3D3625 (Using a cloud image with kvm) or libvirt. =
The OpenStack documentation has an inventory of locations where more imag=
es can be found : http://docs.openstack.org/image-guide/content/ch_obtain=
ing_images.html
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IPjdkDPxgnbX8XMROpRRJAwtE7LXRDcVs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWcC3AACgkQ8dLMyEl6F23SwQCfVKlPzn+ljAunNjLCZRLTPJIY
qlIAn28ZElcPwOFflUiNMaGEI8zmYkfn
=hY8q
-----END PGP SIGNATURE-----

--IPjdkDPxgnbX8XMROpRRJAwtE7LXRDcVs--
