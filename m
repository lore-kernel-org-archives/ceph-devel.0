From: Loic Dachary <loic@dachary.org>
Subject: make check bot resumed
Date: Thu, 05 Feb 2015 11:53:43 +0100
Message-ID: <54D34BB7.5070401@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GKRxSrm1LMMeV6iNgo7UE0qtWnor194BB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53130 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757096AbbBEKxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 05:53:44 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 4212742B2C
	for <ceph-devel@vger.kernel.org>; Thu,  5 Feb 2015 11:53:43 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GKRxSrm1LMMeV6iNgo7UE0qtWnor194BB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The bot that runs make check on pull requests and posts the results (see =
https://github.com/ceph/ceph/pull/3529#issuecomment-72508279 for instance=
) broke yesterday because the "next" branch disappeared. The problem was =
fixed and the bot is back to work.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--GKRxSrm1LMMeV6iNgo7UE0qtWnor194BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTTS7cACgkQ8dLMyEl6F21XNACeLJ/OKKA2SmNiEkgJS4A6n47T
SBMAn2eOh5t+4xFR8fx4IIOy7WovSwx7
=WRaQ
-----END PGP SIGNATURE-----

--GKRxSrm1LMMeV6iNgo7UE0qtWnor194BB--
