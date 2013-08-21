From: Loic Dachary <loic@dachary.org>
Subject: Jerasure & Ceph
Date: Wed, 21 Aug 2013 11:32:42 +0200
Message-ID: <5214893A.2020005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAE3AE9F752D1E6F74DD4F52B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:54565 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab3HUJcs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 05:32:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James S. Plank" <plank@cs.utk.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE3AE9F752D1E6F74DD4F52B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi James,

I'm working on adding jerasure as a plugin to Ceph. If I remember correct=
ly the next version of jerasure was scheduled to be released this month. =
Although using jerasure-1.2 ( as found at http://web.eecs.utk.edu/~plank/=
plank/papers/CS-08-627.html ) would be perfectly fine, it may be worth wa=
iting for a few days if a release is imminent.

Do you advise to wait for the next version of jerasure ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigAE3AE9F752D1E6F74DD4F52B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIUiToACgkQ8dLMyEl6F23cAACfVvVJ2Itio73k/G9kSVv/fz1V
RqQAn312xTzfdlaS/VXNccKS/jmSTw9D
=xKXR
-----END PGP SIGNATURE-----

--------------enigAE3AE9F752D1E6F74DD4F52B--
