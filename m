From: Loic Dachary <loic@dachary.org>
Subject: gitbuilder, master branch and make check bot
Date: Thu, 05 Mar 2015 19:00:24 +0100
Message-ID: <54F899B8.1050005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="v1sgJIdgKq9wcjLn8VaCFDwIMgutHeQib"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53404 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753880AbbCESA1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 13:00:27 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 1C5F242B25
	for <ceph-devel@vger.kernel.org>; Thu,  5 Mar 2015 19:00:25 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v1sgJIdgKq9wcjLn8VaCFDwIMgutHeQib
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The make check bot that runs on pull requests is on pause until the gitbu=
ilder ( http://ceph.com/gitbuilder.cgi ) upgrade is complete. This should=
 fix the build of the master branch. All should be fixed in the next few =
hours at most.

Thanks for your patience :-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--v1sgJIdgKq9wcjLn8VaCFDwIMgutHeQib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT4mbgACgkQ8dLMyEl6F22TaACeLA+ztBMW+3JM7gCfKDFLXQX9
mi4AnRzhfGwb9NxkH+NdxPRsq0se5Be8
=9Nkq
-----END PGP SIGNATURE-----

--v1sgJIdgKq9wcjLn8VaCFDwIMgutHeQib--
