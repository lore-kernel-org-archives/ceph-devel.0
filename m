From: Loic Dachary <loic@dachary.org>
Subject: SHEC updates to the erasure code non regression corpus
Date: Wed, 11 Feb 2015 13:28:28 +0100
Message-ID: <54DB4AEC.6000507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="t2OpXDO1SO775MmTJwtnVqPqVNGMiPw6u"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42414 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752081AbbBKM2e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 07:28:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t2OpXDO1SO775MmTJwtnVqPqVNGMiPw6u
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've updated the erasure code corpus that verifies the encoding of erasur=
e coded chunks do not change over time with a version that includes the S=
HEC erasure code plugin.

https://github.com/ceph/ceph-erasure-code-corpus/commit/498b0102955b74781=
3182734e13e75195f2a02a9

=46rom now on it will run each time someone does "make check", but only i=
f the sources are after

$ git rev-parse v0.92-988-g7df0556
7df0556210be3afdc02e2ca41b3a3b60569b753a

I would be grateful if you could verify that it works as intended. The pr=
ocess for updating the corpus has been documented at https://github.com/c=
eph/ceph-erasure-code-corpus#ceph-erasure-code-corpus : it was difficult =
to guess how it works ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--t2OpXDO1SO775MmTJwtnVqPqVNGMiPw6u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTbSuwACgkQ8dLMyEl6F21PYQCffckf8KS5JG63kXq/YZpMoRxz
A3AAoJcGBIeSTsT9RGkcX2LDSR5VSqSk
=BuO6
-----END PGP SIGNATURE-----

--t2OpXDO1SO775MmTJwtnVqPqVNGMiPw6u--
