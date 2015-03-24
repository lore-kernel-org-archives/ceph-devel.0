From: Loic Dachary <loic@dachary.org>
Subject: make check bot out of order
Date: Wed, 25 Mar 2015 00:33:35 +0100
Message-ID: <5511F44F.5040007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PSIsWUCG9wFrofeGbq3AaRN4xraneKuM4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36051 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752190AbbCXXdh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 19:33:37 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 9A3EF42B48
	for <ceph-devel@vger.kernel.org>; Wed, 25 Mar 2015 00:33:35 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PSIsWUCG9wFrofeGbq3AaRN4xraneKuM4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot stopped working a few hours ago and I'm fixing it. It'=
s a strange behavior (it makes gitlab use a lot of RAM and timeout) after=
 rebooting the machine it runs on.

Thanks for your patience

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--PSIsWUCG9wFrofeGbq3AaRN4xraneKuM4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUR9E8ACgkQ8dLMyEl6F21NlQCgoNNFt5jRGOBwTB2L9XhaZ0LA
tKAAniXdgNbdw/Oyova/8W5RFlTVFD2f
=X1UZ
-----END PGP SIGNATURE-----

--PSIsWUCG9wFrofeGbq3AaRN4xraneKuM4--
