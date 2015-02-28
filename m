From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next firefly release
Date: Sun, 01 Mar 2015 00:30:28 +0100
Message-ID: <54F24F94.2020402@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tCpRamcX1OJJppbgwmNcN7PM1DGIbLDPQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50752 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751937AbbB1Xac (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 18:30:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tCpRamcX1OJJppbgwmNcN7PM1DGIbLDPQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

The rbd teuthology suite for the next firefly release as found in https:/=
/github.com/ceph/ceph/commits/firefly-backports is green. The details of =
the run is at http://tracker.ceph.com/issues/10641#rbd. Note that today's=
 run were to repeat the jobs that failed because of environmental problem=
s (i.e. problems that were fixed by fixing the test suite itself, not by =
adding a patch to Ceph). Do you think it is ready for QE to start their o=
wn round of testing ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre










--tCpRamcX1OJJppbgwmNcN7PM1DGIbLDPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTyT5QACgkQ8dLMyEl6F23XtACfbBeNngnrz0J+edOpTjixx+0j
Ys8AoLuyHJA329gF6bqgWShWUx2PWnTS
=BWWP
-----END PGP SIGNATURE-----

--tCpRamcX1OJJppbgwmNcN7PM1DGIbLDPQ--
