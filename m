From: Loic Dachary <loic@dachary.org>
Subject: Re: Add a converter in OSDMap to split the ruleset into rule
Date: Fri, 15 Aug 2014 11:26:16 +0200
Message-ID: <53EDD238.4020602@dachary.org>
References: <53EDD0C8.5020007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KGhirBanq5TjbBSUghsJ1k8tPfi5vs2ei"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59949 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752908AbaHOJ0X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 05:26:23 -0400
In-Reply-To: <53EDD0C8.5020007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KGhirBanq5TjbBSUghsJ1k8tPfi5vs2ei
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 15/08/2014 11:20, Loic Dachary wrote:
> Hi,
>=20
> I've added a few comments inline at https://github.com/xiaoxichen/ceph/=
commit/354c09131a64ac1e1a67c71794d1a3bab8334ca8 . Could you explain in ps=
eudo code, in the commit message, what upgrade strategy you are trying to=
 implement ?=20
>=20
> For testing purposes, I would create border cases (i.e. having a rule w=
ith ruleid !=3D ruleset) in a script similar to=20
>=20
>    https://github.com/ceph/ceph/blob/firefly/src/test/mon/osd-crush.sh
>=20
> and then trigger the upgrade and check that it enforces the constraint.=
=20

Which is exactly what you did ;-)

>=20
> There is a need for a change near=20
>=20
>    https://github.com/ceph/ceph/blob/master/src/crush/CrushWrapper.cc#L=
787
>=20
> so that it does not pick a ruleset different from the ruleid. Maybe tha=
t could be a first step in the right direction ? I mean, not modifying th=
e existing maps yet, just enforcing ruleid =3D=3D ruleset by changing the=
 code. So that a new cluster does not suffer from this inconsistency.
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--KGhirBanq5TjbBSUghsJ1k8tPfi5vs2ei
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPt0jgACgkQ8dLMyEl6F20opACeOFTxyUSbjFdjfzspk2WI+h6J
gWAAoLIMZR6k+r+DaVrNmTTldFmgRyvr
=ZdXj
-----END PGP SIGNATURE-----

--KGhirBanq5TjbBSUghsJ1k8tPfi5vs2ei--
