From: Loic Dachary <loic@dachary.org>
Subject: teuthology job priorities
Date: Thu, 28 May 2015 11:32:29 +0200
Message-ID: <5566E0AD.80401@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7c3DKCINtUKq1uhudhmSvn8V1Jee6HOqm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52322 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753492AbbE1Jcc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 05:32:32 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 8E2D842B2B
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 11:32:29 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7c3DKCINtUKq1uhudhmSvn8V1Jee6HOqm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

This morning I'll schedule a job with priority 50, assuming nobody will g=
et mad at me for using such a low priority because the associated bug fix=
 blocks the release of v0.94.2 (http://tracker.ceph.com/issues/11546) and=
 also assuming noone uses a priority lower than 100 just to get in front =
of the nightlies[1]. In my imagination

   priority [0,100] is for emergencies
   priority [100,1000] is to schedule a job with higher priority than the=
 nightlies
   priority 1000 (the default) is for all automated tests and no human be=
ing wait on them (the nightlies for instance).

Does someone have a different mapping in mind ?

Cheers

[1] the nightlies http://tracker.ceph.com/projects/ceph-releases/wiki/HOW=
TO_monitor_the_automated_tests_AKA_nightlies
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7c3DKCINtUKq1uhudhmSvn8V1Jee6HOqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVm4K0ACgkQ8dLMyEl6F22lbACfcJEcQ9hutMrvTKYnSufuYtNz
CQkAn3XTwQ53TRsU+x2giYDHd8nI+l7w
=E3oz
-----END PGP SIGNATURE-----

--7c3DKCINtUKq1uhudhmSvn8V1Jee6HOqm--
