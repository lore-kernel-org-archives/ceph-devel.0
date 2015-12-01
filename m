From: Loic Dachary <loic@dachary.org>
Subject: Re: CodingStyle on existing code
Date: Tue, 1 Dec 2015 14:47:47 +0100
Message-ID: <565DA503.9000401@dachary.org>
References: <565D9C37.3060903@42on.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TA9Dd277F93eBRWGeW9SjAFNjhb9n1sTH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42101 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753276AbbLANrx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 08:47:53 -0500
In-Reply-To: <565D9C37.3060903@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TA9Dd277F93eBRWGeW9SjAFNjhb9n1sTH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/12/2015 14:10, Wido den Hollander wrote:
> Hi,
>=20
> While working on mon/PGMonitor.cc I see that there is a lot of
> inconsistency on the code.
>=20
> A lot of whitespaces, indentation which is not correct, well, a lot of
> things.
>=20
> Is this something we want to fix? With some scripts we can probably do
> this easily, but it might cause merge hell with people working on featu=
res.

A sane (but long) way to do that is to cleanup when fixing a bug or addin=
g a feature. With (a lot) of patience, it will eventually be better :-)

My 2cts.

> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--TA9Dd277F93eBRWGeW9SjAFNjhb9n1sTH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZdpQQACgkQ8dLMyEl6F20+kQCfe928YrApMDdlxI3IbH6973Hi
Bf4AoMcOAHOmW4C/HHLyvPdvgPpdDPGP
=a89e
-----END PGP SIGNATURE-----

--TA9Dd277F93eBRWGeW9SjAFNjhb9n1sTH--
