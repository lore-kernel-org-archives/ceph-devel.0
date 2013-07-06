From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Sat, 06 Jul 2013 10:28:46 -0500
Message-ID: <51D837AE.20906@inktank.com>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch>,<51D73960.3070303@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06CCB@PLOXCHG04.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f178.google.com ([209.85.160.178]:57415 "EHLO
	mail-gh0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3GFPgL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jul 2013 11:36:11 -0400
Received: by mail-gh0-f178.google.com with SMTP id g15so1099915ghb.9
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jul 2013 08:36:10 -0700 (PDT)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E494B06CCB@PLOXCHG04.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Guys,

=46or what it's worth, we just added SSE 4.2 CRC32c for architectures t=
hat=20
support it:

https://github.com/ceph/ceph/commit/7c59288d9168ddef3b3dc570464ae9a1f18=
0d18c#src/common/crc32c-intel.c

Mark

On 07/06/2013 08:45 AM, Andreas Joachim Peters wrote:
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
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 05 July 2013 23:23
> To: Andreas Joachim Peters
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>
> Hi Andreas,
>
> On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
>> thanks for the responses!
>>
>> Maybe this is useful for your erasure code discussion:
>>
>> as an example in our RS implementation we chunk a data block of e.g.=
 4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
>>
>> Data & parity chunks are split into 4k blocks and these 4k blocks ge=
t a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT library o=
r BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) - =
nothing compared to the parity overhead ...
>>
>> You can now easily detect data corruption using the local checksums =
and avoid to read any parity information and (C)RS decoding if there is=
 no corruption detected. Moreover CRC32C computation is distributed ove=
r several (in this case 4) machines while (C)RS decoding would run on a=
 single machine where you assemble a block ... and CRC32C is faster tha=
n (C)RS decoding (with SSE4.2) ...
>
> What does (C)RS mean ? (C)Reed-Solomon ?
>
>> In our case we write this checksum information separate from the ori=
ginal data ... while in a block-based storage like CEPH it would be pro=
bably inlined in the data chunk.
>> If an OSD detects to run on BRTFS or ZFS one could disable automatic=
ally the CRC32C code.
>
> Nice. I did not know that was built-in :-)
> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/e=
rasure-code.rst#scrubbing
>
>> (wouldn't CRC32C be also useful for normal CEPH block replication? )
>
> I don't know the details of scrubbing but it seems CRC is already use=
d by deep scrubbing
>
> https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731
>
> Cheers
>
>> As far as I know with the RS CODEC we use you can either miss stripe=
s (data =3D0) in the decoding process but you cannot inject corrupted s=
tripes into the decoding process, so the block checksumming is importan=
t.
>>
>> Cheers Andreas.
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
