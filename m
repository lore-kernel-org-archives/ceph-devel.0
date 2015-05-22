From: Loic Dachary <loic@dachary.org>
Subject: rgw and the next firefly release v0.80.10
Date: Fri, 22 May 2015 22:00:32 +0200
Message-ID: <555F8AE0.6020001@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JUfa69UgJQVSnDHxrMHMnUFWeV71nPgvm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49416 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756510AbbEVUAf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 16:00:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JUfa69UgJQVSnDHxrMHMnUFWeV71nPgvm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The next firefly release as found at https://github.com/ceph/ceph/tree/fi=
refly (68211f695941ee128eb9a7fd0d80b615c0ded6cf) passed the rgw suite (ht=
tp://tracker.ceph.com/issues/11090#rgw). It includes https://github.com/c=
eph/ceph/pull/4697 which is the pull request backporting the fix for http=
://tracker.ceph.com/issues/11604 and http://tracker.ceph.com/issues/11622=
 to firefly.

Do you think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11090#Release-information has direct =
links to the pull requests merged into firefly since v0.80.9 in case you =
need more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


















--JUfa69UgJQVSnDHxrMHMnUFWeV71nPgvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVfiuEACgkQ8dLMyEl6F20+RgCdGC03mLGGcEMOXE0uixqdz0Tz
xJoAnjhsWG7Lmzb4w1sFoI5noCmdVlLG
=qaDJ
-----END PGP SIGNATURE-----

--JUfa69UgJQVSnDHxrMHMnUFWeV71nPgvm--
