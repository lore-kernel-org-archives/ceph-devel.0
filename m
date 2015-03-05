From: Loic Dachary <loic@dachary.org>
Subject: gmock linkage / packaging errors
Date: Thu, 05 Mar 2015 19:09:47 +0100
Message-ID: <54F89BEB.3080303@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="C9WkB5Jk69vVT0XLc6v52wosKw6c48Xv7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53412 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753174AbbCESJt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 13:09:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C9WkB5Jk69vVT0XLc6v52wosKw6c48Xv7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Danny,

The build of master shows linkage errors:

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basic/l=
og.cgi?log=3D60e2bec73ff3970e0c6b44250ce465e6c5dde56f

    error: dpkg-shlibdeps: couldn't find library libgmock_main.so.0 neede=
d by debian/ceph-test/usr/bin/ceph_test_cls_lock (ELF format: 'elf64-x86-=
64'; RPATH: '')=20

    error: dpkg-shlibdeps: couldn't find library libgtest.so.0 needed by =
debian/ceph-test/usr/bin/ceph_test_cls_lock (ELF format: 'elf64-x86-64'; =
RPATH: '')=20

    error: dpkg-shlibdeps: couldn't find library libgmock_main.so.0 neede=
d by debian/ceph-test/usr/bin/ceph_test_rados_api_c_write_operations (ELF=
 format: 'elf64-x86-64'; RPATH: '')=20

Do you know where that comes from ? IIRC it successfully compiled in the =
gitbuilders on a branch of yours. That's weird.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--C9WkB5Jk69vVT0XLc6v52wosKw6c48Xv7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT4m+sACgkQ8dLMyEl6F20EuwCgmgFFGHS7X76xFiB7Od+ztnoj
VngAn28Unb6HdP1HhQ9TVJz5zcoWuOCE
=ofNl
-----END PGP SIGNATURE-----

--C9WkB5Jk69vVT0XLc6v52wosKw6c48Xv7--
