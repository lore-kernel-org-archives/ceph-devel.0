From: Loic Dachary <loic@dachary.org>
Subject: Re: Locally repairable code description revisited (was Pyramid ...)
Date: Thu, 05 Jun 2014 16:05:41 +0200
Message-ID: <53907935.9010009@dachary.org>
References: <538A0CF8.8030501@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uLMcAOJ1fSEJlm2UuO09bUBAB76KgosTc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34810 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaFEOFp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 10:05:45 -0400
In-Reply-To: <538A0CF8.8030501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uLMcAOJ1fSEJlm2UuO09bUBAB76KgosTc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Here is a preliminary implementation https://github.com/ceph/ceph/pull/19=
21 . It does not have tests yet, nor does it run but but it compiles and =
I think it makes sense. It is indeed simpler than the previous implementa=
tion.

It would be great if you could quickly browse=20

   https://github.com/dachary/ceph/commit/5661c72864eca04c5dac9494a3f7e7a=
13515fca6

and let me know if you have any concerns.

Cheers

On 31/05/2014 19:10, Loic Dachary wrote:
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
bDE_" ).=20
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

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--uLMcAOJ1fSEJlm2UuO09bUBAB76KgosTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOQeTUACgkQ8dLMyEl6F210GgCgkFgCztIZI5LdNww7VWKsA1Y5
EO4An0FivI4yBaO2BQJlBAI/9eh2Z+hw
=2NIB
-----END PGP SIGNATURE-----

--uLMcAOJ1fSEJlm2UuO09bUBAB76KgosTc--
