From: Loic Dachary <loic@dachary.org>
Subject: Re: Caching the erasure code decoding matrix
Date: Sun, 07 Jun 2015 00:42:22 +0200
Message-ID: <5573774E.9010105@dachary.org>
References: <55511543.3040603@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WGpWqq5dvt6jn2OPS8HaHf8h9WLvM6C54"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57515 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752744AbbFFWmZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jun 2015 18:42:25 -0400
In-Reply-To: <55511543.3040603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WGpWqq5dvt6jn2OPS8HaHf8h9WLvM6C54
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

After discussing this a little with a few people, I'm tempted to conclude=
 caching the decoding matrix is probably not worth the complexity. It's e=
ven difficult for me to know if maintaining the cache is cheaper than com=
puting the decoding matrix.

Cheers

On 11/05/2015 22:46, Loic Dachary wrote:
> Hi Andreas,
>=20
> I gave a shot at implementing a cache to avoid computing the decoding m=
atrix every time a 4KB stripe needs it, for the jerasure plugin, in the s=
ame way you did it for the ISA plugin.=20
>=20
> The draft is at https://github.com/dachary/ceph/commit/a6fb5257fabd8107=
04405c8bc13743d1592ecc54 if you're curious. Then I did some benchmarking =
and was quite disappointed. It looks like whenever the matrix needs to be=
 computed jerasure_invert_matrix needs ~4000 cycles. Compared to the cost=
 of galois_w08_region_multiply (~4 millions cycles), it is very small [1]=
=2E
>=20
> With the ISA plugin ec_init_table is less expensive than jerasure_inver=
t_matrix with ~1200 cycles as well as the the function ec_encode_data_avx=
 (1.5 millions cycles) [2].
>=20
> In both cases though the order of magnitude remains (1000 to 1) and mak=
es me wonder if I'm not missing something.
>=20
> What do you think ?
>=20
> Cheers
>=20
> [1] jerasure profiling: make -j4 ceph_erasure_code_benchmark && rm benc=
h.callgrind &&  valgrind --tool=3Dcallgrind --callgrind-out-file=3Dbench.=
callgrind      ./ceph_erasure_code_benchmark      --plugin jerasure      =
--parameter directory=3D.libs --workload decode --verbose      --paramete=
r technique=3Dreed_sol_van      --parameter k=3D4      --parameter m=3D2 =
     --iterations 1024 --erased 1 --erased 2 && kcachegrind bench.callgri=
nd=20
> [2] isa profiling: make -j4 ceph_erasure_code_benchmark && rm bench.cal=
lgrind &&  valgrind --tool=3Dcallgrind --callgrind-out-file=3Dbench.callg=
rind      ./ceph_erasure_code_benchmark      --plugin isa      --paramete=
r directory=3D.libs --workload decode --verbose      --parameter techniqu=
e=3Dreed_sol_van      --parameter k=3D4      --parameter m=3D2      --ite=
rations 1024 --erased 1 --erased 2 && kcachegrind bench.callgrind=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WGpWqq5dvt6jn2OPS8HaHf8h9WLvM6C54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVzd04ACgkQ8dLMyEl6F21XBwCfQzzMOzTPJA/8ABVbePP8EYUP
frkAoJ5aFrxzblf0E9lSy/YyIUcPVAFU
=fUli
-----END PGP SIGNATURE-----

--WGpWqq5dvt6jn2OPS8HaHf8h9WLvM6C54--
