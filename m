From: Loic Dachary <loic@dachary.org>
Subject: make check bot disabled on Ubuntu 14.04
Date: Thu, 20 Aug 2015 16:23:41 +0200
Message-ID: <55D5E2ED.4050109@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="faXiNunC0ERdqgbAHLWCdBquiJmKTXjP5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41248 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751553AbbHTOXn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Aug 2015 10:23:43 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 432A942B28
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2015 16:23:41 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--faXiNunC0ERdqgbAHLWCdBquiJmKTXjP5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

For the next 24h the make check bot is disabled for Ubuntu 14.04. An erro=
r preventing it from running and is being fixed at https://github.com/cep=
h/ceph/pull/5620

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--faXiNunC0ERdqgbAHLWCdBquiJmKTXjP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXV4u0ACgkQ8dLMyEl6F225yACggpe+03yayDmz4araHNVQn4mR
wPQAoKpLzdIC7UEUaceFpWl66CYuU9vH
=KtFi
-----END PGP SIGNATURE-----

--faXiNunC0ERdqgbAHLWCdBquiJmKTXjP5--
