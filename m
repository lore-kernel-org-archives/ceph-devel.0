From: Loic Dachary <loic@dachary.org>
Subject: Add a converter in OSDMap to split the ruleset into rule
Date: Fri, 15 Aug 2014 11:20:08 +0200
Message-ID: <53EDD0C8.5020007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oMUc5XugFQpBTVbWUCi3AtXj3A03P6Cbd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59943 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295AbaHOJUQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 05:20:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oMUc5XugFQpBTVbWUCi3AtXj3A03P6Cbd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've added a few comments inline at https://github.com/xiaoxichen/ceph/co=
mmit/354c09131a64ac1e1a67c71794d1a3bab8334ca8 . Could you explain in pseu=
do code, in the commit message, what upgrade strategy you are trying to i=
mplement ?=20

For testing purposes, I would create border cases (i.e. having a rule wit=
h ruleid !=3D ruleset) in a script similar to=20

   https://github.com/ceph/ceph/blob/firefly/src/test/mon/osd-crush.sh

and then trigger the upgrade and check that it enforces the constraint.=20

There is a need for a change near=20

   https://github.com/ceph/ceph/blob/master/src/crush/CrushWrapper.cc#L78=
7

so that it does not pick a ruleset different from the ruleid. Maybe that =
could be a first step in the right direction ? I mean, not modifying the =
existing maps yet, just enforcing ruleid =3D=3D ruleset by changing the c=
ode. So that a new cluster does not suffer from this inconsistency.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--oMUc5XugFQpBTVbWUCi3AtXj3A03P6Cbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPt0MkACgkQ8dLMyEl6F23sYQCfRsAJo+OiKiFfDKJ4CSN1AKLa
Jc4AoK7hGXbRuBa0FBaU8rB54jJC2rdX
=sv6I
-----END PGP SIGNATURE-----

--oMUc5XugFQpBTVbWUCi3AtXj3A03P6Cbd--
