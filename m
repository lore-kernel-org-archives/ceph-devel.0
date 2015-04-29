From: Loic Dachary <loic@dachary.org>
Subject: preparing hammer v0.94.2
Date: Wed, 29 Apr 2015 21:33:45 +0200
Message-ID: <55413219.3040200@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WLMh8WwWCVAmwb0dmV3gGcBlASp7r8rc0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54737 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752015AbbD2Tds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 15:33:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WLMh8WwWCVAmwb0dmV3gGcBlASp7r8rc0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

The pending hammer backports[1] that did not yet have a matching pull req=
uest have been backported[2]. The integration branch[3] has been populate=
d[4] to verify that none of the pull request conflict with each other. Si=
nce there are core, rgw, rbd and fs changes, I think we need to schedule =
all four suites. Of course we must first verify that each individual pull=
 request passes make check but that should not take more than a day. Woul=
d you like to schedule the suites or should I do it ?

Cheers

[1] issues to be backported for hammer http://tracker.ceph.com/projects/c=
eph/issues?query_id=3D77
[2] backport pull requests https://github.com/ceph/ceph/pulls?q=3Dis%3Aop=
en+is%3Apr+milestone%3Ahammer
[3] integration branch for hammer https://github.com/ceph/ceph/tree/hamme=
r-backports
[4] HOWTO populate the integration branch http://tracker.ceph.com/project=
s/ceph-releases/wiki/HOWTO_populate_the_integration_branch

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WLMh8WwWCVAmwb0dmV3gGcBlASp7r8rc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVBMhkACgkQ8dLMyEl6F22RewCffLu3f9yZmhxvOQ5Z++4oyihl
/UcAoLi2ObLzBI5xpXB8oDlfQQcW1YQI
=m6hi
-----END PGP SIGNATURE-----

--WLMh8WwWCVAmwb0dmV3gGcBlASp7r8rc0--
