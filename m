From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: init script bug with multiple clusters
Date: Fri, 17 Apr 2015 08:58:03 +0200
Message-ID: <5530AEFB.1010805@m-privacy.de>
References: <5524FBB9.9070300@m-privacy.de> <CAC6JEv9gHVrTmuo_Nc1vSxCDmh9WckYwrBN34nPrt7gwptGmYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Gw7Vnp23MQcOtQDTvKeHIWxS8iUr3wpJ6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.155.129]:49064 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbbDQG6V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Apr 2015 02:58:21 -0400
In-Reply-To: <CAC6JEv9gHVrTmuo_Nc1vSxCDmh9WckYwrBN34nPrt7gwptGmYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gw7Vnp23MQcOtQDTvKeHIWxS8iUr3wpJ6
Content-Type: multipart/mixed;
 boundary="------------080706020008050201030805"

This is a multi-part message in MIME format.
--------------080706020008050201030805
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 17.04.2015 um 03:01 schrieb Gregory Farnum:
> This looks good to me, but we need an explicit sign-off from you for
> it. If you can submit it as a PR on Github that's easiest for us, but
> if not can you send it in git email patch form? :)

Attached patch against next branch in git email form - hope this is as
expected. Our devel system cannot send mail directly.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Vo=C3=9F-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=C3=A4ftsf=C3=BChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649


--------------080706020008050201030805
Content-Type: text/x-patch;
 name="0001-init-script-bug-with-multiple-clusters.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-init-script-bug-with-multiple-clusters.patch"

=46rom 1e4d9f4fcd688fcbe275f2cff55b272dfeec2e45 Mon Sep 17 00:00:00 2001
From: Amon Ott <a.ott@m-privacy.de>
Date: Fri, 17 Apr 2015 08:42:58 +0200
Subject: [PATCH] init script bug with multiple clusters The Ceph init scr=
ipt
 (src/init-ceph.in) creates pid files without cluster names.
 This means that only one cluster can run at a time. The
 solution is simple and works fine here: add "$cluster-" as
 usual.

Signed-off-by: Amon Ott <a.ott@m-privacy.de>
---
 src/init-ceph.in |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 2ff98c7..d88ca58 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -227,7 +227,7 @@ for name in $what; do
=20
     get_conf run_dir "/var/run/ceph" "run dir"
=20
-    get_conf pid_file "$run_dir/$type.$id.pid" "pid file"
+    get_conf pid_file "$run_dir/$cluster-$type.$id.pid" "pid file"
=20
     if [ "$command" =3D "start" ]; then
 	if [ -n "$pid_file" ]; then
--=20
1.7.10.4


--------------080706020008050201030805--

--Gw7Vnp23MQcOtQDTvKeHIWxS8iUr3wpJ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlUwrwIACgkQIrFYWkD7qS6K6ACePS+d0MT6iG6jgYQvtSFCn2Lz
q5MAn07XzSbK0Z9N1AmUl0qjVelht5ZE
=vd7q
-----END PGP SIGNATURE-----

--Gw7Vnp23MQcOtQDTvKeHIWxS8iUr3wpJ6--
