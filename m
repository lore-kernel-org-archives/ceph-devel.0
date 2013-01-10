From: Loic Dachary <loic@dachary.org>
Subject: code coverage and teuthology
Date: Fri, 11 Jan 2013 00:07:48 +0100
Message-ID: <50EF49C4.1020909@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA68BA330705A6F85323A8FA8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:60991 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab3AJXOt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 18:14:49 -0500
Received: from [10.8.2.6] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 6379D26397
	for <ceph-devel@vger.kernel.org>; Fri, 11 Jan 2013 00:07:49 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA68BA330705A6F85323A8FA8
Content-Type: multipart/mixed;
 boundary="------------030208050309090502060309"

This is a multi-part message in MIME format.
--------------030208050309090502060309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I successfully run teuthology with the proposed 3node_rgw.yaml [1] and ch=
anging the flavor from basic to gcov [2]. I hoped to use cov-init.sh ( ht=
tps://github.com/ceph/teuthology/blob/master/coverage/cov-init.sh ) and t=
hen coverage.sh but I can't figure out how to make it work.

Hints would be most appreciated ;-)

[1] 3node_rgw.yaml

check-locks: false
interactive-on-error: true
overrides:
  ceph:
    branch: master
    fs: xfs
roles:
- - mon.a
  - mon.c
  - osd.0
- - mon.b
  - mds.a
  - osd.1
- - client.0
tasks:
- ceph: null
- rgw:
  - client.0
- interactive:

targets:
(snip)

[2] http://gitbuilder.ceph.com/ceph-tarball-precise-x86_64-gcov/

diff --git a/teuthology/task/ceph.py b/teuthology/task/ceph.py
index b62bc1d..99d4f18 100644
--- a/teuthology/task/ceph.py
+++ b/teuthology/task/ceph.py
@@ -1027,7 +1027,7 @@ def task(ctx, config):
     dist =3D 'precise'
     format =3D 'tarball'
     arch =3D 'x86_64'
-    flavor =3D 'basic'
+    flavor =3D 'gcov'

     # First element: controlled by user (or not there, by default):
     # used to choose the right distribution, e.g. "oneiric".
diff --git a/teuthology/task/kernel.py b/teuthology/task/kernel.py
index 5c34433..54eaebb 100644
--- a/teuthology/task/kernel.py
+++ b/teuthology/task/kernel.py
@@ -183,7 +183,7 @@ def download_deb(ctx, config):
                 package=3D'kernel',
                 sha1=3Dsrc,
                 format=3D'deb',
-                flavor=3D'basic',
+                flavor=3D'gcov',
                 arch=3D'x86_64',
                 dist=3D'precise',
                 )
@@ -408,7 +408,7 @@ def task(ctx, config):
                 branch=3Drole_config.get('branch'),
                 tag=3Drole_config.get('tag'),
                 sha1=3Drole_config.get('sha1'),
-                flavor=3D'basic',
+                flavor=3D'gcov',
                 format=3D'deb',
                 dist=3D'precise',
                 arch=3D'x86_64',


--------------030208050309090502060309
Content-Type: text/x-vcard; charset=utf-8;
 name="loic.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="loic.vcf"

begin:vcard
fn:Loic Dachary
n:Dachary;Loic
org:Artisan Logiciel Libre
adr:;;12 bd Magenta;Paris;;75010;France
email;internet:loic@dachary.org
title:Senior Developer
tel;work:+33 4 84 25 08 05
tel;home:+33 9 51 18 43 38
tel;cell:+33 6 64 03 29 07
note:Born 131414404 before EPOCH.
url:http://dachary.org/
version:2.1
end:vcard


--------------030208050309090502060309--

--------------enigA68BA330705A6F85323A8FA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDvScQACgkQ8dLMyEl6F22T9ACgutUdihJ5aLpwXAAkIj3JSF2a
LmAAoKYBYISksRX5VuMAUxMiEFq1V8k7
=HUKd
-----END PGP SIGNATURE-----

--------------enigA68BA330705A6F85323A8FA8--
