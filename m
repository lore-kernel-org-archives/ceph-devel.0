From: Loic Dachary <loic@dachary.org>
Subject: RFC: teuthology field in commit messages
Date: Sat, 28 Nov 2015 16:56:02 +0100
Message-ID: <5659CE92.4000203@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5gBWTQvA41EEP20DCBrp5NtVl0xNuVngu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40612 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752097AbbK1P4K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Nov 2015 10:56:10 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 04595420AC
	for <ceph-devel@vger.kernel.org>; Sat, 28 Nov 2015 16:56:03 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5gBWTQvA41EEP20DCBrp5NtVl0xNuVngu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

An optional teuthology field could be added to a commit message like so:

teuthology: --suite rbd

to state that this commit should be tested with the rbd suite. It could b=
e parsed by bots and humans.

It would make it easy and cost effective to run partial teuthology suites=
 automatically on pull requests.

What do you think ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--5gBWTQvA41EEP20DCBrp5NtVl0xNuVngu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZZzpIACgkQ8dLMyEl6F22++gCeOyALaFtSiKmSrTyYxJKob1UN
aa4AoK0unlDlmKO/x/qijYdcnBfmy+nr
=2Sl4
-----END PGP SIGNATURE-----

--5gBWTQvA41EEP20DCBrp5NtVl0xNuVngu--
