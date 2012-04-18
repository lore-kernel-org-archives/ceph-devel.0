From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Log files with 0.45
Date: Wed, 18 Apr 2012 06:53:23 +0200
Message-ID: <4F8E48C3.7040309@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig12B570CD39E2EA76797A37D6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:45532 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730Ab2DRExh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Apr 2012 00:53:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Kukawka <dkukawka@suse.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12B570CD39E2EA76797A37D6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

did something change with the default log levels for OSDs on v0.45? With
0.43 and IIRC also 0.44* the logfiles had a acceptable size, but now I
get by default ~3Gbyte per OSD over 12 hours without any change in the
config file.

Danny


--------------enig12B570CD39E2EA76797A37D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQECAAYFAk+OSMgACgkQ9DHLX79LmTL2sAP+NIeUhlItAW+ULfBX8EqYHVek
2oSzV3321ycmk3/NVMIqCzq9PbEjuFZHjN1Twj77yREPhnqoesiR3uFysuR1qSHu
3sdrZbsLY9QtDuejGp8+20COtoCs1Wzlfq5szMstmMiKa+JnMu65Z02e79FcIHlc
arIeyYHachDvQXCsRBo=
=v+Nh
-----END PGP SIGNATURE-----

--------------enig12B570CD39E2EA76797A37D6--
