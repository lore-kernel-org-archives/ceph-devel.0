From: Loic Dachary <loic@dachary.org>
Subject: Using GF-complete in Ceph
Date: Sat, 15 Jun 2013 09:44:13 +0200
Message-ID: <51BC1B4D.5080604@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0FAE29EF9EB1256E8709F0F7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:43511 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab3FOHoP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Jun 2013 03:44:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James S. Plank" <plank@cs.utk.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FAE29EF9EB1256E8709F0F7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi James,

It would be great to re-use GF-complete ( http://web.eecs.utk.edu/~plank/=
plank/papers/CS-13-703.html ) as a basis for erasure coding in Ceph ( htt=
p://ceph.com/ ). The engineering work to make room for erasure coding beg=
an a few weeks ago ( at the moment replication is used ). I'll keep worki=
ng on it until it's done.=20

Any advice you may have on how to approach the integration of erasure cod=
ing in Ceph would be very welcome.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig0FAE29EF9EB1256E8709F0F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlG8G00ACgkQ8dLMyEl6F20U7wCdFlq9CRxj4J14YpTdvWyxSD+2
NaUAniXaE6/c8NqQgSgQdZ8P0eHNRYjv
=/fc9
-----END PGP SIGNATURE-----

--------------enig0FAE29EF9EB1256E8709F0F7--
