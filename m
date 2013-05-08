From: Loic Dachary <loic@dachary.org>
Subject: PG/ReplicatedPG API
Date: Wed, 08 May 2013 02:17:57 +0200
Message-ID: <518999B5.3040606@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD168A6BA03549875426B5FF4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:33946 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab3EHASB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 20:18:01 -0400
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id E5F2326395
	for <ceph-devel@vger.kernel.org>; Wed,  8 May 2013 02:17:57 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD168A6BA03549875426B5FF4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The ceph summit was a great source of inspiration and feedback :-) I trie=
d to take into account Sam's suggestion to not define a base class but to=
 extract components that could be re-used for the implementation of the E=
rasureEncodedPG. To get there as smoothly as possible, I propose to rever=
se engineer the API and write tests for it ( my attempts are inconclusive=
 but I'm hopefull https://github.com/dachary/ceph/commit/3ea566e5918dd099=
de17bc2febadc9c49f782f0e ). The tests can then be used when extracting a =
common component to help make sure there is no regression or other uninte=
nted side effects.

I created a task for it ( http://tracker.ceph.com/issues/4928 ) and made =
it a child of an enclosing task for the implementation of erasure encodin=
g ( http://tracker.ceph.com/issues/4929 ) to track down the related ticke=
ts.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigD168A6BA03549875426B5FF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGJmbUACgkQ8dLMyEl6F23zEgCgo0HeyL7elCNQcBGS3EP5f7aA
8pQAn3XrSaCynFSUEq19oVGLzwotlCmQ
=byBl
-----END PGP SIGNATURE-----

--------------enigD168A6BA03549875426B5FF4--
