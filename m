From: Loic Dachary <loic@dachary.org>
Subject: Pyramid erasure code description revisited
Date: Sat, 31 May 2014 19:10:16 +0200
Message-ID: <538A0CF8.8030501@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="L2nd5k8I8dXvaDtON9Vln0Gd9r2va6lpT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:56201 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaEaRKS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 May 2014 13:10:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L2nd5k8I8dXvaDtON9Vln0Gd9r2va6lpT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

After a few weeks and a fresh eye, I revisited the way pyramid erasure co=
de could be described by the system administrator. Here is a proposal tha=
t is hopefully more intuitive than the one from the last CDS ( http://pad=
=2Eceph.com/p/cdsgiant-pyramid-erasure-code ).

These are the steps to create all coding chunks. The upper case letters a=
re data chunks and the lower case letters are coding chunks.

"__ABC__DE_" data chunks placement

Step 1
"__ABC__DE_"
"_yVWX_zYZ_" K=3D5, M=3D2
"_aABC_bDE_"

Step 2
"_aABC_bDE_"
"z_XYZ_____" K=3D3, M=3D1
"caABC_bDE_"

Step 3
"caABC_bDE_"
"_____zXYZ_" K=3D3, M=3D1
"caABCdbDE_"

Step 4
"caABCdbDE_"
"_____WXYZz" K=3D4, M=3D1
"caABCdbDEe"

The interpretation of Step 3 is as follows:

Given the output of the previous step ( "caABC_bDE_" ), the bDE chunks ar=
e considered to be data chunks at this stage and they are marked with XYZ=
=2E A K=3D3, M=3D1 coding chunk is calculated and placed in the chunk mar=
ked with z ( "_____zXYZ_" ). The output of this coding step is the previo=
us step plus the coding chunk that was just calculated, named d ( "caABCd=
bDE_" ).=20

This gives the flexibility of deciding wether or not a coding chunk from =
a previous step is used as data to compute the coding chunk of the next s=
tep. It also allows for unbalanced steps such as step 4.

For decoding, the steps are walked from the bottom up. If E is missing, i=
t can be reconstructed from dbD.e in step 4 and the other steps are skipp=
ed because it was the only missing chunk. If AB are missing, all steps th=
at have not be used to encode it are ignored, up to step 2 that will fail=
 to recover them because M=3D1 and yeild to step 1 that will use a..CbDE =
successfully because M=3D2.

Giving up the recursion and favor iteration seems to simplify how it can =
be explained. And I suspect the implementation is also simpler. What do y=
ou think ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--L2nd5k8I8dXvaDtON9Vln0Gd9r2va6lpT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOKDPgACgkQ8dLMyEl6F20pTgCgmgo4wcl7n01u/DE3doiTnGyu
2FoAn0YO8CsVesWTzW0WNQ1rUhPfXATJ
=ItkQ
-----END PGP SIGNATURE-----

--L2nd5k8I8dXvaDtON9Vln0Gd9r2va6lpT--
