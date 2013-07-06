From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Sat, 6 Jul 2013 13:45:03 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E494B06CCB@PLOXCHG04.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch>,<51D73960.3070303@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:34829 "EHLO
	CERNMX30.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab3GFNpJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jul 2013 09:45:09 -0400
In-Reply-To: <51D73960.3070303@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

HI Loic,=A0
(C)RS stands for the Cauchy Reed-Solomon codes which are based on pure =
parity operations, while the standard Reed-Solomon codes need more mult=
iplications and are slower.

Considering the checksumming ... for comparison the CRC32 code from lib=
z run's on a 8-core Xeon at ~730 MB/s for small block sizes while SSE4.=
2 CRC32C checksum run's at ~2GByte/s.

Cheers Andreas.
________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 05 July 2013 23:23
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: CEPH Erasure Encoding + OSD Scalability

Hi Andreas,

On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
> thanks for the responses!
>
> Maybe this is useful for your erasure code discussion:
>
> as an example in our RS implementation we chunk a data block of e.g. =
4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
>
> Data & parity chunks are split into 4k blocks and these 4k blocks get=
 a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT library or=
 BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) - n=
othing compared to the parity overhead ...
>
> You can now easily detect data corruption using the local checksums a=
nd avoid to read any parity information and (C)RS decoding if there is =
no corruption detected. Moreover CRC32C computation is distributed over=
 several (in this case 4) machines while (C)RS decoding would run on a =
single machine where you assemble a block ... and CRC32C is faster than=
 (C)RS decoding (with SSE4.2) ...

What does (C)RS mean ? (C)Reed-Solomon ?

> In our case we write this checksum information separate from the orig=
inal data ... while in a block-based storage like CEPH it would be prob=
ably inlined in the data chunk.
> If an OSD detects to run on BRTFS or ZFS one could disable automatica=
lly the CRC32C code.

Nice. I did not know that was built-in :-)
https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/era=
sure-code.rst#scrubbing

> (wouldn't CRC32C be also useful for normal CEPH block replication? )

I don't know the details of scrubbing but it seems CRC is already used =
by deep scrubbing

https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731

Cheers

> As far as I know with the RS CODEC we use you can either miss stripes=
 (data =3D0) in the decoding process but you cannot inject corrupted st=
ripes into the decoding process, so the block checksumming is important=
=2E
>
> Cheers Andreas.

--
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do no=
thing.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
