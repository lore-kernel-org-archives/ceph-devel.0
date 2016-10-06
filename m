From: Sage Weil <sweil@redhat.com>
Subject: RE: mempool
Date: Thu, 6 Oct 2016 21:45:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610062139410.19850@piezo.us.to>
References: <BLUPR0201MB1524FCE57FC7238B33A62A72E8C40@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1610061854160.19850@piezo.us.to> <BLUPR0201MB1524589B080297248250EA3FE8C70@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-528388074-1475790339=:19850"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbcJFVpk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 17:45:40 -0400
In-Reply-To: <BLUPR0201MB1524589B080297248250EA3FE8C70@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-528388074-1475790339=:19850
Content-Type: TEXT/PLAIN; charset=iso-8859-7
Content-Transfer-Encoding: 8BIT

On Thu, 6 Oct 2016, Allen Samuels wrote:
> Not sure why it faults out at fork time. But that's probably easy to dig 
> into.
> 
> The slabs are certainly orthogonal to the accounting.  FWIW, if you set 
> the stackSize to 0 and the heapSize to 1, you'll pretty much get the 
> same effect.

I gave up and ripped out the guts of slab_allocator, renamed it 
pool_allocator, and simplified the rest of the code to just count bytes 
and items by type.  And so far it's working great!

Just a few problems right now:

- When I enable containers the dump stats tends to crash.  I'm 
guessing this is a lifecycle thing where a deleted container is 
getting visited by the stats dumper.

- I was lazy and removed vector entirely since the allocator was special; 
need to add that back in.

- The by_bytes etc stats are not terribly useful because they give you 
totals per container instance.  I'm not convinced that will actually be 
that useful, but maybe I'm missing something.  For now it just makes the 
dump mostly useless because it's sorted ascending.  If we're not concnered 
with slots vs slabs, though, does it really give us anything?  We could 
also just add a container counter so we know items vs containers vs 
bytes...


Anyway, in the process I noticed this comment again:

// fast slab allocator
//
// This is an STL allocator intended for use with short-lived node-heavy 
// containers, i.e., map, set, etc.

and I think the mempools are going to be most useful for long-lived 
objects (like caches), so I don't think the slab stuff belongs here.

What do you think?

sage



> 
> >>> See below
> 
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Thursday, October 06, 2016 6:59 PM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: mempool
> > 
> > Hi Allen,
> > 
> > On Wed, 5 Oct 2016, Allen Samuels wrote:
> > >
> > > Ok, here¢s something to look at:
> > >
> > >
> > https://github.com/allensamuels/ceph/blob/master/src/include/mempool.h
> > >
> > https://github.com/allensamuels/ceph/blob/master/src/common/mempool
> > .cc
> > >
> > > and the unit test
> > >
> > >
> > https://github.com/allensamuels/ceph/blob/master/src/test/test_mempool
> > > .cc
> > >
> > > The simple comment is at the top of mempool.h
> > 
> > I've pulled your core into wip-mempool in github.com:liewegas/ceph.git and
> > switched several bluestore types to use it.  The unit tests work fine, but I
> > have 2 problems:
> > 
> > 1) when ceph-osd forks it asserts out in ~slab_container.  commenting out
> > the asserts for now is enough to proceed.  I assume it's because the
> > mempool is in use at fork() time.
> > 
> > 2) After a few thousand ops I crash here:
> > 
> > #4  0x000055c6180a360b in mempool::slab_allocator<BlueStore::Extent, 0ul,
> > 4ul>::freeslot (
> >     freeEmpty=true, s=0x55c6253f73c8, this=0x55c618a2f6a0
> > <_factory_bluestore_extent>)
> >     at /home/sage/src/ceph2/src/include/mempool.h:485
> > #5  mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::deallocate (s=0,
> > p=0x55c6253f73d0,
> >     this=0x55c618a2f6a0 <_factory_bluestore_extent>)
> >     at /home/sage/src/ceph2/src/include/mempool.h:602
> > #6  mempool::factory<(mempool::pool_index_t)2, BlueStore::Extent, 0ul,
> > 4ul>::free (
> >     p=0x55c6253f73d0, this=0x55c618a2f6a0 <_factory_bluestore_extent>)
> >     at /home/sage/src/ceph2/src/include/mempool.h:1072
> > #7  BlueStore::Extent::operator delete (p=0x55c6253f73d0)
> >     at /home/sage/src/ceph2/src/os/bluestore/BlueStore.cc:37
> > #8  0x000055c6180cb7b0 in BlueStore::ExtentMap::rm (p=...,
> > this=0x55c6254416a8)
> >     at /home/sage/src/ceph2/src/os/bluestore/BlueStore.h:673
> > #9  BlueStore::ExtentMap::punch_hole (this=this@entry=0x55c6231dbc78,
> >     offset=offset@entry=217088, length=length@entry=4096,
> >     old_extents=old_extents@entry=0x7ff6a70324a8)
> >     at /home/sage/src/ceph2/src/os/bluestore/BlueStore.cc:2140
> > 
> > (gdb)
> > #4  0x000055c6180a360b in mempool::slab_allocator<BlueStore::Extent, 0ul,
> > 4ul>::freeslot (
> >     freeEmpty=true, s=0x55c6253f73c8, this=0x55c618a2f6a0
> > <_factory_bluestore_extent>)
> >     at /home/sage/src/ceph2/src/include/mempool.h:485
> > 485              slab->slabHead.next->prev = slab->slabHead.prev;
> > (gdb) p slab
> > $1 = (mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::slab_t *)
> > 0x55c6253f7300
> > (gdb) p slab->slabHead
> > $2 = {
> >   prev = 0x0,
> >   next = 0x0
> > }
> 
> >>>>> Nulls here indicate that this SLAB isn't on the list of slabs that have a free slot, i.e., it indicates that this slab was completely allocated.
> 
> But that seems plausible. 
> 
> The freelist works as follows:
> 
> Each slab has a singly-linked list of free slots in that slab. This is linked through the "freeHead" member of slab_t.
> 
> Each slab that isn't fully allocated is put on a doubly-linked list hung off of the container irself (slab_t::slabHead).
> 
> The basically, if slab_t->freeSlotCount == 0, then slot_t::slabHead is null -> because the slab is fully allocated, it's not on the freelist.
> If slab_t->freeSlotCount != 0 (i.e, there's a free slot), then slot_t::slabHead shouldn't be null, it should be in the double-linked list off of the contiainer head.
> 
> The transition case from 0 to != 0, is handled in the code immediately preceeding this. Plus, since slabSize == 4 here, AND we've satisfied slab->freeSlots == slab->slabSize, that code shouldn't have been triggered.
> There's only one place in the code where freeSlots is incremented (it's a few lines before this). That code seems to clearly catch the transition from 0 to 1....
> There's only one place in the code where freeSlots is decremented, and it handles the == 0 case, pretty clearly.
> 
> So I'm stumped.
> 
> A print of *slab might be helpful.
> 
> 
> > (gdb) list
> > 480           }
> > 481           if (freeEmpty && slab->freeSlots == slab->slabSize && slab !=
> > &stackSlab) {
> > 482              //
> > 483              // Slab is entirely free
> > 484              //
> > 485              slab->slabHead.next->prev = slab->slabHead.prev;
> > 486              slab->slabHead.prev->next = slab->slabHead.next;
> > 487              assert(freeSlotCount >= slab->slabSize);
> > 488              freeSlotCount -= slab->slabSize;
> > 489              assert(slabs > 0);
> > 
> > Any bright ideas before I dig in?
> > 
> > BTW, we discussed this a bit last night at CDM and the main concern is that
> > this approach currently wraps up a slab allocator with the mempools.
> > It may be that these are both going to be good things, but they are
> > conceptually orthogonal, and it's hard to tell whether the slab allocator is
> > necessary without also having a simpler approach that does *just* the
> > accounting.  Is there any reason these have to be tied together?
> > 
> > Thanks!
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-528388074-1475790339=:19850--
