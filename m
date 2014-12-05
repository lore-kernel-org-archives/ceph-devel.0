From: Loic Dachary <loic@dachary.org>
Subject: dead code in gf-complete
Date: Fri, 05 Dec 2014 16:06:23 +0100
Message-ID: <5481C9EF.1090800@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6R1nKhBrv8gSEbjFGALJnHS7SQwpLHUhw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48214 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751380AbaLEPG1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Dec 2014 10:06:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>, Janne Grunau <j@jannau.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6R1nKhBrv8gSEbjFGALJnHS7SQwpLHUhw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kevin & Janne,

Does the following ring a bell ? If not I'll figure it out ;-) It showed =
up with static analysis, after the NEON patch was merged (no static analy=
sis is done before).

Cheers

/erasure-code/jerasure/gf-complete/src/gf_w32.c: 2309 in gf_w32_split_ini=
t()
2303       if ((h->arg1 =3D=3D 4 && h->arg2 =3D=3D 32) || (h->arg1 =3D=3D=
 32 && h->arg2 =3D=3D 4) ||
2304           ((issse3 || isneon) && h->mult_type =3D=3D GF_REGION_DEFAU=
LT)) {
2305         ld4 =3D (struct gf_split_4_32_lazy_data *) h->private;
2306         ld4->last_value =3D 0;
2307         if ((h->region_type & GF_REGION_NOSIMD) || !(issse3 || isneo=
n)) {
2308           gf->multiply_region.w32 =3D gf_w32_split_4_32_lazy_multipl=
y_region;
>>>     CID 1256941:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "if (isneon) {
} else if (h-...".
2309         } else if (isneon) {
2310     #ifdef ARM_NEON
2311           gf_w32_neon_split_init(gf);
2312     #endif
2313         } else if (h->region_type & GF_REGION_ALTMAP) {
2314           gf->multiply_region.w32 =3D gf_w32_split_4_32_lazy_sse_alt=
map_multiply_region;

_________________________________________________________________________=
_______________________________
*** CID 1256942:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf_w8.c: 1147 in gf_w8_table_init(=
)
1141       use_simd =3D 1;
1142     #else
1143       use_simd =3D 0;
1144     #endif
1145
1146       if (h->mult_type =3D=3D GF_MULT_DEFAULT && use_simd) {
>>>     CID 1256942:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "dd =3D (struct gf_w8_defau=
lt_...".
1147         dd =3D (struct gf_w8_default_data *)h->private;
1148         scase =3D 3;
1149         bzero(dd->high, sizeof(uint8_t) * GF_FIELD_SIZE * GF_HALF_SI=
ZE);
1150         bzero(dd->low, sizeof(uint8_t) * GF_FIELD_SIZE * GF_HALF_SIZ=
E);
1151         bzero(dd->divtable, sizeof(uint8_t) * GF_FIELD_SIZE * GF_FIE=
LD_SIZE);
1152         bzero(dd->multtable, sizeof(uint8_t) * GF_FIELD_SIZE * GF_FI=
ELD_SIZE);

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--6R1nKhBrv8gSEbjFGALJnHS7SQwpLHUhw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSBye8ACgkQ8dLMyEl6F23YaQCfZd+pjN4XHwcr0wotYtC+ZJTj
GmYAn1kHhbTLjfe2nKH/MPudmuo16sh0
=Ix41
-----END PGP SIGNATURE-----

--6R1nKhBrv8gSEbjFGALJnHS7SQwpLHUhw--
