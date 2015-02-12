From: Loic Dachary <loic@dachary.org>
Subject: Re: SHEC updates to the erasure code non regression corpus
Date: Thu, 12 Feb 2015 10:13:59 +0100
Message-ID: <54DC6ED7.8020900@dachary.org>
References: <54DB4AEC.6000507@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA6C7F5@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nafVg0nKaLILGVQXUs72doVJ7jtsTkQj7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43025 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751846AbbBLJOB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 04:14:01 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA6C7F5@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nafVg0nKaLILGVQXUs72doVJ7jtsTkQj7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It turned out to be a problem with tests and uninitialized memory which I=
 was able to fix with

https://github.com/ceph/ceph/commit/1a9d717d1661e1e9c9eda3749b7d9c8882a99=
5d2

What surprises me is that we did not catch that before. If I remember cor=
rectly we ran valgrind and it was clean. Would you have time to review th=
e tests once more to see if you can maybe catch another minor problem ?

Cheers

On 12/02/2015 09:43, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
>> I would be grateful if you could verify that it works as intended.
>=20
> We have tried create and check actions once for each. It seems it works=
 well.
> Is that enough for your job?
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Wednesday, February 11, 2015 9:28 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development
> Subject: SHEC updates to the erasure code non regression corpus
>=20
> Hi,
>=20
> I've updated the erasure code corpus that verifies the encoding of eras=
ure coded chunks do not change over time with a version that includes the=
 SHEC erasure code plugin.
>=20
> https://github.com/ceph/ceph-erasure-code-corpus/commit/498b0102955b747=
813182734e13e75195f2a02a9
>=20
> From now on it will run each time someone does "make check", but only i=
f the sources are after
>=20
> $ git rev-parse v0.92-988-g7df0556
> 7df0556210be3afdc02e2ca41b3a3b60569b753a
>=20
> I would be grateful if you could verify that it works as intended. The =
process for updating the corpus has been documented at https://github.com=
/ceph/ceph-erasure-code-corpus#ceph-erasure-code-corpus : it was difficul=
t to guess how it works ;-)
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nafVg0nKaLILGVQXUs72doVJ7jtsTkQj7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTcbtcACgkQ8dLMyEl6F20YGQCgweNpLllzw/ww203y8TO/8zSX
M+oAoIyHfzV6F7hbG4AlS6urHAVf2vV6
=TNTu
-----END PGP SIGNATURE-----

--nafVg0nKaLILGVQXUs72doVJ7jtsTkQj7--
