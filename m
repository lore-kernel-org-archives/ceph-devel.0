From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot hicups today
Date: Wed, 09 Sep 2015 01:10:07 +0200
Message-ID: <55EF6ACF.2020305@dachary.org>
References: <55E76F84.7040204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uSeX1ponFlE1q7xlWNjIvN0alEqJxEbCO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52033 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752579AbbIHXKK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 19:10:10 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id B456C42B29
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2015 01:10:07 +0200 (CEST)
In-Reply-To: <55E76F84.7040204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uSeX1ponFlE1q7xlWNjIvN0alEqJxEbCO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It took more than a day or two but the bot is back running CentOS 7 make =
check as well as Ubuntu 14.04.

Cheers

fix docker-test.sh for CentOS 7 https://github.com/ceph/ceph/pull/5784

On 02/09/2015 23:52, Loic Dachary wrote:
> Hi,
>=20
> The make check bot had troubles today because a yum repository temporar=
ily had missing files. While trying to figure that out the CentOS 7 docke=
r image was updated and fails to create the container to run the tests. I=
t is fixed but it will take a day or two before CentOS 7 is back. In the =
meantime the bot runs Ubuntu 14.04 only.
>=20
> If the bot failed to visit a pull request, you can trigger it again wit=
h a git commit --amend + git push --force.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uSeX1ponFlE1q7xlWNjIvN0alEqJxEbCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXvas8ACgkQ8dLMyEl6F20f3ACgjXYIiXjj6ix+wj6TfpKhJLC7
g8sAn1ZKNH1ZJcuY/WZFEYTtmWmDWpnc
=dO1V
-----END PGP SIGNATURE-----

--uSeX1ponFlE1q7xlWNjIvN0alEqJxEbCO--
