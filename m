From: Loic Dachary <loic@dachary.org>
Subject: Merging hammer in master: conflict on gmock
Date: Mon, 09 Mar 2015 15:18:40 +0100
Message-ID: <54FDABC0.4080803@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fiVwpD9BdB6nAbCfNpna6SwBEOP5VmtGU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55145 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932515AbbCIOSn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 10:18:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fiVwpD9BdB6nAbCfNpna6SwBEOP5VmtGU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Danny,

As of now, git checkout master ; git merge origin/hammer gets a conflict =
on gmock

When we last discussed it you found that git merge -m 1 was a solution. B=
ut I'm not sure I fully understand the consequences.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--fiVwpD9BdB6nAbCfNpna6SwBEOP5VmtGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT9q8AACgkQ8dLMyEl6F21kNgCdHQtfxPEw/W3V8earuvRLXjGa
XqkAniEfKmrNUHZ3yBYJKEXhcAb8x+3/
=tCJO
-----END PGP SIGNATURE-----

--fiVwpD9BdB6nAbCfNpna6SwBEOP5VmtGU--
