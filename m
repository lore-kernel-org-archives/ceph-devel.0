From: Loic Dachary <loic@dachary.org>
Subject: Re: v2 aligned buffer changes for erasure codes
Date: Fri, 19 Sep 2014 11:18:40 +0200
Message-ID: <541BF4F0.4000203@dachary.org>
References: <1410796508-28711-1-git-send-email-j@jannau.net>,<1411036435-18860-1-git-send-email-j@jannau.net>,<3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE7D13BB@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GrRkS8TnPIL0IveVJ1PIcI5pumBO2pR9H"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55681 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751668AbaISJSq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 05:18:46 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7D13BB@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Janne Grunau <j@jannau.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GrRkS8TnPIL0IveVJ1PIcI5pumBO2pR9H
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

The per_chunk_alignment addresses a backward compatible change in the way=
 they are calculated. The problem was that the initial calculation lead t=
o oversized chunks. The long explanation is at https://github.com/ceph/ce=
ph/commit/c7daaaf5e63d0bd1d444385e62611fe276f6ce29

Please let me know if you see something wrong :-)

Cheers

On 18/09/2014 14:34, Andreas Joachim Peters wrote:
> Hi Janne/Loic,=20
> there is more confusion atleast on my side ...
>=20
> I had now a look at the jerasure plug-in and I am now slightly confused=
 why you have two ways to return in get_alignment ... one is as I assume =
and another one is "per_chunk_alignment" ... what should the function ret=
urn Loic?
>=20
> Cheers Andreas.
> ________________________________________
> From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.or=
g] on behalf of Andreas Joachim Peters [Andreas.Joachim.Peters@cern.ch]
> Sent: 18 September 2014 14:18
> To: Janne Grunau; ceph-devel@vger.kernel.org
> Subject: RE: v2 aligned buffer changes for erasure codes
>=20
> Hi Janne,
> =3D> (src/erasure-code/isa/README claims it needs 16*k byte aligned buf=
fers
>=20
> I should update the README since it is misleading ... it should say 8*k=
 or 16*k byte aligned chunk size depending on the compiler/platform used,=
 it is not the alignment of the allocated buffer addresses.The get_alignm=
ent in the plug-in function is used to compute the chunk size for the enc=
oding (as I said not the start address alignment).
>=20
> If you pass k buffers for decoding each buffer should be aligned at lea=
st to 16 or as you pointed out better 32 bytes.
>=20
> For encoding there is normally a single buffer split 'virtually' into k=
 pieces. To make all pieces starting at an aligned address one needs to a=
lign the chunk size to e.g. 16*k. For the best possible performance on al=
l platforms we should change the get_alignment function in the ISA plug-i=
n to return 32*k if there are no other objections ?!?!
>=20
> Cheers Andreas.
> ________________________________________
> From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.or=
g] on behalf of Janne Grunau [j@jannau.net]
> Sent: 18 September 2014 12:33
> To: ceph-devel@vger.kernel.org
> Subject: v2 aligned buffer changes for erasure codes
>=20
> Hi,
>=20
> following a is an updated patchset. It passes now make check in src
>=20
> It has following changes:
>  * use 32-byte alignment since the isa plugin use AVX2
>    (src/erasure-code/isa/README claims it needs 16*k byte aligned buffe=
rs
>    but I can't see a reason why it would need more than 32-bytes
>  * ErasureCode::encode_prepare() handles more than one chunk with paddi=
ng
>=20
> cheers
>=20
> Janne
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--GrRkS8TnPIL0IveVJ1PIcI5pumBO2pR9H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQb9PAACgkQ8dLMyEl6F21f4gCfZZVQyr9MiupvcjreGZsiS1f/
anYAn2KeO64MxEVmfQV8zeHrXMe/stxG
=nV4T
-----END PGP SIGNATURE-----

--GrRkS8TnPIL0IveVJ1PIcI5pumBO2pR9H--
