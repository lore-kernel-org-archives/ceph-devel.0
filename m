From: Loic Dachary <loic@dachary.org>
Subject: Call for jenkins slaves to improve multi operating system support
Date: Wed, 08 Apr 2015 12:56:20 +0200
Message-ID: <55250954.1010305@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6wdbV1BwlA7D3eUUtEjdjTvtAedamvlNK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43318 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751364AbbDHK4X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 06:56:23 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 33B3742B21
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 12:56:21 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wdbV1BwlA7D3eUUtEjdjTvtAedamvlNK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

When a contribution is proposed to Ceph [1], a bot compiles and run tests=
 with it to provide feedback to the developer [2]. When something goes wr=
ong the failure can be repeated on the developer machine [3] for debug. T=
his also helps the reviewer who knows the code compiles and does not brea=
k anything that would be detected by "make check".

The bot runs on CentOS 7 and Ubuntu 14.04 only, and problems related to o=
lder operating systems (headers, compiler version, etc.) may be detected =
later, when building packages [4] and after the pull request has been mer=
ged in master. This is rare but requires extra attention from the reviewe=
r and needs to be dealt with urgently when it happens.

If you can spare a machine to help expand the operating systems on which =
tests can run, it would be a great help. The minimum hardware configurati=
on to run a slave is:

*  x86_64 architecture for CentOS 6, Fedora 21, OpenSUSE 13.2, Debian GNU=
/Linux Jessie, Ubuntu 14.02

  32 GB RAM
  200 GB SSD
  8 core > 2.5Ghz

*  i386 architecture for CentOS 7, CentOS 6, Fedora 21, Debian GNU/Linux =
Jessie, Ubuntu 14.04, Ubuntu 14.02

  4 GB RAM
  200 GB disk
  2 core

*  armv7, armv8 architecture for Ubuntu 14.04

  4 GB RAM
  200 GB disk
  2 core=20

Note that since the make check bot can run in a docker container, x86_64 =
machines can be used to run any of the operating systems for which a dock=
er file has been prepared [5].

Cheers

[1] pull requests https://github.com/ceph/ceph/pulls
[2] make check bot feedback https://github.com/ceph/ceph/pull/4296#issuec=
omment-90812064
[3] run-make-check.sh https://github.com/ceph/ceph/blob/master/run-make-c=
heck.sh#L44
[4] gitbuilder http://ceph.com/gitbuilder.cgi
[5] https://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/Makefile.am;=
hb=3Dhammer#l91

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--6wdbV1BwlA7D3eUUtEjdjTvtAedamvlNK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUlCVQACgkQ8dLMyEl6F2378wCgxesr8ms+WvfkAu//a/e2R4NR
YD8AoJ8TbEy48LclFWN+qfLBGLtREiXs
=bJgZ
-----END PGP SIGNATURE-----

--6wdbV1BwlA7D3eUUtEjdjTvtAedamvlNK--
