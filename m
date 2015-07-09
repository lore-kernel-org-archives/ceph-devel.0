From: Loic Dachary <loic@dachary.org>
Subject: Re: dealing with conflicting pull requests
Date: Thu, 09 Jul 2015 16:00:56 +0200
Message-ID: <559E7E98.70605@dachary.org>
References: <559E4F52.9070007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="j8t6gXNfLxeXEj4P85nANXf0itlODEpud"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47393 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751257AbbGIOBD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 10:01:03 -0400
In-Reply-To: <559E4F52.9070007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j8t6gXNfLxeXEj4P85nANXf0itlODEpud
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/07/2015 12:39, Loic Dachary wrote:
> Dear co-backporters,
>=20
> For the first time we have a few conflicting pull requests that prevent=
 merging all in the integration branch.
>=20
> https://github.com/ceph/ceph/pull/4597
> https://github.com/ceph/ceph/pull/5043
> https://github.com/ceph/ceph/pull/4788
> https://github.com/ceph/ceph/pull/4636
> https://github.com/ceph/ceph/pull/4635

I'll merge

https://github.com/ceph/ceph/pull/4636
https://github.com/ceph/ceph/pull/4635
https://github.com/ceph/ceph/pull/4597

and keep the other two as DNM for later then.

>=20
> I think the simplest way to deal with that is to arbitrarily pick a few=
 that apply cleanly and just DNM the others so they wait for the next rou=
nd of integration testing. After the first round of integration test, the=
 chosen one will be merged and the DNM will have to be rebased to resolve=
 the conflict, but that's what we do routinely.
>=20
> What do you think ?
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--j8t6gXNfLxeXEj4P85nANXf0itlODEpud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWefpgACgkQ8dLMyEl6F20nxwCfUBJqHma5wh4H1PPx/8xeM6WX
i1YAn0qRvS5CtBI/DgU0VTL14dV0dHuH
=vHc0
-----END PGP SIGNATURE-----

--j8t6gXNfLxeXEj4P85nANXf0itlODEpud--
