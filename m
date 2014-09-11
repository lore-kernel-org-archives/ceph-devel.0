From: Loic Dachary <loic@dachary.org>
Subject: jerasure buffer misaligned
Date: Thu, 11 Sep 2014 23:04:32 +0200
Message-ID: <54120E60.3030704@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ODF2axLpba1iF7Es4JENcVmbLKiKpt0vO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50188 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755785AbaIKVEi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 17:04:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ODF2axLpba1iF7Es4JENcVmbLKiKpt0vO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Janne,

In the context of jerasure buffers you found to be misaligned, ( http://t=
racker.ceph.com/issues/9408 ) it would help fix it if you had a simple wa=
y to reproduce it. I read the code once more and I don't see something ob=
viously wrong.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--ODF2axLpba1iF7Es4JENcVmbLKiKpt0vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQSDmAACgkQ8dLMyEl6F23AvACeKa+bsypab2JosVRgG93choxQ
pKQAoLb9UzGv4oqFmcrEnFz/rmFjPji5
=HuSp
-----END PGP SIGNATURE-----

--ODF2axLpba1iF7Es4JENcVmbLKiKpt0vO--
