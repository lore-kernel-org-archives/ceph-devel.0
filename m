From: Loic Dachary <loic@dachary.org>
Subject: pet project: OSD compatible daemon
Date: Wed, 09 Sep 2015 10:45:26 +0200
Message-ID: <55EFF1A6.9060201@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="j5FhckG4w5m9n7EX17P4s8ibp5iO1a2Hw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52327 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751323AbbIIIpd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 04:45:33 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 51AF742092
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2015 10:45:29 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5FhckG4w5m9n7EX17P4s8ibp5iO1a2Hw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

I would like to try to write an OSD compatible daemon, as a pet project, =
to learn Go and better understand the message flow. I suspect it may also=
 be useful for debug purposes but that's not my primary incentive.=20

Has anyone tried something similar ? If so I'd happily contribute instead=
 of starting something from scratch.

Cheers

P.S. Since it's a pet project it's likely to take months before there is =
any kind of progress ;-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--j5FhckG4w5m9n7EX17P4s8ibp5iO1a2Hw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXv8aYACgkQ8dLMyEl6F20fPgCgmPAm5UZ4nt41X5KWHQUG7GIK
F9sAoLz//H5W05huiOYdapwBmVL2LmfU
=CnYR
-----END PGP SIGNATURE-----

--j5FhckG4w5m9n7EX17P4s8ibp5iO1a2Hw--
