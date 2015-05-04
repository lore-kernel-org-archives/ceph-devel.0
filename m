From: Loic Dachary <loic@dachary.org>
Subject: Re: The first infernalis dev release will be v9.0.0
Date: Mon, 04 May 2015 19:18:35 +0200
Message-ID: <5547A9EB.4040404@dachary.org>
References: <alpine.DEB.2.00.1504301528410.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="B3csMDWpUblaqGgSiaNV4l7tuW1sP6QRG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57150 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752045AbbEDRSi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 13:18:38 -0400
In-Reply-To: <alpine.DEB.2.00.1504301528410.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B3csMDWpUblaqGgSiaNV4l7tuW1sP6QRG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

+1 ;-)

On 04/05/2015 18:09, Sage Weil wrote:
> The first Ceph release back in Jan of 2008 was 0.1.  That made sense at=
=20
> the time.  We haven't revised the versioning scheme since then, however=
,=20
> and are now at 0.94.1 (first Hammer point release).  To avoid reaching =

> 0.99 (and 0.100 or 1.00?) we have a new strategy.  This was discussed a=
=20
> bit on ceph-devel and in #ceph-devel and there doesn't appear to be any=
=20
> scheme that everyone likes.
>=20
> So, we're going to go with something that only a few people dislike:
>=20
>  x.0.z - development releases (for early testers and the brave at heart=
)
>  x.1.z - release candidates (for test clusters, brave users)
>  x.2.z - stable/bugfix releases (for users)
>=20
> x will start at 9 for Infernalis ("I" is the 9th letter), making our fi=
rst=20
> development release of the 9th release cycle 9.0.0.  Subsequent=20
> development releases will be 9.0.1, 9.0.2, etc.
>=20
> In a couple months we'll have a 9.1.0 (and maybe 9.1.1) release candida=
te.
>=20
> A few weeks after that we'll have the Infernalis release 9.2.0, followe=
d=20
> by stable bug fix updates 9.2.1, 9.2.2, etc., and then begin work on th=
e=20
> Jewel (10.y.z) release.
>=20
> We'll see how this works out.  We can adjust this in the future to any =

> other 9.y.z scheme (e.g., 9.1, 9.2 etc dev releases and 9.8.z stable=20
> releases); the main commitment here is to the 9 part, indicating=20
> Infernalis is the 9th major release cycle.
>=20
> Onward!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--B3csMDWpUblaqGgSiaNV4l7tuW1sP6QRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVHqesACgkQ8dLMyEl6F2313gCfbr7JJqeiIZ735G/OYy6TvMxi
wygAn3qkyH7gv0Pxwp5KS0QSWK4Somom
=x/q8
-----END PGP SIGNATURE-----

--B3csMDWpUblaqGgSiaNV4l7tuW1sP6QRG--
