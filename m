From: Loic Dachary <loic@dachary.org>
Subject: make check bot paused and resumed
Date: Fri, 19 Jun 2015 11:17:49 +0200
Message-ID: <5583DE3D.5010305@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dmDcF6Q2PQPA6hoB7HCDa5LBSDm9bHxDx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36848 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754508AbbFSJRw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 05:17:52 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id EDE13420B6
	for <ceph-devel@vger.kernel.org>; Fri, 19 Jun 2015 11:17:49 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmDcF6Q2PQPA6hoB7HCDa5LBSDm9bHxDx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot lagged behind about 24h because it now took about one =
hour for one run. To catch up, it was paused and skipped a number of runs=
=2E It now is resumed and a run now takes 30 minutes instead which will a=
llow it to keep up. Re-pushing a pull request will run the make check bot=
 again.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--dmDcF6Q2PQPA6hoB7HCDa5LBSDm9bHxDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWD3j0ACgkQ8dLMyEl6F20ZIACfXhdOpVo4sfio+XelLGl2RqPZ
FX8Anjw7JJ3Q9or2ZncgNdID1E3vGxg7
=XDRO
-----END PGP SIGNATURE-----

--dmDcF6Q2PQPA6hoB7HCDa5LBSDm9bHxDx--
