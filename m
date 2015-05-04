From: Loic Dachary <loic@dachary.org>
Subject: Re: suites running on the hammer-backports branch
Date: Mon, 04 May 2015 11:25:19 +0200
Message-ID: <55473AFF.80902@dachary.org>
References: <55461DBA.1060009@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TNuj2ndOsJJ1tv91nfX8m9lD2ePebEPii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56920 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751365AbbEDJZV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 05:25:21 -0400
In-Reply-To: <55461DBA.1060009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TNuj2ndOsJJ1tv91nfX8m9lD2ePebEPii
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/05/2015 15:08, Loic Dachary wrote:> Hi Abhishek,
>=20
> The rados suite you scheduled ( http://tracker.ceph.com/issues/11492#ra=
dos ) failed because of environmental noise and I re-scheduled the 84 fai=
led jobs on your behalf.

It turns out the rados suite did not fail because of environmental noise =
but because the thrasher yaml file also contains the ceph installation. R=
emoving the thrasher yaml file had the infortunate side effect of not ins=
talling Ceph. And without Ceph installed the tests don't run very well ;-=
) I fixed this at https://github.com/dachary/ceph-qa-suite/tree/wip-rados=
-no-thrash-hammer and re-scheduled a suite of 116 jobs at http://tracker.=
ceph.com/issues/11492#rados

Note that it was not possible to only re-schedule the ones that failed (8=
8 out of 116) using the usual method because I introduced new yaml files =
(ceph.yaml with only the ceph installation). The descriptions are differe=
nts and the filtering does not work anymore.

>=20
> I've scheduled the rgw suite as well, suppressing the apache tests and =
keeping the civetweb tests which should be enough for the purpose of the =
pull requests in the integration branch (44 jobs instead of 88 jobs). htt=
p://tracker.ceph.com/issues/11492#rgw
>=20
> The rbd and fs suites were also scheduled, as usual.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--TNuj2ndOsJJ1tv91nfX8m9lD2ePebEPii
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVHOv8ACgkQ8dLMyEl6F22czACfXj7ZcajAy1rUBkoRXSEWGify
7lYAoJ+m2YMqdqksRvVG/Tb6qRU2I7PF
=fZvl
-----END PGP SIGNATURE-----

--TNuj2ndOsJJ1tv91nfX8m9lD2ePebEPii--
