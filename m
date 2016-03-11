From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: BlueStore Allocator.
Date: Fri, 11 Mar 2016 02:06:16 +0000
Message-ID: <CY1PR0201MB1897D954C262E37CDC98CD7FE8B50@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0092.outbound.protection.outlook.com ([207.46.100.92]:18400
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933202AbcCKCGT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 21:06:19 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

As promised, here is my description of data structures for an allocator to be based on a bitmap-based freelist.

I would propose for each bucket size of the current allocator (4K, 8K, 16K, ...) that there be an instance of a fast searching structure. Each fast searching structure consists of a hierarchy of bitmaps. Each level of the bitmap contains the reduction of some fixed number of bits of the lower level of the bitmap, e.g., for each 64 bits at level N there is one bit at level N+1. There would be ceiling(log64(<freelist-size>)) number of levels (#levels). You might consider this the equivalent of a fully-populated tree with a fan-out of 64 on each level. (The 64 is arbitrary, but a good choice for a 64-bit CPU. It could easily be parameterized for 32-bits on a 32-bit CPU).

With this structure, you can locate a free item in o(#levels calls to ffo) (find first one). That and the usual shifting/masking stuff. This is true whether you start from a hint or not. This is exactly analagous to the current interval_set (or btree_map) implementation except that all of the complex tree manipulation stuff is reduced to some simple shifting and vector indexing operations. Inserts and deletes are relatively easy and require only O(#level) compare and bit-set/masking operations (which can be truncated in many cases).

IMO, this data structure is universally faster than the current tree-based extent maps (either RB or btree_map), supports the same set of operational primitives all with worst-case complexity of O(#levels) [effectively O(1) for our sizes] and is much more easily parallelized than the current implementation.

This data structure has constant memory consumption which is probably somewhat worse than the current implementation in typical scenarios and dramatically better in worst case scenarios.

Memory consumption is (again, please correct the math when I make a mistake):

For 4K objects. we'll make one bit of the level[0] cover 64-bits of the freelist. That means that for each TB of storage we'll have 2^40/2^12 => 2^28 bits of freelist which will be 2^22 bits in level 0, which is 2^19 bytes => 512KB. Level 1 will take 1/64th of that which is 8KB level -- which we will ignore.

For  8K buckets, the first level is 1/2 of that => 256KB
For 16K buckets, the first level is 1/2 of that => 128KB
for 32K buckets, the first level is 1/2 of that => 64KB
.....<As many bucket levels as you want, memory consumption becomes irrelevant)

Total consumption for each TB of storage is then 512K + 256K + 128K + 64K +.... which is about 1MB total. (probably something like 1.1 or 1.2MB when you include the smaller higher levels that I've ignored)

Parallelizing this structure is trivial, you can just shard it in the spatial domain.

Thus the total allocator system becomes:

(1) An in-memory bitmap vector of 4K blocks (this is the equivalent of the FreeList of the current design).
(2) The auxiliary structures described above (~1MB of memory extra).
(3) Allocations set bits in the bitmap at the time of allocation.
(4) Deallocating operations are done after the KV commit.
(5) KV keys become chunks of the bitmap and are manipulated at the individual bit level via the merge capability of RocksDB (which we would duplicate in ZetaScale).

IMO, simple, straightforward and much faster than the current implementation.

IMO, the only deficiencies w.r.t. the current scheme is:

(1) Worse memory consumption in the typical case. But this is really a benefit as I've argued before.
(2) Longer restart times. But I believe that this is minor, we're really only going to be reading 32MB of bitmap for each TB of storage at startup time. Building the 1MB of searching data structures shouldn't really take too long. (I'm guessing it's less than a second of wall time, without even bothering to parallelize it)

As usual, comments solicited.

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
