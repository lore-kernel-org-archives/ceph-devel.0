From: Loic Dachary <loic@dachary.org>
Subject: rados and the next giant release v0.87.2
Date: Wed, 15 Apr 2015 11:48:07 +0200
Message-ID: <552E33D7.9010800@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BcJED1bobaLhKBhGVnMe0ThwJRxW3xDUg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47002 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754469AbbDOJsM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 05:48:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcJED1bobaLhKBhGVnMe0ThwJRxW3xDUg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The next giant release as found at https://github.com/ceph/ceph/tree/gian=
t passed the rados suite (http://tracker.ceph.com/issues/11153#rados). Do=
 you think it is ready for QE to start their own round of testing ?

Note that it will be the last giant release.=20

Cheers

P.S. http://tracker.ceph.com/issues/11153#Release-information has direct =
links to the pull requests merged into giant since v0.87.1 in case you ne=
ed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre










--BcJED1bobaLhKBhGVnMe0ThwJRxW3xDUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUuM9cACgkQ8dLMyEl6F21hZgCgo+4FhBCbkNgBzkMG6btEe5cV
exMAoJ417qR+gGfe6ZVKoDsqnEBBhBY/
=FxLj
-----END PGP SIGNATURE-----

--BcJED1bobaLhKBhGVnMe0ThwJRxW3xDUg--
