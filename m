From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph versions
Date: Fri, 27 Feb 2015 00:38:31 +0100
Message-ID: <54EFAE77.3020101@dachary.org>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xBmbLM5ptfta2RnLAtatQbq3rfMI0A1f7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49679 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932213AbbBZXid (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 18:38:33 -0500
In-Reply-To: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xBmbLM5ptfta2RnLAtatQbq3rfMI0A1f7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

I prefer Option D because it's self explanatory. We could also drop the n=
ames. I became attached to them but they are confusing to the new users w=
ho is required to remember that firefly is 0.80, giant is 0.87 etc.

Cheers

On 27/02/2015 00:12, Sage Weil wrote:
> -- Option D -- "labeled"
>=20
> X.Y-{dev,rc,release}Z
>=20
>  - Increment Y on each major named release
>  - Increment X if it's a major major named release (bigger change=20
> than usual)
>  - Use dev, rc, or release prefix to clearly label what type of release=
=20
> this is
>  - Increment Z for stable updates
>=20
>  1.0-dev1 first infernalis dev release
>  1.0-dev2 another dev release
>  ...
>  1.0-rc1 first rc
>  1.0-rc2 next rc
>  1.0-release1 final release
>  1.0-release2 stable update
>  1.0-release3 stable update
>  1.1-dev1 first cut for j-release
>  1.1-dev2 ...
>  ...
>  1.1-rc1
>  1.1-release1 stable
>  1.1-release2 stable
>  1.1-release3 stable
>=20
> Q: How do I tell what kind of release this is?
> A: Look at the string embedded in the version
>=20
> Q: Will these funny strings confuse things that sort by version?
> A: I don't think so.

dev < rc < release : good pick ;-)

Cheers


--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--xBmbLM5ptfta2RnLAtatQbq3rfMI0A1f7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTvrncACgkQ8dLMyEl6F21LkQCfSJaVEy7dlDzbYBFIwe9Z3lZr
3kUAnjSsFLflmuu/wEcAZk7SrTuT5f1h
=tzpN
-----END PGP SIGNATURE-----

--xBmbLM5ptfta2RnLAtatQbq3rfMI0A1f7--
