From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueStore Allocator.
Date: Wed, 16 Mar 2016 16:03:14 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603161600090.14377@cpach.fuggernut.com>
References: <CY1PR0201MB1897D954C262E37CDC98CD7FE8B50@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37638 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335AbcCPUDb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Mar 2016 16:03:31 -0400
In-Reply-To: <CY1PR0201MB1897D954C262E37CDC98CD7FE8B50@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 11 Mar 2016, Allen Samuels wrote:
> As promised, here is my description of data structures for an allocator 
> to be based on a bitmap-based freelist.
> 
> I would propose for each bucket size of the current allocator (4K, 8K, 
> 16K, ...) that there be an instance of a fast searching structure. Each 
> fast searching structure consists of a hierarchy of bitmaps. Each level 
> of the bitmap contains the reduction of some fixed number of bits of the 
> lower level of the bitmap, e.g., for each 64 bits at level N there is 
> one bit at level N+1. There would be ceiling(log64(<freelist-size>)) 
> number of levels (#levels). You might consider this the equivalent of a 
> fully-populated tree with a fan-out of 64 on each level. (The 64 is 
> arbitrary, but a good choice for a 64-bit CPU. It could easily be 
> parameterized for 32-bits on a 32-bit CPU).
> 
> With this structure, you can locate a free item in o(#levels calls to 
> ffo) (find first one). That and the usual shifting/masking stuff. This 
> is true whether you start from a hint or not. This is exactly analagous 
> to the current interval_set (or btree_map) implementation except that 
> all of the complex tree manipulation stuff is reduced to some simple 
> shifting and vector indexing operations. Inserts and deletes are 
> relatively easy and require only O(#level) compare and bit-set/masking 
> operations (which can be truncated in many cases).
> 
> IMO, this data structure is universally faster than the current 
> tree-based extent maps (either RB or btree_map), supports the same set 
> of operational primitives all with worst-case complexity of O(#levels) 
> [effectively O(1) for our sizes] and is much more easily parallelized 
> than the current implementation.
> 
> This data structure has constant memory consumption which is probably 
> somewhat worse than the current implementation in typical scenarios and 
> dramatically better in worst case scenarios.
> 
> Memory consumption is (again, please correct the math when I make a 
> mistake):
> 
> For 4K objects. we'll make one bit of the level[0] cover 64-bits of the 
> freelist. That means that for each TB of storage we'll have 2^40/2^12 => 
> 2^28 bits of freelist which will be 2^22 bits in level 0, which is 2^19 
> bytes => 512KB. Level 1 will take 1/64th of that which is 8KB level -- 
> which we will ignore.
> 
> For  8K buckets, the first level is 1/2 of that => 256KB
> For 16K buckets, the first level is 1/2 of that => 128KB
> for 32K buckets, the first level is 1/2 of that => 64KB
> .....<As many bucket levels as you want, memory consumption becomes irrelevant)
> 
> Total consumption for each TB of storage is then 512K + 256K + 128K + 
> 64K +.... which is about 1MB total. (probably something like 1.1 or 
> 1.2MB when you include the smaller higher levels that I've ignored)
> 
> Parallelizing this structure is trivial, you can just shard it in the 
> spatial domain.

It would be nice if we made the internal nodes two bits instead of one, so 
that they could represent "00 = no allocations" and "11 = fully allocated" 
(and the sub-key doesn't even need to be instantiated) in addition to "01 
= partially allocated" (and sub-key has the next level of detail down).

This will reduce memory usage in the general case (where hopefully lots of 
space is either fully allocated or fully free).

This might screw up the parallelism, though, with the kv transactions.  
Perhaps we do that only for the in-memory representation, and keep the kv 
representation simple (and pay for the sequential scan on startup).

sage
