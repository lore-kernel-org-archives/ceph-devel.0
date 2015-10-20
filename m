From: Sage Weil <sweil@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 14:47:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510201422450.16833@cobra.newdream.net>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com> <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
 <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48870 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbbJTVrq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Oct 2015 17:47:46 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 6FF40A58A5
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2015 21:47:46 +0000 (UTC)
In-Reply-To: <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 20 Oct 2015, Gregory Farnum wrote:
> On Tue, Oct 20, 2015 at 12:44 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Tue, 20 Oct 2015, Ric Wheeler wrote:
> >> The big problem with consuming block devices directly is that you ultimately
> >> end up recreating most of the features that you had in the file system. Even
> >> enterprise databases like Oracle and DB2 have been migrating away from running
> >> on raw block devices in favor of file systems over time.  In effect, you are
> >> looking at making a simple on disk file system which is always easier to start
> >> than it is to get back to a stable, production ready state.
> >
> > This was why we abandoned ebofs ~4 years ago... btrfs had arrived and had
> > everything we were implementing and more: mainly, copy on write and data
> > checksums.  But in practice the fact that its general purpose means it
> > targets a very different workloads and APIs than what we need.
> 
> Try 7 years since ebofs...

Sigh...

> That's one of my concerns, though. You ditched ebofs once already
> because it had metastasized into an entire FS, and had reached its
> limits of maintainability. What makes you think a second time through
> would work better? :/

A fair point, and I've given this some thought:

1) We know a *lot* more about our workload than I did in 2005.  The things 
I was worrying about then (fragmentation, mainly) are much easier to 
address now, where we have hints from rados and understand what the write 
patterns look like in practice (randomish 4k-128k ios for rbd, sequential 
writes for rgw, and the cephfs wildcard).

2) Most of the ebofs effort was around doing copy-on-write btrees (with 
checksums) and orchestrating commits.  Here our job is *vastly* simplified 
by assuming the existence of a transactional key/value store.  If you look 
at newstore today, we're already half-way through dealing with the 
complexity of doing allocations... we're essentially "allocating" blocks 
that are 1 MB files on XFS, managing that metadata, and overwriting or 
replacing those blocks on write/truncate/clone.  By the time we add in an 
allocator (get_blocks(len), free_block(offset, len)) and rip out all the 
file handling fiddling (like fsync workqueues, file id allocator, 
file truncation fiddling, etc.) we'll probably have something working 
with about the same amount of code we have now.  (Of course, that'll 
grow as we get more sophisticated, but that'll happen either way.)

> On Mon, Oct 19, 2015 at 12:49 PM, Sage Weil <sweil@redhat.com> wrote:
> >  - 2 IOs for most: one to write the data to unused space in the block
> > device, one to commit our transaction (vs 4+ before).  For overwrites,
> > we'd have one io to do our write-ahead log (kv journal), then do
> > the overwrite async (vs 4+ before).
> 
> I can't work this one out. If you're doing one write for the data and
> one for the kv journal (which is on another filesystem), how does the
> commit sequence work that it's only 2 IOs instead of the same 3 we
> already have? Or are you planning to ditch the LevelDB/RocksDB store
> for our journaling and just use something within the block layer?

Now:
    1 io  to write a new file
  1-2 ios to sync the fs journal (commit the inode, alloc change) 
          (I see 2 journal IOs on XFS and only 1 on ext4...)
    1 io  to commit the rocksdb journal (currently 3, but will drop to 
          1 with xfs fix and my rocksdb change)

With block:
    1 io to write to block device
    1 io to commit to rocksdb journal

> If we do want to go down this road, we shouldn't need to write an
> allocator from scratch. I don't remember exactly which ones it is but
> we've read/seen at least a few storage papers where people have reused
> existing allocators  ? I think the one from ext2? And somebody managed
> to get it running in userspace.

Maybe, but the real win is when we combine the allocator state update with 
our kv transaction.  Even if we adopt an existing algorithm we'll need to 
do some significant rejiggering to persist it in the kv store.

My thought is start with something simple that works (e.g., linear sweep 
over free space, simple interval_set<>-style freelist) and once it works 
look at existing state of the art for a clever v2.

BTW, I suspect a modest win here would be to simply use the collection/pg 
as a hint for storing related objects.  That's the best indicator we have 
for aligned lifecycle (think PG migrations/deletions vs flash erase 
blocks).  Good luck plumbing that through XFS...

> Of course, then we also need to figure out how to get checksums on the
> block data, since if we're going to put in the effort to reimplement
> this much of the stack we'd better get our full data integrity
> guarantees along with it!

YES!

Here I think we should make judicious use of the rados hints.  For 
example, rgw always writes complete objects, so we can have coarse 
granularity crcs and only pay for very small reads (that have to make 
slightly larger reads for crc verification).  On RBD... we might opt to be 
opportunistic with the write pattern (if the write was 4k, store the crc 
at small granularity), otherwise use a larger one.  Maybe.  In any case, 
we have a lot more flexibility than we would if trying to plumb this 
through the VFS and a file system.

> > I see two basic options:
> >
> > 1) Wire into the Env abstraction in rocksdb to provide something just
> > smart enough to let rocksdb work.  It isn't much: named files (not that
> > many--we could easily keep the file table in ram), always written
> > sequentially, to be read later with random access. All of the code is
> > written around abstractions of SequentialFileWriter so that everything
> > posix is neatly hidden in env_posix (and there are various other env
> > implementations for in-memory mock tests etc.).
> 
> This seems like the obviously correct move to me? Except we might want
> to include the rocksdb store on flash instead of hard drives, which
> means maybe we do want some unified storage system which can handle
> multiple physical storage devices as a single piece of storage space.
> (Not that any of those exist in "almost done" hell, or that we're
> going through requirements expansion or anything!)

Yeah, I mostly agree.  It's just more work.  And rocks, for example, 
already has some provisions for managing different storage pools: one for 
wal, one for main ssts, one for cold ssts.  And the same Env is used for 
all three, which means we'd run our toy fs backend even for the flash 
portion.  (Which, if it works, is probably good anyway for performance and 
operational simplicity.  One less thing in the stack to break.)

It also ties us to rocksdb, and/or whatever other backends we specifically 
support.  Right now you can trivially swap in leveldb and everything works 
the same.  OTOH there is an alternative btree-based kv store I'm 
considering about that does much better on flash and consumes block 
directly.  Making it share a device with newstore will be interesting.  
So regardless we'll probably have a pretty short list of kv backends that 
we care about...

sage
