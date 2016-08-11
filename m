From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: Bluestore different allocator performance Vs FileStore
Date: Thu, 11 Aug 2016 04:34:08 +0000
Message-ID: <CY1PR0201MB18200CF43D09AE97D3313031851E0@CY1PR0201MB1820.namprd02.prod.outlook.com>
References: <BL2PR02MB211554DBEC8F344E465BAFE5F41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608102125270.17770@piezo.us.to>
 <BL2PR02MB2115CB5D9E89815706293EBBF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608102242590.17762@piezo.us.to>
 <BLUPR0201MB15248A827640A2C8B2119C98E81D0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0077.outbound.protection.outlook.com ([104.47.40.77]:51264
	"EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751598AbcHKEeM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 00:34:12 -0400
In-Reply-To: <BLUPR0201MB15248A827640A2C8B2119C98E81D0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I think insert_free is limited by speed of function clear_bits here.

Though set_bits and clear_bits have same logic except one sets and another clears. Both of these does 64 bits (bitmap size) at a time.

I am not sure if doing memset will make it faster. But if we can do it for group of bitmaps, then it might help.

I am looking in to code if we can handle mkfs and osd mount in special way to make it faster.

If I don't find an easy fix, we can go to path of deferring init to later stage as and when required.

-Ramesh

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Allen Samuels
> Sent: Thursday, August 11, 2016 4:28 AM
> To: Sage Weil; Somnath Roy
> Cc: ceph-devel
> Subject: RE: Bluestore different allocator performance Vs FileStore
>
> We always knew that startup time for bitmap stuff would be somewhat
> longer. Still, the existing implementation can be speeded up significantly. The
> code in BitMapZone::set_blocks_used isn't very optimized. Converting it to
> use memset for all but the first/last bytes should significantly speed it up.
>
>
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Wednesday, August 10, 2016 3:44 PM
> > To: Somnath Roy <Somnath.Roy@sandisk.com>
> > Cc: ceph-devel <ceph-devel@vger.kernel.org>
> > Subject: RE: Bluestore different allocator performance Vs FileStore
> >
> > On Wed, 10 Aug 2016, Somnath Roy wrote:
> > > << inline with [Somnath]
> > >
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@newdream.net]
> > > Sent: Wednesday, August 10, 2016 2:31 PM
> > > To: Somnath Roy
> > > Cc: ceph-devel
> > > Subject: Re: Bluestore different allocator performance Vs FileStore
> > >
> > > On Wed, 10 Aug 2016, Somnath Roy wrote:
> > > > Hi, I spent some time on evaluating different Bluestore allocator
> > > > and freelist performance. Also, tried to gaze the performance
> > > > difference of Bluestore and filestore on the similar setup.
> > > >
> > > > Setup:
> > > > --------
> > > >
> > > > 16 OSDs (8TB Flash) across 2 OSD nodes
> > > >
> > > > Single pool and single rbd image of 4TB. 2X replication.
> > > >
> > > > Disabled the exclusive lock feature so that I can run multiple
> > > > write  jobs in
> > parallel.
> > > > rbd_cache is disabled in the client side.
> > > > Each test ran for 15 mins.
> > > >
> > > > Result :
> > > > ---------
> > > >
> > > > Here is the detailed report on this.
> > > >
> > > >
> >
> https://github.com/somnathr/ceph/blob/6e03a5a41fe2c9b213a610200b2e8a
> > > > 25 0cb05986/Bluestore_allocator_comp.xlsx
> > > >
> > > > Each profile I named based on <allocator>-<freelist> , so in the
> > > > graph for
> > example "stupid-extent" meaning stupid allocator and extent freelist.
> > > >
> > > > I ran the test for each of the profile in the following order
> > > > after creating a
> > fresh rbd image for all the Bluestore test.
> > > >
> > > > 1. 4K RW for 15 min with 16QD and 10 jobs.
> > > >
> > > > 2. 16K RW for 15 min with 16QD and 10 jobs.
> > > >
> > > > 3. 64K RW for 15 min with 16QD and 10 jobs.
> > > >
> > > > 4. 256K RW for 15 min with 16QD and 10 jobs.
> > > >
> > > > The above are non-preconditioned case i.e ran before filling up
> > > > the entire
> > image. The reason is I don't see any reason of filling up the rbd
> > image before like filestore case where it will give stable performance
> > if we fill up the rbd images first. Filling up rbd images in case of
> > filestore will create the files in the filesystem.
> > > >
> > > > 5. Next, I did precondition the 4TB image with 1M seq write. This
> > > > is
> > primarily because I want to load BlueStore with more data.
> > > >
> > > > 6. Ran 4K RW test again (this is called out preconditioned in the
> > > > profile) for 15 min
> > > >
> > > > 7. Ran 4K Seq test for similar QD for 15 min
> > > >
> > > > 8. Ran 16K RW test again for 15min
> > > >
> > > > For filestore test, I ran tests after preconditioning the entire image first.
> > > >
> > > > Each sheet on the xls have different block size result , I often
> > > > miss to navigate through the xls sheets , so, thought of
> > > > mentioning here
> > > > :-)
> > > >
> > > > I have also captured the mkfs time , OSD startup time and the
> > > > memory
> > usage after the entire run.
> > > >
> > > > Observation:
> > > > ---------------
> > > >
> > > > 1. First of all, in case of bitmap allocator mkfs time (and thus
> > > > cluster
> > creation time for 16 OSDs) are ~16X slower than stupid allocator and
> filestore.
> > Each OSD creation is taking ~2min or so sometimes and I nailed down
> > the
> > insert_free() function call (marked ****) in the Bitmap allocator is
> > causing that.
> > > >
> > > > 2016-08-05 16:12:40.587148 7f4024d258c0 10 freelist enumerate_next
> > > > start
> > > > 2016-08-05 16:12:40.975539 7f4024d258c0 10 freelist enumerate_next
> > > > 0x4663d00000~69959451000
> > > > 2016-08-05 16:12:40.975555 7f4024d258c0 10
> > > > bitmapalloc:init_add_free instance 139913322803328 offset
> > > > 0x4663d00000 length 0x69959451000
> > > > ****2016-08-05 16:12:40.975557 7f4024d258c0 20
> > > > bitmapalloc:insert_free instance 139913322803328 off 0x4663d00000
> > > > len 0x69959451000****
> > > > ****2016-08-05 16:13:20.748934 7f4024d258c0 10 freelist
> > > > enumerate_next
> > > > end****
> > > > 2016-08-05 16:13:20.748978 7f4024d258c0 10
> > > > bluestore(/var/lib/ceph/osd/ceph-0) _open_alloc loaded 6757 G in 1
> > > > extents
> > > >
> > > > 2016-08-05 16:13:23.438511 7f4024d258c0 20 bluefs _read_random
> > > > read buffered 0x4a14eb~265 of ^A:5242880+5242880
> > > > 2016-08-05 16:13:23.438587 7f4024d258c0 20 bluefs _read_random got
> > > > 613
> > > > 2016-08-05 16:13:23.438658 7f4024d258c0 10 freelist enumerate_next
> > > > 0x4663d00000~69959451000
> > > > 2016-08-05 16:13:23.438664 7f4024d258c0 10
> > > > bitmapalloc:init_add_free instance 139913306273920 offset
> > > > 0x4663d00000 length 0x69959451000
> > > > *****2016-08-05 16:13:23.438666 7f4024d258c0 20
> > > > bitmapalloc:insert_free instance 139913306273920 off 0x4663d00000
> > > > len
> > > > 0x69959451000*****
> > > > *****2016-08-05 16:14:03.132914 7f4024d258c0 10 freelist
> > > > enumerate_next end
> > >
> > > I'm not sure there's any easy fix for this. We can amortize it by
> > > feeding
> > space to bluefs slowly (so that we don't have to do all the inserts at
> > once), but I'm not sure that's really better.
> > >
> > > [Somnath] I don't know that part of the code, so, may be a dumb
> question.
> > This is during mkfs() time , so, can't we say to bluefs entire space
> > is free ? I can understand for osd mount and all other cases we need
> > to feed the free space every time.
> > > IMO this is critical to fix as cluster creation time will be number
> > > of OSDs * 2
> > min otherwise. For me creating 16 OSDs cluster is taking ~32min
> > compare to
> > ~2 min for stupid allocator/filestore.
> > > BTW, my drive data partition is ~6.9TB , db partition is ~100G and
> > > WAL is
> > ~1G. I guess the time taking is dependent on data partition size as well (?
> >
> > Well, we're fundamentally limited by the fact that it's a bitmap, and
> > a big chunk of space is "allocated" to bluefs and needs to have 1's set.
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
