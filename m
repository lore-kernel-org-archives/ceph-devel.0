From: Loic Dachary <loic@dachary.org>
Subject: Erasure Code plugin system with an example  : review request
Date: Tue, 20 Aug 2013 13:55:29 +0200
Message-ID: <52135931.3040601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2440FE7D2D76E3424FB28882"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56458 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab3HTLzc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 07:55:32 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 87F9126394
	for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 13:55:30 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2440FE7D2D76E3424FB28882
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Yesterday I implemented a simple erasure code plugin that can sustain the=
 loss of a single chunk.

https://github.com/dachary/ceph/blob/wip-5878/src/osd/ErasureCodeExample.=
h

and it works as shown in the unit test

https://github.com/dachary/ceph/blob/wip-5878/src/test/osd/TestErasureCod=
eExample.cc

It would be of limited use in a production environment because it only sa=
ves 25% space ( M=3D2 K=3D1 ) over a 2 replica pool, but it would work.

I would very much appreciate a review of the erasure code plugin system a=
nd the associated example plugin :

https://github.com/ceph/ceph/pull/515

When it's good enough, creating a jerasure plugin will be next :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig2440FE7D2D76E3424FB28882
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlITWTEACgkQ8dLMyEl6F22rEgCgkBVfhHo1muLg+ouPKSIlGaAI
3hAAoJQIqW/0iMTNS5oLtDFM5BoYx7et
=3IN6
-----END PGP SIGNATURE-----

--------------enig2440FE7D2D76E3424FB28882--
