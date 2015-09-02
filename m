From: Loic Dachary <loic@dachary.org>
Subject: Re: verifying rpm packages for v0.80.11
Date: Wed, 02 Sep 2015 07:50:20 +0200
Message-ID: <55E68E1C.7040105@dachary.org>
References: <55E68D6F.5050506@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QTu92KGgRllMp410OKQD8vmTJhEWNAM10"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47937 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750743AbbIBFuY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 01:50:24 -0400
In-Reply-To: <55E68D6F.5050506@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QTu92KGgRllMp410OKQD8vmTJhEWNAM10
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

And https://github.com/ceph/ceph/pull/5394

On 02/09/2015 07:47, Loic Dachary wrote:
> Hi Nathan,
>=20
> In order to verify that the ceph.spec.in change do not introduce a regr=
ession in v0.80.11, I scheduled an upgrade/firefly suite on CentOS 6 ( ht=
tp://tracker.ceph.com/issues/11644#upgrade) and a ceph-deploy suite on al=
l supported distributions (because we did not do it before http://tracker=
=2Eceph.com/issues/11644#ceph-deploy).=20
>=20
> https://github.com/ceph/ceph/pull/5217
> https://github.com/ceph/ceph/pull/5224
> https://github.com/ceph/ceph/pull/5225
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QTu92KGgRllMp410OKQD8vmTJhEWNAM10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXmjhwACgkQ8dLMyEl6F23GQQCfTCs7h0bHuC6MPy84c/PRYSDP
l4AAn05YYKIJEm6teaG7jnWbwPWQVjhL
=przm
-----END PGP SIGNATURE-----

--QTu92KGgRllMp410OKQD8vmTJhEWNAM10--
