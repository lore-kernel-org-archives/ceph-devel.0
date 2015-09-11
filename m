From: Loic Dachary <loic@dachary.org>
Subject: make check bot failures (2 hours today)
Date: Fri, 11 Sep 2015 15:03:51 +0200
Message-ID: <55F2D137.9090401@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="R0HTo8IRDLQpLSx6o9NfVJ6hLdqduN3oB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53785 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753078AbbIKNDy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 09:03:54 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 2A73F42B2B
	for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 15:03:52 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R0HTo8IRDLQpLSx6o9NfVJ6hLdqduN3oB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The make check bot failed a number of pull request verifications today. E=
ach of them was notified as false negative (you should have received a sh=
ort note if your pull request is concerned). The problem is now fixed[1] =
and all should be back to normal. If you want to schedule another run, yo=
u just need to rebase your pull request and re-push it, the bot will noti=
ce.

Sorry for the inconvenience and thanks for your patience :-)

P.S. I'm not sure what it was exactly. Just that git fetch took too long =
to answer and failed. Reseting the git clone from which the bot works fix=
ed the problem. It happened a few times in the past but did not show up i=
n the past six month or so.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--R0HTo8IRDLQpLSx6o9NfVJ6hLdqduN3oB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXy0TcACgkQ8dLMyEl6F23sdQCfXuwQhOjnTWy30suzAwFBTn04
qRoAoLheDOOPoYzOS7s2UuDikbul9ndq
=O3QH
-----END PGP SIGNATURE-----

--R0HTo8IRDLQpLSx6o9NfVJ6hLdqduN3oB--
