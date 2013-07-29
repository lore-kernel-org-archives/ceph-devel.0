From: Loic Dachary <loic@dachary.org>
Subject: Re: ObjectContext & PGRegistry API
Date: Mon, 29 Jul 2013 14:27:20 +0200
Message-ID: <51F65FA8.2020608@dachary.org>
References: <51ED96FF.4030606@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3675450FA8910E7C5E79773"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:35034 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3G2M1W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 08:27:22 -0400
In-Reply-To: <51ED96FF.4030606@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3675450FA8910E7C5E79773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Sorry to bother you with this again. Would you have time to quickly revie=
w this proposal ? I'm sure you'll have comments that will require work on=
 my part ;-)

Cheers

On 22/07/2013 22:33, Loic Dachary wrote:
> Hi Sam,
>=20
> Here is the proposed ObjectContext & PGRegistry API:
>=20
> https://github.com/dachary/ceph/blob/wip-5487/src/osd/PGRegistry.h
>=20
> which is part of the following commit
>=20
> https://github.com/dachary/ceph/commit/60958095585a1f8392d8a967767f7620=
089d547d
>=20
> It's a first draft and I asume your comments will require significant
> work on my part. I'd rather do it as soon as possible, while my short
> term memory is still fresh ;-)
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigD3675450FA8910E7C5E79773
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH2X6gACgkQ8dLMyEl6F20kYQCgjho88eBX0lalTXbgrcy7EWS1
It0An2vBib2vxYgQNNBlw2AyZoCGqC4P
=VSR/
-----END PGP SIGNATURE-----

--------------enigD3675450FA8910E7C5E79773--
