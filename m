From: Loic Dachary <loic@dachary.org>
Subject: Re: summit: erasure coding
Date: Thu, 09 May 2013 23:14:24 +0200
Message-ID: <518C11B0.9030606@dachary.org>
References: <alpine.DEB.2.00.1305090816130.26155@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA3551FAFA9BD97E5F226BAD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:38410 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab3EIVO0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 17:14:26 -0400
In-Reply-To: <alpine.DEB.2.00.1305090816130.26155@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA3551FAFA9BD97E5F226BAD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

I've created "PG/ReplicatedPG API" ( http://tracker.ceph.com/issues/4928 =
) for the first action item:

>  - clean up the OSD -> PG interface

and started with IPG class to be used in place of PG/ReplicatedPG ( https=
://github.com/dachary/ceph/commit/66d798753fc90e0daa7d8ce92ef7b692e259484=
f ).

I'll join the standup tomorrow ( past two days were hollidays in France ;=
-)

Cheers

On 05/09/2013 05:23 PM, Sage Weil wrote:
> We have a great session with Loic, Christopher, Sam, and Greg that=20
> discussed how to move forward with erasure coding support.  The high-le=
vel=20
> consensus on approach:
>=20
>  - it is possible to do erasure coding above rados across distinct pool=
s,=20
> but it is harder, and less useful.
>  - we should have an ErasureCodedPG that takes advantage of CRUSH's=20
> placement to place shards
>  - we can support a limited subset of rados operations for such pools a=
nd=20
> still be useful (write_full, or write/append on block boundaries)
>  - this will be used in conjuction with a replicated pool as a second t=
ier=20
> of storage, or by applications that are happy with a limited subset of =

> commands.
>=20
> That said, the implementation will be non-trivial.  But, we identified =

> several areas where code cleanup will move us down the right path.  By =

> factoring our useful components of PG and ReplicatedPG into separate=20
> classes, we clean up the current interfaces and can also build unit tes=
ts=20
> for them as we do so for immediate benefit.
>=20
> Initial focus areas:
>=20
>  - clean up the OSD -> PG interface (PG -> OSD is already reasonably we=
ll=20
>    captured by teh OSDService class)
>  - ObjectContext tracking
>  - PG log handling
>  - PG missing
>  - RepOp state
>  - Peering state machine
>=20
> The last one willb e most tricky (and saved for last).  In each case,=20
> we'll have to think carefully about how well things generalize from=20
> replication to erasure coding.
>=20
> Loic has volunteered to own this work, and Sam and I will be supporting=
=2E =20
> He'll also be joining our daily core standup.  Yay!
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigFA3551FAFA9BD97E5F226BAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGMEbAACgkQ8dLMyEl6F22d+ACfbq9xEury9SRbEqA0qETU1+3O
GngAoJ+g19ElzXryq6olOrqcVpkasQfg
=3z3A
-----END PGP SIGNATURE-----

--------------enigFA3551FAFA9BD97E5F226BAD--
