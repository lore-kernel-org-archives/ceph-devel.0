From: Loic Dachary <loic@dachary.org>
Subject: Caching the erasure code decoding matrix
Date: Mon, 11 May 2015 22:46:59 +0200
Message-ID: <55511543.3040603@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="v5aOR5fEuJkr57tav1JnvfCOrqbBfWNS2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33166 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752363AbbEKUrB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 16:47:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v5aOR5fEuJkr57tav1JnvfCOrqbBfWNS2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

I gave a shot at implementing a cache to avoid computing the decoding mat=
rix every time a 4KB stripe needs it, for the jerasure plugin, in the sam=
e way you did it for the ISA plugin.=20

The draft is at https://github.com/dachary/ceph/commit/a6fb5257fabd810704=
405c8bc13743d1592ecc54 if you're curious. Then I did some benchmarking an=
d was quite disappointed. It looks like whenever the matrix needs to be c=
omputed jerasure_invert_matrix needs ~4000 cycles. Compared to the cost o=
f galois_w08_region_multiply (~4 millions cycles), it is very small [1].

With the ISA plugin ec_init_table is less expensive than jerasure_invert_=
matrix with ~1200 cycles as well as the the function ec_encode_data_avx (=
1.5 millions cycles) [2].

In both cases though the order of magnitude remains (1000 to 1) and makes=
 me wonder if I'm not missing something.

What do you think ?

Cheers

[1] jerasure profiling: make -j4 ceph_erasure_code_benchmark && rm bench.=
callgrind &&  valgrind --tool=3Dcallgrind --callgrind-out-file=3Dbench.ca=
llgrind      ./ceph_erasure_code_benchmark      --plugin jerasure      --=
parameter directory=3D.libs --workload decode --verbose      --parameter =
technique=3Dreed_sol_van      --parameter k=3D4      --parameter m=3D2   =
   --iterations 1024 --erased 1 --erased 2 && kcachegrind bench.callgrind=
=20
[2] isa profiling: make -j4 ceph_erasure_code_benchmark && rm bench.callg=
rind &&  valgrind --tool=3Dcallgrind --callgrind-out-file=3Dbench.callgri=
nd      ./ceph_erasure_code_benchmark      --plugin isa      --parameter =
directory=3D.libs --workload decode --verbose      --parameter technique=3D=
reed_sol_van      --parameter k=3D4      --parameter m=3D2      --iterati=
ons 1024 --erased 1 --erased 2 && kcachegrind bench.callgrind=20
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--v5aOR5fEuJkr57tav1JnvfCOrqbBfWNS2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVRFUMACgkQ8dLMyEl6F22KOgCcCXLSRowiouSNXUrYuJThFY4+
FXkAoJf5M7XhNvNp3/3DQHUe2pGbQmc/
=6RAZ
-----END PGP SIGNATURE-----

--v5aOR5fEuJkr57tav1JnvfCOrqbBfWNS2--
