From: Loic Dachary <loic@dachary.org>
Subject: Ceph deployment : ceph-deploy, puppet, chef, salt, ansible...
Date: Mon, 21 Oct 2013 13:57:45 +0200
Message-ID: <526516B9.9060700@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="exVTgQw8O4pQKGT3vVuJIp44LG2KhB1Ds"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41517 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab3JUL5r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Oct 2013 07:57:47 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id B365A26394
	for <ceph-devel@vger.kernel.org>; Mon, 21 Oct 2013 13:57:45 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--exVTgQw8O4pQKGT3vVuJIp44LG2KhB1Ds
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

It would be great if we could discuss Ceph deployment and share our exper=
ience accross configuration tools. The work in progress for the new puppe=
t module ( https://wiki.openstack.org/wiki/Puppet-openstack/ceph-blueprin=
t ) shows that it's worth discussing to find simple solutions. For instan=
ce, with the logic in place to create a new osd ( https://github.com/ceph=
/ceph/tree/master/src/upstart https://github.com/ceph/ceph/tree/master/ud=
ev and https://github.com/ceph/ceph/blob/master/src/ceph-disk ) the confi=
guration tool does not need to be concerned with OSD ids.

A proposal was created for the next Ceph Developer Summit ( will happen l=
ate november I think ):

http://wiki.ceph.com/01Planning/02Blueprints/Firefly/Ceph_deployment_%3A_=
ceph-deploy%2C_puppet%2C_chef%2C_salt%2C_ansible...

Anyone interested can update the "Interested Parties" accordingly. I hope=
 there is enough interest and that it will be scheduled :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--exVTgQw8O4pQKGT3vVuJIp44LG2KhB1Ds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJlFrkACgkQ8dLMyEl6F222dACgrDa7wxUv8l2fk1DoCP5oUYVu
XW4Anig1fOf+vjbrZDSryotAdpa+dP9s
=EcMs
-----END PGP SIGNATURE-----

--exVTgQw8O4pQKGT3vVuJIp44LG2KhB1Ds--
