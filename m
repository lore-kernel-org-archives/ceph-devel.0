From: Loic Dachary <loic@dachary.org>
Subject: gitbuilder update request
Date: Tue, 17 Dec 2013 11:49:48 +0100
Message-ID: <52B02C4C.90608@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sgL4S50VgBEUAoMLtWQKpOqUubCsP5XLR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42640 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab3LQKtv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 05:49:51 -0500
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 208D926394
	for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 11:49:50 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sgL4S50VgBEUAoMLtWQKpOqUubCsP5XLR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The wip-use-pytest branch fails with:

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-basic/=
log.cgi?log=3D687ec237ea06e36fb44bf23e3850a5b6bdca721b

   dpkg-checkbuilddeps: Unmet build dependencies: python-pytest
   warning: dpkg-buildpackage: Build dependencies/conflicts unsatisfied; =
aborting.=20

Although pytest was added to the gitbuilder dependencies a week ago:

   https://github.com/ceph/autobuild-ceph/pull/4

It probably means that someone should manually update the machine to take=
 the change into account. I don't know who is the someone but I thank her=
/him in advance for her/his help :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--sgL4S50VgBEUAoMLtWQKpOqUubCsP5XLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKwLEwACgkQ8dLMyEl6F20PEwCcD+58aZkfr0hDtF/EQLBNLSey
V04AnRas6neGxJb4NO8Aa5/l+8R02Oa7
=y/7G
-----END PGP SIGNATURE-----

--sgL4S50VgBEUAoMLtWQKpOqUubCsP5XLR--
