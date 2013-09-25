From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 25 Sep 2013 20:48:52 +0200
Message-ID: <52433014.3030109@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>,<523FED54.8040208@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>,<5242FDDC.3060504@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE3B1BD2731FCC7CE3304BC89"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:45407 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab3IYSsy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Sep 2013 14:48:54 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3B1BD2731FCC7CE3304BC89
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 25/09/2013 20:33, Andreas Joachim Peters wrote:> Yes, sure. I actually=
 thought the same in the meanwhile ...  I have some questions:
>=20
> Q: Can/should it stay in the framework of google test's or you would pr=
efer just a plain executable ?
>=20

A plain executable would make sense. An simple example from src/test/Make=
file.am :

ceph_test_trans_SOURCES =3D test/test_trans.cc
ceph_test_trans_LDADD =3D $(LIBOS) $(CEPH_GLOBAL)
bin_DEBUGPROGRAMS +=3D ceph_test_trans


> I have added local parity support to your erasure class adding a new ar=
gument: "erasure-code-lp" and
> two new methods:
>=20
> localparity_encode(...)
> localparity_decode(...)
>=20
> I made a more complex benchmark of (8,2) + 2 local parities (1^2^3^4, 5=
^6^7^8) which benchmarks performance of encoding/decoding as speed & effe=
ctive write-latency for three cases (each for liberation & cauchy_good co=
decs):
>=20
> 1 (8,2)
> 2 (8,2,lp=3D2)
> 3 (8,2,lp=3D2) + crc32c (blocks)
>=20
> and several failure scenarios ... single, double, triple disk failures.=
 Probably the best is if I make all this parameters configurable.=20

Great :-) Do you have a public git repository where I could clone this & =
give it a try ?

> Q: For the local parity implementation .... shall I inherit from your e=
rasure plugin and overwrite the encode/decode method or you would conside=
r a patch to the original class?

It is a perfect timing for a patch to the original class.

> I have also a 128-bit XOR implementation for the local parities. This w=
ill work with new gcc's & clang compilers ...=20
>=20
> Q: Which compilers/platforms are supported by CEPH? Is there a minimal =
GCC version?

You can see all supported platforms here:

http://ceph.com/gitbuilder.cgi

I don't think the GCC version shows in the logs but you can probably figu=
re it out from the corresponding distribution.=20

> Q: is there some policy restricting comments within code? In general I =
see very few or no comments within the code ..

:-) The mon code tends to be more heavily commented than the osd code (IM=
O) but I'm not aware of any policy. When I feel the need to comment, I wr=
ite a unit test. If the unit test is difficult, I tend to comment to clar=
ify its purpose. The problem with comments is that they quickly become ob=
solete and/or misleading. That being said, I don't think anyone will obje=
ct if you heavily comment your code.

Cheers

> Cheers Andreas.
>=20
>=20
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigE3B1BD2731FCC7CE3304BC89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlJDMBQACgkQ8dLMyEl6F21MvACcCzspHkdoMCjU3eLJYyo69Fth
1owAn2XcJ2v8xwX1n3QTezbRDyLFTtNK
=valX
-----END PGP SIGNATURE-----

--------------enigE3B1BD2731FCC7CE3304BC89--
