From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next hammer release v0.94.3
Date: Mon, 03 Aug 2015 17:44:18 +0200
Message-ID: <55BF8C52.8070805@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="W9XeQtNS5p90OiCCwqpqBhkF96wV6eg08"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60683 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753270AbbHCPoW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 11:44:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W9XeQtNS5p90OiCCwqpqBhkF96wV6eg08
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rbd suite (http://tracker.ceph.com/issues/11990#rbd). Do y=
ou think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11990#Release-information has direct =
links to the pull requests merged into hammer since v0.94.2 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre














--W9XeQtNS5p90OiCCwqpqBhkF96wV6eg08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW/jFIACgkQ8dLMyEl6F222QQCfQThVnMJsEMiZr18UP1jFNzvO
YrkAnAsF5PuZvoZnLxITBhsTS/2C4KD5
=y34p
-----END PGP SIGNATURE-----

--W9XeQtNS5p90OiCCwqpqBhkF96wV6eg08--
