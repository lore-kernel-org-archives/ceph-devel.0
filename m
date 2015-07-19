From: Loic Dachary <loic@dachary.org>
Subject: Breaks & Replaces in debian/control in backports
Date: Sun, 19 Jul 2015 13:28:04 +0200
Message-ID: <55AB89C4.50503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="17DMFc4MVJVRfjsAwrE4Wi1GXCwVjAlwO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52486 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751496AbbGSL2I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jul 2015 07:28:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--17DMFc4MVJVRfjsAwrE4Wi1GXCwVjAlwO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

In the context of https://github.com/ceph/ceph/pull/5206 we need to adapt=
 the version constraints for the Breaks / Replaces in debian/control. Wha=
t we currently do is something like x.y.z-vvv where we randomly pick vvv =
to be something we're sure won't be greater than the actual vvv from git-=
describe that will be associated to this specific commit (otherwise the c=
onstraints won't be satisfied and the install will break).=20

When backporting it translates into something like:

Package: ceph
Depends: ceph-common (>=3D 0.94.2-23)

Package: ceph-common
Replaces: ceph-client-tools,
	  ceph (<< 0.94.2-23),
Breaks: ceph (<< 0.94.2-23),

I propose instead we use the version of the previous stable release like =
so:

Package: ceph
Depends: ceph-common (>> 0.94.2)

Package: ceph-common
Replaces: ceph-client-tools,
	  ceph (<=3D 0.94.2),
Breaks: ceph (<=3D 0.94.2),

I think it achieves the same thing and is less error prone in the case of=
 backports. The risk is that upgrading from v0.94.2-34 to the version wit=
h this change will fail because the conditions are satisified (it thinks =
all versions after v0.94.2 have the change). But the odds of having a tes=
t machine with this specific version already installed are close to non-e=
xistent. The odds of us picking the wrong number and ending up with somet=
hing that's either too high or too small are higher.

What do you think ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--17DMFc4MVJVRfjsAwrE4Wi1GXCwVjAlwO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWricQACgkQ8dLMyEl6F20+CgCdH0HlZL55d+7kb/yAMyYhDjG6
REUAoKeOqUqWlwO86gqo/O3Sxl6znuk4
=OWqJ
-----END PGP SIGNATURE-----

--17DMFc4MVJVRfjsAwrE4Wi1GXCwVjAlwO--
