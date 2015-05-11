From: Loic Dachary <loic@dachary.org>
Subject: Re: EC backend benchmark
Date: Tue, 12 May 2015 00:02:27 +0200
Message-ID: <555126F3.1050607@dachary.org>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8A41B@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ITAbtoFL2s4uu3Owue2QeUn9JxFTAE8Gv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33243 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751693AbbEKWCa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 18:02:30 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8A41B@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITAbtoFL2s4uu3Owue2QeUn9JxFTAE8Gv
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,
[Sorry I missed the body of your questions, here is my answer ;-]

On 11/05/2015 23:13, Somnath Roy wrote:> Summary :
>=20
> -------------
>=20
> =20
>=20
> 1. It is doing pretty good in Reads and 4 Rados Bench clients are satur=
ating 40 GB network. With more physical server, it is scaling almost line=
arly and saturating 40 GbE on both the host.
>=20
> =20
>=20
> 2. As suspected with Ceph, problem is again with writes. Throughput wis=
e it is beating replicated pools in significant numbers. But, it is not s=
caling with multiple clients and not saturating anything.
>=20
> =20
>=20
> =20
>=20
> So, my question is the following.
>=20
> =20
>=20
> 1. Probably, nothing to do with EC backend, we are suffering because of=
 filestore inefficiencies. Do you think any tunable like EC stipe size (o=
r anything else) will help here ?

I think Mark Nelson would be in a better position that me to answer as he=
 has conducted many experiments with erasure coded pools.


> 2. I couldn=92t make fault domain as =91host=92, because of HW limitati=
on. Do you think will that play a role in performance for bigger k values=
 ?

I don't see a reason why there would be a direct relationship between the=
 failure domain and the values of k. Do you have a specific example in mi=
nd ?

> 3. Even though it is not saturating 40 GbE for writes, do you think sep=
arating out public/private network will help in terms of performance ?

I don't think so. What is the bottleneck ? CPU or disk I/O ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre



--ITAbtoFL2s4uu3Owue2QeUn9JxFTAE8Gv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVRJvMACgkQ8dLMyEl6F23kPQCgr+0HHZxdUTQtTIj7WqUV8lZ1
2WsAoJJukyfmoG0JMaJIj112Pn39AQ9T
=ZHYq
-----END PGP SIGNATURE-----

--ITAbtoFL2s4uu3Owue2QeUn9JxFTAE8Gv--
