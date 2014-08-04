From: Loic Dachary <loic@dachary.org>
Subject: ErasureCode base class
Date: Mon, 04 Aug 2014 14:40:16 +0200
Message-ID: <53DF7F30.3080800@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LwLlSLBEgdejuUoJHCoS1cN7ofQ9Al9Wt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53453 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751988AbaHDMkX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 08:40:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LwLlSLBEgdejuUoJHCoS1cN7ofQ9Al9Wt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

A short note to let you know I'm rebasing https://github.com/ceph/ceph/pu=
ll/1911 ( erasure-code: remapping for locally repairable codes ). I'll ad=
apt the ISA plugin code accordingly, in particular for the new ErasureCod=
e base class https://github.com/dachary/ceph/commit/82705f77d5b60653e8395=
ca3909c4564d9ac6825. This should be straightforward but if you have any r=
eservation or warnings, I'm all ears ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--LwLlSLBEgdejuUoJHCoS1cN7ofQ9Al9Wt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPffzAACgkQ8dLMyEl6F21VcgCgjt7jAGJsLkazmPhy0dI9WuIw
VW4An3+pHv1m4srH9j/aCZbB35gCkxtg
=5DzB
-----END PGP SIGNATURE-----

--LwLlSLBEgdejuUoJHCoS1cN7ofQ9Al9Wt--
