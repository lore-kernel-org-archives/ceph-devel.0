From: Loic Dachary <loic@dachary.org>
Subject: make check bot delays
Date: Thu, 15 Oct 2015 00:06:14 +0200
Message-ID: <561ED1D6.7060905@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="etrDL76TTxAktOSdR5Og40L0QIIggc2p0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43332 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753121AbbJNWGQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 18:06:16 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 5E28B428A7
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 00:06:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--etrDL76TTxAktOSdR5Og40L0QIIggc2p0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

TL;DR: the jenkins instance running make check bot hangs daily, looking f=
or a solution

In the past two weeks the make check bot has experienced troubles for whi=
ch I've been unable to find a cause. The same jenkins instance running it=
 for the past nine month now freezes at random times. Nothing in the logs=
, no error message: either the page or the slave are just doing nothing n=
o matter what. The only reliable solution seems to be a restart of jenkin=
s (killing the process since even restart blocks).=20

Maybe it's time for the make check bot to run via teuthology instead of j=
enkins.

Thanks for your patience

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--etrDL76TTxAktOSdR5Og40L0QIIggc2p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYe0dYACgkQ8dLMyEl6F20NEwCfU0rR6JCrX6noMdDVZYnBUbFV
V3wAn17LDJO0LaxIUzAwP9D+5s04vjfY
=e3T1
-----END PGP SIGNATURE-----

--etrDL76TTxAktOSdR5Og40L0QIIggc2p0--
