From: Howard Chu <hyc@symas.com>
Subject: Re: newstore direction
Date: Fri, 23 Oct 2015 06:21:43 +0000 (UTC)
Message-ID: <loom.20151023T081245-920@post.gmane.org>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com> <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net> <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com> <alpine.DEB.2.00.1510201422450.16833@cobra.newdream.net> <5626BECA.7070306@redhat.com> <alpine.DEB.2.00.1510210616060.16833@cobra.newdream.net> <5627981B.2040409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59792 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbbJWGWB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 23 Oct 2015 02:22:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZpVjh-0000jT-6W
	for ceph-devel@vger.kernel.org; Fri, 23 Oct 2015 08:21:57 +0200
Received: from cust231-14.nwewn.com ([78.155.231.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 08:21:57 +0200
Received: from hyc by cust231-14.nwewn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 08:21:57 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ric Wheeler <rwheeler <at> redhat.com> writes:

> 
> On 10/21/2015 09:32 AM, Sage Weil wrote:
> > On Tue, 20 Oct 2015, Ric Wheeler wrote:
> >>> Now:
> >>>       1 io  to write a new file
> >>>     1-2 ios to sync the fs journal (commit the inode, alloc change)
> >>>             (I see 2 journal IOs on XFS and only 1 on ext4...)
> >>>       1 io  to commit the rocksdb journal (currently 3, but will drop to
> >>>             1 with xfs fix and my rocksdb change)
> >> I think that might be too pessimistic - the number of discrete IO's
sent down
> >> to a spinning disk make much less impact on performance than the number of
> >> fsync()'s since they IO's all land in the write cache.  Some newer spinning
> >> drives have a non-volatile write cache, so even an fsync() might not end up
> >> doing the expensive data transfer to the platter.
> > True, but in XFS's case at least the file data and journal are not
> > colocated, so its 2 seeks for the new file write+fdatasync and another for
> > the rocksdb journal commit.  Of course, with a deep queue, we're doing
> > lots of these so there's be fewer journal commits on both counts, but the
> > lower bound on latency of a single write is still 3 seeks, and that bound
> > is pretty critical when you also have network round trips and replication
> > (worst out of 2) on top.
> 
> What are the performance goals we are looking for?
> 
> Small, synchronous writes/second?
> 
> File creates/second?
> 
> I suspect that looking at things like seeks/write is probably looking at the 
> wrong level of performance challenges.  Again, when you write to a modern
drive, 
> you write to its write cache and it decides internally when/how to destage to 
> the platter.
> 
> If you look at the performance of XFS with streaming workloads, it will
tend to 
> max out the bandwidth of the underlaying storage.
> 
> If we need IOP's/file writes, etc, we should be clear on what we are
aiming at.
> 
> >
> >> It would be interesting to get the timings on the IO's you see to
measure the
> >> actual impact.
> > I observed this with the journaling workload for rocksdb, but I assume the
> > journaling behavior is the same regardless of what is being journaled.
> > For a 4KB append to a file + fdatasync, I saw ~30ms latency for XFS, and
> > blktrace showed an IO to the file, and 2 IOs to the journal.  I believe
> > the first one is the record for the inode update, and the second is the
> > journal 'commit' record (though I forget how I decided that).  My guess is
> > that XFS is being extremely careful about journal integrity here and not
> > writing the commit record until it knows that the preceding records landed
> > on stable storage.  For ext4, the latency was about ~20ms, and blktrace
> > showed the IO to the file and then a single journal IO.  When I made the
> > rocksdb change to overwrite an existing, prewritten file, the latency
> > dropped to ~10ms on ext4, and blktrace showed a single IO as expected.
> > (XFS still showed the 2 journal commit IOs, but Dave just posted the fix
> > for that on the XFS list today.)

> Normally, best practice is to use batching to avoid paying worst case latency 
> when you do a synchronous IO. Write a batch of files or appends without
fsync, 
> then go back and fsync and you will pay that latency once (not per file/op).

If filesystems would support ordered writes you wouldn't need to fsync at
all. Just spit out a stream of writes and declare that batch N must be
written before batch N+1. (Note that this is not identical to "write
barriers", which imposed the same latencies as fsync by blocking all I/Os at
a barrier boundary. Ordered writes may be freely interleaved with un-ordered
writes, so normal I/O traffic can proceed unhindered. Their ordering is only
enforced wrt other ordered writes.)

A bit of a shame that Linux's SCSI drivers support Ordering attributes but
nothing above that layer makes use of it.
-- 
  -- Howard Chu
  CTO, Symas Corp.           http://www.symas.com
  Director, Highland Sun     http://highlandsun.com/hyc/
  Chief Architect, OpenLDAP  http://www.openldap.org/project/ 

