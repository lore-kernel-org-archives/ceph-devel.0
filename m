From: Loic Dachary <loic@dachary.org>
Subject: Re: branches! infernalis vs master, RIP next
Date: Wed, 30 Sep 2015 00:17:59 +0200
Message-ID: <560B0E17.9070709@dachary.org>
References: <alpine.DEB.2.00.1509291310470.4617@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="m5mtiMU6lGOgA4p0n7231hhxUFkHfjbcQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34764 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756521AbbI2WSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Sep 2015 18:18:02 -0400
In-Reply-To: <alpine.DEB.2.00.1509291310470.4617@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m5mtiMU6lGOgA4p0n7231hhxUFkHfjbcQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 29/09/2015 23:12, Sage Weil wrote:
> Having master and infernalis branches follow each other is preventing s=
ome=20
> folks from moving forward with post-infernalis work.  And it's confusin=
g. =20
> So, we're proposing a new world order... and this time it should keep=20
> things consistent both during regular development and stabilization=20
> periods:
>=20
>  master - where new feature work is merged
>  infernalis ($next_stable) - where bug fixes are merged
>  hammer, firefly ($previous_stable) - where bug fixes are merged
>=20
> Previously we had a 'next' branch that was whatever the next pending=20
> release would be.  This will henceforth be named after the next major=20
> release (currently infernalis).  This let's us avoid having next someti=
mes=20
> during regular development periods and not during stabilization periods=
=2E =20
> It also means that we needn't know ahead of time whether the next relea=
se=20
> is going to be a development release, rc, or the initial (x.2.0) releas=
e=20
> of the next stable series.
>=20
> That $next_stable branch (currently infernalis) will periodically get=20
> merged back into master, just like next did.  We will stop doing that w=
hen=20
> the release is made.  From that point forward, any stable series backpo=
rts=20
> will be cherry-picked.
>=20
> The only real difference then between the development and stabilization=
=20
> periods is that during development we pull in new stuff from master eac=
h=20
> time we release, and releases are x.0.z.  During stabilization, we do r=
c=20
> releases that look like x.1.z, and we don't merge in anything new from =

> master.
>=20
> So:
>=20
>  1- Target any pull request with a bug fix that should go into infernal=
is=20
> at the infernalis branch.
>=20
>  2- Before merging anything, make sure it is targetting the right branc=
h. =20
> If it isn't, merge it manually, and verify it isn't pulling in a bunch =
of=20
> extra stuff (e.g., because a bug fix for infernalis was based on the=20
> current master branch).
>=20
>  3- We will periodically merge infernalis back into master until the fi=
rst=20
> infernalis (9.2.0) release.  After that we'll cherry-pick -x.
>=20
>  4- At that point we'll create a jewel branch that will work the same w=
ay. =20
> (It will be regularly merged into master, will eventually result in 10.=
0.z=20
> releases, and will pull lumps of new stuff from master in each time tha=
t=20
> happens.)

When 10.0.0 is released, the jewel branch is reset to master and will eve=
ntually be 10.0.1 etc. Is that right ?

>=20
> Sound okay?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--m5mtiMU6lGOgA4p0n7231hhxUFkHfjbcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYLDhcACgkQ8dLMyEl6F20q6QCfToAgXmVo13iLrdjxR8NNFb6B
/T0AoK/3NUc1vRcXHbVZSRx2jEPY5DEh
=PBdg
-----END PGP SIGNATURE-----

--m5mtiMU6lGOgA4p0n7231hhxUFkHfjbcQ--
