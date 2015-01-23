From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC r33 release
Date: Fri, 23 Jan 2015 21:51:43 +0100
Message-ID: <54C2B45F.50705@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RqcMSabL9ngsmu2mnCxkPHflXGDHq5HCr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46230 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751976AbbAWUvq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 15:51:46 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RqcMSabL9ngsmu2mnCxkPHflXGDHq5HCr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

There seems to be a file missing:

make unittest_erasure_code_shec364
  CXX      test/erasure-code/unittest_erasure_code_shec364-TestErasureCod=
eShec364.o
test/erasure-code/TestErasureCodeShec364.cc:21:35: fatal error: test/eras=
ure-code/csv.h: No such file or directory
 #include "test/erasure-code/csv.h"

Cheers

On 23/01/2015 15:30, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> We have released mSHEC r33 just now.
>=20
> https://github.com/t-miyamae/ceph
>=20
> NOTABLE CHANGES
>   - ensure thread safety
>   - support generator matrix cache (added ErasureCodeShecTableCache.cc)=

>   - refer to the shared jerasure 2.0 library
>   - improve verification of return code in test codes
>   - add test code for verifying thread safety (added TestErasureCodeShe=
c_thread.cc)
>=20
> LIMITATION
>   - There are still lots of minor problems in test codes.
>     We will fix it by 1/26(mon).
>=20
> Best regards,
> Takeshi Miyamae
>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=EF=
=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BD=
f=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=
=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=
=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--RqcMSabL9ngsmu2mnCxkPHflXGDHq5HCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTCtF8ACgkQ8dLMyEl6F22i+gCgwGJTV1FYS6NmNlASAOqtwtBA
HLQAn3NXBAAMnQIKmsElRS6hryvxtAKt
=nqk0
-----END PGP SIGNATURE-----

--RqcMSabL9ngsmu2mnCxkPHflXGDHq5HCr--
