From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC r35 release
Date: Sat, 24 Jan 2015 17:22:46 +0100
Message-ID: <54C3C6D6.3040600@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA64E5A@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="12SnNpOxwww4CcnSlar0vcnGqFlqnbCqd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46575 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752381AbbAXQWt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Jan 2015 11:22:49 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64E5A@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--12SnNpOxwww4CcnSlar0vcnGqFlqnbCqd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tests pass for me, thanks :-)

On 24/01/2015 06:45, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> We are sorry that test errors bothered you.
> We have released mSHEC r35 just now.
>=20
> https://github.com/t-miyamae/ceph
>=20
> NOTABLE CHANGES
>   - remove test errors
>   - remove compile warnings
>=20
> LIMITATION
>   - only TestErasureCodeShec364.cc is still not available.
>     We will fix it by 1/26(mon)
>=20
> Best regards,
> Takeshi Miyamae
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--12SnNpOxwww4CcnSlar0vcnGqFlqnbCqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTDxtYACgkQ8dLMyEl6F211+QCgo0faLD9vxSCsgMNG5twBU9RR
voUAn249QizTkBWxiaD49IWvT/PTEM2M
=TTvI
-----END PGP SIGNATURE-----

--12SnNpOxwww4CcnSlar0vcnGqFlqnbCqd--
