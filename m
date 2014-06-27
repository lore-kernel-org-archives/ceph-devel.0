From: Loic Dachary <loic@dachary.org>
Subject: ARM benchmarks for the erasure code plugin
Date: Fri, 27 Jun 2014 19:12:12 +0200
Message-ID: <53ADA5EC.5030302@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hjwSJCpt0ltbtRx0p0OMnxwhcFVIQgsIa"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58781 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751570AbaF0RMV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 13:12:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sandon Van Ness <sandon@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hjwSJCpt0ltbtRx0p0OMnxwhcFVIQgsIa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sandon,

Would it be possible to get access to an ARM based machine to run erasure=
 code plugins benchmarks ? The idea is to get a baseline similar to what =
https://github.com/ceph/ceph/pull/1875 shows and figure out where we stan=
d. At this point any ARM processor will do. Eventually we will want to gi=
ve NEON[1] enabled processors a try but right now we have nothing take ad=
vantage of that ;-)

Cheers

[1] http://en.wikipedia.org/wiki/NEON_%28instruction_set%29#NEON

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--hjwSJCpt0ltbtRx0p0OMnxwhcFVIQgsIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOtpewACgkQ8dLMyEl6F22xJwCdEvq1CizX4zq6DlifoTYE2h13
YrQAnReyK3480IzuHULWLthQdKRZmuPd
=ojjk
-----END PGP SIGNATURE-----

--hjwSJCpt0ltbtRx0p0OMnxwhcFVIQgsIa--
