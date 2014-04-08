From: Loic Dachary <loic@dachary.org>
Subject: gf-complete thread safe initialization
Date: Tue, 08 Apr 2014 19:22:51 +0200
Message-ID: <5344306B.8030708@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qf1LUv3oQqQKPxJkFq5ClMoVkC9DwVpOQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:44211 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbaDHRW5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 13:22:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qf1LUv3oQqQKPxJkFq5ClMoVkC9DwVpOQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

The following patch is initializing the array in a lock protected / not t=
hread sensitive part of code.=20

https://github.com/ceph/ceph/pull/1621/files

Unless I'm mistaken, it ensures that it never happens automagically. The =
first few tests that were run indicate it's not more broken than it was b=
efore. We'll have to wait a few days to be sure that it fixes the issue.

Do you think that's a sensible way to avoid thread safety problem in the =
context of ceph ? Or are there other issues I don't see ?=20

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--qf1LUv3oQqQKPxJkFq5ClMoVkC9DwVpOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNEMGsACgkQ8dLMyEl6F23p+QCfZauLhMxTKfN2saUSU9YozTuQ
+ckAn1ztmyb0nVyGkEdrNFYU8I4hk51t
=DxA4
-----END PGP SIGNATURE-----

--qf1LUv3oQqQKPxJkFq5ClMoVkC9DwVpOQ--
