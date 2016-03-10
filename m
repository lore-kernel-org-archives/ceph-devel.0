From: Sage Weil <sweil@redhat.com>
Subject: RE: BlueStore Performance issue
Date: Thu, 10 Mar 2016 08:45:09 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603100839170.14377@cpach.fuggernut.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com> <CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603091033200.14377@cpach.fuggernut.com> <CY1PR0201MB18972EAD3EAAC4CDC3BDC602E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbcCJNpa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 08:45:30 -0500
In-Reply-To: <CY1PR0201MB18972EAD3EAAC4CDC3BDC602E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 10 Mar 2016, Allen Samuels wrote:
> Thanks for information on the allocator, many sections of code that we 
> didn't understand and thought didn't seem relevant are clearer now. I 
> believe we now understand the deeper coupling between the freespace 
> management and the transaction commit ordering logic.
> 
> The root cause is that we missed the synchronous/asynchronous commits in 
> kv_sync_thread when this was mapped into ZetaScale's commit -- which 
> only has a synchronous transaction commit. So in the short term, we'll 
> do some in-memory caching which will effectively create the equivalent 
> of sync and async transactions in ZetaScale. I'm not yet convinced that 
> this is the best long term solution, but it should get us past this 
> particular problem right now which is more important.

Good to hear.  Let's see how it goes...
 
> On another front, I've expressed concern about the memory consumption 
> associated with the current allocation implementation. Please verify 
> these computations...
> 
> On a 64-bit x86 machine, I used the google btree_map code and populated 
> it with a worst-case allocation scheme -- which is every other block 
> being free and then measured the memory consumption. It turns out that 
> for large maps it consumes about 20 bytes per entry (pretty good for an 
> 8-byte key and an 8-byte value!).
> 
> So for a worst-case allocation pattern and the default 64K allocation 
> block size, the current code will consume 40 bytes per 128KB of storage 
> (2^17) [I'm assuming StupidAllocator also gets converted to btree_map]. 
> This means that for each TB of storage you'll need 40*(2^40/2^17) => 
> 320MB of memory per TB of storage. Current HW recommendations are 1-2GB 
> DRAM for each TB of storage. This is a pretty big chunk of that memory 
> that I'm certain has much better ways to be useful.
> 
> Alternatively, if you use a simple bit vector with a 4KB block size 
> (each bit represents 4KB), then you only need (2^40/2^12/2^3) which is 
> 2^25 or 32MB of DRAM per TB. Of course the current code uses two of 
> those vectors which would be 64MB total for each TB. (And yes, you'll 
> use more memory to allow efficient searching of those vectors, but that 
> memory is only an additional 3-4%).

What would the search data structures look like in this case?

> Another important benefit of this is that the WAL code need only kick in 
> for operations that are less than 4K rather than the current 64K. This 
> is a big reduction in write-amplification for these operations which 
> should translate directly into improved throughput, especially for such 
> benchmark critical areas as random 4K writes...
>
> While not terribly useful on hybrid or HDD systems, the bitmap based 
> code has MUCH shorter CPU paths than does the current code. On an all 
> flash OSD system this will directly translate into more performance 
> (quantity unknown of course).
> 
> While the memory consumption reduction is nice, for me the significant 
> performance improvement implied by virtual elimination of WAL is the 
> compelling factor.

I wouldn't conflate the allcoation size and freelist representation; we 
get the same avoidance of the WAL path with the current code by changing 
min_alloc_size to 4k.  Making the freelist represntation more efficient is 
important for small block sizes, but *any* memory-efficient strategy is 
fine (and even the current one is probably fine for most workloads).  For 
example, we could keep an extent-based representation and page in regions 
instead...

The other thing to keep in mind is that the freelist is representated 
twice: once in memory in indexed form in StupidAllocator, and once in 
FreelistManager just to ensure it's persisted properly.  In the second 
case, I suspect we could leverage a custom rocksdb merge operator to avoid 
that representation entirely so that adjacent extents are coalesced when 
the sst is generated (when writing to l0 or during compaction).  I'm 
guessing that functionality isn't present is ZS though?

sage


> Of course, if I've misplaced a binary (or decimal) point in my 
> computation, then please ignore.
> 
> 
> Allen Samuels
> Software Architect, Fellow, Systems and Software Solutions
> 
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, March 09, 2016 7:38 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: BlueStore Performance issue
> 
> On Wed, 9 Mar 2016, Allen Samuels wrote:
> > > Stage 3 is serious bottleneck in that it guarantees that you will
> > > never exceed QD=1 for your logging device. We believe there is no
> > > need to serialize the KV commit operations.
> >
> > It's potentially a bottleneck, yes, but it's also what keeps the
> > commit rate self-throttling.  If we assume that there are generally
> > lots of other IOs in flight because every op isn't metadata-only the
> > QD will be higher.
> >
> > If it's a separate log device, though, yes.. it will have QD=1.  In
> > those situations, though, the log device is probably faster than the
> > other devices, and a shallow QD probably isn't going to limit
> > throughput--just marginally increase latency?
> >
> > [Allen] No a shallow queue depth will directly impact BW on many
> > (most?/all?) SSDs. I agree that in a hybrid model (DB on flash, data
> > on
> > HDD) that the delivered performance delta may not be large. As for the
> > throttling, we haven't focused on that area yet (just enough to put it
> > on the list of future things to investigate).
> 
> FWIW in the single-device non-hybrid case, the QD=1 for *kv* IOs, but there will generally be a whole bunch of non-kv reads and writes also in flight.  I wouldn't expect us to ever actually have a QD of 1 unless
> *every* operation is pure-kv (say, omap operations).
> 
> For example, say we have 4 KB random writes, and the QD at the OSD level is 64.  In that case, BlueStore should have up to 64 4 KB aio writes and 0 to 1 64*whatever kv writes in flight.
> 
> My intuition says that funneling the txn commits like this will in practice maybe halve the effective QD at the device (compared to the QD at the OSD)... does that seem about right?  Maybe it'd stay about the same, since 1 OSD IO is actually between 1 and 2 device IOs (the aio write + the [maybe batched] txn commit).
> 
> sage
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
