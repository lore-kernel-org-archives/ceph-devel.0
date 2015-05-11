From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next hammer release v0.94.2
Date: Mon, 11 May 2015 14:17:09 +0200
Message-ID: <55509DC5.4090703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="noxCtBQxt4DctRWEgTxViMubttEDpmvEO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32891 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750919AbbEKMRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 08:17:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--noxCtBQxt4DctRWEgTxViMubttEDpmvEO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rbd suite (http://tracker.ceph.com/issues/11492#rbd). Do y=
ou think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11492#Release-information has direct =
links to the pull requests merged into hammer since v0.94.1 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre












--noxCtBQxt4DctRWEgTxViMubttEDpmvEO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVQncUACgkQ8dLMyEl6F22+ogCgxjb9oPBUqD2Qiq7USuFCkMj2
M34AoKIkhnrq7TsO/Qj2X5t8kiIZ57+c
=Lu4S
-----END PGP SIGNATURE-----

--noxCtBQxt4DctRWEgTxViMubttEDpmvEO--
