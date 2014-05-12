From: Loic Dachary <loic@dachary.org>
Subject: Re: Implied parity and erasure code
Date: Mon, 12 May 2014 07:39:55 -0400
Message-ID: <5370B30B.4000609@dachary.org>
References: <536CF5BA.8040300@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE704806@CERNXCHG42.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="H0veHWpJ848uoxJ7J34mCKGq10P72csHl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34061 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbaELLkA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 May 2014 07:40:00 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE704806@CERNXCHG42.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H0veHWpJ848uoxJ7J34mCKGq10P72csHl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 10/05/2014 14:40, Andreas Joachim Peters wrote:
> Hi Loic,=20
> I think it is good to have the flexibility to include the global parity=
 stripes in local subgroups or as in the picture to make a subgroup out o=
f the global parities and compute a local paritiy for them. Although with=
 the chosen parameters these local subgroups are not symmetric (5,5 and 4=
 chunks per group)  but e.g. for 8+4 one would have 3 symmetric local gro=
ups as drawn and if you project is on a three data center setup you would=
 like to have for each center a local parity.=20
>=20
> But wasn't this already possible with your prototype implementation?

It was possible to distribute in this way, indeed. But there is no suppor=
t for the implied parity idea. I wonder how that would fit.

Cheers

>=20
> Cheers Andreas.
>=20
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 09 May 2014 17:35
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Implied parity and erasure code
>=20
> Hi Andreas,
>=20
> The "implied parity bloc" mentionned page 4 of http://anrg.usc.edu/~mah=
eswaran/Xorbas.pdf is something we've not discussed in the context of the=
 implementation of the pyramid erasure code plugin. I'm not sure if it wo=
uld be useful to have. Do you have an opinion ?
>=20
> Cheers
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--H0veHWpJ848uoxJ7J34mCKGq10P72csHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNwswsACgkQ8dLMyEl6F20ouACfZS5YjxQAg/RRtFHPcZHrguLj
ZTIAn3ynpq1KFC2ROjX80hvhIg/Pq++x
=DHBU
-----END PGP SIGNATURE-----

--H0veHWpJ848uoxJ7J34mCKGq10P72csHl--
