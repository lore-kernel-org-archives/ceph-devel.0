From: Loic Dachary <loic@dachary.org>
Subject: shec tests failure on i386
Date: Mon, 14 Sep 2015 22:01:41 +0200
Message-ID: <55F727A5.1080300@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="X8KB8r7GIDMJdja5gco0nWC2SNjSfXtss"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55287 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751339AbbINUBn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 16:01:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X8KB8r7GIDMJdja5gco0nWC2SNjSfXtss
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takeshi,

http://tracker.ceph.com/issues/12936 shows that shec tests fail on i386. =
Before I investigate further, I'd like to know if you had a chance to run=
 more tests ? There are not many users of i386 these days, of course ;-) =
But this is a good test to verify there are no architecture related probl=
ems.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--X8KB8r7GIDMJdja5gco0nWC2SNjSfXtss
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX3J6UACgkQ8dLMyEl6F233nwCdHId35DWYU48YoSoTVjE5CNgj
+qAAoI1cfZTy0GnhkonHgDIWH4NYDBxp
=cLUo
-----END PGP SIGNATURE-----

--X8KB8r7GIDMJdja5gco0nWC2SNjSfXtss--
