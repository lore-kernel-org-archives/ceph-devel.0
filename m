From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next firefly release v0.80.10
Date: Fri, 22 May 2015 22:04:13 +0200
Message-ID: <555F8BBD.90606@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KLTPi5OQ28wN2RHtKUcI6g8H8kAvbAhaJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49429 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030205AbbEVUEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 16:04:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KLTPi5OQ28wN2RHtKUcI6g8H8kAvbAhaJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The next firefly release as found at https://github.com/ceph/ceph/tree/fi=
refly (68211f695941ee128eb9a7fd0d80b615c0ded6cf) passed the fs suite (htt=
p://tracker.ceph.com/issues/11090#fs). Do you think it is ready for QE to=
 start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11090#Release-information has direct =
links to the pull requests merged into firefly since v0.80.9 in case you =
need more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre






















--KLTPi5OQ28wN2RHtKUcI6g8H8kAvbAhaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVfi70ACgkQ8dLMyEl6F23o/wCgv1ST1olKJExeV5jLHvO5fhwV
W94AoIQDgf9SWmq5PZpzg/us2Dn0TXr/
=iBMd
-----END PGP SIGNATURE-----

--KLTPi5OQ28wN2RHtKUcI6g8H8kAvbAhaJ--
