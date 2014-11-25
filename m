From: Loic Dachary <loic@dachary.org>
Subject: listing packages required to build from sources
Date: Tue, 25 Nov 2014 08:27:53 +0100
Message-ID: <54742F79.6030001@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gTJ0aMkl6tuSPHeWEEcXU4ohAnkDuMU80"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42959 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750864AbaKYH1z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 02:27:55 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 72147420AC
	for <ceph-devel@vger.kernel.org>; Tue, 25 Nov 2014 08:27:53 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gTJ0aMkl6tuSPHeWEEcXU4ohAnkDuMU80
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

It would be nice to replace the files

https://github.com/ceph/ceph/blob/giant/deps.deb.txt
https://github.com/ceph/ceph/blob/giant/deps.rpm.txt

with a script that uses the corresponding package files:

https://github.com/ceph/ceph/blob/giant/debian/control
https://github.com/ceph/ceph/blob/giant/ceph.spec.in

This is what

https://github.com/ceph/ceph/pull/2994/files

does for deb based systems. Does anyone know how it should be done for RP=
M based systems ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--gTJ0aMkl6tuSPHeWEEcXU4ohAnkDuMU80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlR0L3kACgkQ8dLMyEl6F23B6QCbBtsJmKG93F8bctLu1zOt+WuL
HusAoLzCyaKtQEYoPU0xRNG+wGwkA6yk
=cVEw
-----END PGP SIGNATURE-----

--gTJ0aMkl6tuSPHeWEEcXU4ohAnkDuMU80--
