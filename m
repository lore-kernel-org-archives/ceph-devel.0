From: Loic Dachary <loic@dachary.org>
Subject: Simpler LRC configuration
Date: Fri, 15 Aug 2014 18:44:50 +0200
Message-ID: <53EE3902.1080009@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vVHv39NpAL9QmGtSJ8Brd4VBws8PuD7qN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60206 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751102AbaHOQo5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 12:44:57 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 0B6A842B1B
	for <ceph-devel@vger.kernel.org>; Fri, 15 Aug 2014 18:44:51 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vVHv39NpAL9QmGtSJ8Brd4VBws8PuD7qN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Based on Andreas suggestions for Xorbas configuration (in a previous thre=
ad) and the last G/H discussions ( https://wiki.ceph.com/Planning/CDS/CDS=
_Giant_and_Hammer_%28Jun_2014%29 ), here is a simpler configuration for t=
he LRC plugin. Instead of replacing the generic description, it generates=
 it from a user friendly set of parameters:

   https://github.com/dachary/ceph/commit/a2cfda81b8f51bb77f2c2708597f7ad=
7e1882b3c

The more flexible configuration syntax can be retained but the system adm=
inistrator is not required to understand it.

What do people think ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--vVHv39NpAL9QmGtSJ8Brd4VBws8PuD7qN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPuOQIACgkQ8dLMyEl6F20vjQCgpRBRgUIeiO6iei4Hde7JkBkU
pkIAoJl6hH+T7wYBXBs/uy8Voc/quUNH
=SBdQ
-----END PGP SIGNATURE-----

--vVHv39NpAL9QmGtSJ8Brd4VBws8PuD7qN--
