From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure-1.2A valgrind error
Date: Fri, 23 Aug 2013 19:04:26 +0200
Message-ID: <5217961A.1000806@dachary.org>
References: <521788BE.1010404@dachary.org> <1518C028-7AEE-4385-BBDE-0CB15BC2DCE3@cs.utk.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE45ECCEFE922D6C2A0822D16"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:50527 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab3HWRE2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 13:04:28 -0400
In-Reply-To: <1518C028-7AEE-4385-BBDE-0CB15BC2DCE3@cs.utk.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Plank <plank@cs.utk.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE45ECCEFE922D6C2A0822D16
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[cc'ing the mailing list for the record]

On 23/08/2013 18:53, James Plank wrote:
> Hi Loic -- I see why valgrind is having issues with that, but it's safe=
 -- I have double-checked it. =20

Thanks, I'm reassured :-)

>=20
> Tell you what, though -- you should change the "+10" in line 425 of enc=
oder.c to +20 (+11 will do, but you may as well be safe --.  I'm guessing=
 that bug doesn't manifest too often -- the file name sizes have to align=
 -- but when it does, it's a problem.
>=20

Ok.

> Best wishes -- Jim
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigE45ECCEFE922D6C2A0822D16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIXlhoACgkQ8dLMyEl6F22k7wCgnOxAB+Rk8HePlXlALjjr+Dul
kIYAoKUjhq08B7cgGQ2x+6h3MAIPGXf2
=/iG+
-----END PGP SIGNATURE-----

--------------enigE45ECCEFE922D6C2A0822D16--
