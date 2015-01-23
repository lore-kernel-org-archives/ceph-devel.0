From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC r33 release
Date: Fri, 23 Jan 2015 15:39:58 +0100
Message-ID: <54C25D3E.3080202@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WHNTHsq7JT9JpVCWTsPbmhF3M70aBn8Xo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46025 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751968AbbAWOkB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 09:40:01 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WHNTHsq7JT9JpVCWTsPbmhF3M70aBn8Xo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks, I'll take a look. Could you please create a pull request against =
the master branch ? When you do so, it will be convenient if you submit f=
rom a branch that has a descriptive name such as wip-mSHEC or something s=
imilar.

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


--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WHNTHsq7JT9JpVCWTsPbmhF3M70aBn8Xo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTCXT4ACgkQ8dLMyEl6F20hIwCeIN8TxqELStYdQHfuIPHNKld+
jR8An1+vPOnh96uD6+DXUZUoEJuAZiuK
=SoVo
-----END PGP SIGNATURE-----

--WHNTHsq7JT9JpVCWTsPbmhF3M70aBn8Xo--
