From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: Reduce read latency and bandwidth for ec pool
Date: Tue, 17 Mar 2015 08:48:55 +0100
Message-ID: <5507DC67.2030800@dachary.org>
References: <CANE=7sUo7tMT=kyuN86vs5b13nnqY9wpOuNuf=_z=P7UXKc+sg@mail.gmail.com> <CANE=7sVcY5sCaHUSFn+MDkAYzeewa767ziXXLqNiSCXhnG4s-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SRDUCHRRgO8thHjbh6AuAwAlH4qwOwQKH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59325 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751895AbbCQHs5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 03:48:57 -0400
In-Reply-To: <CANE=7sVcY5sCaHUSFn+MDkAYzeewa767ziXXLqNiSCXhnG4s-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SRDUCHRRgO8thHjbh6AuAwAlH4qwOwQKH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 17/03/2015 08:27, Xinze Chi wrote:
> hi, loic:
>=20
>    I have an idea which could reduce read latency and bandwidth for ec =
pool.
>=20
>    But, I don't know whether it is feasible.
>=20
>    Such as ec pool stripe_width =3D 16384 =3D 4 * 4096,  K =3D 4, M =3D=
2
>=20
>    So ceph will partition the total of 16384 bytes to 4 data chunk,
> and encoding 2 parity chunk
>=20
>    shard_0 include 0 - (4096-1) in original data;
>    shard_1 include 4096 - (4096*2 - 1) in original data;
>    shard_2 include 4096*2 - (4096 * 3 -1) in original data;
>    shard_3 include 4096*3 - (4096 * 4 - 1) in original data
>    shard_4 include parity chunk
>    shard_5 include parity chunk
>=20
>     Now if client read (offset 0, len 4096) from object, it should
> read 4 shard (from 0-3) and decode all this 4 chunk.
>=20
>     But, this example, maybe we can compute the destination shard
> based on ec pool config ,read offset and read len , we only read
>=20
> shard_0 and return it to client, because shard_0 has include all data
> as client need.

That optimization makes sense to me. I guess you're interested in having =
small objects in the pool and only read a few bytes at a time ?

Cheers

>=20
>     Wait for your comment.
>=20
>     Thanks.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SRDUCHRRgO8thHjbh6AuAwAlH4qwOwQKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUH3GcACgkQ8dLMyEl6F203/QCdGhYhAh8c9fJD2iSpzsjvDa50
aEsAn0B7I3bhS6dR9Q6opfLnY3z7xtWs
=5YlV
-----END PGP SIGNATURE-----

--SRDUCHRRgO8thHjbh6AuAwAlH4qwOwQKH--
