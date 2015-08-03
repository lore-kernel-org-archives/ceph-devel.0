From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next hammer release v0.94.3
Date: Mon, 03 Aug 2015 17:43:29 +0200
Message-ID: <55BF8C21.5020204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IFd0LJ4DAbOJwgLB3txVM48wh0aIUIuuI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60677 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753270AbbHCPnb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 11:43:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IFd0LJ4DAbOJwgLB3txVM48wh0aIUIuuI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the fs suite (http://tracker.ceph.com/issues/11990#fs). Do you=
 think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11990#Release-information has direct =
links to the pull requests merged into hammer since v0.94.2 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

















--IFd0LJ4DAbOJwgLB3txVM48wh0aIUIuuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW/jCEACgkQ8dLMyEl6F23MGgCcDrcnWsgaZyGRcEuqUuW1yeH0
jTUAoK9+2Jk30wfsrSU4J0Gs7y8lh3BP
=xcrX
-----END PGP SIGNATURE-----

--IFd0LJ4DAbOJwgLB3txVM48wh0aIUIuuI--
