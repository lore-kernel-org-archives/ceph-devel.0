From: Loic Dachary <loic@dachary.org>
Subject: How to collect coverage with teuthology ?
Date: Wed, 14 Aug 2013 13:14:23 +0200
Message-ID: <520B668F.1070001@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig835D1B49A4B54A1C2750A105"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47488 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759672Ab3HNLO0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 07:14:26 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id DF4D326394
	for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 13:14:24 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig835D1B49A4B54A1C2750A105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Although

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-gcov/l=
og.cgi?log=3D26707923b23cb55583a7d6b46ef6deb9591fd165

claims to build packages with coverage ( -gcov in the name ), I can't fig=
ure out where it is nor how it is supposed to be used.

A hint would be much appreciated :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig835D1B49A4B54A1C2750A105
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlILZpAACgkQ8dLMyEl6F22b9wCgwZt9rdKkE6UDYTqOqpjbWZZu
ZT4AoME9NpErIbLgAWtZBFTwrwoJqLbz
=PXaa
-----END PGP SIGNATURE-----

--------------enig835D1B49A4B54A1C2750A105--
