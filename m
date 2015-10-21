From: Sage Weil <sweil@redhat.com>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 10:30:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510210543110.16833@cobra.newdream.net>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <56268886.7010806@redhat.com> <1445415736.1809.71.camel@redhat.com> <56277468.5000504@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbbJURab (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 13:30:31 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 1029E69
	for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 17:30:31 +0000 (UTC)
In-Reply-To: <56277468.5000504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>
Cc: Orit Wasserman <owasserm@redhat.com>, ceph-devel@vger.kernel.org

On Wed, 21 Oct 2015, Ric Wheeler wrote:
> On 10/21/2015 04:22 AM, Orit Wasserman wrote:
> > On Tue, 2015-10-20 at 14:31 -0400, Ric Wheeler wrote:
> > > On 10/19/2015 03:49 PM, Sage Weil wrote:
> > > > The current design is based on two simple ideas:
> > > > 
> > > >    1) a key/value interface is better way to manage all of our internal
> > > > metadata (object metadata, attrs, layout, collection membership,
> > > > write-ahead logging, overlay data, etc.)
> > > > 
> > > >    2) a file system is well suited for storage object data (as files).
> > > > 
> > > > So far 1 is working out well, but I'm questioning the wisdom of #2.  A
> > > > few
> > > > things:
> > > > 
> > > >    - We currently write the data to the file, fsync, then commit the kv
> > > > transaction.  That's at least 3 IOs: one for the data, one for the fs
> > > > journal, one for the kv txn to commit (at least once my rocksdb changes
> > > > land... the kv commit is currently 2-3).  So two people are managing
> > > > metadata, here: the fs managing the file metadata (with its own
> > > > journal) and the kv backend (with its journal).
> > > If all of the fsync()'s fall into the same backing file system, are you
> > > sure
> > > that each fsync() takes the same time? Depending on the local FS
> > > implementation
> > > of course, but the order of issuing those fsync()'s can effectively make
> > > some of
> > > them no-ops.
> > > 
> > > >    - On read we have to open files by name, which means traversing the
> > > > fs
> > > > namespace.  Newstore tries to keep it as flat and simple as possible,
> > > > but
> > > > at a minimum it is a couple btree lookups.  We'd love to use open by
> > > > handle (which would reduce this to 1 btree traversal), but running
> > > > the daemon as ceph and not root makes that hard...
> > > This seems like a a pretty low hurdle to overcome.
> > > 
> > > >    - ...and file systems insist on updating mtime on writes, even when
> > > > it is
> > > > a overwrite with no allocation changes.  (We don't care about mtime.)
> > > > O_NOCMTIME patches exist but it is hard to get these past the kernel
> > > > brainfreeze.
> > > Are you using O_DIRECT? Seems like there should be some enterprisey
> > > database
> > > tricks that we can use here.
> > > 
> > > >    - XFS is (probably) never going going to give us data checksums,
> > > > which we
> > > > want desperately.
> > > What is the goal of having the file system do the checksums? How strong do
> > > they
> > > need to be and what size are the chunks?
> > > 
> > > If you update this on each IO, this will certainly generate more IO (each
> > > write
> > > will possibly generate at least one other write to update that new
> > > checksum).
> > > 
> > > > But what's the alternative?  My thought is to just bite the bullet and
> > > > consume a raw block device directly.  Write an allocator, hopefully keep
> > > > it pretty simple, and manage it in kv store along with all of our other
> > > > metadata.
> > > The big problem with consuming block devices directly is that you
> > > ultimately end
> > > up recreating most of the features that you had in the file system. Even
> > > enterprise databases like Oracle and DB2 have been migrating away from
> > > running
> > > on raw block devices in favor of file systems over time.  In effect, you
> > > are
> > > looking at making a simple on disk file system which is always easier to
> > > start
> > > than it is to get back to a stable, production ready state.
> > The best performance is still on block device (SAN).
> > File system simplify the operation tasks which worth the performance
> > penalty for a database. I think in a storage system this is not the
> > case.
> > In many cases they can use their own file system that is tailored for
> > the database.
> 
> You will have to trust me on this as the Red Hat person who spoke to pretty
> much all of our key customers about local file systems and storage - customers
> all have migrated over to using normal file systems under Oracle/DB2.
> Typically, they use XFS or ext4.  I don't know of any non-standard file
> systems and only have seen one account running on a raw block store in 8 years
> :)
> 
> If you have a pre-allocated file and write using O_DIRECT, your IO path is
> identical in terms of IO's sent to the device.

...except it's not.  Preallocating the file gives you contiguous space, 
but you still have to mark the extent written (not zero/prealloc).  The 
only way to get an identical IO pattern is to *pre-write* zeros (or 
whatever) to the file... which is hours on modern HDDs.

Ted asked for a way to force prealloc to expose preexisting disk bits a 
couple hears back at LSF and it was shot down for security reasons (and 
rightly so, IMO).

If you're going down this path, you already have a "file system" in user 
space sitting on top of the preallocated file, and you could just as 
easily use the block device directly.

If you're not, then you're writing smaller files (e.g., megabytes), and 
will be paying the price to write to the {xfs,ext4} journal to update 
allocation and inode metadata.  And that's what we're trying to avoid...

> If we are causing additional IO's, then we really need to spend some time
> talking to the local file system gurus about this in detail.  I can help with
> that conversation.

Happy to sync up with Eric or Dave, but I really don't think the fs is 
doing anything wrong here.  It's just not the right fit.

> > This won't be a file system but just an allocator which is a very small
> > part of a file system.
> 
> That is always the intention and then we wake up a few years into the project
> with something that looks and smells like a file system as we slowly bring in
> just one more small thing at a time.

Probably, yes.  But it will be exactly the small things that *we* need.

> > The benefits are not just in reducing the number of IO operations we
> > preform, we are also removing the file system stack overhead that will
> > reduce our latency and make it more predictable.
> > Removing this layer will give use more control and allow us other
> > optimization we cannot do today.
> 
> I strongly disagree here - we can get that optimal number of IO's if we use
> the file system API's developed over the years to support enterprise
> databases.  And we can have that today without having to re-write allocation
> routines and checkers.

It will take years and years to get data crcs and the types of IO hints 
that we want in XFS (if we ever get them--my guess is we won't as it's not 
worth the rearchitecting that is required).  We can be much more agile 
this way.  Yes it's an additional burden, but it's also necessary to get 
the performance we need to be competitive: POSIX does not provide the 
atomicity/consistency that we require, and there is no way to unify our 
transaction commit IOs with the underlying FS journals, or get around the 
fact that the fs is maintaining an independent data structure (inode) for 
our per-object metadata record with yet another intervening data structure 
(directories and dentries) that we have 0 use for.  It's not that the fs 
isn't doing what it does really well, it's that it's doing the wrong 
things for our use case.

> > I think this is more acute when taking SSD (and even faster
> > technologies) into account.
> 
> XFS and ext4 both support DAX, so we can effectively do direct writes to
> persistent memory (no block IO required). Most of the work over the past few
> years in the IO stack has been around driving IOPs at insanely high rates on
> top of the whole stack (file system layer included) and we have really good
> results.

Yes.  But ironically much of that hard work is around maintaining the 
existing functionality of the stack while reducing its overhead.  If you 
avoid a layer of the stack entirely it's a moot issue.  Obviously the 
block layer work will still be important for us, but the fs bits won't 
matter.  And in order to capture any of these benefits the code that is 
driving the IO from userspace also has to be equally efficient anyway, so 
it's not like using a file system here gets you anything for free.

> > > In addition to the technical hurdles, there are also production worries
> > > like how
> > > long will it take for distros to pick up formal support?  How do we test
> > > it
> > > properly?
> > > 
> > This should be userspace only, I don't think we need it in the kernel
> > (will need root access for opening the device).
> > For users that don't have root access we can use one big file and use
> > the same allocator in it. It can be good for testing too.
> > 
> > As someone that already been part of such a
> > move more than once (for example in Exanet) I can say that the
> > performance gain is very impressive and after the change we could
> > remove many workarounds which simplified the code.
> > 
> > As the API should be small the testing effort is reasonable, we do need
> > to test it well as a bug in the allocator has really bad consequences.
> > 
> > We won't be able to match (or exceed) our competitors performance
> > without making this effort ...
> > 
> > Orit
> > 
> 
> I don't agree that we will see a performance win if we use the file system
> properly.  Certainly, you can measure a slow path through a file system and
> then show an improvement with a new, user space block access, but that is not
> a long term path to success.

I've been doing this long enough that I'm pretting confident I'm not 
measuring the slow path.  And yes, there are some things we could do to 
improve the situation, but the complexity required is similar to avoiding 
the fs altogether, and the end result will still be far from optimal.

For example: we need to do an overwrite of an existing object that is 
atomic with respect to a larger ceph transaction (we're updating a bunch 
of other metadata at the same time, possibly overwriting or appending to 
multiple files, etc.).  XFS and ext4 aren't cow file systems, so plugging 
into the transaction infrastructure isn't really an option (and even after 
several years of trying to do it with btrfs it proved to be impractical).  
So: we do write-ahead journaling.  That's okay (even great) for small io 
(the database we're tracking our metadata is log-structured anyway), but 
if the overwrite it large it's pretty inefficient.  Assuming I have a 4MB 
XFS file, how to I do an atomic 1MB overwrite?  Maybe we write to a new 
file, fsync that, and use the defrag ioctl to swap extents.  But then 
we're creating extraneous inodes, forcing additional fsyncs, and relying 
on weakly tested functionality that is much more likely to lead to nasty 
surprises for users (for example, see our use of the xfs extsize ioctl in 
firefly and the resulting data corruption that causes on 3.2 kernels).  
It would be an extremely delicate solution that relies on very 
careful ordering of fs ioctls and syscalls to ensure both data 
safety and performance... and even then it wouldn't be optimal.

If we manage allocation ourselves this problem is trivial: write to an 
unallocated extent, fua/flush, commit transaction.

The allocators in general purpose file systems have to cope with a huge 
spectrum of workloads, and they to admirably well given the challenge.  
Ours will need to cope with a vastly simpler set of constraints.  And most 
importantly will be tied into the same transaction commit mechanism as 
everything else, which means it will not require additional IOs to 
maintain its metadata.  And the metadata we do manage will be exactly the 
metadata we need, and nothing more and nothing less.

sage
