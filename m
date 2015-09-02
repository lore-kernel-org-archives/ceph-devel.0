From: Loic Dachary <loic@dachary.org>
Subject: make check bot hicups today
Date: Wed, 02 Sep 2015 23:52:04 +0200
Message-ID: <55E76F84.7040204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UVpcsFLij5ccg7gHhDgtUUqW586jWt1Hl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48494 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753182AbbIBVwH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 17:52:07 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 497B142B2B
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2015 23:52:04 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UVpcsFLij5ccg7gHhDgtUUqW586jWt1Hl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot had troubles today because a yum repository temporaril=
y had missing files. While trying to figure that out the CentOS 7 docker =
image was updated and fails to create the container to run the tests. It =
is fixed but it will take a day or two before CentOS 7 is back. In the me=
antime the bot runs Ubuntu 14.04 only.

If the bot failed to visit a pull request, you can trigger it again with =
a git commit --amend + git push --force.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UVpcsFLij5ccg7gHhDgtUUqW586jWt1Hl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXnb4QACgkQ8dLMyEl6F23vZACffvkZE+aIvnw8ZRzBki+QW7em
QRAAoJ4dvj5dEkWtCqWXZPBwp4NZFytQ
=Nshc
-----END PGP SIGNATURE-----

--UVpcsFLij5ccg7gHhDgtUUqW586jWt1Hl--
