From: Loic Dachary <loic@dachary.org>
Subject: RHEL 6.5 shared library upgrade safety
Date: Mon, 18 Aug 2014 13:57:16 +0200
Message-ID: <53F1EA1C.1020108@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6U7NTVgOcJ02rGVOQo9g5k5mJ46nlxQE7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33167 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751120AbaHRL50 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 07:57:26 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 0A9BE4209E
	for <ceph-devel@vger.kernel.org>; Mon, 18 Aug 2014 13:57:16 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6U7NTVgOcJ02rGVOQo9g5k5mJ46nlxQE7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

In RHEL 6.5, is the following scenario possible :=20

a) an OSD dlopen a shared library for erasure-code,=20
b) the shared library file is replaced while the OSD is running,=20
c) the OSD starts using the new file instead of the old one.=20

It seems unlikely but it would explain a weird stack trace at http://trac=
ker.ceph.com/issues/9153#note-5 so I'm double checking ;-)

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--6U7NTVgOcJ02rGVOQo9g5k5mJ46nlxQE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPx6hwACgkQ8dLMyEl6F20HGwCZAU3Rh9MCC/vso4zQBMNBgGlF
4owAn1BpYdvEi5a9nRr9WC0gLyj1OlT+
=lo5h
-----END PGP SIGNATURE-----

--6U7NTVgOcJ02rGVOQo9g5k5mJ46nlxQE7--
