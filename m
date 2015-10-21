From: Sage Weil <sweil@redhat.com>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 06:32:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510210616060.16833@cobra.newdream.net>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com> <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net> <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
 <alpine.DEB.2.00.1510201422450.16833@cobra.newdream.net> <5626BECA.7070306@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbbJUNcr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 09:32:47 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id A73F2227
	for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 13:32:47 +0000 (UTC)
In-Reply-To: <5626BECA.7070306@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 20 Oct 2015, Ric Wheeler wrote:
> > Now:
> >      1 io  to write a new file
> >    1-2 ios to sync the fs journal (commit the inode, alloc change)
> >            (I see 2 journal IOs on XFS and only 1 on ext4...)
> >      1 io  to commit the rocksdb journal (currently 3, but will drop to
> >            1 with xfs fix and my rocksdb change)
> 
> I think that might be too pessimistic - the number of discrete IO's sent down
> to a spinning disk make much less impact on performance than the number of
> fsync()'s since they IO's all land in the write cache.  Some newer spinning
> drives have a non-volatile write cache, so even an fsync() might not end up
> doing the expensive data transfer to the platter.

True, but in XFS's case at least the file data and journal are not 
colocated, so its 2 seeks for the new file write+fdatasync and another for 
the rocksdb journal commit.  Of course, with a deep queue, we're doing 
lots of these so there's be fewer journal commits on both counts, but the 
lower bound on latency of a single write is still 3 seeks, and that bound 
is pretty critical when you also have network round trips and replication 
(worst out of 2) on top.

> It would be interesting to get the timings on the IO's you see to measure the
> actual impact.

I observed this with the journaling workload for rocksdb, but I assume the 
journaling behavior is the same regardless of what is being journaled.  
For a 4KB append to a file + fdatasync, I saw ~30ms latency for XFS, and 
blktrace showed an IO to the file, and 2 IOs to the journal.  I believe 
the first one is the record for the inode update, and the second is the 
journal 'commit' record (though I forget how I decided that).  My guess is 
that XFS is being extremely careful about journal integrity here and not 
writing the commit record until it knows that the preceding records landed 
on stable storage.  For ext4, the latency was about ~20ms, and blktrace 
showed the IO to the file and then a single journal IO.  When I made the 
rocksdb change to overwrite an existing, prewritten file, the latency 
dropped to ~10ms on ext4, and blktrace showed a single IO as expected.  
(XFS still showed the 2 journal commit IOs, but Dave just posted the fix 
for that on the XFS list today.)

> Plumbing for T10 DIF/DIX already exist, what is missing is the normal block
> device that handles them (not enterprise SAS/disk array class)

Yeah... which unfortunately means that unless the cheap drives 
suddenly start shipping if DIF/DIX support we'll need to do the 
checksums ourselves.  This is probably a good thing anyway as it doesn't 
constrain our choice of checksum or checksum granularity, and will 
still work with other storage devices (ssds, nvme, etc.).

sage
