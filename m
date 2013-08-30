From: Loic Dachary <loic@dachary.org>
Subject: Jerasure 1.2A plugin for Ceph
Date: Fri, 30 Aug 2013 10:20:14 +0200
Message-ID: <522055BE.2040200@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B56F69F824BEAB8592B5B70"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:48556 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab3H3IUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 04:20:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James S. Plank" <plank@cs.utk.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B56F69F824BEAB8592B5B70
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi James,

The first version of the jerasure 1.2A plugin for Ceph is complete at

https://github.com/ceph/ceph/pull/538#commits-pushed-763275e

This commit introduces the main part:
ErasureCodeJerasure: base class for jerasure ErasureCodeInterface
https://github.com/dachary/ceph/commit/76d2842358465e560a4929d60131762f8c=
93804f

and each technique is derived from it in six successive commits, starting=
 from here
ErasureCodeJerasure: define technique ReedSolomonVandermonde

It would be great if you could take a look and let us know if you see any=
thing odd.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig6B56F69F824BEAB8592B5B70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIgVb4ACgkQ8dLMyEl6F21NCgCdHytbTwaQAlq4SEXe7OVF/1Pq
xXYAnRNoXA+hVIft0o1cK7tYFuXkdDUh
=Khen
-----END PGP SIGNATURE-----

--------------enig6B56F69F824BEAB8592B5B70--
