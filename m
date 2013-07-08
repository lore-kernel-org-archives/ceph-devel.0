From: Sage Weil <sage@inktank.com>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Mon, 8 Jul 2013 08:47:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307080846310.13481@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch> <51D73960.3070303@dachary.org> <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com>, <51D8827E.8030906@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch>,
 <alpine.DEB.2.00.1307072035020.22858@cobra.newdream.net> <3472A07E6605974CBC9BC573F1BC02E494B06FDA@PLOXCHG04.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60337 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab3GHPrL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jul 2013 11:47:11 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E494B06FDA@PLOXCHG04.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 8 Jul 2013, Andreas Joachim Peters wrote:
> Hi Loic,
> 
> I did the two mentioned benchmarks:
> 
> QFS (m+3) code run's at 300 MB/s ... not worthy (jerasure 390 MB/s).
> 
> I made a quick (3+2) encoding benchmark and this encodes ~ 3 GB/s.
> 
> ...
> 
> For the checksumming ... I saw that there is the check if CRC32C is supported, but I was looking for a generic routine like:
> 
> crc32c_t crc32c(void* buffer, off_t lenght)
> 
> which internally selects either the HW accelerated or SW implementation. Mayby you have this in some other source file.

https://github.com/ceph/ceph/blob/master/src/include/crc32c.h

Let me know if anything looks awry; this is the first time I've done any 
runtime cpu checks.

Thanks!
sage

> 
> Cheers Andreas.
> 
> ________________________________________
> From: Sage Weil [sage@inktank.com]
> Sent: 08 July 2013 05:37
> To: Andreas Joachim Peters
> Cc: Loic Dachary; ceph-devel@vger.kernel.org
> Subject: RE: CEPH Erasure Encoding + OSD Scalability
> 
> On Sun, 7 Jul 2013, Andreas Joachim Peters wrote:
> > Considering the crc32c-intel code you added ... I would provide a
> > function which provides a crc32c checksum and detects if it can do it
> > using SSE4.2 or implements just the standard algorithm e.g if you run in
> > a virtual machine you need this emulation ...
> 
> The current code in master will do this detection by checking the cpu
> features; see
> 
>         https://github.com/ceph/ceph/blob/master/src/common/crc32c-intel.c#L74
> 
> If there is a better way to do this, I'd love to hear about it.  gcc 4.8
> just added a bunch of built-in functions to do this stuff cleanly, but
> it'll be quite a while before all of our build targets are on 4.8 or
> later.
> 
> sage
> 
> 
> >
> > Cheers Andreas.
> > ________________________________________
> > From: Loic Dachary [loic@dachary.org]
> > Sent: 06 July 2013 22:47
> > To: Andreas Joachim Peters
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: CEPH Erasure Encoding + OSD Scalability
> >
> > Hi Andreas,
> >
> > Since it looks like we're going to use jerasure-1.2, we will be able to try (C)RS using
> >
> > https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.c
> > https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.h
> >
> > Do you know of a better / faster implementation ? Is there a tradeoff between (C)RS and RS ?
> >
> > Cheers
> >
> > On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
> > > HI Loic,
> > > (C)RS stands for the Cauchy Reed-Solomon codes which are based on pure parity operations, while the standard Reed-Solomon codes need more multiplications and are slower.
> > >
> > > Considering the checksumming ... for comparison the CRC32 code from libz run's on a 8-core Xeon at ~730 MB/s for small block sizes while SSE4.2 CRC32C checksum run's at ~2GByte/s.
> > >
> > > Cheers Andreas.
> > >
> > >
> > >
> > >
> > > On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dachary.org <mailto:loic@dachary.org>> wrote:
> > >
> > >     Hi Andreas,
> > >
> > >     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
> > >     > thanks for the responses!
> > >     >
> > >     > Maybe this is useful for your erasure code discussion:
> > >     >
> > >     > as an example in our RS implementation we chunk a data block of e.g. 4M into 4 data chunks of 1M. Then we create a 2 parity chunks.
> > >     >
> > >     > Data & parity chunks are split into 4k blocks and these 4k blocks get a CRC32C block checksum each (SSE4.2 CPU extension => MIT library or BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) - nothing compared to the parity overhead ...
> > >     >
> > >     > You can now easily detect data corruption using the local checksums and avoid to read any parity information and (C)RS decoding if there is no corruption detected. Moreover CRC32C computation is distributed over several (in this case 4) machines while (C)RS decoding would run on a single machine where you assemble a block ... and CRC32C is faster than (C)RS decoding (with SSE4.2) ...
> > >
> > >     What does (C)RS mean ? (C)Reed-Solomon ?
> > >
> > >     > In our case we write this checksum information separate from the original data ... while in a block-based storage like CEPH it would be probably inlined in the data chunk.
> > >     > If an OSD detects to run on BRTFS or ZFS one could disable automatically the CRC32C code.
> > >
> > >     Nice. I did not know that was built-in :-)
> > >     https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasure-code.rst#scrubbing
> > >
> > >     > (wouldn't CRC32C be also useful for normal CEPH block replication? )
> > >
> > >     I don't know the details of scrubbing but it seems CRC is already used by deep scrubbing
> > >
> > >     https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731
> > >
> > >     Cheers
> > >
> > >     > As far as I know with the RS CODEC we use you can either miss stripes (data =0) in the decoding process but you cannot inject corrupted stripes into the decoding process, so the block checksumming is important.
> > >     >
> > >     > Cheers Andreas.
> > >
> > >     --
> > >     Lo?c Dachary, Artisan Logiciel Libre
> > >     All that is necessary for the triumph of evil is that good people do nothing.
> > >
> > >
> >
> > --
> > Lo?c Dachary, Artisan Logiciel Libre
> > All that is necessary for the triumph of evil is that good people do nothing.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> 
> 
