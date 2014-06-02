From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid erasure code description revisited
Date: Mon, 02 Jun 2014 15:14:47 +0200
Message-ID: <538C78C7.2090308@dachary.org>
References: <538A0CF8.8030501@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE72E354@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QMqfjCuFUicov2i4tPpJhWWqipr09BGwi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58150 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbaFBNOu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 09:14:50 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE72E354@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Koleos Fuscus <koleosfuscus@yahoo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QMqfjCuFUicov2i4tPpJhWWqipr09BGwi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 02/06/2014 14:20, Andreas Joachim Peters wrote:> Hi Loic,=20
>=20
> I think this gives all the flexibility to define any possible combinati=
on for encoding ...
>=20
> When one constructs the steps one has just to be aware that the 'most l=
ocal' encoding should happen in the end, right?

Yes.=20

>=20
> It would be usefule to have a tool which outputs then for each data aND=
 parity chunk the achieved 'redundancy' and the overall volume and maxima=
l reconstruction 'overhead'.

Right. I'm kind of hoping koleosfuscus (cc'ed) will be able to fit that i=
nto the reliability model, but we've not discussed that yet. In any case =
you are right, a small command line tool would be helpful. Something that=
 would explain: if you loose one of the chunks you need four to recover. =
If you lose two you need all of them. That's more humanly readable and un=
derstandable than the full description ;-)

Cheers

>=20
> Cheers Andreas.
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 31 May 2014 19:10
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Pyramid erasure code description revisited
>=20
> Hi Andreas,
>=20
> After a few weeks and a fresh eye, I revisited the way pyramid erasure =
code could be described by the system administrator. Here is a proposal t=
hat is hopefully more intuitive than the one from the last CDS ( http://p=
ad.ceph.com/p/cdsgiant-pyramid-erasure-code ).
>=20
> These are the steps to create all coding chunks. The upper case letters=
 are data chunks and the lower case letters are coding chunks.
>=20
> "__ABC__DE_" data chunks placement
>=20
> Step 1
> "__ABC__DE_"
> "_yVWX_zYZ_" K=3D5, M=3D2
> "_aABC_bDE_"
>=20
> Step 2
> "_aABC_bDE_"
> "z_XYZ_____" K=3D3, M=3D1
> "caABC_bDE_"
>=20
> Step 3
> "caABC_bDE_"
> "_____zXYZ_" K=3D3, M=3D1
> "caABCdbDE_"
>=20
> Step 4
> "caABCdbDE_"
> "_____WXYZz" K=3D4, M=3D1
> "caABCdbDEe"
>=20
> The interpretation of Step 3 is as follows:
>=20
> Given the output of the previous step ( "caABC_bDE_" ), the bDE chunks =
are considered to be data chunks at this stage and they are marked with X=
YZ. A K=3D3, M=3D1 coding chunk is calculated and placed in the chunk mar=
ked with z ( "_____zXYZ_" ). The output of this coding step is the previo=
us step plus the coding chunk that was just calculated, named d ( "caABCd=
bDE_" ).
>=20
> This gives the flexibility of deciding wether or not a coding chunk fro=
m a previous step is used as data to compute the coding chunk of the next=
 step. It also allows for unbalanced steps such as step 4.
>=20
> For decoding, the steps are walked from the bottom up. If E is missing,=
 it can be reconstructed from dbD.e in step 4 and the other steps are ski=
pped because it was the only missing chunk. If AB are missing, all steps =
that have not be used to encode it are ignored, up to step 2 that will fa=
il to recover them because M=3D1 and yeild to step 1 that will use a..CbD=
E successfully because M=3D2.
>=20
> Giving up the recursion and favor iteration seems to simplify how it ca=
n be explained. And I suspect the implementation is also simpler. What do=
 you think ?
>=20
> Cheers
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--QMqfjCuFUicov2i4tPpJhWWqipr09BGwi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOMeMcACgkQ8dLMyEl6F21eVQCgmcUPJqHCO4l5iRbhMD9WFxeu
bqwAoLP6EZiXiXmz3Z0SfCx+Uwypr1h5
=AiuB
-----END PGP SIGNATURE-----

--QMqfjCuFUicov2i4tPpJhWWqipr09BGwi--
