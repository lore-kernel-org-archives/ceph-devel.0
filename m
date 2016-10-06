From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: mempool
Date: Thu, 6 Oct 2016 20:05:57 +0000
Message-ID: <BLUPR0201MB1524589B080297248250EA3FE8C70@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <BLUPR0201MB1524FCE57FC7238B33A62A72E8C40@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1610061854160.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0040.outbound.protection.outlook.com ([104.47.41.40]:38240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934992AbcJFUF7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 16:05:59 -0400
In-Reply-To: <alpine.DEB.2.11.1610061854160.19850@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Not sure why it faults out at fork time. But that's probably easy to dig in=
to.

The slabs are certainly orthogonal to the accounting.  FWIW, if you set the=
 stackSize to 0 and the heapSize to 1, you'll pretty much get the same effe=
ct.=20

>>> See below

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, October 06, 2016 6:59 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: mempool
>=20
> Hi Allen,
>=20
> On Wed, 5 Oct 2016, Allen Samuels wrote:
> >
> > Ok, here=A2s something to look at:
> >
> >
> https://github.com/allensamuels/ceph/blob/master/src/include/mempool.h
> >
> https://github.com/allensamuels/ceph/blob/master/src/common/mempool
> .cc
> >
> > and the unit test
> >
> >
> https://github.com/allensamuels/ceph/blob/master/src/test/test_mempool
> > .cc
> >
> > The simple comment is at the top of mempool.h
>=20
> I've pulled your core into wip-mempool in github.com:liewegas/ceph.git an=
d
> switched several bluestore types to use it.  The unit tests work fine, bu=
t I
> have 2 problems:
>=20
> 1) when ceph-osd forks it asserts out in ~slab_container.  commenting out
> the asserts for now is enough to proceed.  I assume it's because the
> mempool is in use at fork() time.
>=20
> 2) After a few thousand ops I crash here:
>=20
> #4  0x000055c6180a360b in mempool::slab_allocator<BlueStore::Extent, 0ul,
> 4ul>::freeslot (
>     freeEmpty=3Dtrue, s=3D0x55c6253f73c8, this=3D0x55c618a2f6a0
> <_factory_bluestore_extent>)
>     at /home/sage/src/ceph2/src/include/mempool.h:485
> #5  mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::deallocate (s=
=3D0,
> p=3D0x55c6253f73d0,
>     this=3D0x55c618a2f6a0 <_factory_bluestore_extent>)
>     at /home/sage/src/ceph2/src/include/mempool.h:602
> #6  mempool::factory<(mempool::pool_index_t)2, BlueStore::Extent, 0ul,
> 4ul>::free (
>     p=3D0x55c6253f73d0, this=3D0x55c618a2f6a0 <_factory_bluestore_extent>=
)
>     at /home/sage/src/ceph2/src/include/mempool.h:1072
> #7  BlueStore::Extent::operator delete (p=3D0x55c6253f73d0)
>     at /home/sage/src/ceph2/src/os/bluestore/BlueStore.cc:37
> #8  0x000055c6180cb7b0 in BlueStore::ExtentMap::rm (p=3D...,
> this=3D0x55c6254416a8)
>     at /home/sage/src/ceph2/src/os/bluestore/BlueStore.h:673
> #9  BlueStore::ExtentMap::punch_hole (this=3Dthis@entry=3D0x55c6231dbc78,
>     offset=3Doffset@entry=3D217088, length=3Dlength@entry=3D4096,
>     old_extents=3Dold_extents@entry=3D0x7ff6a70324a8)
>     at /home/sage/src/ceph2/src/os/bluestore/BlueStore.cc:2140
>=20
> (gdb)
> #4  0x000055c6180a360b in mempool::slab_allocator<BlueStore::Extent, 0ul,
> 4ul>::freeslot (
>     freeEmpty=3Dtrue, s=3D0x55c6253f73c8, this=3D0x55c618a2f6a0
> <_factory_bluestore_extent>)
>     at /home/sage/src/ceph2/src/include/mempool.h:485
> 485              slab->slabHead.next->prev =3D slab->slabHead.prev;
> (gdb) p slab
> $1 =3D (mempool::slab_allocator<BlueStore::Extent, 0ul, 4ul>::slab_t *)
> 0x55c6253f7300
> (gdb) p slab->slabHead
> $2 =3D {
>   prev =3D 0x0,
>   next =3D 0x0
> }

>>>>> Nulls here indicate that this SLAB isn't on the list of slabs that ha=
ve a free slot, i.e., it indicates that this slab was completely allocated.

But that seems plausible.=20

The freelist works as follows:

Each slab has a singly-linked list of free slots in that slab. This is link=
ed through the "freeHead" member of slab_t.

Each slab that isn't fully allocated is put on a doubly-linked list hung of=
f of the container irself (slab_t::slabHead).

The basically, if slab_t->freeSlotCount =3D=3D 0, then slot_t::slabHead is =
null -> because the slab is fully allocated, it's not on the freelist.
If slab_t->freeSlotCount !=3D 0 (i.e, there's a free slot), then slot_t::sl=
abHead shouldn't be null, it should be in the double-linked list off of the=
 contiainer head.

The transition case from 0 to !=3D 0, is handled in the code immediately pr=
eceeding this. Plus, since slabSize =3D=3D 4 here, AND we've satisfied slab=
->freeSlots =3D=3D slab->slabSize, that code shouldn't have been triggered.
There's only one place in the code where freeSlots is incremented (it's a f=
ew lines before this). That code seems to clearly catch the transition from=
 0 to 1....
There's only one place in the code where freeSlots is decremented, and it h=
andles the =3D=3D 0 case, pretty clearly.

So I'm stumped.

A print of *slab might be helpful.


> (gdb) list
> 480           }
> 481           if (freeEmpty && slab->freeSlots =3D=3D slab->slabSize && s=
lab !=3D
> &stackSlab) {
> 482              //
> 483              // Slab is entirely free
> 484              //
> 485              slab->slabHead.next->prev =3D slab->slabHead.prev;
> 486              slab->slabHead.prev->next =3D slab->slabHead.next;
> 487              assert(freeSlotCount >=3D slab->slabSize);
> 488              freeSlotCount -=3D slab->slabSize;
> 489              assert(slabs > 0);
>=20
> Any bright ideas before I dig in?
>=20
> BTW, we discussed this a bit last night at CDM and the main concern is th=
at
> this approach currently wraps up a slab allocator with the mempools.
> It may be that these are both going to be good things, but they are
> conceptually orthogonal, and it's hard to tell whether the slab allocator=
 is
> necessary without also having a simpler approach that does *just* the
> accounting.  Is there any reason these have to be tied together?
>=20
> Thanks!
> sage
