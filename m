From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: Bluestore different allocator performance Vs FileStore
Date: Fri, 12 Aug 2016 05:52:51 +0000
Message-ID: <CY1PR0201MB182000D1CFB7D55ED04C8658851F0@CY1PR0201MB1820.namprd02.prod.outlook.com>
References: <BL2PR02MB211554DBEC8F344E465BAFE5F41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <1431B127-59B3-4DCA-B3F2-FBB209ED2059@sandisk.com>
 <CY1PR0201MB1820F3561F0F89AFAF8A24AE851E0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608111636360.17762@piezo.us.to>
 <BLUPR0201MB1524345DD4A25895939CE7B6E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608111710400.17762@piezo.us.to>
 <BLUPR0201MB1524F46599D0A90A7025F373E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608111929250.17770@piezo.us.to>
 <BLUPR0201MB15248F97217C67BA0051F131E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608112000200.17762@piezo.us.to>
 <BLUPR0201MB15249FEF89ED408BDCC5808BE81E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608112018400.17762@piezo.us.to>
 <BLUPR0201MB1524A947959FE39B1D2A5E4EE81E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608112115250.17762@piezo.us.to>
 <BL2PR02MB211500E786B1AB540711A7E8F41F0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BLUPR0201MB1524C5F1601946044F21B0F8E81F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:33702
	"EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750878AbcHLFw4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 01:52:56 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Good catch Allen :),

Removing is_allocated call reduces time to < 10 secs   from around 40secs.

Though we may not be able to live with just removing it, but can definitely think of avoiding it or optimizing it.

One obvious one is to do check bits in batch as we do set and clear. I was not done since we always thought it as debug code.

I am already doing the code change.

-Ramesh

> -----Original Message-----
> From: Ramesh Chander
> Sent: Friday, August 12, 2016 10:57 AM
> To: Allen Samuels; Somnath Roy; Sage Weil
> Cc: ceph-devel
> Subject: RE: Bluestore different allocator performance Vs FileStore
>
> Yes, that is good point, I will try skip the is_allocated and see if it improves.
>
> I confirm Somnath's number , 2G of bitmap takes around 40sec to init and in
> mkfs it is done two times, once for mkfs then for mount.
>
> That makes total of ~80secs ( 1 min 20 secs) out of 120 secs Somanth is
> seeing.
>
> -Ramesh
>
> > -----Original Message-----
> > From: Allen Samuels
> > Sent: Friday, August 12, 2016 9:15 AM
> > To: Somnath Roy; Sage Weil
> > Cc: Ramesh Chander; ceph-devel
> > Subject: RE: Bluestore different allocator performance Vs FileStore
> >
> > Is there a simple way to detect whether you're in initialization/not?
> > If so, you could augment the debug_asserts to skip the is_allocated
> > during initialization but re-enable them during normal operation.
> >
> > Allen Samuels
> > SanDisk |a Western Digital brand
> > 2880 Junction Avenue, Milpitas, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >
> > > -----Original Message-----
> > > From: Somnath Roy
> > > Sent: Thursday, August 11, 2016 8:10 PM
> > > To: Sage Weil <sage@newdream.net>; Allen Samuels
> > > <Allen.Samuels@sandisk.com>
> > > Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>; ceph-devel
> <ceph-
> > > devel@vger.kernel.org>
> > > Subject: RE: Bluestore different allocator performance Vs FileStore
> > >
> > > Sage,
> > > I tried your PR but it is not helping much. See this each
> > > insert_free() call is taking ~40sec to complete and we have 2 calls
> > > that is
> > taking time..
> > >
> > > 2016-08-11 17:32:48.086109 7f7243fad8c0 10 bitmapalloc:init_add_free
> > > instance 140128595341440 offset 0x2000 length 0x6ab7d14f000
> > > 2016-08-11 17:32:48.086111 7f7243fad8c0 20 bitmapalloc:insert_free
> > > instance
> > > 140128595341440 off 0x2000 len 0x6ab7d14f000
> > > 2016-08-11 17:33:27.843948 7f7243fad8c0 30 freelist  no more clear
> > > bits in
> > > 0x6ab7d100000
> > >
> > > 2016-08-11 17:33:30.839093 7f7243fad8c0 10 bitmapalloc:init_add_free
> > > instance 140127837929472 offset 0x2000 length 0x6ab7d14f000
> > > 2016-08-11 17:33:30.839095 7f7243fad8c0 20 bitmapalloc:insert_free
> > > instance
> > > 140127837929472 off 0x2000 len 0x6ab7d14f000
> > > 2016-08-11 17:34:10.517809 7f7243fad8c0 30 freelist  no more clear
> > > bits in
> > > 0x6ab7d100000
> > >
> > > I have also tried with the following and it is not helping either..
> > >
> > >        bluestore_bluefs_min_ratio = .01
> > >         bluestore_freelist_blocks_per_key = 512
> > >
> > >
> > > I did some debugging on this to find out which call inside this
> > > function is taking time and I found this within
> > > BitAllocator::free_blocks
> > >
> > >   debug_assert(is_allocated(start_block, num_blocks));
> > >
> > >   free_blocks_int(start_block, num_blocks);
> > >
> > > I did skip this debug_assert and total time reduced from ~80sec
> > > ~49sec , so, that's a significant improvement.
> > >
> > > Next, I found out that debug_assert(is_allocated()) is called from
> > > free_blocks_int as well. I commented out blindly all
> > > debug_assert(is_allocated()) and performance became similar to
> > > stupid/filestore.
> > > I didn't bother to look into is_allocated() anymore as my guess is
> > > we can safely ignore this during mkfs() time ?
> > > But, it will be good if we can optimize this as it may induce
> > > latency in the IO path (?).
> > >
> > > Thanks & Regards
> > > Somnath
> > >
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@newdream.net]
> > > Sent: Thursday, August 11, 2016 2:20 PM
> > > To: Allen Samuels
> > > Cc: Ramesh Chander; Somnath Roy; ceph-devel
> > > Subject: RE: Bluestore different allocator performance Vs FileStore
> > >
> > > On Thu, 11 Aug 2016, Allen Samuels wrote:
> > > > > -----Original Message-----
> > > > > From: Sage Weil [mailto:sage@newdream.net]
> > > > > Sent: Thursday, August 11, 2016 1:24 PM
> > > > > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > > > Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>; Somnath Roy
> > > > > <Somnath.Roy@sandisk.com>; ceph-devel <ceph-
> > > devel@vger.kernel.org>
> > > > > Subject: RE: Bluestore different allocator performance Vs
> > > > > FileStore
> > > > >
> > > > > On Thu, 11 Aug 2016, Allen Samuels wrote:
> > > > > > Perhaps my understanding of the blueFS is incorrect -- so
> > > > > > please clarify as needed.
> > > > > >
> > > > > > I thought that the authoritative indication of space used by
> > > > > > BlueFS was contained in the snapshot/journal of BlueFS itself,
> > > > > > NOT in the KV store itself. This requires that upon startup,
> > > > > > we replay the BlueFS snapshot/journal into the FreeListManager
> > > > > > so that it properly records the consumption of BlueFS space
> > > > > > (since that allocation MAY NOT be accurate within the
> > > > > > FreeListmanager
> > itself).
> > > > > > But that this playback need not generate an KVStore operations
> > > > > > (since those are duplicates of the BlueFS).
> > > > > >
> > > > > > So in the code you cite:
> > > > > >
> > > > > > fm->allocate(0, reserved, t);
> > > > > >
> > > > > > There's no need to commit 't', and in fact, in the general
> > > > > > case, you don't want to commit 't'.
> > > > > >
> > > > > > That suggests to me that a version of allocate that doesn't
> > > > > > have a transaction could be easily created would have the
> > > > > > speed we're looking for (and independence from the
> > > > > > BitMapAllocator to KVStore
> > > chunking).
> > > > >
> > > > > Oh, I see.  Yeah, you're right--this step isn't really
> > > > > necessary, as long as we ensure that the auxilliary
> > > > > representation of what bluefs owns (bluefs_extents in the
> > > > > superblock) is still passed into the Allocator during
> > > > > initialization.  Having the freelist reflect the allocator that
> > > > > this space was "in use" (by bluefs) and thus off limits to bluestore is
> simple but not strictly necessary.
> > > > >
> > > > > I'll work on a PR that avoids this...
> > >
> > > https://github.com/ceph/ceph/pull/10698
> > >
> > > Ramesh, can you give it a try?
> > >
> > > > > > I suspect that we also have long startup times because we're
> > > > > > doing the same underlying bitmap operations except they come
> > > > > > from the BlueFS replay code instead of the BlueFS
> > > > > > initialization code, but same problem with likely the same fix.
> > > > >
> > > > > BlueFS doesn't touch the FreelistManager (or explicitly persist
> > > > > the freelist at all)... we initialize the in-memory Allocator
> > > > > state from the metadata in the bluefs log.  I think we should be
> > > > > fine on
> > this end.
> > > >
> > > > Likely that code suffers from the same problem -- a false need to
> > > > update the KV Store (During the playback, BlueFS extents are
> > > > converted to bitmap runs, it's essentially the same lower level
> > > > code as the case we're seeing now, but it instead of being driven
> > > > by an artificial "big run", it'sll be driven from the BlueFS
> > > > Journal replay code). But that's just a guess, I don't have time
> > > > to track down the actual code right
> > > now.
> > >
> > > BlueFS can't touch the freelist (or kv store, ever) since it
> > > ultimately backs the kv store and that would be problematic.  We do
> > > initialize the bluefs Allocator's in-memory state, but that's it.
> > >
> > > The PR above changes the BlueStore::_init_alloc() so that
> > > BlueStore's Allocator state is initialize with both the freelist
> > > state (from kv
> > > store)
> > > *and* the bluefs_extents list (from the bluestore superblock).
> > > (From this Allocator's perspective, all of bluefs's space is
> > > allocated and can't be
> > used.
> > > BlueFS has it's own separate instance to do it's internal
> > > allocations.)
> > >
> > > sage
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
