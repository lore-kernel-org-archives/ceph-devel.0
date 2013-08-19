From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Mon, 19 Aug 2013 12:35:52 +0200
Message-ID: <5211F508.3030706@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch> <51D73960.3070303@dachary.org> <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com>,<51D8827E.8030906@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C4F75E59E799E4A002FD31C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:39226 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab3HSKf7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 06:35:59 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C4F75E59E799E4A002FD31C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Trying to write minimal code as you suggested, for an example plugin. My =
first attempt at writing an erasure coding function. I don't get how you =
can rebuild P1 + A from P2 + B + C. I must be missing something obvious :=
-)

Cheers

On 07/07/2013 23:04, Andreas Joachim Peters wrote:
>=20
> Hi Loic,
> I don't think there is a better generic implementation. Just made a ben=
chmark .. the Jerasure library with algorithm 'cauchy_good' gives 1.1 GB/=
s (Xeon 2.27 GHz) on a single core for a 4+2 encoding w=3D32. Just to giv=
e a feeling if you do 10+4 it is 300 MB/s .... there is a specialized imp=
lementation in QFS (Hadoop in C++) for (M+3) ... for curiosity I will mak=
e a benchmark with this to compare with Jerasure ...
>=20
> In any case I would do an optimized implementation for 3+2 which would =
be probably the most performant implementation having the same reliabilit=
y like standard 3-fold replication in CEPH using only 53% of the space.
>=20
> 3+2 is trivial since you encode (A,B,C) with only two parity operations=

> P1 =3D A^B
> P2 =3D B^C
> and reconstruct with one or two parity operations:
> A =3D P1^B
> B =3D P1^A
> B =3D P2^C
> C =3D P2^B
> aso.
>=20
> You can write this as a simple loop using advanced vector extensions on=
 Intel (AVX). I can paste a benchmark tomorrow.
>=20
> Considering the crc32c-intel code you added ... I would provide a funct=
ion which provides a crc32c checksum and detects if it can do it using SS=
E4.2 or implements just the standard algorithm e.g if you run in a virtua=
l machine you need this emulation ...
>=20
> Cheers Andreas.
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 06 July 2013 22:47
> To: Andreas Joachim Peters
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>=20
> Hi Andreas,
>=20
> Since it looks like we're going to use jerasure-1.2, we will be able to=
 try (C)RS using
>=20
> https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.c
> https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.h
>=20
> Do you know of a better / faster implementation ? Is there a tradeoff b=
etween (C)RS and RS ?
>=20
> Cheers
>=20
> On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
>> HI Loic,
>> (C)RS stands for the Cauchy Reed-Solomon codes which are based on pure=
 parity operations, while the standard Reed-Solomon codes need more multi=
plications and are slower.
>>
>> Considering the checksumming ... for comparison the CRC32 code from li=
bz run's on a 8-core Xeon at ~730 MB/s for small block sizes while SSE4.2=
 CRC32C checksum run's at ~2GByte/s.
>>
>> Cheers Andreas.
>>
>>
>>
>>
>> On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:
>>
>>     Hi Andreas,
>>
>>     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
>>     > thanks for the responses!
>>     >
>>     > Maybe this is useful for your erasure code discussion:
>>     >
>>     > as an example in our RS implementation we chunk a data block of =
e.g. 4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
>>     >
>>     > Data & parity chunks are split into 4k blocks and these 4k block=
s get a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT library=
 or BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) - =
nothing compared to the parity overhead ...
>>     >
>>     > You can now easily detect data corruption using the local checks=
ums and avoid to read any parity information and (C)RS decoding if there =
is no corruption detected. Moreover CRC32C computation is distributed ove=
r several (in this case 4) machines while (C)RS decoding would run on a s=
ingle machine where you assemble a block ... and CRC32C is faster than (C=
)RS decoding (with SSE4.2) ...
>>
>>     What does (C)RS mean ? (C)Reed-Solomon ?
>>
>>     > In our case we write this checksum information separate from the=
 original data ... while in a block-based storage like CEPH it would be p=
robably inlined in the data chunk.
>>     > If an OSD detects to run on BRTFS or ZFS one could disable autom=
atically the CRC32C code.
>>
>>     Nice. I did not know that was built-in :-)
>>     https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internal=
s/erasure-code.rst#scrubbing
>>
>>     > (wouldn't CRC32C be also useful for normal CEPH block replicatio=
n? )
>>
>>     I don't know the details of scrubbing but it seems CRC is already =
used by deep scrubbing
>>
>>     https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731
>>
>>     Cheers
>>
>>     > As far as I know with the RS CODEC we use you can either miss st=
ripes (data =3D0) in the decoding process but you cannot inject corrupted=
 stripes into the decoding process, so the block checksumming is importan=
t.
>>     >
>>     > Cheers Andreas.
>>
>>     --
>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>     All that is necessary for the triumph of evil is that good people =
do nothing.
>>
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do no=
thing.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig2C4F75E59E799E4A002FD31C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIR9QgACgkQ8dLMyEl6F20qPQCfV8l8VjvaZJzrfn9f0iY69tTW
4F0An3Al3mTWaRpCOUzpvB+vgGDFqGxY
=Pz0n
-----END PGP SIGNATURE-----

--------------enig2C4F75E59E799E4A002FD31C--
