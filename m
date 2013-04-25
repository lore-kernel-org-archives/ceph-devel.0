From: Loic Dachary <loic@dachary.org>
Subject: OSD abstract class
Date: Thu, 25 Apr 2013 10:17:50 +0200
Message-ID: <5178E6AE.6060609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF56D070BD2CAACD1507AE5D2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:57254 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab3DYIRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 04:17:54 -0400
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id B891B26395
	for <ceph-devel@vger.kernel.org>; Thu, 25 Apr 2013 10:17:51 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF56D070BD2CAACD1507AE5D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

In the context of the implementation of

http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_as=
_a_storage_backend

I'm preparing tests to assert that the modifications that will be made to=
 the existing PG and ReplicatedPG will not introduce regressions. Unless =
I'm mistaken, there are no unit tests or functional tests for PG or Repli=
catedPG at the moment. I thought that it might be useful to add an abstra=
ct OSD class from which OSD is derived, to allow a test to derive from it=
 to implement synthetic behavior.=20


I gave it a try and it passes make check successfully. It is a little hai=
ry because I commented out the code instead of removing it to help with r=
ebasing.=20

https://github.com/dachary/ceph/commit/a9eb690a3537c3f844b47e76cde048b084=
e314eb

I'll now try to use it to implement some tests for ReplicatedPG.=20

I would very much appreciate if someone has an advice on the best way to =
proceed. Even if it's to say : "you're crazy, don't go there ! you're was=
ting your time, there is a much simpler way !" ;-)

Cheers
=20
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigF56D070BD2CAACD1507AE5D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF45q8ACgkQ8dLMyEl6F22tlwCgvIj4pPu24QvXe7EVo2hd8kaQ
DBcAoI5ftNjMoVJNooXVjAviJbcWsonr
=KywN
-----END PGP SIGNATURE-----

--------------enigF56D070BD2CAACD1507AE5D2--
