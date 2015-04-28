From: Loic Dachary <loic@dachary.org>
Subject: make check bot paused
Date: Wed, 29 Apr 2015 00:40:43 +0200
Message-ID: <55400C6B.9070907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DLTuow1toepnrUqjq4rfmc7vrXu2wahrr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54201 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030901AbbD1Wkr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Apr 2015 18:40:47 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 9100F420A2
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2015 00:40:44 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DLTuow1toepnrUqjq4rfmc7vrXu2wahrr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot needs to go through all passed pull requests before it=
 can start working again. This is because of https://issues.jenkins-ci.or=
g/browse/JENKINS-22752 and we just need to wait it out. It should not las=
t more than 24h.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--DLTuow1toepnrUqjq4rfmc7vrXu2wahrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVADGsACgkQ8dLMyEl6F21UbQCgri2yaRmrGk2+b0T6IbFiBAIy
fWMAoK+cUsf7IW9qtV7Rcjd3jkrYV7H3
=nMj9
-----END PGP SIGNATURE-----

--DLTuow1toepnrUqjq4rfmc7vrXu2wahrr--
