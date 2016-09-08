From: Sage Weil <sage@newdream.net>
Subject: RE: assert at BitMapAllocator
Date: Thu, 8 Sep 2016 19:20:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609081918210.10416@piezo.us.to>
References: <36559f57-15a3-f6d8-b27c-1efe5b1cb041@mirantis.com> <CY1PR0201MB18208FC20978DF6806F46D4085FB0@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-454269082-1473362408=:10416"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57588 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938681AbcIHTUK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 15:20:10 -0400
In-Reply-To: <CY1PR0201MB18208FC20978DF6806F46D4085FB0@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-454269082-1473362408=:10416
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 8 Sep 2016, Ramesh Chander wrote:
> The bluestore allocator is initialized with min_alloc_size and BlueFS 
> instance of allocator is initialized with bluefs_alloc_size.
> 
> The intention to keep BlueFS allocator to bluefs_alloc_size (1MB) was 
> considering that allocations are always 1MB for BlueFS, so 1MB block 
> size keeps it memory and search efficient.
> 
> But in case of moving extents between bluefs and bluestore this 
> assumption breaks.
> 
> So either we can make sure that extents moving to and fro bluestore and 
> bluefs are always in contiguous 1MB chunks. That demands availability of 
> 1MB chunks.
> 
> Or
> 
> make bluefs allocator also use min_alloc_size.
> 
> 
> 316     assert(bdev[id]->get_size());
>  317     alloc[id] = Allocator::create(g_conf->bluestore_allocator,
>  318                                   bdev[id]->get_size(),
>  319                                   g_conf->bluefs_alloc_size);     <<< Change it to g_conf->min_alloc_size or to min min_alloc_size as discussed in other thread regarding the changing min_alloc_size across reboots.
> 
> 
> But that may make two instance of allocator for same device and have 
> double memory requirement.

Hmm.  I wonder if the simplest solution is just to use the ExtentAllocator 
for bluefs.  It's extents are all big so it'll be more memory (and 
probably CPU?) efficient, and it won't have the alignment restriction.

My second choice would be to ensure that bluestore gives bluefs 
1MB-aligned extents... but that sounds annoying, and may fail in 
pathological cases if we are heavily fragmented.

sage


> 
> Igor,
> 
>  Second should at least fix you problem for now.
> 
> 
> -Regards,
>  Ramesh
> 
> 
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Igor Fedotov
> > Sent: Thursday, September 08, 2016 7:57 PM
> > To: ceph-devel
> > Subject: assert at BitMapAllocator
> >
> > Hi All,
> >
> > I'm observing an assert at BitMapAllocator with recent master.
> >
> > Here is the call stack
> >
> >    -2> 2016-09-08 14:03:06.012847 7fe64ffff700  0
> > bluestore(./fio-bluestore) _balance_bluefs_freespace reclaiming
> > 1908342784 (1819 M)
> >      -1> 2016-09-08 14:03:06.012915 7fe64ffff700  0 bitmapalloc:reserve
> > 1908342784 1048576
> >       0> 2016-09-08 14:03:06.026425 7fe64ffff700 -1
> > /root/ceph/ceph/src/os/bluestore/BitMapAllocator.cc: In function 'virtual int
> > BitMapAllocator::reserve(uint64_t)' thread 7fe64ffff700 time 2016-09-08
> > 14:03:06.012930
> > /root/ceph/ceph/src/os/bluestore/BitMapAllocator.cc: 88: FAILED
> > assert(!(need % m_block_size))
> >
> >   ceph version v11.0.0-2160-g1556190
> > (15561908510a3838e87f1938e5afc65570fecdc4)
> >   1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x95) [0x7fe72f132d7e]
> >   2: (BitMapAllocator::reserve(unsigned long)+0x204) [0x7fe72efb8482]
> >   3: (BlueFS::reclaim_blocks(unsigned int, unsigned long, unsigned long*,
> > unsigned int*)+0x286) [0x7fe72ef6bc3a]
> >   4:
> > (BlueStore::_balance_bluefs_freespace(std::vector<bluestore_pextent_t,
> > std::allocator<bluestore_pextent_t> >*)+0x1417) [0x7fe72ee62227]
> >   5: (BlueStore::_kv_sync_thread()+0x1234) [0x7fe72ee849d2]
> >   6: (BlueStore::KVSyncThread::entry()+0x1c) [0x7fe72eea81c8]
> >   7: (Thread::entry_wrapper()+0xc1) [0x7fe72f1ea9dd]
> >   8: (Thread::_entry_func(void*)+0x18) [0x7fe72f1ea912]
> >   9: (()+0x76fa) [0x7fe7421dc6fa]
> >   10: (clone()+0x6d) [0x7fe741d0eb5d]
> >
> > The line below presents 'reclaim' var value when calling
> > bluefs->reclaim_blocks from BlueStore.cc
> >
> >    -2> 2016-09-08 14:03:06.012847 7fe64ffff700  0
> > bluestore(./fio-bluestore) _balance_bluefs_freespace reclaiming
> > 1908342784 (1819 M)
> >
> > and following one provides need & m_block_size vars at
> > BitMapAlloc::reserve
> >
> >      -1> 2016-09-08 14:03:06.012915 7fe64ffff700  0 bitmapalloc:reserve
> > 1908342784 1048576
> >
> > One can see that BlueStore provides a value not aligned with
> > BitMapAllocator's m_block_size.
> > Indeed there is
> >      reclaim = P2ROUNDUP(reclaim, min_alloc_size); where min_alloc_size =
> > 64K in my case, not 1M as BitMapAllocator expects.
> >
> > Any comments/suggestions?
> >
> > Thanks,
> > Igor
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> > body of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-454269082-1473362408=:10416--
