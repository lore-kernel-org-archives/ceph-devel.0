From: Loic Dachary <loic@dachary.org>
Subject: Re: osd pool erasure code stripe width
Date: Sat, 20 Jun 2015 00:47:19 +0200
Message-ID: <55849BF7.5050603@dachary.org>
References: <BC97738F8E7C8742BABED7F06FB9DF91669A8E8B@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UFD1jCT54npw7Vav98nrprhk4ecHgChnU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37197 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753917AbbFSWrW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 18:47:22 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669A8E8B@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UFD1jCT54npw7Vav98nrprhk4ecHgChnU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Tom,

A stripe width of 4KB (the default) means the object is encoded 4KB at a =
time. It does not show in the file written to disk.

Cheers

On 19/06/2015 22:11, Deneau, Tom wrote:
> I am trying to understand the use of "osd pool erasure code stripe widt=
h"
> For example, I have a single-node system with a k=3D2,m=3D1 ec pool
> and I write a single 40M object to this pool using rados bench.
> But when I look on the disk, I still see only the 3 20M pieces for this=
 object.
> Where does the striping get used?
>=20
> -- Tom Deneau, AMD
>=20
>=20
> Description:
> Sets the desired size, in bytes, of an object stripe on every erasure c=
oded pools. Every object if size S will be stored as N stripes and each s=
tripe will be encoded/decoded individually.
> Type:
> Unsigned 32-bit Integer
> Default:
> 4096
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--UFD1jCT54npw7Vav98nrprhk4ecHgChnU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWEm/cACgkQ8dLMyEl6F23u0gCfcJBWpQdswsRGc7v+2HabnFuU
YmIAnjBom7srq8QHyzAcBbSTqGKYe+yM
=/sgf
-----END PGP SIGNATURE-----

--UFD1jCT54npw7Vav98nrprhk4ecHgChnU--
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
