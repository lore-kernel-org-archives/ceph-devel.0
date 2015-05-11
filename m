From: Loic Dachary <loic@dachary.org>
Subject: rados and the next hammer release v0.94.2
Date: Mon, 11 May 2015 14:25:53 +0200
Message-ID: <55509FD1.8010704@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bXW9VL5UgEFfcLJsM8lsP2Vs9KqkIH6aR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32908 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750919AbbEKM0A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 08:26:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXW9VL5UgEFfcLJsM8lsP2Vs9KqkIH6aR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rados suite (http://tracker.ceph.com/issues/11492#rados). =
It includes https://github.com/ceph/ceph/pull/4559 which is the pull requ=
est backporting the fix for "OSD::load_pgs: we need to handle the case wh=
ere an upgrade from earlier versions which ignored non-existent pgs resur=
rects a pg with a prehistoric osdmap" http://tracker.ceph.com/issues/1142=
9 to hammer (the corresponding ceph-qa-suite pull request https://github.=
com/ceph/ceph-qa-suite/pull/432 has also been tested and merged).

Do you think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11492#Release-information has direct =
links to the pull requests merged into hammer since v0.94.1 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre














--bXW9VL5UgEFfcLJsM8lsP2Vs9KqkIH6aR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVQn9EACgkQ8dLMyEl6F22TcQCdFLVkFFbtw5uoCBUFyXmoll4I
OVgAn0gZ4pgzZtQvVwrbr+SFQiKCmuAz
=OO6v
-----END PGP SIGNATURE-----

--bXW9VL5UgEFfcLJsM8lsP2Vs9KqkIH6aR--
