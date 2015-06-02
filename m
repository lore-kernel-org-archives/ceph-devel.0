From: Loic Dachary <loic@dachary.org>
Subject: make check bot paused
Date: Wed, 03 Jun 2015 01:48:25 +0200
Message-ID: <556E40C9.90900@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XfLvdemJ7ovpQk58cRDt795Xku5txtr2b"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55338 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751105AbbFBXsc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 19:48:32 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 008A842B3E
	for <ceph-devel@vger.kernel.org>; Wed,  3 Jun 2015 01:48:25 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XfLvdemJ7ovpQk58cRDt795Xku5txtr2b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The bot that reports unit tests and functional tests results from run-mak=
e-check.sh[1] on pull requests[2] will be paused tomorrow and resume in a=
 few days. The same verification can be done from sources by running the =
script with:

   git clone http://github.com/ceph/ceph
   cd ceph
   bash run-make-check.sh

Feel free to ping me if you experience problems. The most common cause of=
 trouble is low ulimits[3] which can lead to mysterious errors and proces=
s left overs. The minimum configuration is:

  4 cores
  16GB RAM
  30GB disk

Cheers

[1] run-make-check.sh http://workbench.dachary.org/ceph/ceph/blob/master/=
run-make-check.sh
[2] see https://github.com/ceph/ceph/pull/4833#issuecomment-108114267 for=
 instance
[3] ulimit verifications before make check http://workbench.dachary.org/c=
eph/ceph/blob/master/Makefile.am#L44
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--XfLvdemJ7ovpQk58cRDt795Xku5txtr2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVuQMkACgkQ8dLMyEl6F22yjQCaA8P7tSsEP7PURprYlle2I2II
m2AAn34EFC+c1HB7C/K+UMAkg4IYGMdF
=03B7
-----END PGP SIGNATURE-----

--XfLvdemJ7ovpQk58cRDt795Xku5txtr2b--
