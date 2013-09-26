From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Thu, 26 Sep 2013 21:18:18 +0200
Message-ID: <5244887A.80503@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch> <523FED54.8040208@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch> <5242FDDC.3060504@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch> <52433014.3030109@dachary.org> <CAGhffvz1TYYLoqn0tps1HiLObSCv7H0ZNVgOd0raicGqgRuukA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig429DE20268F73A93A1C8311D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46534 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab3IZTS0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 15:18:26 -0400
In-Reply-To: <CAGhffvz1TYYLoqn0tps1HiLObSCv7H0ZNVgOd0raicGqgRuukA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig429DE20268F73A93A1C8311D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[re-adding ceph-devel to the cc]

On 26/09/2013 20:36, Andreas-Joachim Peters wrote:> Hi Loic,
> today I forked he CEPH repository and will commit my changes to my GitH=
ub fork asap ... (I am not familiar with GitHub in particular).
> I was finalizing the minimim_to_decode function today with test cases (=
it is more sophisticated in this case ...) ... I didn't fully get what th=
e 'with cost' function is supposed to do diffrent from the one without co=
st?

I'd be happy to explain if=20
https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface.h#L=
131
is unclear. Would you be so kind as to tell me what is confusing in the d=
escription ?=20

>=20
>=20
> Cheers Andreas.
>=20
> On Wed, Sep 25, 2013 at 8:48 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>=20
>=20
>     On 25/09/2013 20:33, Andreas Joachim Peters wrote:> Yes, sure. I ac=
tually thought the same in the meanwhile ...  I have some questions:
>     >
>     > Q: Can/should it stay in the framework of google test's or you wo=
uld prefer just a plain executable ?
>     >
>=20
>     A plain executable would make sense. An simple example from src/tes=
t/Makefile.am :
>=20
>     ceph_test_trans_SOURCES =3D test/test_trans.cc
>     ceph_test_trans_LDADD =3D $(LIBOS) $(CEPH_GLOBAL)
>     bin_DEBUGPROGRAMS +=3D ceph_test_trans
>=20
>=20
>     > I have added local parity support to your erasure class adding a =
new argument: "erasure-code-lp" and
>     > two new methods:
>     >
>     > localparity_encode(...)
>     > localparity_decode(...)
>     >
>     > I made a more complex benchmark of (8,2) + 2 local parities (1^2^=
3^4, 5^6^7^8) which benchmarks performance of encoding/decoding as speed =
& effective write-latency for three cases (each for liberation & cauchy_g=
ood codecs):
>     >
>     > 1 (8,2)
>     > 2 (8,2,lp=3D2)
>     > 3 (8,2,lp=3D2) + crc32c (blocks)
>     >
>     > and several failure scenarios ... single, double, triple disk fai=
lures. Probably the best is if I make all this parameters configurable.
>=20
>     Great :-) Do you have a public git repository where I could clone t=
his & give it a try ?
>=20
>     > Q: For the local parity implementation .... shall I inherit from =
your erasure plugin and overwrite the encode/decode method or you would c=
onsider a patch to the original class?
>=20
>     It is a perfect timing for a patch to the original class.
>=20
>     > I have also a 128-bit XOR implementation for the local parities. =
This will work with new gcc's & clang compilers ...
>     >
>     > Q: Which compilers/platforms are supported by CEPH? Is there a mi=
nimal GCC version?
>=20
>     You can see all supported platforms here:
>=20
>     http://ceph.com/gitbuilder.cgi
>=20
>     I don't think the GCC version shows in the logs but you can probabl=
y figure it out from the corresponding distribution.
>=20
>     > Q: is there some policy restricting comments within code? In gene=
ral I see very few or no comments within the code ..
>=20
>     :-) The mon code tends to be more heavily commented than the osd co=
de (IMO) but I'm not aware of any policy. When I feel the need to comment=
, I write a unit test. If the unit test is difficult, I tend to comment t=
o clarify its purpose. The problem with comments is that they quickly bec=
ome obsolete and/or misleading. That being said, I don't think anyone wil=
l object if you heavily comment your code.
>=20
>     Cheers
>=20
>     > Cheers Andreas.
>     >
>     >
>     >
>     >
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>     All that is necessary for the triumph of evil is that good people d=
o nothing.
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig429DE20268F73A93A1C8311D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlJEiHoACgkQ8dLMyEl6F23E5ACgsAadF1WWUJBmoLAZDXz8oyMb
g9UAoKDOTyzr1UvojOV3UBClHqL/Drr+
=MVdB
-----END PGP SIGNATURE-----

--------------enig429DE20268F73A93A1C8311D--
