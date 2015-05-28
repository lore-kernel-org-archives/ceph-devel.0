From: Loic Dachary <loic@dachary.org>
Subject: Re: rados and the next firefly release v0.80.10
Date: Thu, 28 May 2015 18:09:49 +0200
Message-ID: <55673DCD.7030903@dachary.org>
References: <555F89CA.8080005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BLmlGgONRhINA82PGfxiaGKr1weUxIOxf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52537 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753291AbbE1QJx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 12:09:53 -0400
In-Reply-To: <555F89CA.8080005@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BLmlGgONRhINA82PGfxiaGKr1weUxIOxf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For the record:

[28.05 18:09] <sjusthm> loicd: you have my ack

On 22/05/2015 21:55, Loic Dachary wrote:
> Hi Sam,
>=20
> The next firefly release as found at https://github.com/ceph/ceph/tree/=
firefly (68211f695941ee128eb9a7fd0d80b615c0ded6cf) passed the rados suite=
 (http://tracker.ceph.com/issues/11090#rados). It includes https://github=
=2Ecom/ceph/ceph/pull/4556 which is the pull request backporting the fix =
for "OSD::load_pgs: we need to handle the case where an upgrade from earl=
ier versions which ignored non-existent pgs resurrects a pg with a prehis=
toric osdmap" http://tracker.ceph.com/issues/11429 to firefly (the corres=
ponding ceph-qa-suite pull request https://github.com/ceph/ceph-qa-suite/=
pull/435 has also been tested and merged).
>=20
> Do you think it is ready for QE to start their own round of testing ?
>=20
> Cheers
>=20
> P.S. http://tracker.ceph.com/issues/11090#Release-information has direc=
t links to the pull requests merged into firefly since v0.80.9 in case yo=
u need more context about one of them.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--BLmlGgONRhINA82PGfxiaGKr1weUxIOxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVnPc0ACgkQ8dLMyEl6F21XiACgqjubjOK3fRFZHYfy7A4O/9lF
r4UAoKAAxB6XuwNjX737MgekDhNju4Nf
=c0d8
-----END PGP SIGNATURE-----

--BLmlGgONRhINA82PGfxiaGKr1weUxIOxf--
