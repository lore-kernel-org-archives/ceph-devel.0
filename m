From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 25 Sep 2013 17:14:36 +0200
Message-ID: <5242FDDC.3060504@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>,<523FED54.8040208@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig626953CD78D28170A91913C2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:45264 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3IYQXy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Sep 2013 12:23:54 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig626953CD78D28170A91913C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

It looks like this code would be useful as a standalone program instead o=
f being integrated within unit tests. There are a few support program of =
that kind. The unit tests are probably not the best place for benchmarks.=
 What do you think ?

Cheers

Note: got the updated file ;-)

> I fixed some more issues in the test:
>=20
> 1 strncmp =3D> memcmp (object has now binary data and 0 ..)
> 2 I fixed the length of the second block which was wrong after the chan=
ge from 2,2 to 4,2
> 3 I have put 1MB as default object size, otherwise running with valgrin=
d is too long
> 4 I have simplified the time measurement code etc.
>=20

On 23/09/2013 17:43, Andreas Joachim Peters wrote:
> Hi Loic,=20
>=20
> I have modified the Jerasure unit test, to record the encoding & recons=
truction performance and to store this value in the optional google-test =
xml outputfile. I have put (4,2) with a 4MB random object as default and =
one can pass a different object size via '--object-size=3D1000' (for 1G).=

>=20
> It looks like this:
>=20
> ./unittest_erasure_code_jerasure --gtest_filter=3D*.* --log-to-stderr=3D=
true --gtest_output=3D"xml:erasure.xml" --object-size=3D1000
> Note: Google Test filter =3D *.*
> [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 8 tests from 8 test cases.
> [----------] Global test environment set-up.
> [----------] 1 test from ErasureCodeTest/0, where TypeParam =3D Erasure=
CodeJerasureReedSolomonVandermonde
> [ RUN      ] ErasureCodeTest/0.encode_decode
> [       OK ] ErasureCodeTest/0.encode_decode (35231 ms)
> [----------] 1 test from ErasureCodeTest/0 (35231 ms total)
>=20
> [----------] 1 test from ErasureCodeTest/1, where TypeParam =3D Erasure=
CodeJerasureReedSolomonRAID6
> [ RUN      ] ErasureCodeTest/1.encode_decode
> [       OK ] ErasureCodeTest/1.encode_decode (35594 ms)
> [----------] 1 test from ErasureCodeTest/1 (35594 ms total)
>=20
> [----------] 1 test from ErasureCodeTest/2, where TypeParam =3D Erasure=
CodeJerasureCauchyOrig
> [ RUN      ] ErasureCodeTest/2.encode_decode
> [       OK ] ErasureCodeTest/2.encode_decode (33009 ms)
> [----------] 1 test from ErasureCodeTest/2 (33010 ms total)
>=20
> [----------] 1 test from ErasureCodeTest/3, where TypeParam =3D Erasure=
CodeJerasureCauchyGood
> [ RUN      ] ErasureCodeTest/3.encode_decode
> [       OK ] ErasureCodeTest/3.encode_decode (31917 ms)
> [----------] 1 test from ErasureCodeTest/3 (31920 ms total)
>=20
> [----------] 1 test from ErasureCodeTest/4, where TypeParam =3D Erasure=
CodeJerasureLiberation
> [ RUN      ] ErasureCodeTest/4.encode_decode
> [       OK ] ErasureCodeTest/4.encode_decode (31801 ms)
> [----------] 1 test from ErasureCodeTest/4 (31801 ms total)
>=20
> [----------] 1 test from ErasureCodeTest/5, where TypeParam =3D Erasure=
CodeJerasureBlaumRoth
> [ RUN      ] ErasureCodeTest/5.encode_decode
> [       OK ] ErasureCodeTest/5.encode_decode (31927 ms)
> [----------] 1 test from ErasureCodeTest/5 (31927 ms total)
>=20
> [----------] 1 test from ErasureCodeTest/6, where TypeParam =3D Erasure=
CodeJerasureLiber8tion
> [ RUN      ] ErasureCodeTest/6.encode_decode
> [       OK ] ErasureCodeTest/6.encode_decode (31824 ms)
> [----------] 1 test from ErasureCodeTest/6 (31824 ms total)
>=20
> [----------] 1 test from ErasureCodeTiming
> [ RUN      ] ErasureCodeTiming.PropertyOutput
> [ -TIMING- ] technique=3Dblaum_roth       speed [ encode ]=3D2.902 [GB/=
s]
> [ -TIMING- ] technique=3Dblaum_roth       speed [   reco ]=3D1.701 [GB/=
s]
> [ -TIMING- ] technique=3Dcauchy_good      speed [ encode ]=3D2.551 [GB/=
s]
> [ -TIMING- ] technique=3Dcauchy_good      speed [   reco ]=3D1.571 [GB/=
s]
> [ -TIMING- ] technique=3Dcauchy_orig      speed [ encode ]=3D1.401 [GB/=
s]
> [ -TIMING- ] technique=3Dcauchy_orig      speed [   reco ]=3D0.911 [GB/=
s]
> [ -TIMING- ] technique=3Dliber8tion       speed [ encode ]=3D2.861 [GB/=
s]
> [ -TIMING- ] technique=3Dliber8tion       speed [   reco ]=3D1.822 [GB/=
s]
> [ -TIMING- ] technique=3Dliberation       speed [ encode ]=3D2.863 [GB/=
s]
> [ -TIMING- ] technique=3Dliberation       speed [   reco ]=3D1.815 [GB/=
s]
> [ -TIMING- ] technique=3Dreed_sol_r6_op   speed [ encode ]=3D1.194 [GB/=
s]
> [ -TIMING- ] technique=3Dreed_sol_r6_op   speed [   reco ]=3D0.489 [GB/=
s]
> [ -TIMING- ] technique=3Dreed_sol_van     speed [ encode ]=3D0.600 [GB/=
s]
> [ -TIMING- ] technique=3Dreed_sol_van     speed [   reco ]=3D0.429 [GB/=
s]
> [       OK ] ErasureCodeTiming.PropertyOutput (0 ms)
> [----------] 1 test from ErasureCodeTiming (0 ms total)
>=20
> [----------] Global test environment tear-down
> [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 8 tests from 8 test cases ran. (231307=
 ms total)
> [  PASSED  ] 8 tests.
>=20
>=20
> [----------] Global test environment tear-down
> [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 8 tests from 8 test cases ran. (31351 =
ms total)
> [  PASSED  ] 8 tests.
>=20
> And the XML:
>=20
> <testsuite name=3D"ErasureCodeTiming" tests=3D"1" failures=3D"0" disabl=
ed=3D"0" errors=3D"0" time=3D"0">
>     <testcase name=3D"PropertyOutput" status=3D"run" time=3D"0" classna=
me=3D"ErasureCodeTiming" jerasure::blaum_roth::encode=3D"2902" jerasure::=
blaum_roth::reco=3D"1700" jerasure::cauchy_good::encode=3D"2551" jerasure=
::cauchy_good::reco=3D"1571" jerasure::cauchy_orig::encode=3D"1401" jeras=
ure::cauchy_orig::reco=3D"910" jerasure::liber8tion::encode=3D"2861" jera=
sure::liber8tion::reco=3D"1821" jerasure::liberation::encode=3D"2862" jer=
asure::liberation::reco=3D"1814" jerasure::reed_sol_r6_op::encode=3D"1194=
" jerasure::reed_sol_r6_op::reco=3D"489" jerasure::reed_sol_van::encode=3D=
"599" jerasure::reed_sol_van::reco=3D"428" object-size=3D"1000000000" />
>   </testsuite>
>=20
> Maybe you could use this directly for QA.
>=20
> Cheers Andreas.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig626953CD78D28170A91913C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlJC/d0ACgkQ8dLMyEl6F22tZQCfX5alrZILIVUSNCywY6C7lATH
tu0AoJ8+g2lE1jeCsRdpVx+U3MYfXwoc
=o9SW
-----END PGP SIGNATURE-----

--------------enig626953CD78D28170A91913C2--
