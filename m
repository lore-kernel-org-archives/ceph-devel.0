From: Loic Dachary <loic@dachary.org>
Subject: teuthology and code coverage revisited
Date: Tue, 05 Mar 2013 00:40:22 +0100
Message-ID: <513530E6.4000705@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig45C58554A3A27327DDBB0416"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56577 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758082Ab3CDXk1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 18:40:27 -0500
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 7850B26394
	for <ceph-devel@vger.kernel.org>; Tue,  5 Mar 2013 00:40:23 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45C58554A3A27327DDBB0416
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The "ceph code coverage" ( http://dachary.org/?p=3D1788 ) guide to collec=
ting code coverage using teuthology was updated to take into account the =
fact that teuthology now uses packages ( the install: task ). But it is s=
till incomplete because I'm not sure how to collect the coverage data.

For test purposes I used the simplest yaml file:

check-locks: false
roles:
- - mon.a
  - mon.c
  - osd.0
- - mon.b
  - osd.1
tasks:
- install:
- ceph:
   branch: master
   coverage: true
   flavor: gcov
   fs: xfs

and it completes successfully. The method I learnt to collect code covera=
ge back in january relied on a ceph-sha1 file being created in the --arch=
ive but it's no longer there. Reading

https://github.com/ceph/teuthology/commit/2653b5a07b880c202800c939efcd1cc=
aaf254841#L0R72

prompted me to try to add coverage: true :

check-locks: false
roles:
- - mon.a
  - mon.c
  - osd.0
- - mon.b
  - osd.1
tasks:
- install:
   coverage: true
- ceph:
   branch: master
   coverage: true
   flavor: gcov
   fs: xfs

but it fails with

CommandFailedError: Command failed on 10.20.0.7 with status 1: 'rmdir -- =
/tmp/cephtest/ubuntu@teuthology-2013-03-04_21-03-19'
DEBUG:teuthology.run_tasks:Exception was not quenched, exiting: Exception=
: failed to fetch package version from http://gitbuilder.ceph.com/ceph-de=
b-quantal-x86_64-gcov/ref/master/version
INFO:teuthology.run:Summary data:

I would very much appreciate a hint.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig45C58554A3A27327DDBB0416
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE1MOYACgkQ8dLMyEl6F216NQCbBdAy9a/5onnW1pAxP4icbXj4
/PsAn2FyvPQ3Od0n+iL5Iq9rtjJ/Cxgr
=1oi/
-----END PGP SIGNATURE-----

--------------enig45C58554A3A27327DDBB0416--
