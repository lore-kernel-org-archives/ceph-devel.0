From: Loic Dachary <loic@dachary.org>
Subject: Using google mock
Date: Fri, 29 Mar 2013 08:16:04 +0100
Message-ID: <51553FB4.8000208@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5056D55E1E258B925903F856"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:40014 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab3C2HQH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 03:16:07 -0400
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id B1B1226394
	for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 08:16:04 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5056D55E1E258B925903F856
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Google mock ( ) provides convenient string matchers ( http://code.google.=
com/p/googlemock/wiki/CheatSheet#String_Matchers ) that would be useful w=
hen writing unit tests. It is available in most distributions:

http://packages.debian.org/search?keywords=3Dgoogle-mock
https://launchpad.net/ubuntu/+source/google-mock
http://rpmfind.net/linux/rpm2html/search.php?query=3Dgmock

I've never used it before. Any objection on adding it as a dependency in =
addition to google test ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig5056D55E1E258B925903F856
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlFVP7QACgkQ8dLMyEl6F20+MwCghHvnB20CV2N3/denk0N9pOYL
UvsAoIR5mT0nWlEMq+0PPr7rnQ5+pl+l
=ej67
-----END PGP SIGNATURE-----

--------------enig5056D55E1E258B925903F856--
