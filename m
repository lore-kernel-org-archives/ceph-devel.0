From: Loic Dachary <loic@dachary.org>
Subject: ceph internals : buffer lists
Date: Sat, 23 Feb 2013 10:37:40 +0100
Message-ID: <51288DE4.6090306@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2FEE98B1767AB8D7D79615A4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:53311 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab3BWJhm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Feb 2013 04:37:42 -0500
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 0F73926396
	for <ceph-devel@vger.kernel.org>; Sat, 23 Feb 2013 10:37:41 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FEE98B1767AB8D7D79615A4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

As a followup to my work on the buffer lists ( https://github.com/ceph/ce=
ph/commit/fb472a57c6a17e9d2f74a5d226e4e0c91ae9f2a2#src/test/bufferlist.cc=
 ), I wrote down an article explaining how they work

http://dachary.org/?p=3D1904

I hope it will be useful to developers who need a quick overview. If ther=
e are mistakes or mis-conceptions, please let me know and I'll fix it.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig2FEE98B1767AB8D7D79615A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEojeQACgkQ8dLMyEl6F23W/QCeNM3q66EOANdFj/cFlgian9dj
CZ4AoK8Xb32kASg5XeyyDSRxdWwZoGTr
=cqyr
-----END PGP SIGNATURE-----

--------------enig2FEE98B1767AB8D7D79615A4--
