From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure coding / jerasure: topic of interest?
Date: Sat, 21 Sep 2013 09:01:14 +0200
Message-ID: <523D443A.8040508@dachary.org>
References: <523D2D33.1030407@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDD5F630D9AD79D73AA70110C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:40936 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab3IUHBR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Sep 2013 03:01:17 -0400
In-Reply-To: <523D2D33.1030407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD5F630D9AD79D73AA70110C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dan,

It will be exciting to see the next jerasure release integrate the optimi=
zations from gf-complete. It should happen before the end of the year :-)=


Cheers

On 21/09/2013 07:22, Dan Mick wrote:
> At SDC this week, Ethan Miller presented about some work he has done al=
ong with others including Jim Plank, who also was involved with jerasure;=
 it seems like this work may be useful for optimizing the
> erasure code calculations on Intel CPUs, at least:
>=20
> http://bitbucket.org/ethanmiller/gf-complete
>=20
> Paper here: http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pd=
f
> looks very much like the presentation Ethan gave at the conference.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigDD5F630D9AD79D73AA70110C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI9RDsACgkQ8dLMyEl6F23ifgCeIASru3BlrbCwMbWHv/80XmMy
WwEAn2KASQSpDpjIHzOvPJfJFV1gtqpY
=3Qn3
-----END PGP SIGNATURE-----

--------------enigDD5F630D9AD79D73AA70110C--
