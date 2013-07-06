From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Sat, 06 Jul 2013 22:43:07 +0200
Message-ID: <51D8815B.2080808@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch>,<51D73960.3070303@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06CCB@PLOXCHG04.cern.ch> <51D837AE.20906@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8183CC549234AFED112B5059"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:60898 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3GFUnL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jul 2013 16:43:11 -0400
In-Reply-To: <51D837AE.20906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8183CC549234AFED112B5059
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Nice :-) I'm curious about how it's used. Is it computed every time an ob=
ject is written to disk ? Or is it part of the WRITE messages that are se=
nt to the replicas ?=20

Cheers

On 06/07/2013 17:28, Mark Nelson wrote:
> Hi Guys,
>=20
> For what it's worth, we just added SSE 4.2 CRC32c for architectures tha=
t support it:
>=20
> https://github.com/ceph/ceph/commit/7c59288d9168ddef3b3dc570464ae9a1f18=
0d18c#src/common/crc32c-intel.c
>=20
> Mark
>=20
> On 07/06/2013 08:45 AM, Andreas Joachim Peters wrote:
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
>> ________________________________________
>> From: Loic Dachary [loic@dachary.org]
>> Sent: 05 July 2013 23:23
>> To: Andreas Joachim Peters
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>>
>> Hi Andreas,
>>
>> On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
>>> thanks for the responses!
>>>
>>> Maybe this is useful for your erasure code discussion:
>>>
>>> as an example in our RS implementation we chunk a data block of e.g. =
4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
>>>
>>> Data & parity chunks are split into 4k blocks and these 4k blocks get=
 a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT library or B=
TRFS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) - nothi=
ng compared to the parity overhead ...
>>>
>>> You can now easily detect data corruption using the local checksums a=
nd avoid to read any parity information and (C)RS decoding if there is no=
 corruption detected. Moreover CRC32C computation is distributed over sev=
eral (in this case 4) machines while (C)RS decoding would run on a single=
 machine where you assemble a block ... and CRC32C is faster than (C)RS d=
ecoding (with SSE4.2) ...
>>
>> What does (C)RS mean ? (C)Reed-Solomon ?
>>
>>> In our case we write this checksum information separate from the orig=
inal data ... while in a block-based storage like CEPH it would be probab=
ly inlined in the data chunk.
>>> If an OSD detects to run on BRTFS or ZFS one could disable automatica=
lly the CRC32C code.
>>
>> Nice. I did not know that was built-in :-)
>> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/er=
asure-code.rst#scrubbing
>>
>>> (wouldn't CRC32C be also useful for normal CEPH block replication? )
>>
>> I don't know the details of scrubbing but it seems CRC is already used=
 by deep scrubbing
>>
>> https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731
>>
>> Cheers
>>
>>> As far as I know with the RS CODEC we use you can either miss stripes=
 (data =3D0) in the decoding process but you cannot inject corrupted stri=
pes into the decoding process, so the block checksumming is important.
>>>
>>> Cheers Andreas.
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig8183CC549234AFED112B5059
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHYgVsACgkQ8dLMyEl6F23vBACfQbZcVKsR4t2gFHggt+LdpJpq
F5MAn36l6vAUnZEaeWz3CU5XKRw7CTZd
=JeJj
-----END PGP SIGNATURE-----

--------------enig8183CC549234AFED112B5059--
