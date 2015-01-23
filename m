From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC r33 release
Date: Sat, 24 Jan 2015 00:39:56 +0100
Message-ID: <54C2DBCC.4050207@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1DwlwrnUwcivTPbCQMUfpM2QT9gJjiAoV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46310 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751554AbbAWXj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 18:39:58 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1DwlwrnUwcivTPbCQMUfpM2QT9gJjiAoV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Since the SHEC plugin depends on the jerasure plugin, it would be simpler=
 if it loaded it instead of including it. The main problem with the curre=
nt inclusion is that it does not compile any SIMD acceleration code and l=
oses the benefit of optimization when the CPU can provide it.=20

There are two ways out of this=20

a) add to the SHEC plugin the same selection that jerasure has (in the Ma=
kefile and with something like http://workbench.dachary.org/ceph/ceph/blo=
b/master/src/erasure-code/jerasure/ErasureCodePluginSelectJerasure.cc

b) compile jerasure as a convenience library that can be included by both=
 the jerasure and SHEC plugin.

The LRC plugin loads the jerasure plugin but the SHEC plugin cannot do th=
e same because the standard API at http://workbench.dachary.org/ceph/ceph=
/blob/master/src/erasure-code/ErasureCodeInterface.h is not enough.

Note that this is not a blocker for the inclusion of the plugin and can b=
e done afterwards.

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


--1DwlwrnUwcivTPbCQMUfpM2QT9gJjiAoV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTC28wACgkQ8dLMyEl6F22zyQCgpFd7puEkatwdDS5AL7zBDG4v
S9QAn08WBjHLo4H0Awbe5pibTDzH+dyH
=oaxB
-----END PGP SIGNATURE-----

--1DwlwrnUwcivTPbCQMUfpM2QT9gJjiAoV--
