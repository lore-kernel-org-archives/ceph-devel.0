From: Loic Dachary <loic@dachary.org>
Subject: Re: Stopping ceph daemons during the upgrade
Date: Mon, 18 Aug 2014 18:00:00 +0200
Message-ID: <53F22300.6080702@dachary.org>
References: <53F21994.5000202@dachary.org> <A856D71F-CC6F-4A6A-B29B-FD19FB511482@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5Qppk4aEfccTeqMIJCIJ0lDv2ieaKG7Uq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33360 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750911AbaHRQAH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 12:00:07 -0400
In-Reply-To: <A856D71F-CC6F-4A6A-B29B-FD19FB511482@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Qppk4aEfccTeqMIJCIJ0lDv2ieaKG7Uq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Pre-loading the erasure code plugins will reduce this race condition (i.e=
=2E the files will have to be modified between the start of the ceph-osd =
process and the bootstrap phase where it loads the plugins for it to happ=
en) and it seems to be preferable to stopping the daemons. Thanks for giv=
ing an additional incentive to go in this direction !

Cheers

On 18/08/2014 17:31, Dan Van Der Ster wrote:
> Hi,
>=20
> On 18 Aug 2014, at 17:19, Loic Dachary <loic@dachary.org> wrote:
>=20
>> there probably is a way to do something similar with RPM packages.=20
>=20
> That behaviour (well, close enough) just _removed_ from firefly, see:
>   https://github.com/ceph/ceph/commit/361c1f8554ce1fedfd0020cd306c41b0b=
a25f53e
>=20
> I don=92t have a strong opinion if the pkg update should restart the da=
emon or not =97 but we should try not to change this too often as it chan=
ges our operating procedures.
>=20
> Cheers, Dan--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--5Qppk4aEfccTeqMIJCIJ0lDv2ieaKG7Uq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPyIwEACgkQ8dLMyEl6F21oPACeI6thfAE2KZ41tb8fMWAYHhrt
GNoAoLwOm/EwpXFjUOQJDV2ppYdCUAiX
=heYq
-----END PGP SIGNATURE-----

--5Qppk4aEfccTeqMIJCIJ0lDv2ieaKG7Uq--
