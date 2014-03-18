From: Loic Dachary <loic@dachary.org>
Subject: SSE extensions detection problem on the current master
Date: Tue, 18 Mar 2014 12:16:48 +0100
Message-ID: <53282B20.9000508@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nEKpCbOGHdCixvTUPvh6JWx2rXAWPoeWV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46716 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbaCRLQ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Mar 2014 07:16:57 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 7637C26397
	for <ceph-devel@vger.kernel.org>; Tue, 18 Mar 2014 12:16:55 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nEKpCbOGHdCixvTUPvh6JWx2rXAWPoeWV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Builds happening after=20

  https://github.com/ceph/ceph/commit/7bc9ade26b5af068318e50cb4d5f7824375=
dd28f

which was merged yesterday and before the following is merged

  https://github.com/ceph/ceph/pull/1489

will produce binaries using SSE extensions on intel processors without ch=
ecking their availability at runtime, when using erasure coded pools only=
=2E I'm not sure how it will fail or when, but it is better to not try ;-=
)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--nEKpCbOGHdCixvTUPvh6JWx2rXAWPoeWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMoKyAACgkQ8dLMyEl6F20XRQCdGjkHZH90Qdmc0aZy5iHCEo4D
UKMAniCiUQ177libOnkvCNSdbq4zUMRz
=qKVd
-----END PGP SIGNATURE-----

--nEKpCbOGHdCixvTUPvh6JWx2rXAWPoeWV--
