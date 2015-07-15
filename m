From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer-backports  branch is ready to schedule suites (v0.94.3)
Date: Thu, 16 Jul 2015 01:45:58 +0200
Message-ID: <55A6F0B6.10707@dachary.org>
References: <55A6ECAF.4020402@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7f2pB2QHQu5qB2OFi0OACKo3EIi45RnuN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50809 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753501AbbGOXqG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2015 19:46:06 -0400
In-Reply-To: <55A6ECAF.4020402@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7f2pB2QHQu5qB2OFi0OACKo3EIi45RnuN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

Which of https://github.com/ceph/ceph/pulls?utf8=3D%E2%9C%93&q=3Dis%3Aope=
n+is%3Apr+milestone%3Ahammer+ceph.spec.in+in%3Atitle should be built in t=
he gitbuilders first ?

Cheers

On 16/07/2015 01:28, Loic Dachary wrote:
> Hi Abhishek,
>=20
> The last pull request from the previous integration branch was merged (=
 https://github.com/ceph/ceph/pull/4891 ).
>=20
> http://tracker.ceph.com/issues/11990#teuthology-run-commit-0c435d3974c9=
aa215ea10c6e9eed30ada6dbc390-hammer-backports-July-15
>=20
> The ceph.spec.in pull request are not included (I made it so all of the=
m have ceph.spec.in in the pull request title) because they conflict and =
the suite use debian packages.=20
>=20
> https://github.com/ceph/ceph/pulls?utf8=3D%E2%9C%93&q=3Dis%3Aopen+is%3A=
pr+milestone%3Ahammer+ceph.spec.in+in%3Atitle
>=20
> I believe running them one by one through the gitbuilders is the best w=
e can do right now.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7f2pB2QHQu5qB2OFi0OACKo3EIi45RnuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWm8LYACgkQ8dLMyEl6F22BcwCfU1OGQJg2CqtDXQquXbizAMmS
M1AAoKVAqBDMIteMbU1oatD9x2VD+wat
=EJBV
-----END PGP SIGNATURE-----

--7f2pB2QHQu5qB2OFi0OACKo3EIi45RnuN--
