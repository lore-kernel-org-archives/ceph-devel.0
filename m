From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 18:22:58 +0100
Message-ID: <54DA3E72.9010600@dachary.org>
References: <54DA3A5B.5050509@dachary.org> <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q9hpEAqFpvVRfreDtOdL3f3tcjxojUPoh"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41886 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751012AbbBJRXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 12:23:01 -0500
In-Reply-To: <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q9hpEAqFpvVRfreDtOdL3f3tcjxojUPoh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/02/2015 18:19, Yuri Weinstein wrote:>=20
> Loic,
>=20
> The only difference between options if we run suits on merged dumpling =
vs dumpling-backports first - is time.
> We will have to run suites on the final branch after the merge anyway.

Could you explain why ? After merging dumpling and dumpling-backports wil=
l be exactly the same.

>=20
> Unless I hear otherwise, I will schedule suites to run on dumpling-back=
ports first (as you are suggesting, with higher priority) and then assumi=
ng that we resolved all issues, we will run on the dumpling merged.=20
>=20
> Sage, pls correct if this is not what has to be done.
>=20
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 9:05:31 AM
> Subject: dumpling integration branch for v0.67.12 ready for QE
>=20
> Hi Yuri,
>=20
> The dumpling integration branch for v0.67.12 as found at https://github=
=2Ecom/ceph/ceph/commits/dumpling-backports has been approved by Yehuda, =
Josh and Sam and is ready for QE.=20
>=20
> For the record, the head is https://github.com/ceph/ceph/commit/3944c77=
c404c4a05886fe8276d5d0dd7e4f20410
>=20
> I think it would be best for the QE tests to use the dumpling-backports=
=2E The alternative would be to merge dumpling-backports into dumpling. H=
owever, since testing may take a long time and require more patches, it p=
robably is better to not do that iterative process on the dumpling branch=
 itself. As it is now, there already are a number of commits in the dumpl=
ing branch that should really be in the dumpling-backports: they do not b=
elong to v0.67.11 and are going to be released in v0.67.12. In the future=
 though, the dumpling branch will only receive commits that have been car=
efully tested and all the integration work will be on the dumpling-backpo=
rts branch exclusively. So that third parties do not have to worry that t=
he dumpling branch contains commits that have not been tested yet.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Q9hpEAqFpvVRfreDtOdL3f3tcjxojUPoh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaPnIACgkQ8dLMyEl6F22KagCgs029r4yyijjqbQo+psKnvXZM
z1EAnR556BhvE16HTGkCVEzIXNpQtfz3
=n8wL
-----END PGP SIGNATURE-----

--Q9hpEAqFpvVRfreDtOdL3f3tcjxojUPoh--
