From: Loic Dachary <loic@dachary.org>
Subject: sharedptr_registry.hpp unit tests
Date: Wed, 24 Jul 2013 10:01:57 -0700
Message-ID: <51F00885.1040801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6CCA120A3B937F708EFF38EA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:34666 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3GXRCD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jul 2013 13:02:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6CCA120A3B937F708EFF38EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I added a commit=20

https://github.com/dachary/ceph/commit/14ab122b43fd028ccfeecbd7b03243ca45=
0501ce

to the pull request=20

https://github.com/ceph/ceph/pull/425

to address your comment

https://github.com/dachary/ceph/commit/a5bde96db5ea52e56fbe94accb3538aee4=
729aa3#commitcomment-3698471

I figured it would be easier for you to review the commit instead of a re=
base but I'd be happy to squash the two into a single one if you prefer.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig6CCA120A3B937F708EFF38EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHwCIUACgkQ8dLMyEl6F20z1wCbBfbX2cOWxVcqwaoicNDWJZDc
UiEAoMJt1tIrryWo2z3zZKr0TSWwlxe0
=5Ju5
-----END PGP SIGNATURE-----

--------------enig6CCA120A3B937F708EFF38EA--
