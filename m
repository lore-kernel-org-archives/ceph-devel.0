From: Loic Dachary <loic@dachary.org>
Subject: Re: dead code in gf-complete
Date: Fri, 05 Dec 2014 21:42:55 +0100
Message-ID: <548218CF.5070504@dachary.org>
References: <5481C9EF.1090800@dachary.org> <CA+AFVBjtbVbmq_Hn+-DubpHy2i_eFUhiUhSKmg2dXeGgT=RChA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sLLsjw93Glnhjgcmf6GSSG41IXdRGNs58"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48394 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751221AbaLEUm6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Dec 2014 15:42:58 -0500
In-Reply-To: <CA+AFVBjtbVbmq_Hn+-DubpHy2i_eFUhiUhSKmg2dXeGgT=RChA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sLLsjw93Glnhjgcmf6GSSG41IXdRGNs58
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/12/2014 21:06, Kevin Greenan wrote:
> I can take a look...  Man, some of our conditional expressions and if-t=
hen-else chains are pretty ugly!

It works, that's beautiful ;-)

>=20
> -kevin=20
>=20
> On Fri, Dec 5, 2014 at 7:06 AM, Loic Dachary <loic@dachary.org <mailto:=
loic@dachary.org>> wrote:
>=20
>     Hi Kevin & Janne,
>=20
>     Does the following ring a bell ? If not I'll figure it out ;-) It s=
howed up with static analysis, after the NEON patch was merged (no static=
 analysis is done before).
>=20
>     Cheers
>=20
>     /erasure-code/jerasure/gf-complete/src/gf_w32.c: 2309 in gf_w32_spl=
it_init()
>     2303       if ((h->arg1 =3D=3D 4 && h->arg2 =3D=3D 32) || (h->arg1 =
=3D=3D 32 && h->arg2 =3D=3D 4) ||
>     2304           ((issse3 || isneon) && h->mult_type =3D=3D GF_REGION=
_DEFAULT)) {
>     2305         ld4 =3D (struct gf_split_4_32_lazy_data *) h->private;=

>     2306         ld4->last_value =3D 0;
>     2307         if ((h->region_type & GF_REGION_NOSIMD) || !(issse3 ||=
 isneon)) {
>     2308           gf->multiply_region.w32 =3D gf_w32_split_4_32_lazy_m=
ultiply_region;
>     >>>     CID 1256941:  Logically dead code  (DEADCODE)
>     >>>     Execution cannot reach this statement "if (isneon) {
>     } else if (h-...".
>     2309         } else if (isneon) {
>     2310     #ifdef ARM_NEON
>     2311           gf_w32_neon_split_init(gf);
>     2312     #endif
>     2313         } else if (h->region_type & GF_REGION_ALTMAP) {
>     2314           gf->multiply_region.w32 =3D gf_w32_split_4_32_lazy_s=
se_altmap_multiply_region;
>=20
>     ___________________________________________________________________=
_____________________________________
>     *** CID 1256942:  Logically dead code  (DEADCODE)
>     /erasure-code/jerasure/gf-complete/src/gf_w8.c: 1147 in gf_w8_table=
_init()
>     1141       use_simd =3D 1;
>     1142     #else
>     1143       use_simd =3D 0;
>     1144     #endif
>     1145
>     1146       if (h->mult_type =3D=3D GF_MULT_DEFAULT && use_simd) {
>     >>>     CID 1256942:  Logically dead code  (DEADCODE)
>     >>>     Execution cannot reach this statement "dd =3D (struct gf_w8=
_default_...".
>     1147         dd =3D (struct gf_w8_default_data *)h->private;
>     1148         scase =3D 3;
>     1149         bzero(dd->high, sizeof(uint8_t) * GF_FIELD_SIZE * GF_H=
ALF_SIZE);
>     1150         bzero(dd->low, sizeof(uint8_t) * GF_FIELD_SIZE * GF_HA=
LF_SIZE);
>     1151         bzero(dd->divtable, sizeof(uint8_t) * GF_FIELD_SIZE * =
GF_FIELD_SIZE);
>     1152         bzero(dd->multtable, sizeof(uint8_t) * GF_FIELD_SIZE *=
 GF_FIELD_SIZE);
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--sLLsjw93Glnhjgcmf6GSSG41IXdRGNs58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSCGM8ACgkQ8dLMyEl6F22kDACfbh9zE4PmTCWoc+tOIhm7t9pr
0cIAoLEGv8dUwoJVO/gY+oWpgueXY63z
=I7Rz
-----END PGP SIGNATURE-----

--sLLsjw93Glnhjgcmf6GSSG41IXdRGNs58--
