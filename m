From: Loic Dachary <loic@dachary.org>
Subject: jerasure-1.2A valgrind error
Date: Fri, 23 Aug 2013 18:07:26 +0200
Message-ID: <521788BE.1010404@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1789907EA2FB545E29C50DB8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:52876 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab3HWQH3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 12:07:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James S. Plank" <plank@cs.utk.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1789907EA2FB545E29C50DB8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi James,

I ran:

valgrind --tool=3Dmemcheck ./encoder F 2 2 reed_sol_van 8 0 310

compiled from jerasure-1.2A as found at http://web.eecs.utk.edu/~plank/pl=
ank/papers/Jerasure-1.2A.tar
and compiled without modifications except for -g in the makefile to get t=
he error lines.

=3D=3D22001=3D=3D Use of uninitialised value of size 8
=3D=3D22001=3D=3D    at 0x409CB1: galois_w08_region_multiply (galois.c:47=
4)
=3D=3D22001=3D=3D    by 0x4061CD: jerasure_matrix_dotprod (jerasure.c:628=
)
=3D=3D22001=3D=3D    by 0x404F06: jerasure_matrix_encode (jerasure.c:313)=

=3D=3D22001=3D=3D    by 0x40259C: main (encoder.c:518)

The input file contains (i.e. 310 bytes, no newline )

ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJK=
LMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUV=
WXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefg=
hijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqr=
stuvwxyz0123456789

Should I be concerned about it ?

valgrind --tool=3Dmemcheck ./encoder F 2 2 cauchy_good 8 8 310

shows no error.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig1789907EA2FB545E29C50DB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIXiL4ACgkQ8dLMyEl6F22ASQCggWjjDcIY9msxGH2wm+B94NHL
rWwAn1TK6EMf3Hg2EuiCnAvbPO0Z3a/b
=lYfG
-----END PGP SIGNATURE-----

--------------enig1789907EA2FB545E29C50DB8--
