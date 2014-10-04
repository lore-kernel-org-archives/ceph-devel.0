From: Loic Dachary <loic@dachary.org>
Subject: Sorting pull requests per label
Date: Sat, 04 Oct 2014 13:00:02 +0200
Message-ID: <542FD332.6040408@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="t56vFc3CL2QAQSMBO73hoMQD7nlCFGDqw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37831 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751072AbaJDLAK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Oct 2014 07:00:10 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 3A047420A0
	for <ceph-devel@vger.kernel.org>; Sat,  4 Oct 2014 13:00:03 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t56vFc3CL2QAQSMBO73hoMQD7nlCFGDqw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The bug / feature labels were added to make them easier to find:

Pending bugs https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+lab=
el%3A%22bug+fix%22
Pending features https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr=
+label%3Afeature

There also is one tag per release:

Pending for giant https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Ap=
r+label%3Agiant
Pending firefly backports https://github.com/ceph/ceph/pulls?q=3Dis%3Aope=
n+is%3Apr+label%3Afirefly
etc.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--t56vFc3CL2QAQSMBO73hoMQD7nlCFGDqw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQv0zIACgkQ8dLMyEl6F22wdACfSDp2jfGkxfW2sLF6RWNQDWik
ARQAn0s/NIIB4GBaeGwALKWIVBVn3p9E
=JP4q
-----END PGP SIGNATURE-----

--t56vFc3CL2QAQSMBO73hoMQD7nlCFGDqw--
