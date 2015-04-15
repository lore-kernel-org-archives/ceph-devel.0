From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next giant release v0.87.2
Date: Wed, 15 Apr 2015 11:37:49 +0200
Message-ID: <552E316D.5060703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MgsJPI1Hx1xw8GV2Pd13bSKnt1bn7mXjr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46985 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751276AbbDOJhz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 05:37:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MgsJPI1Hx1xw8GV2Pd13bSKnt1bn7mXjr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The next giant release as found at https://github.com/ceph/ceph/tree/gian=
t passed the fs suite (http://tracker.ceph.com/issues/11153#fs). Do you t=
hink it is ready for QE to start their own round of testing ?

Note that it will be the last giant release.=20

Cheers

P.S. http://tracker.ceph.com/issues/11153#Release-information has direct =
links to the pull requests merged into giant since v0.87.1 in case you ne=
ed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre








--MgsJPI1Hx1xw8GV2Pd13bSKnt1bn7mXjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUuMW0ACgkQ8dLMyEl6F202pgCeNx+KT7wVmwrUF6m6MPjIAszz
2wAAn0nJaMU0b88WHSE05SCAcMFHkiSB
=ePTf
-----END PGP SIGNATURE-----

--MgsJPI1Hx1xw8GV2Pd13bSKnt1bn7mXjr--
