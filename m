From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: hackathon recap
Date: Mon, 4 Apr 2016 23:17:34 +0800
Message-ID: <CACJqLybuo97ho=NhDri-f5UxuPKw+-0ZTgs0=A=Orp1Yr=4C8A@mail.gmail.com>
References: <alpine.DEB.2.11.1604040951240.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36079 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbcDDPRg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 11:17:36 -0400
Received: by mail-vk0-f50.google.com with SMTP id c4so58449103vkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2016 08:17:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604040951240.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Apr 4, 2016 at 10:26 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi all,
>
> Here's a brief summary of some of the topics we discussed at last week's
> hackathon:
>
>
> - BlueStore freelist and allocator
>
> One of many goals is to move away from a single thread submitting
> transactions to rocksdb.  The freelist representation as offset=length kv
> pairs is one thing standing in the way.  We talked about Allen's proposal
> to move to a bitmap-based representation in some detail, including its
> reliance on a merge operator in the kv database, whether we would need to
> separate allocations into discontiguous regions at the allocator stage for
> parallelism anyway, and how things would vary for HDD and SMR HDD vs
> flash.
>
> The eventual conclusion was that the merge operator dependency was
> annoying but the best path forward.  Allen did some simple merge operator
> performance tests after the fact on rocksdb and it behaved as expected (no
> slower than doing inserts vs merges).
>
> Next steps are to reimplement FreelistManager using bitmaps and merge.
> The Allocator vs FreelistManager separation still stands--the multilevel
> bitmap scheme we discussed earlier is an Allocator implementation detail
> (that favors fixed memory utilization, etc.).  On the freelist side, I
> think the main open question is whether to continue to support the old
> scheme, with some "must serialize freelist at tx submit time" flag.  And
> whether to support the old on-disk format.

Cool, Current StupidAllocator is stupid enough for real workload
benchmark :-). Look forward to Bitmap

>
> - SMR allocator
>
> We talked about how to support SMR drives.  In particular, the Allocator
> should be pretty trivial: we just need to maintain a write pointer for
> each zone, and some stats on how many used blocks/bytes are still in use
> in each zone.  Probably the hard part on the write side will be
> making sure that racing writes submit writes in order if they both
> allocate out of the same zone.
>
> The other half of the problem is how to do zone cleaning.  The thought was
> to have a kv hints indicating which [shard,poolid,]hash values allocated
> in that region.  When cleaning time happens, we iterate over objects with
> those prefixes and, if they still reference that zone, rewrite them
> elsewhere.
>
> - Occluded blob compaction
>
> A related discussion was how to free up wasted space from occluded blobs,
> and whether that was similar or the same as the SMR cleaning function.
> One idea was that if we make a similar map of [shard,poolid,]hash for any
> onodes that have occluded blobs.  In general we expect these to be
> uniformly distributd across the device, so the SMR-style per-zone
> accounting isn't really helpful for finding the 'best' logical offset to
> do compaction, but this does give us a list of objects to examine.
>
> - Async read
>
> Sam and Vikas spent some time going over the async read patches in detail.

I hope this progress could be faster and quicker :--

>
> - RocksDB short-lived keys
>
> We talked about the short-lived keys getting written to level0.  This led
> us to the realization that the whiteouts/tombstones will still go to
> level0 even if the wal create+delete is in the same .log file.  That led
> us to SingleDelete
>
>         https://github.com/ceph/rocksdb/blob/master/include/rocksdb/db.h#L189
>
> which we should probably switch to immediately for WAL keys.
>
> Whether it is worth doing something more sophisticated here is still
> TBD.
>
> - RocksDB column families
>
> We're storing very different types of data under different prefixes (e.g.,
> internal metadata in the form of onodes vs user data as omap).  Next steps
> are to do some further investigation to see if we'll benefit from using
> column families here.
>
> - Multi-stream SSDs and GC control APIs
>
> Jianjian presented about new APIs to contorl when the SSD is doing garbage
> collection (stop, start, start but suspend on IO) and streams to segregate
> writes into different erase blocks.

Where these new apis from? for specified vendor?

>
> It wasn't clear how helpful the GC control would be since we don't have
> explicit idle periods--we would be detecting idleness via heuristics in
> the same way the device would be.  Scrubbing IO might be one possibility
> where we could say this is IO that doesn't warrant pausing GC.
>
> The streams are much more promising.  The rocksdb strategy that was
> presented (wal, l0, l1, etc. in different streams) should map well to what
> BlueStore is doing, plus another stream for data IO.  We discussed
> separating PGs into different streams (since entire PGs can be deleted at
> one time) but in the end it wasn't clear that woukd be much of a win, and
> there generally aren't that many streams supported by the devices (8-16)
> anyway.
>
> - BlueStore checksums
>
> Most of this made it onto the list, but the main points were that the
> checksum block size determines the minimum read size (i.e., read
> amplification for small reads), and probably affects the read error rate
> as observed by users (see related email thread).
>
> - DPDK and SPDK
>
> We spent a lot of time going over some background about what DPDK and SPDK
> do and don't do.  Takeaways/questions include
>
>  - Which TCP stack are we using with Haomai's DPDK AsyncMessenger
> integration?  Should we support multiple options?

yes, it will be a backend of AsyncMessenger. Just like impled options:
ms type = async
ms async transport type = dpdk
ms dpdk host ipv4 addr = 10.253.102.119
ms dpdk gateway ipv4 addr = 10.253.102.1
ms dpdk netmask ipv4 addr = 255.255.255.0

these options will enable dpdk backend.

Current, I don't find any problem between kernel tcp/ip stack with
dpdk userspace tcp/ip. Even passed test_msgr which injects lots of
errors.

>  - How much benefit should we expect?  Current estimate (based on
> SanDisk's numbers) were that each op consumes around 250us of CPU time,
> about 80 of that is actual IO time on an NVMe device, and the max time
> we're likely to cut from bypassing the kernel block stack is on the order
> of 20-30us.  Successful users of DPDK/SPDK benefit mostly from
> restructuring the rest of the stack to avoid legacy threading models.

From now, because of some known bottlenecks need to solve. The most
advantage is combining dpdk and spdk which actually make
spdk(userspace nvme driver) effective. Because spdk still use poll
mode and require physical address while queuing io request. Without
dpdk, we always need to alloc a physical address aware memory and do
copy. With dpdk as network stack, we could use memory from NIC to SSD.
Thanks to the dpdk mbuf design, dpdk stack permit a lots of inflight
mbuf and alloc new memory if hungry.

The current status is osd could boot up with serveal dedicated dpdk
network thread, and the last one run spdk polling. I really want to
make make dpdk network thread can take over
OSD::ShardedOpWQ::_process(just discard thread pool and let dpdk
thread poll this function) and let each dpdk thread own a shard of
PGs, then poll BlueStore::kv_thread, and last for spdk completion reap
threads. The main gap now is:
1. Signal/Wait pair ....
2. Async Read ...
3. discard potential slowness in fast path.

If so, lots of locks could be discarded. My initial idea is not change
so much in current path. But it seemed the Signal/Wait and async read
couldn't bypass. Look forward to future/promise and async read :-)

>  - NVMe has undefined behavior if you submit racing writes for the same
> block, even in the same queue.  BlueStore currently does this in certain
> circumstances.  We should probably determine whether this is already
> problematic with direct i/o, but regardless we need to stop doing it.  It
> comes up frequenetly, e.g., when appending sub-block-sized writes to the
> same object/file.
>  - We'll need to implement our own caching layer, probably sooner
> rather than later.  Our current strategy of mixing direct io and buffered
> io *almost* works, but there are two problems: (1) an unrelated process
> doing buffered reads over our block device can pollute the page cache and
> potentially cause us to corrupt ourselves, and (2) a huge address_space
> with lots of (even clean) pages can make fdatasync(2) slow when it scans
> for dirty pages (and we have to do the sync to induce a device flush).
>
> - RBD consistency groups
>
> Victor and I spent some time discussing consistency groups and the
> quiescing strategy that will be needed to ensure the cg snapshot is in
> fact consistent.  We also talked about the various failure/timeout
> conditions that will need to be addressed.
>
>
> That's all I'm remembering right now; chime in if I missed any details or
> topics we should record for posterity!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Wheat
