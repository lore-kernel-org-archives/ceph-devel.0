From: Loic Dachary <loic@dachary.org>
Subject: script for light weight testing of ceph
Date: Sun, 13 Oct 2013 20:42:15 +0200
Message-ID: <525AE987.8090907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EVu086M4oWOLW0xeDPaMP0Ej0j0R88iGK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34021 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab3JMSmS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Oct 2013 14:42:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Bode <dan@puppetlabs.com>, "Robert Starmer (starmer)" <starmer@cisco.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EVu086M4oWOLW0xeDPaMP0Ej0j0R88iGK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Today I wrote a script ( http://dachary.org/wp-uploads/2013/10/micro-osd.=
txt ) to quickly configure and spawn a ceph cluster for test purposes ( u=
nder 5 seconds ). The details are explained at http://dachary.org/?p=3D23=
74 . It could be useful for the ceph related work done with openstack-ins=
taller. I plan to use it to create a variation of https://github.com/Cisc=
oSystems/openstack-installer/blob/master/tests/basic_test.sh that enables=
 ceph instead of a iscsi / lvm cinder backend.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--EVu086M4oWOLW0xeDPaMP0Ej0j0R88iGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJa6YcACgkQ8dLMyEl6F21HfgCfX4n+XZi3yrYw5n+Fjw3G9XTV
6MIAn2hOccsPBXASjt6ucEkaSI+AB90i
=pVts
-----END PGP SIGNATURE-----

--EVu086M4oWOLW0xeDPaMP0Ej0j0R88iGK--
