From: Loic Dachary <loic@dachary.org>
Subject: jerasure: galois_uninit_default_field
Date: Mon, 29 Sep 2014 14:11:24 +0200
Message-ID: <54294C6C.5090307@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3psG0LUmFtwg0tPWg3EU1bGx8a8UgeMcC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33961 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753498AbaI2MLb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 08:11:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3psG0LUmFtwg0tPWg3EU1bGx8a8UgeMcC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The following patch helps maintain the caller program valgrind clean:

    https://bitbucket.org/jimplank/jerasure/pull-request/24/define-galois=
_uninit_default_field/diff

Please let me know if you would like that done differently and I'll work =
on it.

Cheers

Reference: http://tracker.ceph.com/issues/8741

--=20
Lo=EFc Dachary, Artisan Logiciel Libre



--3psG0LUmFtwg0tPWg3EU1bGx8a8UgeMcC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQpTGwACgkQ8dLMyEl6F23m/wCcCnQEcZDV1QD4a366ok7s61ME
emEAoJIBG8kH9XiFTCTO3DYvYtdFYSaF
=7EpJ
-----END PGP SIGNATURE-----

--3psG0LUmFtwg0tPWg3EU1bGx8a8UgeMcC--
