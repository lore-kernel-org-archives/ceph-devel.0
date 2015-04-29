From: Loic Dachary <loic@dachary.org>
Subject: Retiring Dumpling
Date: Wed, 29 Apr 2015 21:58:09 +0200
Message-ID: <554137D1.8030107@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DQhEI4l1Q4TmGT3kWKrdvbHOgnUL6FWaN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54754 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750776AbbD2T6M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 15:58:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alistair Israel <aisrael@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DQhEI4l1Q4TmGT3kWKrdvbHOgnUL6FWaN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

We're a few days away from retiring dumpling, a few month after its theor=
itical end of life. It the first time a LTS Ceph release is retired and i=
t probably deserve a mail to announce it. Would you like me to draft one =
? My english is not so good but I can give it a shot.

Although the last point release for dumpling (v0.67.12) has been carefull=
y prepared[1], it looks like it won't be necessary to publish it[2]. It i=
s a good thing because it means the migration path from Dumpling to Firef=
ly works well. It also is a bit frustrating because it would have been a =
nice conclusion. It feels like building houses with lots of precautions i=
n case of an earthquake and ... no earthquake ;-)

Cheers

[1] dumpling v0.67.12 http://tracker.ceph.com/issues/10560
[2] http://ceph.com/docs/master/dev/development-workflow/#cutting-a-new-s=
table-release
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--DQhEI4l1Q4TmGT3kWKrdvbHOgnUL6FWaN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVBN9EACgkQ8dLMyEl6F22NGACeJq1Jr6W2IxQYcS7p5iT8bROx
cB4AoLWkCRvF1K8/JvJDyzZdVWD0AgKV
=EyVd
-----END PGP SIGNATURE-----

--DQhEI4l1Q4TmGT3kWKrdvbHOgnUL6FWaN--
