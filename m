From: Loic Dachary <loic@dachary.org>
Subject: Re: firefly branch for v0.80.10 ready for QE
Date: Fri, 05 Jun 2015 11:11:44 +0200
Message-ID: <557167D0.40201@dachary.org>
References: <5568915D.3040005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QkMUEOUihLfkgKq2Q5qCDF42TeVawuJVp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56779 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753543AbbFEJLr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 05:11:47 -0400
In-Reply-To: <5568915D.3040005@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QkMUEOUihLfkgKq2Q5qCDF42TeVawuJVp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

A month passed since this mail was sent and the firefly branch has a few =
additional commits. All but one (https://github.com/ceph/ceph/pull/4829 w=
ith more information at http://tracker.ceph.com/issues/11890) have been t=
ested. This exception seems harmless but I thought you should know.=20

For the record, the head of the firefly branch now is https://github.com/=
ceph/ceph/commit/d0f9c5f47024f53b4eccea2e0fde9b7844746362 and http://trac=
ker.ceph.com/issues/11090#Release-information has been updated accordingl=
y.

Cheers

On 29/05/2015 18:18, Loic Dachary wrote:> Hi Yuri,
>=20
> The firefly branch for v0.80.10 as found at https://github.com/ceph/cep=
h/commits/firefly has been approved by Greg, Yehuda, Josh and Sam and is =
ready for QE. For the record, the head is https://github.com/ceph/ceph/co=
mmit/071c94385ee71b86c5ed8363d56cf299da1aa7b3 and the details of the test=
s run are at http://tracker.ceph.com/issues/11090
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QkMUEOUihLfkgKq2Q5qCDF42TeVawuJVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVxZ9AACgkQ8dLMyEl6F20fnwCfSSNKF4bd1mFs2PIQ9613jesn
eocAn11Gl8egiKrcJIbp2S7Xt7wY7GOA
=5sxP
-----END PGP SIGNATURE-----

--QkMUEOUihLfkgKq2Q5qCDF42TeVawuJVp--
