From: Loic Dachary <loic@dachary.org>
Subject: ObjectContext : check that all references are gone
Date: Mon, 15 Jul 2013 21:25:11 +0200
Message-ID: <51E44C97.8040902@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAAF1E0D0485B62FAADD70728"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56048 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab3GOTZP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jul 2013 15:25:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAAF1E0D0485B62FAADD70728
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

You mentionned that there is code somewhere checking the fact that all re=
ferences to an ObjectContext are gone and that replacing manual reference=
 counting with shared_ptr should preserve this ( i.e. in relation to http=
s://github.com/ceph/ceph/pull/414 "replace ObjectContext pointers with sh=
ared_ptr" ). However, I've not been able to find such code. Would you be =
so kind as to show me where it is ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigAAF1E0D0485B62FAADD70728
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHkTJcACgkQ8dLMyEl6F21yYgCgjyqHYfQPsjNZTPSBeU4SorPV
s8YAn1M4n0/obOGCUIdXSn1zN47uSuPq
=DgX5
-----END PGP SIGNATURE-----

--------------enigAAF1E0D0485B62FAADD70728--
