From: Loic Dachary <loic@dachary.org>
Subject: PG statechart
Date: Fri, 26 Apr 2013 17:20:26 +0200
Message-ID: <517A9B3A.3080806@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig59300E6F9C09BE03B6AA9115"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:51608 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab3DZPU2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 11:20:28 -0400
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id BBA1726395
	for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 17:20:26 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59300E6F9C09BE03B6AA9115
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I was considering drawing a statechart ( http://www.math-cs.gordon.edu/co=
urses/cs211/ATMExample/SessionStatechart.gif ) to better understand the t=
ransitions of PG

https://github.com/ceph/ceph/blob/master/src/osd/PG.h#L1341

and realized that it probably already exists somewhere. Does it ?=20

/me hopefull ;-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig59300E6F9C09BE03B6AA9115
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF6mzoACgkQ8dLMyEl6F21jfQCgomOqbOme9YWHZEqHyot3Yem3
+sMAn0ZfpxYYpBd0niv+00S46yfNszU9
=PEe0
-----END PGP SIGNATURE-----

--------------enig59300E6F9C09BE03B6AA9115--
