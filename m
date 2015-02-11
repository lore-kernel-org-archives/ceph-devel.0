From: Loic Dachary <loic@dachary.org>
Subject: unittest_erasure_code_shec  fails
Date: Wed, 11 Feb 2015 20:33:46 +0100
Message-ID: <54DBAE9A.6030205@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2cPt2NOKOjaEPruuR7OjTn8CgRaQgLhWB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42647 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754033AbbBKTdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 14:33:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2cPt2NOKOjaEPruuR7OjTn8CgRaQgLhWB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

As of today the SHEC unit test fail as described at http://tracker.ceph.c=
om/issues/10839. Can you reproduce the failure locally ? I'm not sure why=
 it happens now and not yesterday. I'll bisect the failure down to the gu=
ilty commit but it would be great if you could confirm that you also see =
it.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2cPt2NOKOjaEPruuR7OjTn8CgRaQgLhWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTbrpoACgkQ8dLMyEl6F22lKQCgsZjRP8g5LbOEQIL2ft9lSLwK
3icAoL7/wq1umec4qixZxRc8gZf/KJ5A
=uESs
-----END PGP SIGNATURE-----

--2cPt2NOKOjaEPruuR7OjTn8CgRaQgLhWB--
