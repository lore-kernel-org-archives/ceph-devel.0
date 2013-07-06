From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Sat, 06 Jul 2013 22:47:58 +0200
Message-ID: <51D8827E.8030906@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch> <51D73960.3070303@dachary.org> <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD220BFEF1639367C0CAAD3BB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:44243 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3GFUsC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jul 2013 16:48:02 -0400
In-Reply-To: <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD220BFEF1639367C0CAAD3BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Since it looks like we're going to use jerasure-1.2, we will be able to t=
ry (C)RS using

https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.c
https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.h

Do you know of a better / faster implementation ? Is there a tradeoff bet=
ween (C)RS and RS ?

Cheers

On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
> HI Loic,=20
> (C)RS stands for the Cauchy Reed-Solomon codes which are based on pure =
parity operations, while the standard Reed-Solomon codes need more multip=
lications and are slower.
>=20
> Considering the checksumming ... for comparison the CRC32 code from lib=
z run's on a 8-core Xeon at ~730 MB/s for small block sizes while SSE4.2 =
CRC32C checksum run's at ~2GByte/s.
>=20
> Cheers Andreas.
>=20
>=20
>=20
>=20
> On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Andreas,
>=20
>     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
>     > thanks for the responses!
>     >
>     > Maybe this is useful for your erasure code discussion:
>     >
>     > as an example in our RS implementation we chunk a data block of e=
=2Eg. 4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
>     >
>     > Data & parity chunks are split into 4k blocks and these 4k blocks=
 get a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT library =
or BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) - n=
othing compared to the parity overhead ...
>     >
>     > You can now easily detect data corruption using the local checksu=
ms and avoid to read any parity information and (C)RS decoding if there i=
s no corruption detected. Moreover CRC32C computation is distributed over=
 several (in this case 4) machines while (C)RS decoding would run on a si=
ngle machine where you assemble a block ... and CRC32C is faster than (C)=
RS decoding (with SSE4.2) ...
>=20
>     What does (C)RS mean ? (C)Reed-Solomon ?
>=20
>     > In our case we write this checksum information separate from the =
original data ... while in a block-based storage like CEPH it would be pr=
obably inlined in the data chunk.
>     > If an OSD detects to run on BRTFS or ZFS one could disable automa=
tically the CRC32C code.
>=20
>     Nice. I did not know that was built-in :-)
>     https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals=
/erasure-code.rst#scrubbing
>=20
>     > (wouldn't CRC32C be also useful for normal CEPH block replication=
? )
>=20
>     I don't know the details of scrubbing but it seems CRC is already u=
sed by deep scrubbing
>=20
>     https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731
>=20
>     Cheers
>=20
>     > As far as I know with the RS CODEC we use you can either miss str=
ipes (data =3D0) in the decoding process but you cannot inject corrupted =
stripes into the decoding process, so the block checksumming is important=
=2E
>     >
>     > Cheers Andreas.
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>     All that is necessary for the triumph of evil is that good people d=
o nothing.
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigD220BFEF1639367C0CAAD3BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHYgn4ACgkQ8dLMyEl6F20LMQCfcpCRVxtcC6KVRB8KSaVeMmAj
0yAAnA9eNL1s1bXuwxFuWfFyhjvKbq3M
=MDQD
-----END PGP SIGNATURE-----

--------------enigD220BFEF1639367C0CAAD3BB--
