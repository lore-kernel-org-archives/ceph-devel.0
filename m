From: Loic Dachary <loic@dachary.org>
Subject: Re: better temp objects
Date: Fri, 30 Aug 2013 00:29:44 +0200
Message-ID: <521FCB58.4080607@dachary.org>
References: <alpine.DEB.2.00.1308291331130.24783@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1B66D179E166DE6E732D0417"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:55639 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab3H2W3r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 18:29:47 -0400
In-Reply-To: <alpine.DEB.2.00.1308291331130.24783@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: sam.just@inktank.com, greg.farnum@inktank.com, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B66D179E166DE6E732D0417
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

What is the temp collection used for ? Is there a thread / document I cou=
ld read to learn about it or a piece of code that is mainly about it ?

Cheers

On 29/08/2013 22:40, Sage Weil wrote:
> Here's what I'm thinking:
>=20
> Above the ObjectStore, we clear everything from temp on restart anyway.=

>=20
> We always write bits of a temp object in pieces, and then at the end=20
> copy/move it into the main collection. =20
>=20
> On replay, we should *only* do that final move/rename if the temp objec=
t=20
> was replayed in its entirety.
>=20
> So:
>=20
> - clear out temp collections in the filestore on startup.
>=20
> - give temp objects unique names so that they don't collide with non-te=
mp=20
> object fd caching (or whatever else).  for the DBObjectMap part there i=
s=20
> probably some futzing though to make this work right.
>=20
> - add a new 'move_from_temp' type operation that renames an object a te=
mp=20
> (coll_t::is_temp()) collection to a non-temp one.  it will succeed iff =
the=20
> temp source exists.
>=20
> - all operations that write to temp objects fail if the object doesn't =

> already exist, except an explicit 'create' op
>=20
> - all transactions the osds generate that write to temp object start wi=
th=20
> that explicit create.
>=20
> The combination of these thigns means that we will only have a temp sou=
rce=20
> for the move_from_temp op if it is complete.  Which I think means we ca=
n=20
> avoid any of the fsync guard stuff entirely.
>=20
> The DBObjectMap I'm very fuzzy on, so I suspect that's where the tricky=
=20
> part will be.  Maybe the temp object name includes the intended hobject=
_t=20
> in it somewhere, or something, so that the rename can be reflected=20
> in leveldb at the end.
>=20
> Thoughts?  Maybe we can do a quick hangout this afternoon to make sure =

> this will work before I start putting it together...
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig1B66D179E166DE6E732D0417
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIfy1gACgkQ8dLMyEl6F22OxQCeMfaZl1RVsKB+EV/IKO/qWIzq
s2cAnjQMO2aX/zkqVS7VHyVDww7idBUC
=uMGD
-----END PGP SIGNATURE-----

--------------enig1B66D179E166DE6E732D0417--
