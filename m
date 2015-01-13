From: Loic Dachary <loic@dachary.org>
Subject: backports status report: upcoming release giant v0.87.1
Date: Tue, 13 Jan 2015 01:47:18 +0100
Message-ID: <54B46B16.5070707@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2wXHCO3bL9flTaNDn3Ij19JnjAW8kkvpo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37781 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751614AbbAMArU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 19:47:20 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id E581D42B6A
	for <ceph-devel@vger.kernel.org>; Tue, 13 Jan 2015 01:47:18 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2wXHCO3bL9flTaNDn3Ij19JnjAW8kkvpo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

I consolidated the pull request, issues and commits into a report in the =
description of http://tracker.ceph.com/issues/10501 to get a better view =
of the upcoming v0.87.1 point release. It is broken down into:

* already merged in https://github.com/ceph/ceph/tree/giant
* included and tested in integration branch https://github.com/ceph/ceph/=
tree/giant-backports
* pull requests waiting to be integrated=20
* issues that need backporting

Please let me know if you see something unexpected.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2wXHCO3bL9flTaNDn3Ij19JnjAW8kkvpo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS0axYACgkQ8dLMyEl6F21hCgCgxzqw0QP+8Ekd3nDbVw5bKJAt
0LUAoJViSia8XglEAcndoh09tpqLchFl
=Hb1s
-----END PGP SIGNATURE-----

--2wXHCO3bL9flTaNDn3Ij19JnjAW8kkvpo--
