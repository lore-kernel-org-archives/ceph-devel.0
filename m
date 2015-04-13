From: Loic Dachary <loic@dachary.org>
Subject: Re: proposal to stop using "backport: " in commit logs
Date: Mon, 13 Apr 2015 19:04:47 +0200
Message-ID: <552BF72F.5090505@dachary.org>
References: <552BF349.50909@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ede6NkaehBUbrmVVkbwnUco9R5LskKpUo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45951 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932219AbbDMREu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 13:04:50 -0400
In-Reply-To: <552BF349.50909@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ede6NkaehBUbrmVVkbwnUco9R5LskKpUo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/04/2015 18:48, Ken Dreyer wrote:
> A while ago this came up in #ceph-devel and I wanted to bring it to a
> wider audience.
>=20
> Should we stop the convention of adding the "backport: " tags in Git?
>=20
> Loic brought up the point that this data is essentially immutable after=

> we merge it, and it's better to point at a Redmine tracker where we can=

> alter the "backport" field.
>=20
> This makes it easier to adjust the "backport" data after the code's bee=
n
> merged to master. It also makes it easier for whoever is corralling the=

> backport efforts, because the person only have one place to look
> (Redmine) instead of two (Redmine + git commit logs).
>=20
> For what it's worth I agree with Loic on this.

I agree with myself ;-)

>=20
> Any objections?
>=20
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ede6NkaehBUbrmVVkbwnUco9R5LskKpUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUr9y8ACgkQ8dLMyEl6F23+DwCgvKOq67mwb3MZQ6PhKFJBD8dp
LwMAni1Vg026nzyXqIxENchXCo59DY91
=7APE
-----END PGP SIGNATURE-----

--ede6NkaehBUbrmVVkbwnUco9R5LskKpUo--
