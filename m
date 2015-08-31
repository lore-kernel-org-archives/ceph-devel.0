From: Loic Dachary <loic@dachary.org>
Subject: devicemapper and udev events
Date: Tue, 01 Sep 2015 00:09:38 +0200
Message-ID: <55E4D0A2.6040302@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d8wsI819lkHDXFvOcuStQQRTxM6JS8Mxm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47093 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751381AbbHaWJn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Aug 2015 18:09:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8wsI819lkHDXFvOcuStQQRTxM6JS8Mxm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

While working on multipath, I noticed that udev add event are not trigger=
ed when /dev/dm-0 etc. are created. Should I expect a udev add event for =
every device ? Or does it not apply to devices created by / with devicema=
pper ?=20

Thanks in advance for your insights :-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--d8wsI819lkHDXFvOcuStQQRTxM6JS8Mxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXk0KMACgkQ8dLMyEl6F20bEQCgkL1gr3DYeBQ6boE4/ngEkqzj
k8cAoI5l+FgM3PI5jVr2PRFK/plgXJto
=xptV
-----END PGP SIGNATURE-----

--d8wsI819lkHDXFvOcuStQQRTxM6JS8Mxm--
