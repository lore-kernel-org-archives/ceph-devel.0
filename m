From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next firefly release v0.80.10
Date: Fri, 22 May 2015 22:01:49 +0200
Message-ID: <555F8B2D.30909@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="J9D0isexKilQX8B1PnwO0W9WliitOGJLo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49422 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756674AbbEVUBv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 16:01:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J9D0isexKilQX8B1PnwO0W9WliitOGJLo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

The next firefly release as found at https://github.com/ceph/ceph/tree/fi=
refly (68211f695941ee128eb9a7fd0d80b615c0ded6cf) passed the rbd suite (ht=
tp://tracker.ceph.com/issues/11090#rbd). Do you think it is ready for QE =
to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11090#Release-information has direct =
links to the pull requests merged into firefly since v0.80.9 in case you =
need more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




















--J9D0isexKilQX8B1PnwO0W9WliitOGJLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVfiy0ACgkQ8dLMyEl6F21vdgCeKNWFGhvofPxhLbXi3eZaIxKT
srsAnRQaFrjG9BymR6g4WWPGQ+tyj1zj
=WBlJ
-----END PGP SIGNATURE-----

--J9D0isexKilQX8B1PnwO0W9WliitOGJLo--
