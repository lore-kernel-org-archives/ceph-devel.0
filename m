From: Sage Weil <sage@newdream.net>
Subject: RE: Bluestore different allocator performance Vs FileStore
Date: Fri, 12 Aug 2016 15:26:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608121521010.29701@piezo.us.to>
References: <BL2PR02MB211554DBEC8F344E465BAFE5F41D0@BL2PR02MB2115.namprd02.prod.outlook.com> <1431B127-59B3-4DCA-B3F2-FBB209ED2059@sandisk.com> <CY1PR0201MB1820F3561F0F89AFAF8A24AE851E0@CY1PR0201MB1820.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608111636360.17762@piezo.us.to>
 <BLUPR0201MB1524345DD4A25895939CE7B6E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608111710400.17762@piezo.us.to> <BLUPR0201MB1524F46599D0A90A7025F373E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608111929250.17770@piezo.us.to>
 <BLUPR0201MB15248F97217C67BA0051F131E81E0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608112000200.17762@piezo.us.to> <BLUPR0201MB15249FEF89ED408BDCC5808BE81E0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608112018400.17762@piezo.us.to>
 <BLUPR0201MB1524A947959FE39B1D2A5E4EE81E0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608112115250.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59514 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbcHLP0T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 11:26:19 -0400
In-Reply-To: <alpine.DEB.2.11.1608112115250.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 11 Aug 2016, Sage Weil wrote:
> On Thu, 11 Aug 2016, Allen Samuels wrote:
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@newdream.net]
> > > Sent: Thursday, August 11, 2016 1:24 PM
> > > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>; Somnath Roy
> > > <Somnath.Roy@sandisk.com>; ceph-devel <ceph-devel@vger.kernel.org>
> > > Subject: RE: Bluestore different allocator performance Vs FileStore
> > > 
> > > On Thu, 11 Aug 2016, Allen Samuels wrote:
> > > > Perhaps my understanding of the blueFS is incorrect -- so please
> > > > clarify as needed.
> > > >
> > > > I thought that the authoritative indication of space used by BlueFS
> > > > was contained in the snapshot/journal of BlueFS itself, NOT in the KV
> > > > store itself. This requires that upon startup, we replay the BlueFS
> > > > snapshot/journal into the FreeListManager so that it properly records
> > > > the consumption of BlueFS space (since that allocation MAY NOT be
> > > > accurate within the FreeListmanager itself). But that this playback
> > > > need not generate an KVStore operations (since those are duplicates of
> > > > the BlueFS).
> > > >
> > > > So in the code you cite:
> > > >
> > > > fm->allocate(0, reserved, t);
> > > >
> > > > There's no need to commit 't', and in fact, in the general case, you
> > > > don't want to commit 't'.
> > > >
> > > > That suggests to me that a version of allocate that doesn't have a
> > > > transaction could be easily created would have the speed we're looking
> > > > for (and independence from the BitMapAllocator to KVStore chunking).
> > > 
> > > Oh, I see.  Yeah, you're right--this step isn't really necessary, as long as we
> > > ensure that the auxilliary representation of what bluefs owns
> > > (bluefs_extents in the superblock) is still passed into the Allocator during
> > > initialization.  Having the freelist reflect the allocator that this space was "in
> > > use" (by bluefs) and thus off limits to bluestore is simple but not strictly
> > > necessary.
> > > 
> > > I'll work on a PR that avoids this...
> 
> https://github.com/ceph/ceph/pull/10698
> 
> Ramesh, can you give it a try?
> 
> > > > I suspect that we also have long startup times because we're doing the
> > > > same underlying bitmap operations except they come from the BlueFS
> > > > replay code instead of the BlueFS initialization code, but same
> > > > problem with likely the same fix.
> > > 
> > > BlueFS doesn't touch the FreelistManager (or explicitly persist the freelist at
> > > all)... we initialize the in-memory Allocator state from the metadata in the
> > > bluefs log.  I think we should be fine on this end.
> > 
> > Likely that code suffers from the same problem -- a false need to update 
> > the KV Store (During the playback, BlueFS extents are converted to 
> > bitmap runs, it's essentially the same lower level code as the case 
> > we're seeing now, but it instead of being driven by an artificial "big 
> > run", it'sll be driven from the BlueFS Journal replay code). But that's 
> > just a guess, I don't have time to track down the actual code right now.
> 
> BlueFS can't touch the freelist (or kv store, ever) since it ultimately 
> backs the kv store and that would be problematic.  We do initialize the 
> bluefs Allocator's in-memory state, but that's it.
> 
> The PR above changes the BlueStore::_init_alloc() so that BlueStore's 
> Allocator state is initialize with both the freelist state (from kv store) 
> *and* the bluefs_extents list (from the bluestore superblock).  (From this 
> Allocator's perspective, all of bluefs's space is allocated and can't be 
> used.  BlueFS has it's own separate instance to do it's internal 
> allocations.)

Ah, okay, so after our conversation in standup I went and looked at the 
code some more and realized I've been thinking about the 
BitmapFreelistManager and not the BitMapAllocator.  The ~40s is all CPU 
time spent updating in-memory bits, and has nothing to do with pushing 
updates through rocksdb.  Sorry for the confusing conversation.

So... I think there is one thing we can do: change the initialization of 
the allocator state from the freelist so that the assumption is that space 
is freed and we tell it was is allocation (currently we assume everything 
is allocated and tell it what is free).  I'm not sure it's worth it, 
though: we'll just make things slower to start up on a full OSD instead of 
slower on an empty OSD.  And it seems like the CPU time really won't be 
significant anyway once the debugging stuff is taken out.

I think this PR

	https://github.com/ceph/ceph/pull/10698

is still a good idea, though, since it avoids useless freelist kv work 
during mkfs.

Does that sound right?  Or am I still missing something?

Thanks for you patience!
sage


