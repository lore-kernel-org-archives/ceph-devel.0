From: Loic Dachary <loic@dachary.org>
Subject: Re: Checking of Reed-Solomon Vandermonde parameter combinations
Date: Thu, 03 Jul 2014 12:30:26 +0200
Message-ID: <53B530C2.5020401@dachary.org>
References: <53B52EC8.5030708@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE747EDC@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bdu56dnDcRxRcXS0Mb1FDGllALqB0tI1O"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36717 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750978AbaGCKac (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 06:30:32 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE747EDC@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bdu56dnDcRxRcXS0Mb1FDGllALqB0tI1O
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the clarification, we're good then :-)

On 03/07/2014 12:27, Andreas Joachim Peters wrote:
> Hi Loic,=20
> as much as I understood for now it should not happen in Jerasure, but i=
t will happen with the default Vandermonde matrix in the Intel library. T=
he reason is the way these matrices are constructed.
>=20
> But to verify this you have to make millions of iterations not only 1 b=
ecause for large (k,m) there many failure scenario (chunk combinations) t=
o test.
>=20
> Cheers Andreas.
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 03 July 2014 12:22
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Checking of Reed-Solomon Vandermonde parameter combinations
>=20
> Hi Andreas,
>=20
> There are some combinations of K/M parameters for which Reed-Solomon Va=
ndermonde may not be able to recover from the loss of M chunks. Reed-Solo=
mon Cauchy does not suffer from this problem. (I'm paraphrasing a convers=
ation we had in private, feel free to correct me if I'm wrong).
>=20
> In the context of Ceph we are interested in a limited range of paramete=
rs so I ran a test with:
>=20
> https://github.com/ceph/ceph/blob/master/src/test/erasure-code/ceph_era=
sure_code_benchmark.cc#L40
>=20
> for k in $(seq 2 50) ; do for m in $(seq 1 $k) ; do echo -n "k=3D$k m=3D=
$m " ; ./ceph_erasure_code_benchmark      --plugin jerasure      --parame=
ter directory=3D.libs      --parameter technique=3Dreed_sol_van      --pa=
rameter k=3D$k      --parameter m=3D$m --erasures $m      --iterations 1 =
--workload decode ; done ; done
>=20
> and it does not throw an error. It basically take a range of parameters=
 K=3D2,M=3D2 up to K=3D50,M=3D50 and decode with M erasures for each of t=
hem. Should some of them fail ?
>=20
> Cheers
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bdu56dnDcRxRcXS0Mb1FDGllALqB0tI1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO1MMIACgkQ8dLMyEl6F21SfACdHHWaLfMWuTXr2h5qtNGZ3Zy0
cosAoLGBN7NQNLlzGAWdAsdiB/WO3rmj
=jAFH
-----END PGP SIGNATURE-----

--bdu56dnDcRxRcXS0Mb1FDGllALqB0tI1O--
