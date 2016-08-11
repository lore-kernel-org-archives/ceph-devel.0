From: Sage Weil <sage@newdream.net>
Subject: RE: Bluestore different allocator performance Vs FileStore
Date: Thu, 11 Aug 2016 20:03:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608112000200.17762@piezo.us.to>
References: <BL2PR02MB211554DBEC8F344E465BAFE5F41D0@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608102125270.17770@piezo.us.to> <BL2PR02MB2115CB5D9E89815706293EBBF41D0@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608102242590.17762@piezo.us.to>
 <BLUPR0201MB15248A827640A2C8B2119C98E81D0@BLUPR0201MB1524.namprd02.prod.outlook.com> ,<CY1PR0201MB1820E86B7587927ED23C055A851E0@CY1PR0201MB1820.namprd02.prod.outlook.com> <1431B127-59B3-4DCA-B3F2-FBB209ED2059@sandisk.com>
 <CY1PR0201MB1820F3561F0F89AFAF8A24AE851E0@CY1PR0201MB1820.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608111636360.17762@piezo.us.to> <BLUPR0201MB1524345DD4A25895939CE7B6E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608111710400.17762@piezo.us.to>
 <BLUPR0201MB1524F46599D0A90A7025F373E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608111929250.17770@piezo.us.to> <BLUPR0201MB15248F97217C67BA0051F131E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53682 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcHKUDR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 16:03:17 -0400
In-Reply-To: <BLUPR0201MB15248F97217C67BA0051F131E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 11 Aug 2016, Allen Samuels wrote:
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Thursday, August 11, 2016 12:34 PM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>; Somnath Roy
> > <Somnath.Roy@sandisk.com>; ceph-devel <ceph-devel@vger.kernel.org>
> > Subject: RE: Bluestore different allocator performance Vs FileStore
> > 
> > On Thu, 11 Aug 2016, Allen Samuels wrote:
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sage@newdream.net]
> > > > Sent: Thursday, August 11, 2016 10:15 AM
> > > > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > > Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>; Somnath Roy
> > > > <Somnath.Roy@sandisk.com>; ceph-devel <ceph-
> > devel@vger.kernel.org>
> > > > Subject: RE: Bluestore different allocator performance Vs FileStore
> > > >
> > > > On Thu, 11 Aug 2016, Allen Samuels wrote:
> > > > > > -----Original Message-----
> > > > > > From: Sage Weil [mailto:sage@newdream.net]
> > > > > > Sent: Thursday, August 11, 2016 9:38 AM
> > > > > > To: Ramesh Chander <Ramesh.Chander@sandisk.com>
> > > > > > Cc: Allen Samuels <Allen.Samuels@sandisk.com>; Somnath Roy
> > > > > > <Somnath.Roy@sandisk.com>; ceph-devel <ceph-
> > > > devel@vger.kernel.org>
> > > > > > Subject: RE: Bluestore different allocator performance Vs
> > > > > > FileStore
> > > > > >
> > > > > > On Thu, 11 Aug 2016, Ramesh Chander wrote:
> > > > > > > I think the free list does not initialize all keys at mkfs
> > > > > > > time, it does sets key that has some allocations.
> > > > > > >
> > > > > > > Rest keys are assumed to have 0's if key does not exist.
> > > > > >
> > > > > > Right.. it's the region "allocated" to bluefs that is consuming the time.
> > > > > >
> > > > > > > The bitmap allocator insert_free is done in group of free bits
> > > > > > > together(maybe more than bitmap freelist keys at a time).
> > > > > >
> > > > > > I think Allen is asking whether we are doing lots of inserts
> > > > > > within a single rocksdb transaction, or lots of separate transactions.
> > > > > >
> > > > > > FWIW, my guess is that increasing the size of the value (i.e.,
> > > > > > increasing
> > > > > >
> > > > > > OPTION(bluestore_freelist_blocks_per_key, OPT_INT, 128)
> > > > > >
> > > > > > ) will probably speed this up.
> > > > >
> > > > > If your assumption (> Right.. it's the region "allocated" to
> > > > > bluefs that is consuming the time) is correct, then I don't
> > > > > understand why this parameter has any effect on the problem.
> > > > >
> > > > > Aren't we reading BlueFS extents and setting them in the
> > > > > BitMapAllocator? That doesn't care about the chunking of bitmap
> > > > > bits into KV keys.
> > > >
> > > > I think this is something different.  During mkfs we take ~2% (or
> > > > somethign like that) of the block device, mark it 'allocated' (from
> > > > the bluestore freelist's
> > > > perspective) and give it to bluefs.  On a large device that's a lot of bits to
> > set.
> > > > Larger keys should speed that up.
> > >
> > > But the bits in the BitMap shouldn't be chunked up in the same units
> > > as the Keys. Right? Sharding of the bitmap is done for internal
> > > parallelism
> > > -- only, it has nothing to do with the persistent representation.
> > 
> > I'm not really sure what the BitmapAllocator is doing, but yeah, it's
> > independent.  The tunable I'm talking about though is the one that controls
> > how many bits BitmapFreelist puts in each key/value pair.
> 
> I understand, but that should be relevant only to operations that 
> actually either read or write to the KV Store. That's not the case here, 
> allocations by BlueFS are not recorded in the KVStore.
> 
> Whatever chunking/sharding of the bitmapfreelist is present should be 
> independent (well an integer multiple thereof....) of the number of bits 
> that are chunked up into a single KV Key/Value pair. Hence when doing 
> the initialization here (i.e., the marking of BlueFS allocated space in 
> the freelist) that shouldn't involve ANY KVStore operations. I think 
> it's worthwhile to modify the option (say make it 16 or 64x larger) and 
> see if that actually affects the initialization time -- if it does, then 
> there's something structurally inefficient in the code that's hopefully 
> easy to fix.

This is the allocation of space *to* bluefs, not *by* bluefs.  At mkfs 
time, we (BlueStore::mkfs() -> _open_fm()) will take 2% of the block 
device and mark it in-use with that fm->allocate() call below, and that 
flips a bunch of bits in the kv store.

> > > BlueFS allocations aren't stored in the KV database (to avoid
> > > circularity).
> > >
> > > So I don't see why a bitset of 2m bits should be taking so long.....
> > > Makes me thing that we don't really understand the problem.
> > 
> > Could be, I'm just guessing.  During mkfs, _open_fm() does
> > 
> >     fm->create(bdev->get_size(), t);
> > 
> > and then
> > 
> >     fm->allocate(0, reserved, t);

        ^ here.

> > 
> > where the value of reserved depends on how much we give to bluefs.  I'm
> > assuming this is the mkfs allocation that is taking time, but I haven't looked at
> > the allocator code at all or whether insert_free is part of this path...
> 
> Somnath's data clearly points to this....

sage

> 
> > 
> > sage
> > 
> > 
> > 
> > >
> > > >
> > > > The amount of space we start with comes from _open_db():
> > > >
> > > >       uint64_t initial =
> > > > 	bdev->get_size() * (g_conf->bluestore_bluefs_min_ratio +
> > > > 			    g_conf->bluestore_bluefs_gift_ratio);
> > > >       initial = MAX(initial, g_conf->bluestore_bluefs_min);
> > > >
> > > > Simply lowering min_ratio might also be fine.  The current value of
> > > > 2% is meant to be enough for most stores, and to avoid giving over
> > > > lots of little extents later (and making the bluefs_extents list too
> > > > big).  That can overflow the superblock, another annoying thing we
> > > > need to fix (though not a big deal to fix).
> > > >
> > > > Anyway, adjust bluestore_bluefs_min_ratio to .01 should ~halve the
> > > > time spent on this.. that is probably another useful test to confirm
> > > > this is what is going on.
> > >
> > > Yes, this should help -- but still seems like a bandaid. 
> > >
> > > >
> > > > sage
> > > >
> > > > > I would be cautious about just changing this option to affect this
> > > > > problem (though as an experiment, we can change the value and see
> > > > > if it has ANY affect on this problem -- which I don't think it
> > > > > will). The value of this option really needs to be dictated by its
> > > > > effect on the more mainstream read/write operations not on the
> > initialization problem.
> > > > > >
> > > > > > sage
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > -Ramesh
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Allen Samuels
> > > > > > > > Sent: Thursday, August 11, 2016 9:34 PM
> > > > > > > > To: Ramesh Chander
> > > > > > > > Cc: Sage Weil; Somnath Roy; ceph-devel
> > > > > > > > Subject: Re: Bluestore different allocator performance Vs
> > > > > > > > FileStore
> > > > > > > >
> > > > > > > > Is the initial creation of the keys for the bitmap one by
> > > > > > > > one or are they batched?
> > > > > > > >
> > > > > > > > Sent from my iPhone. Please excuse all typos and autocorrects.
> > > > > > > >
> > > > > > > > > On Aug 10, 2016, at 11:07 PM, Ramesh Chander
> > > > > > > > <Ramesh.Chander@sandisk.com> wrote:
> > > > > > > > >
> > > > > > > > > Somnath,
> > > > > > > > >
> > > > > > > > > Basically mkfs time has increased from 7.5 seconds (2min /
> > > > > > > > > 16) to
> > > > > > > > > 2 minutes
> > > > > > > > ( 32 / 16).
> > > > > > > > >
> > > > > > > > > But is there a reason you should create osds in serial? I
> > > > > > > > > think for mmultiple
> > > > > > > > osds mkfs can happen in parallel?
> > > > > > > > >
> > > > > > > > > As a fix I am looking to batch multiple insert_free calls for now.
> > > > > > > > > If still that
> > > > > > > > does not help, thinking of doing insert_free on different
> > > > > > > > part of device in parallel.
> > > > > > > > >
> > > > > > > > > -Ramesh
> > > > > > > > >
> > > > > > > > >> -----Original Message-----
> > > > > > > > >> From: Ramesh Chander
> > > > > > > > >> Sent: Thursday, August 11, 2016 10:04 AM
> > > > > > > > >> To: Allen Samuels; Sage Weil; Somnath Roy
> > > > > > > > >> Cc: ceph-devel
> > > > > > > > >> Subject: RE: Bluestore different allocator performance Vs
> > > > > > > > >> FileStore
> > > > > > > > >>
> > > > > > > > >> I think insert_free is limited by speed of function clear_bits
> > here.
> > > > > > > > >>
> > > > > > > > >> Though set_bits and clear_bits have same logic except one
> > > > > > > > >> sets and another clears. Both of these does 64 bits
> > > > > > > > >> (bitmap size) at
> > > > a time.
> > > > > > > > >>
> > > > > > > > >> I am not sure if doing memset will make it faster. But if
> > > > > > > > >> we can do it for group of bitmaps, then it might help.
> > > > > > > > >>
> > > > > > > > >> I am looking in to code if we can handle mkfs and osd
> > > > > > > > >> mount in special way to make it faster.
> > > > > > > > >>
> > > > > > > > >> If I don't find an easy fix, we can go to path of
> > > > > > > > >> deferring init to later stage as and when required.
> > > > > > > > >>
> > > > > > > > >> -Ramesh
> > > > > > > > >>
> > > > > > > > >>> -----Original Message-----
> > > > > > > > >>> From: ceph-devel-owner@vger.kernel.org
> > > > > > > > >>> [mailto:ceph-devel- owner@vger.kernel.org] On Behalf Of
> > > > > > > > >>> Allen Samuels
> > > > > > > > >>> Sent: Thursday, August 11, 2016 4:28 AM
> > > > > > > > >>> To: Sage Weil; Somnath Roy
> > > > > > > > >>> Cc: ceph-devel
> > > > > > > > >>> Subject: RE: Bluestore different allocator performance
> > > > > > > > >>> Vs FileStore
> > > > > > > > >>>
> > > > > > > > >>> We always knew that startup time for bitmap stuff would
> > > > > > > > >>> be somewhat longer. Still, the existing implementation
> > > > > > > > >>> can be speeded up significantly. The code in
> > > > > > > > >>> BitMapZone::set_blocks_used isn't very optimized.
> > > > > > > > >>> Converting it to use memset for all but the first/last
> > > > > > > > >>> bytes
> > > > > > > > >> should significantly speed it up.
> > > > > > > > >>>
> > > > > > > > >>>
> > > > > > > > >>> Allen Samuels
> > > > > > > > >>> SanDisk |a Western Digital brand
> > > > > > > > >>> 2880 Junction Avenue, San Jose, CA 95134
> > > > > > > > >>> T: +1 408 801 7030| M: +1 408 780 6416
> > > > > > > > >>> allen.samuels@SanDisk.com
> > > > > > > > >>>
> > > > > > > > >>>
> > > > > > > > >>>> -----Original Message-----
> > > > > > > > >>>> From: ceph-devel-owner@vger.kernel.org
> > > > > > > > >>>> [mailto:ceph-devel- owner@vger.kernel.org] On Behalf Of
> > > > > > > > >>>> Sage Weil
> > > > > > > > >>>> Sent: Wednesday, August 10, 2016 3:44 PM
> > > > > > > > >>>> To: Somnath Roy <Somnath.Roy@sandisk.com>
> > > > > > > > >>>> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> > > > > > > > >>>> Subject: RE: Bluestore different allocator performance
> > > > > > > > >>>> Vs FileStore
> > > > > > > > >>>>
> > > > > > > > >>>>> On Wed, 10 Aug 2016, Somnath Roy wrote:
> > > > > > > > >>>>> << inline with [Somnath]
> > > > > > > > >>>>>
> > > > > > > > >>>>> -----Original Message-----
> > > > > > > > >>>>> From: Sage Weil [mailto:sage@newdream.net]
> > > > > > > > >>>>> Sent: Wednesday, August 10, 2016 2:31 PM
> > > > > > > > >>>>> To: Somnath Roy
> > > > > > > > >>>>> Cc: ceph-devel
> > > > > > > > >>>>> Subject: Re: Bluestore different allocator performance
> > > > > > > > >>>>> Vs FileStore
> > > > > > > > >>>>>
> > > > > > > > >>>>>> On Wed, 10 Aug 2016, Somnath Roy wrote:
> > > > > > > > >>>>>> Hi, I spent some time on evaluating different
> > > > > > > > >>>>>> Bluestore allocator and freelist performance. Also,
> > > > > > > > >>>>>> tried to gaze the performance difference of Bluestore
> > > > > > > > >>>>>> and filestore on the similar
> > > > > > > > >> setup.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Setup:
> > > > > > > > >>>>>> --------
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 16 OSDs (8TB Flash) across 2 OSD nodes
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Single pool and single rbd image of 4TB. 2X replication.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Disabled the exclusive lock feature so that I can run
> > > > > > > > >>>>>> multiple write  jobs in
> > > > > > > > >>>> parallel.
> > > > > > > > >>>>>> rbd_cache is disabled in the client side.
> > > > > > > > >>>>>> Each test ran for 15 mins.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Result :
> > > > > > > > >>>>>> ---------
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Here is the detailed report on this.
> > > > > > > > >>
> > > > > > > >
> > > > > >
> > > >
> > https://github.com/somnathr/ceph/blob/6e03a5a41fe2c9b213a610200b2e8a
> > > > > > > > >>>>>> 25 0cb05986/Bluestore_allocator_comp.xlsx
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Each profile I named based on <allocator>-<freelist>
> > > > > > > > >>>>>> , so in the graph for
> > > > > > > > >>>> example "stupid-extent" meaning stupid allocator and
> > > > > > > > >>>> extent
> > > > > > freelist.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> I ran the test for each of the profile in the
> > > > > > > > >>>>>> following order after creating a
> > > > > > > > >>>> fresh rbd image for all the Bluestore test.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 1. 4K RW for 15 min with 16QD and 10 jobs.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 2. 16K RW for 15 min with 16QD and 10 jobs.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 3. 64K RW for 15 min with 16QD and 10 jobs.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 4. 256K RW for 15 min with 16QD and 10 jobs.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> The above are non-preconditioned case i.e ran before
> > > > > > > > >>>>>> filling up the entire
> > > > > > > > >>>> image. The reason is I don't see any reason of filling
> > > > > > > > >>>> up the rbd image before like filestore case where it
> > > > > > > > >>>> will give stable performance if we fill up the rbd images first.
> > > > > > > > >>>> Filling up rbd images in case of filestore will create
> > > > > > > > >>>> the files in
> > > > the filesystem.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 5. Next, I did precondition the 4TB image with 1M seq
> > write.
> > > > > > > > >>>>>> This is
> > > > > > > > >>>> primarily because I want to load BlueStore with more data.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 6. Ran 4K RW test again (this is called out
> > > > > > > > >>>>>> preconditioned in the
> > > > > > > > >>>>>> profile) for 15 min
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 7. Ran 4K Seq test for similar QD for 15 min
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 8. Ran 16K RW test again for 15min
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> For filestore test, I ran tests after preconditioning
> > > > > > > > >>>>>> the entire image
> > > > > > > > >> first.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Each sheet on the xls have different block size
> > > > > > > > >>>>>> result , I often miss to navigate through the xls
> > > > > > > > >>>>>> sheets , so, thought of mentioning here
> > > > > > > > >>>>>> :-)
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> I have also captured the mkfs time , OSD startup time
> > > > > > > > >>>>>> and the memory
> > > > > > > > >>>> usage after the entire run.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> Observation:
> > > > > > > > >>>>>> ---------------
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 1. First of all, in case of bitmap allocator mkfs
> > > > > > > > >>>>>> time (and thus cluster
> > > > > > > > >>>> creation time for 16 OSDs) are ~16X slower than stupid
> > > > > > > > >>>> allocator and
> > > > > > > > >>> filestore.
> > > > > > > > >>>> Each OSD creation is taking ~2min or so sometimes and I
> > > > > > > > >>>> nailed down the
> > > > > > > > >>>> insert_free() function call (marked ****) in the Bitmap
> > > > > > > > >>>> allocator is causing that.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 2016-08-05 16:12:40.587148 7f4024d258c0 10 freelist
> > > > > > > > >>>>>> enumerate_next start
> > > > > > > > >>>>>> 2016-08-05 16:12:40.975539 7f4024d258c0 10 freelist
> > > > > > > > >>>>>> enumerate_next
> > > > > > > > >>>>>> 0x4663d00000~69959451000
> > > > > > > > >>>>>> 2016-08-05 16:12:40.975555 7f4024d258c0 10
> > > > > > > > >>>>>> bitmapalloc:init_add_free instance 139913322803328
> > > > > > > > >>>>>> offset
> > > > > > > > >>>>>> 0x4663d00000 length 0x69959451000
> > > > > > > > >>>>>> ****2016-08-05 16:12:40.975557 7f4024d258c0 20
> > > > > > > > >>>>>> bitmapalloc:insert_free instance 139913322803328 off
> > > > > > > > >>>>>> 0x4663d00000 len 0x69959451000****
> > > > > > > > >>>>>> ****2016-08-05 16:13:20.748934 7f4024d258c0 10
> > > > > > > > >>>>>> freelist enumerate_next
> > > > > > > > >>>>>> end****
> > > > > > > > >>>>>> 2016-08-05 16:13:20.748978 7f4024d258c0 10
> > > > > > > > >>>>>> bluestore(/var/lib/ceph/osd/ceph-0) _open_alloc
> > > > > > > > >>>>>> loaded
> > > > > > > > >>>>>> 6757 G in
> > > > > > > > >>>>>> 1 extents
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> 2016-08-05 16:13:23.438511 7f4024d258c0 20 bluefs
> > > > > > > > >>>>>> _read_random read buffered 0x4a14eb~265 of
> > > > > > ^A:5242880+5242880
> > > > > > > > >>>>>> 2016-08-05 16:13:23.438587 7f4024d258c0 20 bluefs
> > > > > > > > >>>>>> _read_random got
> > > > > > > > >>>>>> 613
> > > > > > > > >>>>>> 2016-08-05 16:13:23.438658 7f4024d258c0 10 freelist
> > > > > > > > >>>>>> enumerate_next
> > > > > > > > >>>>>> 0x4663d00000~69959451000
> > > > > > > > >>>>>> 2016-08-05 16:13:23.438664 7f4024d258c0 10
> > > > > > > > >>>>>> bitmapalloc:init_add_free instance 139913306273920
> > > > > > > > >>>>>> offset
> > > > > > > > >>>>>> 0x4663d00000 length 0x69959451000
> > > > > > > > >>>>>> *****2016-08-05 16:13:23.438666 7f4024d258c0 20
> > > > > > > > >>>>>> bitmapalloc:insert_free instance 139913306273920 off
> > > > > > > > >>>>>> 0x4663d00000 len
> > > > > > > > >>>>>> 0x69959451000*****
> > > > > > > > >>>>>> *****2016-08-05 16:14:03.132914 7f4024d258c0 10
> > > > > > > > >>>>>> freelist enumerate_next end
> > > > > > > > >>>>>
> > > > > > > > >>>>> I'm not sure there's any easy fix for this. We can
> > > > > > > > >>>>> amortize it by feeding
> > > > > > > > >>>> space to bluefs slowly (so that we don't have to do all
> > > > > > > > >>>> the inserts at once), but I'm not sure that's really better.
> > > > > > > > >>>>>
> > > > > > > > >>>>> [Somnath] I don't know that part of the code, so, may
> > > > > > > > >>>>> be a dumb
> > > > > > > > >>> question.
> > > > > > > > >>>> This is during mkfs() time , so, can't we say to bluefs
> > > > > > > > >>>> entire space is free ? I can understand for osd mount
> > > > > > > > >>>> and all other cases we need to feed the free space every
> > time.
> > > > > > > > >>>>> IMO this is critical to fix as cluster creation time
> > > > > > > > >>>>> will be number of OSDs * 2
> > > > > > > > >>>> min otherwise. For me creating 16 OSDs cluster is
> > > > > > > > >>>> taking ~32min compare to
> > > > > > > > >>>> ~2 min for stupid allocator/filestore.
> > > > > > > > >>>>> BTW, my drive data partition is ~6.9TB , db partition
> > > > > > > > >>>>> is ~100G and WAL is
> > > > > > > > >>>> ~1G. I guess the time taking is dependent on data
> > > > > > > > >>>> partition size as well
> > > > > > > > (?
> > > > > > > > >>>>
> > > > > > > > >>>> Well, we're fundamentally limited by the fact that it's
> > > > > > > > >>>> a bitmap, and a big chunk of space is "allocated" to
> > > > > > > > >>>> bluefs and needs to have 1's
> > > > > > > > set.
> > > > > > > > >>>>
> > > > > > > > >>>> sage
> > > > > > > > >>>> --
> > > > > > > > >>>> To unsubscribe from this list: send the line
> > > > > > > > >>>> "unsubscribe
> > > > > > > > >>>> ceph-
> > > > > > devel"
> > > > > > > > >>>> in the body of a message to majordomo@vger.kernel.org
> > > > > > > > >>>> More
> > > > > > > > >>> majordomo
> > > > > > > > >>>> info at http://vger.kernel.org/majordomo-info.html
> > > > > > > > >>> --
> > > > > > > > >>> To unsubscribe from this list: send the line
> > > > > > > > >>> "unsubscribe ceph-
> > > > devel"
> > > > > > > > >>> in the body of a message to majordomo@vger.kernel.org
> > > > > > > > >>> More
> > > > > > > > >> majordomo
> > > > > > > > >>> info at http://vger.kernel.org/majordomo-info.html
> > > > > > > PLEASE NOTE: The information contained in this electronic mail
> > > > > > > message is
> > > > > > intended only for the use of the designated recipient(s) named
> > > > > > above. If the reader of this message is not the intended
> > > > > > recipient, you are hereby notified that you have received this
> > > > > > message in error and that any review, dissemination,
> > > > > > distribution, or copying of this message is strictly prohibited.
> > > > > > If you have received this communication in error, please notify
> > > > > > the sender by telephone or e-mail (as shown above) immediately
> > > > > > and destroy any and all copies of this message in your
> > > > > > possession (whether hard copies or electronically
> > > > stored copies).
> > > > > > > --
> > > > > > > To unsubscribe from this list: send the line "unsubscribe ceph-
> > devel"
> > > > > > > in the body of a message to majordomo@vger.kernel.org More
> > > > > > majordomo
> > > > > > > info at  http://vger.kernel.org/majordomo-info.html
> > > > > > >
> > > > > > >
> > > > >
> > > > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org More
> > majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> 
> 
