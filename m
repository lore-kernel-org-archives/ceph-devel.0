From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next hammer release v0.94.2
Date: Mon, 11 May 2015 14:21:26 +0200
Message-ID: <55509EC6.2060503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JBQ1M1JqkD22frD9XftwsRiiKVxQ01hAf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32898 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751290AbbEKMV2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 08:21:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JBQ1M1JqkD22frD9XftwsRiiKVxQ01hAf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the fs suite (http://tracker.ceph.com/issues/11492#fs), which =
also includes your last minute addition https://github.com/ceph/ceph/pull=
/4629. Do you think it is ready for QE to start their own round of testin=
g ?

Cheers

P.S. http://tracker.ceph.com/issues/11492#Release-information has direct =
links to the pull requests merged into hammer since v0.94.1 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre














--JBQ1M1JqkD22frD9XftwsRiiKVxQ01hAf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVQnsYACgkQ8dLMyEl6F22exgCfTakjKUGlQzXuRx//nx1pxBpr
HTQAmgLzznDNxvZGq1ptYJkq1ylMdP2R
=Q7CM
-----END PGP SIGNATURE-----

--JBQ1M1JqkD22frD9XftwsRiiKVxQ01hAf--
