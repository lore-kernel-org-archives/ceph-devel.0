From: Loic Dachary <loic@dachary.org>
Subject: About erasure code optimizations for ARM
Date: Thu, 31 Jul 2014 17:42:09 +0545
Message-ID: <53DA2F15.5060605@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KPklwDBmbRavNbnvRFMTSllsXnSbqhcxO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51555 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbaGaL5T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 07:57:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ethan Miller <elm@cs.ucsc.edu>, Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KPklwDBmbRavNbnvRFMTSllsXnSbqhcxO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

When using the jerasure plugin for erasure coded placement groups, it tak=
es advantage of http://en.wikipedia.org/wiki/SIMD when running on an Inte=
l processor. It would be nice to also use http://en.wikipedia.org/wiki/NE=
ON_%28instruction_set%29 when running on an ARM processor.

The optimizations themselves are in the https://bitbucket.org/jimplank/gf=
-complete library. At compile time Ceph creates different flavors of the =
plugin ( https://github.com/ceph/ceph/blob/firefly/src/erasure-code/jeras=
ure/Makefile.am#L73 ) depending on the capabilities of the compiler to ge=
nerate the appropriate instructions for SIMD. At runtime Ceph selects the=
 plugin ( https://github.com/ceph/ceph/blob/firefly/src/erasure-code/jera=
sure/ErasureCodePluginSelectJerasure.cc#L41 ) depending on the CPU capabi=
lities ( https://github.com/ceph/ceph/blob/firefly/src/arch/intel.c#L55 )=
=2E=20

NEON detection already exists in Ceph ( https://github.com/ceph/ceph/blob=
/firefly/src/arch/neon.c#L41 ) and adding more would be trivial.

A (very) naive approach would be to add #ifdef NEON in places such as htt=
ps://bitbucket.org/jimplank/gf-complete/src/c25310f215bc97a37944339d331b0=
00ba806d505/src/gf_w4.c?at=3Dmaster#cl-492 when and if a function such as=
 https://bitbucket.org/jimplank/gf-complete/src/c25310f215bc97a37944339d3=
31b000ba806d505/src/gf_w4.c?at=3Dmaster#cl-922 can be implemented with NE=
ON instructions instead of SIMD.

Maybe it is more complex and it needs some kind of rearchitecture ?

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--KPklwDBmbRavNbnvRFMTSllsXnSbqhcxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPaLxYACgkQ8dLMyEl6F2340wCcCFEWD9dZ54d2R0o8wCFOoUJC
1a4An2iZrLuQoj9kghuMQgHwBD2uExqI
=MCm2
-----END PGP SIGNATURE-----

--KPklwDBmbRavNbnvRFMTSllsXnSbqhcxO--
