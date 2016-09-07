From: Sage Weil <sweil@redhat.com>
Subject: RE: bitmap allocator granularity
Date: Wed, 7 Sep 2016 13:17:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609071313160.31624@piezo.us.to>
References: <alpine.DEB.2.11.1609061922340.31624@piezo.us.to> <BLUPR0201MB18093BA9C03CA8CE6F7FDC3985F80@BLUPR0201MB1809.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757656AbcIGNR3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Sep 2016 09:17:29 -0400
In-Reply-To: <BLUPR0201MB18093BA9C03CA8CE6F7FDC3985F80@BLUPR0201MB1809.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 7 Sep 2016, Ramesh Chander wrote:
> Hi Sage,
> 
> Thanks for root causing this and pin pointing the problem.
> 
> In my opinion keeping it persistent is good way to go.
> 
> This is because min_alloc_size is the unit that allocator has to 
> guarantee that it will allocate contiguous.
> 
> If we store something else smaller (block size) in allocator, then we 
> might end up searching for N contiguous bits every time even for single 
> unit allocation.
> 
> This might happen in any case but aligning it to min_alloc_size will at 
> least avoid it in good configurations.
> 
> Also in some misconfiguration where block size is very small, the 
> allocator might take more memory even if minimum allocation unit is 
> larger.
> 
> I assume that min_alloc_size is not something that will change too 
> frequently in lifetime of OSD and we have to just make sure it works so 
> whatever you suggested for persisting minimum min_alloc_size will work. 

If we go this route I see two options: specify min_alloc_size only at mkfs 
time and store and use that value forever after, or store the 
min_min_alloc_size and use that for the allocator granularity.  Any 
preferences?

The min_min_alloc_size isn't difficult, but it's weird that starting with 
min_alloc_size of 64K, switching to 4K, and then switching back to 64K 
will not behave/perform the same as having it at 64K the whole time.  We 
can just say as much on startup in the log, I suppose.

> It can be stored in superblock or with Freelist manger metadata during 
> mount and unmount time?
> If you suggest I can do these changes?

Sure!  There's the "super" area that's read during startup 
(_open_super_meta) and a corresponding write function too.

Thanks!
sage



> 
> -Ramesh
> 
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, September 07, 2016 12:57 AM
> > To: Ramesh Chander; ceph-devel@vger.kernel.org
> > Subject: bitmap allocator granularity
> >
> > Hi Ramesh,
> >
> > It looks like fsck error I've been chasing on my branch is a general problem
> > with the bitmap granularity.  The
> > ObjectStore/StoreTest.SyntheticMatrixCsumVsCompression/2 test sets
> > min_alloc_size to 32k and then to something smaller after that.  My branch
> > adds an occasional umount+fsck+mount to the synthetic workload test that
> > uncovers a problem: if we start with a small min_alloc_size, write some
> > objects, and then umount and remount with a larger min_alloc_size (say,
> > 32k), things can go wrong.  The allocator defines its bits in terms of
> > min_alloc_size, but some used extents are smaller than that, and when they
> > get released we trigger an assert like
> >
> > /home/sage/src/ceph/src/os/bluestore/BitMapAllocator.cc: In function 'void
> > BitMapAllocator::insert_free(uint64_t, uint64_t)' thread 7ffb44deb700 time
> > 2016-09-06 15:23:39.055902
> > /home/sage/src/ceph/src/os/bluestore/BitMapAllocator.cc: 76: FAILED
> > assert(!(off % m_block_size))
> >
> > There was a related issue with fsck that its used_blcoks bitmap was
> > min_alloc_size granularity.
> >
> > I see two options: we can either unconditionally maintain the bitmap in
> > block_size units, or we can store persistently the smallest min_alloc_size that
> > we have ever mounted with and use that ("min_min_alloc_size?").
> >
> > What do you think?
> > sage
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
