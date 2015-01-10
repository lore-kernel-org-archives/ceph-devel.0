From: Loic Dachary <loic@dachary.org>
Subject: Re: gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP - failure
Date: Sat, 10 Jan 2015 18:58:23 +0100
Message-ID: <54B1683F.7080004@dachary.org>
References: <54B16763.7070602@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5dRl25Ccw4qU5pj170g1Vx80cde2jmixb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36519 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751201AbbAJR60 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Jan 2015 12:58:26 -0500
In-Reply-To: <54B16763.7070602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>, Janne Grunau <j@jannau.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5dRl25Ccw4qU5pj170g1Vx80cde2jmixb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I should add that this failure only happens on ARMv7 Ubuntu with gcc vers=
ion 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu7)

On 10/01/2015 18:54, Loic Dachary wrote:
> Hi Kevin & Janne,
>=20
> The test gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP - fails on the current=
 gf-complete master. The first commit where it fails is
>=20
> commit 474010a91d35fef5ca7dea77205b6a5c7e68c3e9
> Author: Janne Grunau <j@jannau.net>
> Date:   Wed Sep 17 16:10:25 2014 +0200
>=20
>     arm: NEON optimisations for gf_w16
>=20
>     Optimisations for the 4,16 split table region multiplications.
>=20
>     Selected time_tool.sh 16 -A -B results for a 1.7 GHz cortex-a9:
>     Region Best (MB/s):   532.14   W-Method: 16 -m SPLIT 16 4 -r SIMD -=

>     Region Best (MB/s):   212.34   W-Method: 16 -m SPLIT 16 4 -r NOSIMD=
 -
>     Region Best (MB/s):   801.36   W-Method: 16 -m SPLIT 16 4 -r SIMD -=
r ALTMAP -
>     Region Best (MB/s):    93.20   W-Method: 16 -m SPLIT 16 4 -r NOSIMD=
 -r ALTMAP -
>     Region Best (MB/s):   273.99   W-Method: 16 -m SPLIT 16 8 -
>     Region Best (MB/s):   270.81   W-Method: 16 -m SPLIT 8 8 -
>     Region Best (MB/s):    70.42   W-Method: 16 -m COMPOSITE 2 - -
>     Region Best (MB/s):   393.54   W-Method: 16 -m COMPOSITE 2 - -r ALT=
MAP -
>=20
> but the test did exit(0) on error instead of exit(1) and we failed to n=
otice.
>=20
> gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP -
> Args: 16 A -1 -m SPLIT 16 4 -r ALTMAP - / size (bytes): 524428
> Problem with region multiply (all values in hex):
>    Target address base: 0x8fd08e.  Word 0x1 of 0x1fee.  Xor: 0
>    Value: 2
>    Original source word: d00a
>    Product word: a000
>    It should be: b01f
>=20
> Do you have an idea why this happens ? For the record here is the bisec=
t command I used:
>=20
> git bisect start 6fdd8bc3d32cb2f7fa55d2de9dc7cc5bb2f885aa 36e75c3efec08=
b1e9bdb9c1f69a5b0018abd8ac7
> git bisect run try.sh
>=20
> #!/bin/bash
> log=3D$(git rev-parse HEAD)
> echo $log.log
> make distclean > $log.log 2>&1
> ./autogen.sh >> $log.log 2>&1
> ./configure >> $log.log 2>&1
> make -j4 >> $log.log 2>&1
> ! test/gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP - 2>&1 | grep 'It should=
 be'
>=20
> Note that b87c41f282dccc1b3649e3ea3fb80d19f820310 fails the test for di=
fferent reasons:
>=20
> Args: 16 A -1 -m SPLIT 16 4 -r ALTMAP - / size (bytes): 524428
> *** Error in `/home/ubuntu/f/gf-complete/test/.libs/lt-gf_unit': free()=
: invalid pointer: 0x00ce7070 ***
> try.sh: line 8: 12193 Aborted                 test/gf_unit 16 A -1 -m S=
PLIT 16 4 -r ALTMAP -
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--5dRl25Ccw4qU5pj170g1Vx80cde2jmixb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSxaD8ACgkQ8dLMyEl6F230JgCZAT2CON5k3NLz00qUWrV//gyq
ms4An2KGY7wG5jEx4ZXzm5EwVuch783B
=7w0r
-----END PGP SIGNATURE-----

--5dRl25Ccw4qU5pj170g1Vx80cde2jmixb--
