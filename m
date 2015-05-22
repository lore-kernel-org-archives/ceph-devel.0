From: Loic Dachary <loic@dachary.org>
Subject: rados and the next firefly release v0.80.10
Date: Fri, 22 May 2015 21:55:54 +0200
Message-ID: <555F89CA.8080005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9ac1rrlSQ4N5pIXwKxTJ4fV69CqRSgNuK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49407 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756048AbbEVTz5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 15:55:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ac1rrlSQ4N5pIXwKxTJ4fV69CqRSgNuK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The next firefly release as found at https://github.com/ceph/ceph/tree/fi=
refly (68211f695941ee128eb9a7fd0d80b615c0ded6cf) passed the rados suite (=
http://tracker.ceph.com/issues/11090#rados). It includes https://github.c=
om/ceph/ceph/pull/4556 which is the pull request backporting the fix for =
"OSD::load_pgs: we need to handle the case where an upgrade from earlier =
versions which ignored non-existent pgs resurrects a pg with a prehistori=
c osdmap" http://tracker.ceph.com/issues/11429 to firefly (the correspond=
ing ceph-qa-suite pull request https://github.com/ceph/ceph-qa-suite/pull=
/435 has also been tested and merged).

Do you think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11090#Release-information has direct =
links to the pull requests merged into firefly since v0.80.9 in case you =
need more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
















--9ac1rrlSQ4N5pIXwKxTJ4fV69CqRSgNuK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVficoACgkQ8dLMyEl6F212dACgxfD6G6UbxdZN2d79qf3OcK2I
EnIAnjt+OgNZz7HyBTmmr34MvuS4lw+k
=qnj7
-----END PGP SIGNATURE-----

--9ac1rrlSQ4N5pIXwKxTJ4fV69CqRSgNuK--
