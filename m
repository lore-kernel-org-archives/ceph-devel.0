From: Loic Dachary <loic@dachary.org>
Subject: Re: Pull Request for ISA EC plug-in
Date: Mon, 28 Jul 2014 22:16:59 +0600
Message-ID: <53D6777B.40907@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KH5JNJ2UGDnJel0gFDW6X3dV7AkPsv79t"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49694 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750708AbaG1QR2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 12:17:28 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KH5JNJ2UGDnJel0gFDW6X3dV7AkPsv79t
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

I'll take a look next monday if noone did before. Happy prospect for when=
 I return from hollidays ;-)

Cheers

On 28/07/2014 21:12, Andreas Joachim Peters wrote:
> Hi all,
>=20
> here is a PULL request for the ISA EC plugin rebased against master of =
today for review.
>=20
> https://github.com/ceph/ceph/pull/2155
>=20
> I have added as discussed the exhaustive test of all possible failures =
scenarios for both supported matrix types for a (k=3D12,m=3D4) configurat=
ion to the unit tests ( which helped indeed to spot a bug in the table ca=
ching )=20
>=20
> Cheers Andreas.
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


--KH5JNJ2UGDnJel0gFDW6X3dV7AkPsv79t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPWd3sACgkQ8dLMyEl6F210QwCfQzJOTO89qOcysgQ3219lejCW
Ms8An12jD9WfYYdU2nqsrk3yW/ucxTa/
=iPoO
-----END PGP SIGNATURE-----

--KH5JNJ2UGDnJel0gFDW6X3dV7AkPsv79t--
