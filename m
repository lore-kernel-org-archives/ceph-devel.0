From: Sage Weil <sweil@redhat.com>
Subject: bitmap allocator granularity
Date: Tue, 6 Sep 2016 19:27:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609061922340.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934551AbcIFT1F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Sep 2016 15:27:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh.Chander@sandisk.com, ceph-devel@vger.kernel.org

Hi Ramesh,

It looks like fsck error I've been chasing on my branch is a general 
problem with the bitmap granularity.  The 
ObjectStore/StoreTest.SyntheticMatrixCsumVsCompression/2 test sets 
min_alloc_size to 32k and then to something smaller after that.  My branch 
adds an occasional umount+fsck+mount to the synthetic 
workload test that uncovers a problem: if we start with a 
small min_alloc_size, write some objects, and then umount and remount with 
a larger min_alloc_size (say, 32k), things can go wrong.  The allocator 
defines its bits in terms of min_alloc_size, but some used extents are 
smaller than that, and when they get released we trigger an assert like

/home/sage/src/ceph/src/os/bluestore/BitMapAllocator.cc: In function 'void BitMapAllocator::insert_free(uint64_t, uint64_t)' thread 7ffb44deb700 time 2016-09-06 15:23:39.055902
/home/sage/src/ceph/src/os/bluestore/BitMapAllocator.cc: 76: FAILED assert(!(off % m_block_size))

There was a related issue with fsck that its used_blcoks bitmap was 
min_alloc_size granularity.

I see two options: we can either unconditionally maintain the bitmap in 
block_size units, or we can store persistently the smallest min_alloc_size 
that we have ever mounted with and use that ("min_min_alloc_size?").

What do you think?
sage
