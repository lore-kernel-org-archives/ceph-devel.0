From: Howard Chu <hyc@symas.com>
Subject: Re: newstore direction
Date: Fri, 23 Oct 2015 03:16:12 +0000 (UTC)
Message-ID: <loom.20151023T045140-113@post.gmane.org>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com> <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net> <CANP1eJEZGe6uqdd3i8exT7zX8wWHHRSk-x0H8zn1h9u5pni3+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54537 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbJWDfL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Oct 2015 23:35:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZpT8B-0001ry-Sx
	for ceph-devel@vger.kernel.org; Fri, 23 Oct 2015 05:35:04 +0200
Received: from cust231-14.nwewn.com ([78.155.231.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 05:35:03 +0200
Received: from hyc by cust231-14.nwewn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 05:35:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Milosz Tanski <milosz <at> adfin.com> writes:

> 
> On Tue, Oct 20, 2015 at 4:00 PM, Sage Weil <sweil <at> redhat.com> wrote:
> > On Tue, 20 Oct 2015, John Spray wrote:
> >> On Mon, Oct 19, 2015 at 8:49 PM, Sage Weil <sweil <at> redhat.com> wrote:
> >> >  - We have to size the kv backend storage (probably still an XFS
> >> > partition) vs the block storage.  Maybe we do this anyway (put
metadata on
> >> > SSD!) so it won't matter.  But what happens when we are storing gobs of
> >> > rgw index data or cephfs metadata?  Suddenly we are pulling storage
out of
> >> > a different pool and those aren't currently fungible.
> >>
> >> This is the concerning bit for me -- the other parts one "just" has to
> >> get the code right, but this problem could linger and be something we
> >> have to keep explaining to users indefinitely.  It reminds me of cases
> >> in other systems where users had to make an educated guess about inode
> >> size up front, depending on whether you're expecting to efficiently
> >> store a lot of xattrs.
> >>
> >> In practice it's rare for users to make these kinds of decisions well
> >> up-front: it really needs to be adjustable later, ideally
> >> automatically.  That could be pretty straightforward if the KV part
> >> was stored directly on block storage, instead of having XFS in the
> >> mix.  I'm not quite up with the state of the art in this area: are
> >> there any reasonable alternatives for the KV part that would consume
> >> some defined range of a block device from userspace, instead of
> >> sitting on top of a filesystem?
> >
> > I agree: this is my primary concern with the raw block approach.
> >
> > There are some KV alternatives that could consume block, but the problem
> > would be similar: we need to dynamically size up or down the kv portion of
> > the device.
> >
> > I see two basic options:
> >
> > 1) Wire into the Env abstraction in rocksdb to provide something just
> > smart enough to let rocksdb work.  It isn't much: named files (not that
> > many--we could easily keep the file table in ram), always written
> > sequentially, to be read later with random access. All of the code is
> > written around abstractions of SequentialFileWriter so that everything
> > posix is neatly hidden in env_posix (and there are various other env
> > implementations for in-memory mock tests etc.).
> >
> > 2) Use something like dm-thin to sit between the raw block device and XFS
> > (for rocksdb) and the block device consumed by newstore.  As long as XFS
> > doesn't fragment horrifically (it shouldn't, given we *always* write ~4mb
> > files in their entirety) we can fstrim and size down the fs portion.  If
> > we similarly make newstores allocator stick to large blocks only we would
> > be able to size down the block portion as well.  Typical dm-thin block
> > sizes seem to range from 64KB to 512KB, which seems reasonable enough to
> > me.  In fact, we could likely just size the fs volume at something
> > conservatively large (like 90%) and rely on -o discard or periodic fstrim
> > to keep its actual utilization in check.
> >
> 
> I think you could prototype a raw block device OSD store using LMDB as
> a starting point. I know there's been some experiments using LMDB as
> KV store before with positive read numbers and not great write
> numbers.
> 
> 1. It mmaps, just mmap the raw disk device / partition. I've done this
> as an experiment before, I can dig up a patch for LMDB.
> 2. It already has a free space management strategy. I'm prob it's not
> right for the OSDs in the long term but there's something to start
> there with.
> 3. It's already supports transactions / COW.
> 4. LMDB isn't a huge code base so it might be a good place to start /
> evolve code from.
> 5. You're not starting a multi-year effort at the 0 point.
> 
> As to the not great write performance, that could be addressed by
> write transaction merging (what mysql implemented a few years ago).

We have a heavily hacked version of LMDB contributed by VMware that
implements a WAL. In my preliminary testing it performs synchronous writes
30x faster (on average) than current LMDB. Their version unfortunately
slashed'n'burned a lot of LMDB features that other folks actually need, so
we can't use it as-is. Currently working on rationalizing the approach and
merging it into mdb.master.

The reasons for the WAL approach:
  1) obviously sequential writes are cheaper than random writes.
  2) fsync() of a small log file will always be faster than fsync() of a
large DB. I.e., fsync() latency is proportional to the total number of pages
in the file, not just the number of dirty pages.

LMDB on a raw block device is a simpler proposition, and one we intend to
integrate soon as well. (Milosz, did you ever submit your changes?)

> Here you have an opportunity to do it two days. One, you can do it in
> the application layer while waiting for the fsync from transaction to
> complete. This is probably the easier route. Two, you can do it in the
> DB layer (the LMDB transaction handling / locking) where you're
> already started processing the following transactions using the
> currently committing transaction (COW) as a starting point. This is
> harder mostly because of the synchronization needed or involved.
> 
> I've actually spend some time thinking about doing LMDB write
> transaction merging outside the OSD context. This was for another
> project.
> 
> My 2 cents.

For my 2 cents, a number of approaches have been mentioned on this thread
that I think are worth touching on:

First of all LevelDB-style LSMs are an inherently poor design choice -
requiring multiple files to be opened/closed during routine operation is
inherently fragile. Inside a service that is also opening/closing many
network sockets, if you hit your filedescriptor limit in the middle of a DB
op you lose the DB. If you get a system crash in the middle of a sequence of
open/close/rename/delete ops you lose the DB. Etc. etc. (LevelDB
unreliability is already well researched and well proven, I'm not saying
anything new here
https://www.usenix.org/conference/osdi14/technical-sessions/presentation/pillai
)

User-level pagecache management - also an inherently poor design choice.
  1) The kernel has hardware-assist - it will always be more efficient than
any user-level code.
  2) The kernel knows about the entire system state - user level can only
easily know about a single process' resource usage. If your process is
sharing with any other services on the machine your performance will be
sub-optimal.
  3) In this day of virtual machines/cloud processing with
hardware-accelerated VMs, kernel-managed paging passes thru straight to the
hypervisor, so it is always efficient. User-level paging might know about
the current guest machine image's resource consumption, but won't know about
the actual state of the world in the hypervisor or host machine. It will be
prone to (and exacerbate) thrashing in ways that kernel-managed paging won't.

User-level pagecache management only works when your application is the only
thing running on the box. (In that case, it can certainly work very well.)
That's not the reality for most of today's computing landscape, nor the
foreseeable future.

-- 
  -- Howard Chu
  CTO, Symas Corp.           http://www.symas.com
  Director, Highland Sun     http://highlandsun.com/hyc/
  Chief Architect, OpenLDAP  http://www.openldap.org/project/ 

