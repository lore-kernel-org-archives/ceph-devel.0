From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Mon, 08 Jul 2013 12:31:01 +0200
Message-ID: <51DA94E5.5020903@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch> <51D73960.3070303@dachary.org> <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com>, <51D8827E.8030906@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch>,<alpine.DEB.2.00.1307072035020.22858@cobra.newdream.net> <3472A07E6605974CBC9BC573F1BC02E494B06FDA@PLOXCHG04.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5AFE60EFA931080BD211E3E5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:37266 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab3GHKbF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jul 2013 06:31:05 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E494B06FDA@PLOXCHG04.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5AFE60EFA931080BD211E3E5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 08/07/2013 12:00, Andreas Joachim Peters wrote:
> Hi Loic,
>=20
> I did the two mentioned benchmarks:
>=20
> QFS (m+3) code run's at 300 MB/s ... not worthy (jerasure 390 MB/s).
>=20
> I made a quick (3+2) encoding benchmark and this encodes ~ 3 GB/s.
>=20

Hi Andreas,

It looks like the simplest and fastest implementation there is :-) I unde=
rstand it only addresses 3+2 but it would make for a fine default impleme=
ntation / example for the erasure coding plugin implementing the proposed=
 API https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/=
erasure-code.rst#erasure-code-library-abstract-api

Cheers

> Cheers Andreas.
>=20
> ________________________________________
> From: Sage Weil [sage@inktank.com]
> Sent: 08 July 2013 05:37
> To: Andreas Joachim Peters
> Cc: Loic Dachary; ceph-devel@vger.kernel.org
> Subject: RE: CEPH Erasure Encoding + OSD Scalability
>=20
> On Sun, 7 Jul 2013, Andreas Joachim Peters wrote:
>> Considering the crc32c-intel code you added ... I would provide a
>> function which provides a crc32c checksum and detects if it can do it
>> using SSE4.2 or implements just the standard algorithm e.g if you run =
in
>> a virtual machine you need this emulation ...
>=20
> The current code in master will do this detection by checking the cpu
> features; see
>=20
>         https://github.com/ceph/ceph/blob/master/src/common/crc32c-inte=
l.c#L74
>=20
> If there is a better way to do this, I'd love to hear about it.  gcc 4.=
8
> just added a bunch of built-in functions to do this stuff cleanly, but
> it'll be quite a while before all of our build targets are on 4.8 or
> later.
>=20
> sage
>=20
>=20
>>
>> Cheers Andreas.
>> ________________________________________
>> From: Loic Dachary [loic@dachary.org]
>> Sent: 06 July 2013 22:47
>> To: Andreas Joachim Peters
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>>
>> Hi Andreas,
>>
>> Since it looks like we're going to use jerasure-1.2, we will be able t=
o try (C)RS using
>>
>> https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.c
>> https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.h
>>
>> Do you know of a better / faster implementation ? Is there a tradeoff =
between (C)RS and RS ?
>>
>> Cheers
>>
>> On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
>>> HI Loic,
>>> (C)RS stands for the Cauchy Reed-Solomon codes which are based on pur=
e parity operations, while the standard Reed-Solomon codes need more mult=
iplications and are slower.
>>>
>>> Considering the checksumming ... for comparison the CRC32 code from l=
ibz run's on a 8-core Xeon at ~730 MB/s for small block sizes while SSE4.=
2 CRC32C checksum run's at ~2GByte/s.
>>>
>>> Cheers Andreas.
>>>
>>>
>>>
>>>
>>> On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>>
>>>     Hi Andreas,
>>>
>>>     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
>>>     > thanks for the responses!
>>>     >
>>>     > Maybe this is useful for your erasure code discussion:
>>>     >
>>>     > as an example in our RS implementation we chunk a data block of=
 e.g. 4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
>>>     >
>>>     > Data & parity chunks are split into 4k blocks and these 4k bloc=
ks get a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT librar=
y or BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) -=
 nothing compared to the parity overhead ...
>>>     >
>>>     > You can now easily detect data corruption using the local check=
sums and avoid to read any parity information and (C)RS decoding if there=
 is no corruption detected. Moreover CRC32C computation is distributed ov=
er several (in this case 4) machines while (C)RS decoding would run on a =
single machine where you assemble a block ... and CRC32C is faster than (=
C)RS decoding (with SSE4.2) ...
>>>
>>>     What does (C)RS mean ? (C)Reed-Solomon ?
>>>
>>>     > In our case we write this checksum information separate from th=
e original data ... while in a block-based storage like CEPH it would be =
probably inlined in the data chunk.
>>>     > If an OSD detects to run on BRTFS or ZFS one could disable auto=
matically the CRC32C code.
>>>
>>>     Nice. I did not know that was built-in :-)
>>>     https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_interna=
ls/erasure-code.rst#scrubbing
>>>
>>>     > (wouldn't CRC32C be also useful for normal CEPH block replicati=
on? )
>>>
>>>     I don't know the details of scrubbing but it seems CRC is already=
 used by deep scrubbing
>>>
>>>     https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731
>>>
>>>     Cheers
>>>
>>>     > As far as I know with the RS CODEC we use you can either miss s=
tripes (data =3D0) in the decoding process but you cannot inject corrupte=
d stripes into the decoding process, so the block checksumming is importa=
nt.
>>>     >
>>>     > Cheers Andreas.
>>>
>>>     --
>>>     Lo?c Dachary, Artisan Logiciel Libre
>>>     All that is necessary for the triumph of evil is that good people=
 do nothing.
>>>
>>>
>>
>> --
>> Lo?c Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig5AFE60EFA931080BD211E3E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHalOYACgkQ8dLMyEl6F22XNgCePdF3Dr670AWxoZMwnN152bUr
s6gAn07NA656Wn7OkfRE+OH6IBdcEkf1
=mUzx
-----END PGP SIGNATURE-----

--------------enig5AFE60EFA931080BD211E3E5--
