From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 17:43:00 -0400
Message-ID: <5626B564.5050307@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com>
 <alpine.DEB.2.00.1510201215470.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbbJTVnD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Oct 2015 17:43:03 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 9246BA442E
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2015 21:43:03 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1510201215470.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 10/20/2015 03:44 PM, Sage Weil wrote:
> On Tue, 20 Oct 2015, Ric Wheeler wrote:
>> On 10/19/2015 03:49 PM, Sage Weil wrote:
>>> The current design is based on two simple ideas:
>>>
>>>    1) a key/value interface is better way to manage all of our internal
>>> metadata (object metadata, attrs, layout, collection membership,
>>> write-ahead logging, overlay data, etc.)
>>>
>>>    2) a file system is well suited for storage object data (as files).
>>>
>>> So far 1 is working out well, but I'm questioning the wisdom of #2.  A few
>>> things:
>>>
>>>    - We currently write the data to the file, fsync, then commit the kv
>>> transaction.  That's at least 3 IOs: one for the data, one for the fs
>>> journal, one for the kv txn to commit (at least once my rocksdb changes
>>> land... the kv commit is currently 2-3).  So two people are managing
>>> metadata, here: the fs managing the file metadata (with its own
>>> journal) and the kv backend (with its journal).
>> If all of the fsync()'s fall into the same backing file system, are you sure
>> that each fsync() takes the same time? Depending on the local FS
>> implementation of course, but the order of issuing those fsync()'s can
>> effectively make some of them no-ops.
> Surely, yes, but the fact remains we are maintaining two journals: one
> internal to the fs that manages the allocation metadata, and one layered
> on top that handles the kv store's write stream.  The lower bound on any
> write is 3 IOs (unless we're talking about a COW fs).

The way storage devices work means that if we can batch these in some way, we 
might get 3 IO's that land in the cache (even for spinning drives) and one 1 
that is followed by a cache flush.

The first three IO's are quite quick, you don't need to write through to the 
platter. The cost is mostly in the fsync() call which waits until storage 
destages the cache to the platter.

With SSD's, we have some different considerations.

>
>>>    - On read we have to open files by name, which means traversing the fs
>>> namespace.  Newstore tries to keep it as flat and simple as possible, but
>>> at a minimum it is a couple btree lookups.  We'd love to use open by
>>> handle (which would reduce this to 1 btree traversal), but running
>>> the daemon as ceph and not root makes that hard...
>> This seems like a a pretty low hurdle to overcome.
> I wish you luck convincing upstream to allow unprivileged access to
> open_by_handle or the XFS ioctl.  :)  But even if we had that, any object
> access requires multiple metadata lookups: one in our kv db, and a second
> to get the inode for the backing file.  Again, there's an unnecessary
> lower bound on the number of IOs needed to access a cold object.

We should dig into what this actually means when you can do open by handle. If 
you cache the inode (i.e., skip the directory traversal), you still need to 
figure out the mapping back to an actual block on the storage device. Not clear 
to me that you need more IO's with the file system doing this or by having a 
btree on disk - both will require IO.

>
>>>    - ...and file systems insist on updating mtime on writes, even when it is
>>> a overwrite with no allocation changes.  (We don't care about mtime.)
>>> O_NOCMTIME patches exist but it is hard to get these past the kernel
>>> brainfreeze.
>> Are you using O_DIRECT? Seems like there should be some enterprisey database
>> tricks that we can use here.
> It's not about about the data path, but avoiding the useless bookkeeping
> the file system is doing that we don't want or need.  See the recent
> recent reception of Zach's O_NOCMTIME patches on linux-fsdevel:
>
> 	http://marc.info/?t=143094969800001&r=1&w=2
>
> I'm generally an optimist when it comes to introducing new APIs upstream,
> but I still found this to be an unbelievingly frustrating exchange.

We should talk more about this with the local FS people. Might be other ways to 
solve this.

>
>>>    - XFS is (probably) never going going to give us data checksums, which we
>>> want desperately.
>> What is the goal of having the file system do the checksums? How strong do
>> they need to be and what size are the chunks?
>>
>> If you update this on each IO, this will certainly generate more IO (each
>> write will possibly generate at least one other write to update that new
>> checksum).
> Not if we keep the checksums with the allocation metadata, in the
> onode/inode, which we're also doing and IO to persist.  But whther that is
> practial depends on the granularity (4KB or 16K or 128K or ...), which may
> in turn depend on the object (RBD block that'll service random 4K reads
> and writes?  or RGW fragment that is always written sequentially?).  I'm
> highly skeptical we'd ever get anything from a general-purpose file system
> that would work well here (if anything at all).

XFS (or device mapper) could also store checksums per block. I think that the 
T10 DIF/DIX bits work for enterprise databases (again, bypassing the file 
system). Might be interesting to see if we could put the checksums into dm-thin.

>
>>> But what's the alternative?  My thought is to just bite the bullet and
>>> consume a raw block device directly.  Write an allocator, hopefully keep
>>> it pretty simple, and manage it in kv store along with all of our other
>>> metadata.
>> The big problem with consuming block devices directly is that you ultimately
>> end up recreating most of the features that you had in the file system. Even
>> enterprise databases like Oracle and DB2 have been migrating away from running
>> on raw block devices in favor of file systems over time.  In effect, you are
>> looking at making a simple on disk file system which is always easier to start
>> than it is to get back to a stable, production ready state.
> This was why we abandoned ebofs ~4 years ago... btrfs had arrived and had
> everything we were implementing and more: mainly, copy on write and data
> checksums.  But in practice the fact that its general purpose means it
> targets a very different workloads and APIs than what we need.
>
> Now that I've realized the POSIX file namespace is a bad fit for what we
> need and opted to manage that directly, things are vastly simpler: we no
> longer have the horrific directory hashing tricks to allow PG splits (not
> because we are scared of big directories but because we need ordered
> enumeration of objects) and the transactions have exactly the granularity
> we want.  In fact, it turns out that pretty much the *only* thing the file
> system provides that we need is block allocation; everything else is
> overhead we have to play tricks to work around (batched fsync, O_NOCMTIME,
> open by handle), or something that we want but the fs will likely never
> provide (like checksums).

Database people have figured this all out on top of file systems a long time 
ago, I think that we are looking at solving a solved problem here.

>
>> I think that it might be quicker and more maintainable to spend some time
>> working with the local file system people (XFS or other) to see if we can
>> jointly address the concerns you have.
> I have been, in cases where what we want is something that makes sense for
> other file system users.  But mostly I think that the problem is more
> that what we want isn't a file system, but an allocator + block device.

(Broken record) the local fs community deal with enterprise database needs 
already and they are special cases.

>
> And the end result is that slotting a file system into the stack puts an
> upper bound on our performance.  On its face this isn't surprising, but
> I'm running up against it in gory detail in my efforts to make the Ceph
> OSD faster, and the question becomes whether we want to be fast or
> layered.  (I don't think 'simple' is really an option given the effort to
> work around the POSIX vs ObjectStore impedence mismatch.)

The goal of file systems is to make the underlying storage device the bound on 
performance for IO operations. True, you pay something for metadata updates, but 
you would end up doing that in any case.

That should not be a big deal for ceph I think.

>
>> I really hate the idea of making a new file system type (even if we call it a
>> raw block store!).
> Just to be clear, this isn't a new kernel file system--it's userland
> consuming a block device (ala oracle).  (But yeah, I hate it too.)

Once you need a new file system check like utility, you *are* a file system :)  
(dm-thin has one, it is in effect a file system as well).

>
>> In addition to the technical hurdles, there are also production worries like
>> how long will it take for distros to pick up formal support?  How do we test
>> it properly?
> This actually means less for the distros to support: we'll consume
> /dev/sdb instead of an XFS mount.  Testing will be the same as before...
> the usual forced-kill and power cycle testing under the stress and
> correctness testing workloads.
>
> What we (Ceph) will support in its place will be a combination of a kv
> store (which we already need) and a block allocator.
>
>

You need to convince each distro to enable any kernel module that you need if 
you are a kernel driver. If it stays in user space, you need to get access from 
a non-root process to a block device.

Ric

