From: Loic Dachary <loic@dachary.org>
Subject: make check bot on pause
Date: Mon, 19 Jan 2015 00:10:55 +0100
Message-ID: <54BC3D7F.8030901@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jcFTW68fsdAgXdQeMKXWhHviOW7NprtKJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42875 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751127AbbARXK6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jan 2015 18:10:58 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 3607D42B46
	for <ceph-devel@vger.kernel.org>; Mon, 19 Jan 2015 00:10:56 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jcFTW68fsdAgXdQeMKXWhHviOW7NprtKJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Master fails make check at the moment and the make check bot that reports=
 to github was paused to avoid sending false negative.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--jcFTW68fsdAgXdQeMKXWhHviOW7NprtKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS8PX8ACgkQ8dLMyEl6F20RtACeLHq0t1A+2Psho7HZmIFY/qdv
hkcAni0DAvlJdeqgMP+KwZt0C3SUf6C4
=lCyP
-----END PGP SIGNATURE-----

--jcFTW68fsdAgXdQeMKXWhHviOW7NprtKJ--
