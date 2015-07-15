From: Loic Dachary <loic@dachary.org>
Subject: hammer-backports  branch is ready to schedule suites (v0.94.3)
Date: Thu, 16 Jul 2015 01:28:47 +0200
Message-ID: <55A6ECAF.4020402@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UdgkOjcQg8u5nGlri31AAMrHbLbOGJe3m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50797 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753606AbbGOX2z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2015 19:28:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UdgkOjcQg8u5nGlri31AAMrHbLbOGJe3m
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

The last pull request from the previous integration branch was merged ( h=
ttps://github.com/ceph/ceph/pull/4891 ).

http://tracker.ceph.com/issues/11990#teuthology-run-commit-0c435d3974c9aa=
215ea10c6e9eed30ada6dbc390-hammer-backports-July-15

The ceph.spec.in pull request are not included (I made it so all of them =
have ceph.spec.in in the pull request title) because they conflict and th=
e suite use debian packages.=20

https://github.com/ceph/ceph/pulls?utf8=3D%E2%9C%93&q=3Dis%3Aopen+is%3Apr=
+milestone%3Ahammer+ceph.spec.in+in%3Atitle

I believe running them one by one through the gitbuilders is the best we =
can do right now.

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UdgkOjcQg8u5nGlri31AAMrHbLbOGJe3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWm7K8ACgkQ8dLMyEl6F208sACgwaG2bKqdse/wzlTK2HQ1tXhs
QogAoKHUa18aD0l16Ohatl/Jv5LZQdkk
=F2Pa
-----END PGP SIGNATURE-----

--UdgkOjcQg8u5nGlri31AAMrHbLbOGJe3m--
