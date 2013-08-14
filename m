From: Loic Dachary <loic@dachary.org>
Subject: Re: review request : ReplicatedPG::AccessMode::wake removal
Date: Wed, 14 Aug 2013 19:30:23 +0200
Message-ID: <520BBEAF.7080402@dachary.org>
References: <520B5939.9050503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB11A9F0C95095D22E28A0E31"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:48127 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759241Ab3HNRa0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 13:30:26 -0400
In-Reply-To: <520B5939.9050503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB11A9F0C95095D22E28A0E31
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I removed the code in a minimal way instead of removing the data member i=
tself, as you suggested.

https://github.com/dachary/ceph/commit/2f73eea0b8d7d4633d5887ba725d258ce8=
1f8ac0

On 14/08/2013 12:17, Loic Dachary wrote:
> Hi Sam,
>=20
> IIRC, a few weeks ago you told me that=20
>=20
> https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f=
582/src/osd/ReplicatedPG.cc#L4626
>=20
>   if (mode.wake) {
>     requeue_ops(mode.waiting);
>     for (list<Cond*>::iterator p =3D mode.waiting_cond.begin(); p !=3D =
mode.waiting_cond.end(); ++p)
>       (*p)->Signal();
>     mode.wake =3D false;
>   }=20
>=20
> was not used and could be discarded. In the context of https://github.c=
om/ceph/ceph/pull/414 I originally kept calling it wherever put_object_co=
ntext() was called, just to make sure no opportunity to signal the waiter=
s was missed.=20
>=20
> Since that could lead to very subtle bugs if I misunderstood what you m=
eant, I would very much appreciate a review of this specific commit.=20
>=20
> https://github.com/dachary/ceph/commit/014997d55aa8d614fe38a1f86faa246d=
3c13e21b
>=20
> I've not hit anything suspicious yet while running teuthology. But that=
's really the only part of this patch series that worries me.
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigB11A9F0C95095D22E28A0E31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlILvq8ACgkQ8dLMyEl6F22DxwCfcLMfcDlON5SKQE2x5CR+of3D
awMAoLBaqPQrvnJEkWN5fy59OBeVQqgL
=0xAq
-----END PGP SIGNATURE-----

--------------enigB11A9F0C95095D22E28A0E31--
