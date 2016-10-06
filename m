From: Sage Weil <sweil@redhat.com>
Subject: Re: mempool
Date: Thu, 6 Oct 2016 18:59:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610061854160.19850@piezo.us.to>
References: <BLUPR0201MB1524FCE57FC7238B33A62A72E8C40@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2838077-1475780361=:19850"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932990AbcJFS7V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 14:59:21 -0400
In-Reply-To: <BLUPR0201MB1524FCE57FC7238B33A62A72E8C40@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2838077-1475780361=:19850
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Hi Allen,

On Wed, 5 Oct 2016, Allen Samuels wrote:
> 
> Ok, here¢s something to look at:
> 
> https://github.com/allensamuels/ceph/blob/master/src/include/mempool.h
> https://github.com/allensamuels/ceph/blob/master/src/common/mempool.cc
> 
> and the unit test
> 
> https://github.com/allensamuels/ceph/blob/master/src/test/test_mempool.cc
>
> The simple comment is at the top of mempool.h

I've pulled your core into wip-mempool in github.com:liewegas/ceph.git and 
switched several bluestore types to use it.  The unit tests work fine, but 
I have 2 problems:

1) when ceph-osd forks it asserts out in ~slab_container.  commenting out 
the asserts for now is enough to proceed.  I assume it's because the
mempool is in use at fork() time.

2) After a few thousand ops I crash here:

#4  0x000055c6180a360b in mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::freeslot (
    freeEmpty=true, s=0x55c6253f73c8, this=0x55c618a2f6a0 <_factory_bluestore_extent>)
    at /home/sage/src/ceph2/src/include/mempool.h:485
#5  mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::deallocate (s=0, p=0x55c6253f73d0, 
    this=0x55c618a2f6a0 <_factory_bluestore_extent>)
    at /home/sage/src/ceph2/src/include/mempool.h:602
#6  mempool::factory<(mempool::pool_index_t)2, BlueStore::Extent, 0ul, 4ul>::free (
    p=0x55c6253f73d0, this=0x55c618a2f6a0 <_factory_bluestore_extent>)
    at /home/sage/src/ceph2/src/include/mempool.h:1072
#7  BlueStore::Extent::operator delete (p=0x55c6253f73d0)
    at /home/sage/src/ceph2/src/os/bluestore/BlueStore.cc:37
#8  0x000055c6180cb7b0 in BlueStore::ExtentMap::rm (p=..., this=0x55c6254416a8)
    at /home/sage/src/ceph2/src/os/bluestore/BlueStore.h:673
#9  BlueStore::ExtentMap::punch_hole (this=this@entry=0x55c6231dbc78, 
    offset=offset@entry=217088, length=length@entry=4096, 
    old_extents=old_extents@entry=0x7ff6a70324a8)
    at /home/sage/src/ceph2/src/os/bluestore/BlueStore.cc:2140

(gdb) 
#4  0x000055c6180a360b in mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::freeslot (
    freeEmpty=true, s=0x55c6253f73c8, this=0x55c618a2f6a0 <_factory_bluestore_extent>)
    at /home/sage/src/ceph2/src/include/mempool.h:485
485              slab->slabHead.next->prev = slab->slabHead.prev;
(gdb) p slab
$1 = (mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::slab_t *) 
0x55c6253f7300
(gdb) p slab->slabHead 
$2 = {
  prev = 0x0, 
  next = 0x0
}
(gdb) list
480           }
481           if (freeEmpty && slab->freeSlots == slab->slabSize && slab != &stackSlab) {
482              //
483              // Slab is entirely free
484              //
485              slab->slabHead.next->prev = slab->slabHead.prev;
486              slab->slabHead.prev->next = slab->slabHead.next;
487              assert(freeSlotCount >= slab->slabSize);
488              freeSlotCount -= slab->slabSize;
489              assert(slabs > 0);

Any bright ideas before I dig in?

BTW, we discussed this a bit last night at CDM and the main concern is 
that this approach currently wraps up a slab allocator with the mempools.  
It may be that these are both going to be good things, but they are 
conceptually orthogonal, and it's hard to tell whether the slab allocator 
is necessary without also having a simpler approach that does *just* the 
accounting.  Is there any reason these have to be tied together?

Thanks!
sage

--8323329-2838077-1475780361=:19850--
