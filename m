From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 09:50:19 -0400
Message-ID: <5627981B.2040409@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
 <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
 <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
 <alpine.DEB.2.00.1510201422450.16833@cobra.newdream.net>
 <5626BECA.7070306@redhat.com>
 <alpine.DEB.2.00.1510210616060.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbbJUNuX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 09:50:23 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 131BC8EA2C
	for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 13:50:23 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1510210616060.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 10/21/2015 09:32 AM, Sage Weil wrote:
> On Tue, 20 Oct 2015, Ric Wheeler wrote:
>>> Now:
>>>       1 io  to write a new file
>>>     1-2 ios to sync the fs journal (commit the inode, alloc change)
>>>             (I see 2 journal IOs on XFS and only 1 on ext4...)
>>>       1 io  to commit the rocksdb journal (currently 3, but will drop to
>>>             1 with xfs fix and my rocksdb change)
>> I think that might be too pessimistic - the number of discrete IO's sent down
>> to a spinning disk make much less impact on performance than the number of
>> fsync()'s since they IO's all land in the write cache.  Some newer spinning
>> drives have a non-volatile write cache, so even an fsync() might not end up
>> doing the expensive data transfer to the platter.
> True, but in XFS's case at least the file data and journal are not
> colocated, so its 2 seeks for the new file write+fdatasync and another for
> the rocksdb journal commit.  Of course, with a deep queue, we're doing
> lots of these so there's be fewer journal commits on both counts, but the
> lower bound on latency of a single write is still 3 seeks, and that bound
> is pretty critical when you also have network round trips and replication
> (worst out of 2) on top.

What are the performance goals we are looking for?

Small, synchronous writes/second?

File creates/second?

I suspect that looking at things like seeks/write is probably looking at the 
wrong level of performance challenges.  Again, when you write to a modern drive, 
you write to its write cache and it decides internally when/how to destage to 
the platter.

If you look at the performance of XFS with streaming workloads, it will tend to 
max out the bandwidth of the underlaying storage.

If we need IOP's/file writes, etc, we should be clear on what we are aiming at.

>
>> It would be interesting to get the timings on the IO's you see to measure the
>> actual impact.
> I observed this with the journaling workload for rocksdb, but I assume the
> journaling behavior is the same regardless of what is being journaled.
> For a 4KB append to a file + fdatasync, I saw ~30ms latency for XFS, and
> blktrace showed an IO to the file, and 2 IOs to the journal.  I believe
> the first one is the record for the inode update, and the second is the
> journal 'commit' record (though I forget how I decided that).  My guess is
> that XFS is being extremely careful about journal integrity here and not
> writing the commit record until it knows that the preceding records landed
> on stable storage.  For ext4, the latency was about ~20ms, and blktrace
> showed the IO to the file and then a single journal IO.  When I made the
> rocksdb change to overwrite an existing, prewritten file, the latency
> dropped to ~10ms on ext4, and blktrace showed a single IO as expected.
> (XFS still showed the 2 journal commit IOs, but Dave just posted the fix
> for that on the XFS list today.)

Right, if we want to avoid metadata related IO's, we can preallocate a file and 
use O_DIRECT. Effectively, there should be no updates outside of the data write 
itself.  Also won't be performance optimizations, but we could avoid redoing 
allocation and defragmentation again.

Normally, best practice is to use batching to avoid paying worst case latency 
when you do a synchronous IO. Write a batch of files or appends without fsync, 
then go back and fsync and you will pay that latency once (not per file/op).

>
>> Plumbing for T10 DIF/DIX already exist, what is missing is the normal block
>> device that handles them (not enterprise SAS/disk array class)
> Yeah... which unfortunately means that unless the cheap drives
> suddenly start shipping if DIF/DIX support we'll need to do the
> checksums ourselves.  This is probably a good thing anyway as it doesn't
> constrain our choice of checksum or checksum granularity, and will
> still work with other storage devices (ssds, nvme, etc.).
>
> sage

Might be interesting to see if a device mapper target could be written to 
support DIF/DIX.  For what it's worth, XFS developers have talked loosely about 
looking at data block checksums (could do something like btrfs does, store the 
checksums in another btree)

ric

