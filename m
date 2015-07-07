From: Loic Dachary <loic@dachary.org>
Subject: Cloud images for OpenStack & libvirt
Date: Tue, 07 Jul 2015 19:15:15 +0200
Message-ID: <559C0923.7000202@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="68cIFAcmLxjuhMdlwCwVX8lPbH8t4GhUL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46164 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932689AbbGGRPc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 13:15:32 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 6A3F642B2C
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2015 19:15:17 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--68cIFAcmLxjuhMdlwCwVX8lPbH8t4GhUL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a summary of how to acquire cloud images where we presumably want=
 Ceph to build. I did not research Debian GNU/Linux squeeze nor OpenSUSE =
12. And I added a few (Fedora 21, OpenSUSE 13.2 and Ubuntu 15.04).

glance image-download --file debian-7.4.qcow2 --progress 'GNU/Linux Debia=
n 7.4 Wheezy x64' # http://www.entercloudsuite.com/
wget -O debian-8.0.qcow2  http://cdimage.debian.org/cdimage/openstack/cur=
rent/debian-8.1.0-openstack-amd64.qcow2
wget -O ubuntu-12.04.qcow2 https://cloud-images.ubuntu.com/precise/curren=
t/precise-server-cloudimg-amd64-disk1.img
wget -O ubuntu-12.04-i386.qcow2 https://cloud-images.ubuntu.com/precise/c=
urrent/precise-server-cloudimg-i386-disk1.img
wget -O ubuntu-14.04.qcow2 https://cloud-images.ubuntu.com/trusty/current=
/trusty-server-cloudimg-amd64-disk1.img
wget -O ubuntu-14.04-i386.qcow2 https://cloud-images.ubuntu.com/trusty/cu=
rrent/trusty-server-cloudimg-i386-disk1.img
wget -O ubuntu-15.04.qcow2 https://cloud-images.ubuntu.com/vivid/current/=
vivid-server-cloudimg-arm64-disk1.img
wget -O ubuntu-15.04-i386.qcow2 https://cloud-images.ubuntu.com/vivid/cur=
rent/vivid-server-cloudimg-i386-disk1.img
wget -O opensuse-13.2 http://download.opensuse.org/repositories/Cloud:/Im=
ages:/openSUSE_13.2/images/openSUSE-13.2-OpenStack-Guest.x86_64.qcow2
glance image-download --file centos-7.0.qcow2 --progress 'GNU/Linux CentO=
S 7 x64' # http://www.entercloudsuite.com/
wget -O centos-7.0.qcow2 http://cloud.centos.org/centos/7/images/CentOS-7=
-x86_64-GenericCloud.qcow2                                               =
                                                                 =20
glance image-download --file centos-6.5.qcow2 --progress 'GNU/Linux CentO=
S 6.5 x64' # http://www.entercloudsuite.com/
wget -O fedora-22.qcow2 https://download.fedoraproject.org/pub/fedora/lin=
ux/releases/22/Cloud/x86_64/Images/Fedora-Cloud-Base-22-20150521.x86_64.q=
cow2
wget -O fedora-21.qcow2 http://fedora.mirrors.ovh.net/linux/releases/21/C=
loud/Images/x86_64/Fedora-Cloud-Base-20141203-21.x86_64.qcow2
wget -O fedora-20.qcow2 http://fedora.mirrors.ovh.net/linux/releases/20/I=
mages/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2

If you don't have access to an ttp://www.entercloudsuite.com/ OpenStack t=
enant, you can find a copy at http://ecs.dachary.org/images/. Note howeve=
r that you can also create an account there and run the glance command, y=
ou won't be charged for it.

These images can be used with kvm from the command line as explained at h=
ttp://dachary.org/?p=3D3625 (Using a cloud image with kvm) or libvirt. Th=
e OpenStack documentation has an inventory of locations where more images=
 can be found : http://docs.openstack.org/image-guide/content/ch_obtainin=
g_images.html

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--68cIFAcmLxjuhMdlwCwVX8lPbH8t4GhUL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWcCSMACgkQ8dLMyEl6F233AACfasp7ZIhdev7WiN88zyYFr/0W
VGQAnjOV/bR0yh/N8tv5apdJW8kP7pnB
=PVMe
-----END PGP SIGNATURE-----

--68cIFAcmLxjuhMdlwCwVX8lPbH8t4GhUL--
