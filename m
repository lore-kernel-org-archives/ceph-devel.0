From: Loic Dachary <loic@dachary.org>
Subject: advice on adding the rhel6-server-optional repo
Date: Sat, 07 Mar 2015 21:03:51 +0100
Message-ID: <54FB59A7.8080304@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6VBRqVrkT4xBgMNTfHjcba2LIwfLxEM9U"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54436 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752225AbbCGUDz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Mar 2015 15:03:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6VBRqVrkT4xBgMNTfHjcba2LIwfLxEM9U
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

When trying to compile Ceph on a fresh rhel 6.5 provisioned in a VPS via =
teuthology, I missed the following:

diff --git a/ceph.spec.in b/ceph.spec.in
index d284844..4c80cfe 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -45,7 +45,6 @@ BuildRequires:        gdbm
 BuildRequires: hdparm
 BuildRequires: libaio-devel
 BuildRequires: libcurl-devel
-BuildRequires: libedit-devel
 BuildRequires: libxml2-devel
 BuildRequires: libuuid-devel
 BuildRequires: libblkid-devel >=3D 2.17
@@ -95,7 +94,6 @@ BuildRequires:        fdupes
 Requires:      gdisk
 BuildRequires: nss-devel
 BuildRequires: keyutils-libs-devel
-BuildRequires: libatomic_ops-devel
 Requires:      gdisk
 Requires(post):        chkconfig
 Requires(preun):chkconfig

which I eventually found in [rhel6-server-optional] as installed with htt=
p://tracker.ceph.com/issues/11061#note-2

How do you suggest I script this in https://ceph.com/git/?p=3Dceph.git;a=3D=
blob;f=3Dinstall-deps.sh so people don't worry about it ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--6VBRqVrkT4xBgMNTfHjcba2LIwfLxEM9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT7WacACgkQ8dLMyEl6F20hSACgjvkvlJ/8AxWkSADtyKPGEWh6
pD0AoIlr2j+CB9i1j528e7SXta1pod1Z
=ibO6
-----END PGP SIGNATURE-----

--6VBRqVrkT4xBgMNTfHjcba2LIwfLxEM9U--
