From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Sun, 7 Jul 2013 21:04:54 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch>
 <51D73960.3070303@dachary.org>
 <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com>,<51D8827E.8030906@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx31.cern.ch ([137.138.144.179]:12538 "EHLO
	CERNMX31.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3GGVE4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Jul 2013 17:04:56 -0400
In-Reply-To: <51D8827E.8030906@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi Loic,
I don't think there is a better generic implementation. Just made a ben=
chmark .. the Jerasure library with algorithm 'cauchy_good' gives 1.1 G=
B/s (Xeon 2.27 GHz) on a single core for a 4+2 encoding w=3D32. Just to=
 give a feeling if you do 10+4 it is 300 MB/s .... there is a specializ=
ed implementation in QFS (Hadoop in C++) for (M+3) ... for curiosity I =
will make a benchmark with this to compare with Jerasure ...

In any case I would do an optimized implementation for 3+2 which would =
be probably the most performant implementation having the same reliabil=
ity like standard 3-fold replication in CEPH using only 53% of the spac=
e.

3+2 is trivial since you encode (A,B,C) with only two parity operations
P1 =3D A^B
P2 =3D B^C
and reconstruct with one or two parity operations:
A =3D P1^B
B =3D P1^A
B =3D P2^C
C =3D P2^B
aso.

You can write this as a simple loop using advanced vector extensions on=
 Intel (AVX). I can paste a benchmark tomorrow.

Considering the crc32c-intel code you added ... I would provide a funct=
ion which provides a crc32c checksum and detects if it can do it using =
SSE4.2 or implements just the standard algorithm e.g if you run in a vi=
rtual machine you need this emulation ...

Cheers Andreas.
________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 06 July 2013 22:47
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: CEPH Erasure Encoding + OSD Scalability

Hi Andreas,

Since it looks like we're going to use jerasure-1.2, we will be able to=
 try (C)RS using

https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.c
https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.h

Do you know of a better / faster implementation ? Is there a tradeoff b=
etween (C)RS and RS ?

Cheers

On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
> HI Loic,
> (C)RS stands for the Cauchy Reed-Solomon codes which are based on pur=
e parity operations, while the standard Reed-Solomon codes need more mu=
ltiplications and are slower.
>
> Considering the checksumming ... for comparison the CRC32 code from l=
ibz run's on a 8-core Xeon at ~730 MB/s for small block sizes while SSE=
4.2 CRC32C checksum run's at ~2GByte/s.
>
> Cheers Andreas.
>
>
>
>
> On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>
>     Hi Andreas,
>
>     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
>     > thanks for the responses!
>     >
>     > Maybe this is useful for your erasure code discussion:
>     >
>     > as an example in our RS implementation we chunk a data block of=
 e.g. 4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
>     >
>     > Data & parity chunks are split into 4k blocks and these 4k bloc=
ks get a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT libr=
ary or BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 byte=
s) - nothing compared to the parity overhead ...
>     >
>     > You can now easily detect data corruption using the local check=
sums and avoid to read any parity information and (C)RS decoding if the=
re is no corruption detected. Moreover CRC32C computation is distribute=
d over several (in this case 4) machines while (C)RS decoding would run=
 on a single machine where you assemble a block ... and CRC32C is faste=
r than (C)RS decoding (with SSE4.2) ...
>
>     What does (C)RS mean ? (C)Reed-Solomon ?
>
>     > In our case we write this checksum information separate from th=
e original data ... while in a block-based storage like CEPH it would b=
e probably inlined in the data chunk.
>     > If an OSD detects to run on BRTFS or ZFS one could disable auto=
matically the CRC32C code.
>
>     Nice. I did not know that was built-in :-)
>     https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_interna=
ls/erasure-code.rst#scrubbing
>
>     > (wouldn't CRC32C be also useful for normal CEPH block replicati=
on? )
>
>     I don't know the details of scrubbing but it seems CRC is already=
 used by deep scrubbing
>
>     https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731
>
>     Cheers
>
>     > As far as I know with the RS CODEC we use you can either miss s=
tripes (data =3D0) in the decoding process but you cannot inject corrup=
ted stripes into the decoding process, so the block checksumming is imp=
ortant.
>     >
>     > Cheers Andreas.
>
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>     All that is necessary for the triumph of evil is that good people=
 do nothing.
>
>

--
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do no=
thing.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
