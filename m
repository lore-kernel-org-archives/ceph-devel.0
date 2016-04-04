From: Sage Weil <sweil@redhat.com>
Subject: hackathon recap
Date: Mon, 4 Apr 2016 10:26:38 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604040951240.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbcDDO0p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Apr 2016 10:26:45 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAD7364368
	for <ceph-devel@vger.kernel.org>; Mon,  4 Apr 2016 14:26:44 +0000 (UTC)
Received: from cpach (ovpn-112-83.phx2.redhat.com [10.3.112.83])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u34EQgAk014382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 4 Apr 2016 10:26:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Here's a brief summary of some of the topics we discussed at last week's 
hackathon:


- BlueStore freelist and allocator

One of many goals is to move away from a single thread submitting 
transactions to rocksdb.  The freelist representation as offset=length kv 
pairs is one thing standing in the way.  We talked about Allen's proposal 
to move to a bitmap-based representation in some detail, including its 
reliance on a merge operator in the kv database, whether we would need to 
separate allocations into discontiguous regions at the allocator stage for 
parallelism anyway, and how things would vary for HDD and SMR HDD vs 
flash.

The eventual conclusion was that the merge operator dependency was 
annoying but the best path forward.  Allen did some simple merge operator 
performance tests after the fact on rocksdb and it behaved as expected (no 
slower than doing inserts vs merges).

Next steps are to reimplement FreelistManager using bitmaps and merge.  
The Allocator vs FreelistManager separation still stands--the multilevel 
bitmap scheme we discussed earlier is an Allocator implementation detail 
(that favors fixed memory utilization, etc.).  On the freelist side, I 
think the main open question is whether to continue to support the old 
scheme, with some "must serialize freelist at tx submit time" flag.  And 
whether to support the old on-disk format.

- SMR allocator

We talked about how to support SMR drives.  In particular, the Allocator 
should be pretty trivial: we just need to maintain a write pointer for 
each zone, and some stats on how many used blocks/bytes are still in use 
in each zone.  Probably the hard part on the write side will be 
making sure that racing writes submit writes in order if they both 
allocate out of the same zone.

The other half of the problem is how to do zone cleaning.  The thought was 
to have a kv hints indicating which [shard,poolid,]hash values allocated 
in that region.  When cleaning time happens, we iterate over objects with 
those prefixes and, if they still reference that zone, rewrite them 
elsewhere.

- Occluded blob compaction

A related discussion was how to free up wasted space from occluded blobs, 
and whether that was similar or the same as the SMR cleaning function.  
One idea was that if we make a similar map of [shard,poolid,]hash for any 
onodes that have occluded blobs.  In general we expect these to be 
uniformly distributd across the device, so the SMR-style per-zone 
accounting isn't really helpful for finding the 'best' logical offset to 
do compaction, but this does give us a list of objects to examine.

- Async read

Sam and Vikas spent some time going over the async read patches in detail.

- RocksDB short-lived keys

We talked about the short-lived keys getting written to level0.  This led 
us to the realization that the whiteouts/tombstones will still go to 
level0 even if the wal create+delete is in the same .log file.  That led 
us to SingleDelete

	https://github.com/ceph/rocksdb/blob/master/include/rocksdb/db.h#L189

which we should probably switch to immediately for WAL keys.

Whether it is worth doing something more sophisticated here is still 
TBD.

- RocksDB column families

We're storing very different types of data under different prefixes (e.g., 
internal metadata in the form of onodes vs user data as omap).  Next steps 
are to do some further investigation to see if we'll benefit from using 
column families here.

- Multi-stream SSDs and GC control APIs

Jianjian presented about new APIs to contorl when the SSD is doing garbage 
collection (stop, start, start but suspend on IO) and streams to segregate 
writes into different erase blocks.

It wasn't clear how helpful the GC control would be since we don't have 
explicit idle periods--we would be detecting idleness via heuristics in 
the same way the device would be.  Scrubbing IO might be one possibility 
where we could say this is IO that doesn't warrant pausing GC.

The streams are much more promising.  The rocksdb strategy that was 
presented (wal, l0, l1, etc. in different streams) should map well to what 
BlueStore is doing, plus another stream for data IO.  We discussed 
separating PGs into different streams (since entire PGs can be deleted at 
one time) but in the end it wasn't clear that woukd be much of a win, and 
there generally aren't that many streams supported by the devices (8-16) 
anyway.

- BlueStore checksums

Most of this made it onto the list, but the main points were that the 
checksum block size determines the minimum read size (i.e., read 
amplification for small reads), and probably affects the read error rate 
as observed by users (see related email thread).

- DPDK and SPDK

We spent a lot of time going over some background about what DPDK and SPDK 
do and don't do.  Takeaways/questions include

 - Which TCP stack are we using with Haomai's DPDK AsyncMessenger 
integration?  Should we support multiple options?
 - How much benefit should we expect?  Current estimate (based on 
SanDisk's numbers) were that each op consumes around 250us of CPU time, 
about 80 of that is actual IO time on an NVMe device, and the max time 
we're likely to cut from bypassing the kernel block stack is on the order 
of 20-30us.  Successful users of DPDK/SPDK benefit mostly from 
restructuring the rest of the stack to avoid legacy threading models.
 - NVMe has undefined behavior if you submit racing writes for the same 
block, even in the same queue.  BlueStore currently does this in certain 
circumstances.  We should probably determine whether this is already 
problematic with direct i/o, but regardless we need to stop doing it.  It 
comes up frequenetly, e.g., when appending sub-block-sized writes to the 
same object/file.
 - We'll need to implement our own caching layer, probably sooner 
rather than later.  Our current strategy of mixing direct io and buffered 
io *almost* works, but there are two problems: (1) an unrelated process 
doing buffered reads over our block device can pollute the page cache and 
potentially cause us to corrupt ourselves, and (2) a huge address_space 
with lots of (even clean) pages can make fdatasync(2) slow when it scans 
for dirty pages (and we have to do the sync to induce a device flush).

- RBD consistency groups

Victor and I spent some time discussing consistency groups and the 
quiescing strategy that will be needed to ensure the cg snapshot is in 
fact consistent.  We also talked about the various failure/timeout 
conditions that will need to be addressed.


That's all I'm remembering right now; chime in if I missed any details or 
topics we should record for posterity!

sage
