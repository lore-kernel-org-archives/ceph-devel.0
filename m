From: Loic Dachary <loic@dachary.org>
Subject: rbd support in openstack-installer
Date: Mon, 14 Oct 2013 01:34:15 +0200
Message-ID: <525B2DF7.6080106@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0HTRTfDILhjJOGjQAmb3pmemiJITQ3bn0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34130 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319Ab3JMXeR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Oct 2013 19:34:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Bode <bodepd@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0HTRTfDILhjJOGjQAmb3pmemiJITQ3bn0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dan,

I'm looking for the path of least resistance to add rbd support to https:=
//github.com/CiscoSystems/openstack-installer/ Being unfamiliar with the =
data oriented approach it would be great to get your advice on the follow=
ing.

* assume ceph has already been installed without cephx which simplifies c=
onfiguration. From the point of view of integration tests it means instal=
ling when vagrant is setup ( which I currently rely on ) or via https://g=
ithub.com/CiscoSystems/openstack-installer/tree/master/stack-builder. Not=
 sure if the post_config is where it should be installed for test purpose=
s. Not sure how to let it know what IP to use.

diff --git a/data/nodes/2_role.yaml b/data/nodes/2_role.yaml
index 9ccfb81..9c855c8 100644
--- a/data/nodes/2_role.yaml
+++ b/data/nodes/2_role.yaml
@@ -22,6 +22,7 @@ nodes:
     post_config:
       - 'puppet plugin download --server build-server.domain.name'
       - 'service apache2 restart'
+      - 'wget -O - http://dachary.org/wp-uploads/2013/10/micro-osd.txt |=
 bash'
       - "ip addr add 172.16.2.1/24 dev eth2; sysctl -w net.ipv4.ip_forwa=
rd=3D1; iptables -A FORWARD -o eth0 -i e
=20
     networks:


* create /etc/ceph/ceph.conf on each volume + compute node with the list =
of monitors IP. Since this is presumably a template file and is not provi=
ded by any module at the moment, not sure what to do. I could add this to=
 cinder + nova because it's needed by both. I suppose it's what should be=
 done since openstack-installer has no template at the moment.

[global]
mon host =3D 192.168.242.100

* setting the default parameters

diff --git a/data/hiera_data/user.common.yaml b/data/hiera_data/user.comm=
on.yaml
index 349eb1a..c38a0a4 100644
--- a/data/hiera_data/user.common.yaml
+++ b/data/hiera_data/user.common.yaml
@@ -48,3 +48,7 @@ swift_service_password: swift_pass
 swift_hash: super_secret_swift_hash
 glance::backend::swift::swift_store_key: secret_key
 glance::backend::swift::swift_store_auth_address: '127.0.0.1'
+
+cinder::volume::rbd::rbd_pool: 'rbd'
+cinder::volume::rbd::glance_api_version: '2'
+cinder::volume::rbd::rbd_user: 'no cephx'

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--0HTRTfDILhjJOGjQAmb3pmemiJITQ3bn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJbLfcACgkQ8dLMyEl6F2308ACgrzn+lO33Kh/KeKkDPW3WYdBY
fV8AnjshlbrC7gVmGbX7MZ0jVXFrD4nz
=XiVa
-----END PGP SIGNATURE-----

--0HTRTfDILhjJOGjQAmb3pmemiJITQ3bn0--
