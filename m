From: Loic Dachary <loic@dachary.org>
Subject: gf-complete alignment constraints
Date: Mon, 01 Dec 2014 20:15:56 +0100
Message-ID: <547CBE6C.5040801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pllXkCUt0php8t6h2WqFfwd1eMWqNGVqO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45969 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932253AbaLATP7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Dec 2014 14:15:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pllXkCUt0php8t6h2WqFfwd1eMWqNGVqO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

I've hit the following stack trace (and I can reproduce it which is nice =
;-)

#0  __GI_exit (status=3D1) at exit.c:104
#1  0x00007ffff18f3312 in gf_set_region_data (rd=3D0x7fffd9b8b0a0, gf=3D0=
x485dd40, src=3D0x4a7b31f, dest=3D0x4d25800, bytes=3D2048, val=3D143, xor=
=3D1, align=3D16) at erasure-code/jerasure/gf-complete/src/gf.c:817
#2  0x00007ffff1932364 in gf_w8_split_multiply_region_sse (gf=3D0x485dd40=
, src=3D0x4a7b31f, dest=3D0x4d25800, val=3D143, bytes=3D2048, xor=3D1) at=
 erasure-code/jerasure/gf-complete/src/gf_w8.c:1071
#3  0x00007ffff18db9cc in galois_w08_region_multiply (region=3D0x4a7b31f =
"", multby=3D143, nbytes=3D2048, r2=3D0x4d25800 "root:x:0:\ndaemon:x:1:\n=
bin:x:2:\nsys:x:3:\nadm:x:4:loic,swift,syslog\ntty:x:5:\ndisk:x:6:\nlp:x:=
7:\nmail:x:8:\nnews:x:9:\nuucp:x:10:\nman:x:12:\nproxy:x:13:\nkmem:x:15:\=
ndialout:x:20:\nfax:x:21:\nvoice:x:22:\ncdrom:x"..., add=3D1) at erasure-=
code/jerasure/jerasure/src/galois.c:295
#4  0x00007ffff18ddb42 in jerasure_matrix_dotprod (k=3D2, w=3D8, matrix_r=
ow=3D0x47fa558, src_ids=3D0x0, dest_id=3D3, data_ptrs=3D0x7fffd9b8b260, c=
oding_ptrs=3D0x7fffd9b8b270, size=3D2048) at erasure-code/jerasure/jerasu=
re/src/jerasure.c:626

https://github.com/ceph/gf-complete/blob/v1/src/gf.c#L811 indeed checks t=
hat src=3D0x4a7b31f, dest=3D0x4d25800 are aligned and finds they are not.=
 If I'm not mistaken src comes from https://github.com/ceph/jerasure/blob=
/v2/src/galois.c#L294 which will allocate it via https://github.com/ceph/=
jerasure/blob/v2/src/galois.c#L292 i.e https://github.com/ceph/jerasure/b=
lob/v2/src/galois.c#L191 and then https://github.com/ceph/jerasure/blob/v=
2/src/galois.c#L175 which does a malloc that does not enforce alignment.

Should we relax the requirements or make sure https://github.com/ceph/jer=
asure/blob/v2/src/galois.c#L175 uses a logic similar to https://github.co=
m/ceph/ceph/blob/giant/src/common/buffer.cc#L235 ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--pllXkCUt0php8t6h2WqFfwd1eMWqNGVqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlR8vmwACgkQ8dLMyEl6F22e5wCeI4jKcS6cqTBaS7T+7BIUJtR2
giYAnRWav7ncKNdpCspoM+wYgCTP2C1Q
=IEMg
-----END PGP SIGNATURE-----

--pllXkCUt0php8t6h2WqFfwd1eMWqNGVqO--
