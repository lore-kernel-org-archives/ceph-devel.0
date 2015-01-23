From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC r33 release
Date: Sat, 24 Jan 2015 00:59:45 +0100
Message-ID: <54C2E071.40909@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9Cd1N8mQi6grpVq4Qovq9PlSN2wmusnJn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46322 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751744AbbAWX7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 18:59:48 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Cd1N8mQi6grpVq4Qovq9PlSN2wmusnJn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I see the following error when running make check http://paste2.org/dNChV=
pL1 . Does it ring a bell ?

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


--9Cd1N8mQi6grpVq4Qovq9PlSN2wmusnJn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTC4HEACgkQ8dLMyEl6F23XoACffEmSYBDepeOii6nc4pf+eLag
oPIAn1pYSjGP8ZnTbRfudIt2NJ01Ch7b
=D6V/
-----END PGP SIGNATURE-----

--9Cd1N8mQi6grpVq4Qovq9PlSN2wmusnJn--
