From: Loic Dachary <loic@dachary.org>
Subject: Re: Simplified LRC in CEPH
Date: Fri, 01 Aug 2014 18:17:44 +0545
Message-ID: <53DB88EC.4050209@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4AE753328@CERNXCHG44.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE75333D@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HVwOK1gmNduPv7L2pbwXsB0U5tP3iSwgg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52149 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751963AbaHAMcs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 08:32:48 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE75333D@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HVwOK1gmNduPv7L2pbwXsB0U5tP3iSwgg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Enlightening explanation, thank you !

On 01/08/2014 13:45, Andreas Joachim Peters wrote:
> Hi Loic et. al.
>=20
> I managed to prototype (and understand) LRC encoding similiar to Xorbas=
 in the ISA plug-in.
>=20
> As an example take a (16,4) code (which gives nice alignment for 4k blo=
cks) :
>=20
> For 4 sub groups of the data chunks you build e.g. local parities LP1-L=
P4
>=20
> LP1 =3D 1 ^ 2 ^ 3 ^ 4
>=20
> LP2 =3D 5 ^ 6 ^ 7 ^ 8
>=20
> LP3 =3D 9 ^ 10 ^ 11 ^ 12
>=20
> LP4 =3D 13 ^ 14 ^ 15 ^ 16
>=20
> You do normal erasure encoding with 4 RS chunks:
>=20
> RS(1..16) =3D (R1, R2, R3, R4)
>=20
> You compute the local parity LP5 for the erasure chunks:
>=20
> LP5 =3D R1 ^ R2 ^ R3 ^ R4
>=20
> The relation which holds for Vandermonde matrices (because the first ma=
trix row contains only 1's)
>=20
> LP1 ^ LP2 ^ LP3 ^ LP4 =3D R1
>=20
> So you need to store only 24 chunks (not 25):
>=20
> (1 .. 16) (R2,R3,R4) (LP1,LP2,LP3,LP4,LP5)
>=20
> Side remark: in this simplified explanation I imply R1, not LP5 as desc=
ribed in the Xorbas paper

Does it make a difference or is it equivalent ?

> The degree of the code is 5 e.g. you can construct a failure with 5 los=
ses where you loose data, while if you are 'lucky' the code can even repa=
ir up to 8 failures (one loss in each sub group + LP5,R2,R3,R4).
>=20
> The reconstruction traffic for single failures is:
>=20
> [(20 x 4) + (4 x 8)]/24 =3D~ 4.66 x [disk size] instead of 16 x [disk s=
ize]
>=20
> There are three repair scenarios:
>=20
> 1) only single failures in any of the local groups using LRC repair (si=
mple parities)
> 2) multiple failures which can be reconstructed with RS parities withou=
t LRC repair
> 3) multiple failures which can be reconstructed with RS parities after =
LRC repair
>=20
> [ 4) reconstruction impossible  ]
>=20
> Having your proposed LRC layer (decoding) model in mind there is a cert=
ain contradiction here because there are cases where it is not required t=
o use LRC since you can resolve all the failures with RS alone.
>=20
> In the end I think, it is sufficient if we introduce a parameter l in t=
he EC parameter list which defines the number of subgroups in the data ch=
unks and imply to use always one local parity for all RS chunks. So you c=
an specify an LRC easily with three simple parameters:
>=20
> k=3D16 m=3D4 l=3D4
>=20
> The Xorbas configuration would be written as k=3D10 m=3D4 l=3D2
>=20
> Wouldn't that be much simpler and sufficient? What do you think?

It would, definitely. How would you control where data / parity chunks ar=
e located ?

Cheers
>=20
> Cheers Andreas.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--HVwOK1gmNduPv7L2pbwXsB0U5tP3iSwgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPbiOwACgkQ8dLMyEl6F21OCwCfQZK/L7Km0ixrrdmAN0zJ0T4n
gtsAnRwrvbELN/U5N+E3LQPH1CoicVmE
=IMPB
-----END PGP SIGNATURE-----

--HVwOK1gmNduPv7L2pbwXsB0U5tP3iSwgg--
