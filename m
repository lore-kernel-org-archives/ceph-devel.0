From: Loic Dachary <loic@dachary.org>
Subject: reducing package size / compression time
Date: Mon, 14 Sep 2015 00:38:10 +0200
Message-ID: <55F5FAD2.10802@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="J3jQXT11km3pqsMCBaVM10pCIHqmqFR2B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54749 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbbIMWiN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Sep 2015 18:38:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J3jQXT11km3pqsMCBaVM10pCIHqmqFR2B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

You did something to reduce the size (hence the compression time) of the =
debug packages using https://fedoraproject.org/wiki/Features/DwarfCompres=
sor. Would you be so kind as to remind me which commit does that ?

Thanks in advance :-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--J3jQXT11km3pqsMCBaVM10pCIHqmqFR2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX1+tIACgkQ8dLMyEl6F22r+gCgpZKGVXgzG89JCRZOZ7rUKLxK
2jEAoJlNNhp4P/Jj/HIV/FFocxU+TJpL
=Asw6
-----END PGP SIGNATURE-----

--J3jQXT11km3pqsMCBaVM10pCIHqmqFR2B--
