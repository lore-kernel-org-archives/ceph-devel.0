From: Sage Weil <sage@newdream.net>
Subject: Re: BlueStore Performance issue
Date: Thu, 10 Mar 2016 14:04:53 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603101355560.14377@cpach.fuggernut.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com> <CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603091033200.14377@cpach.fuggernut.com> <CY1PR0201MB18972EAD3EAAC4CDC3BDC602E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603100839170.14377@cpach.fuggernut.com> <CY1PR0201MB1897D0D0D818B598F0EA85A6E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603101110071.14377@cpach.fuggernut.com> <CY1PR0201MB1897D24DAC3415BCBDFB3F72E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com> <CAN=+7FUk7QCOKU7Y5-O9SREbknR_UXDn7zbAA9QF5FdNTWsFfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53850 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbcCJTFP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 14:05:15 -0500
In-Reply-To: <CAN=+7FUk7QCOKU7Y5-O9SREbknR_UXDn7zbAA9QF5FdNTWsFfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 10 Mar 2016, Samuel Just wrote:
> First, let me try to flesh out my understanding of Allen's suggestion
> a bit (Allen, let me know if I'm misunderstanding):
> 
> Instead of using rocksdb to store a freelist extent mapping of
> start->end, we instead store coarse_offset->(fine_offset->allocated?)
> where (with a 4k min allocation size), fine-offset is 4k aligned and
> coarse_offset is some largish multiple of that (4MB coarse offset
> ->1024 bits/key?).  The actual keys contain a bitmap containing 1s for
> fine_offsets where the allocation status changed and we use a rocksdb
> merge operator to xor the overlapping keys to get a final key value
> which represents the current allocation status.
>
> I think this does avoid the issue of needing to serialize the
> transactions just before submission, but I don't think it actually
> gets us anything else.
> - We aren't assuming rmw transactions in the backend kv store, so we
> still need a way to avoid two concurrent operations trying to allocate
> the same extent.
> - Such a representation makes it relatively difficult to find free
> space (particularly contiguous free space) -- we'd probably need a
> secondary structure to make that faster.

FWIW this is already separate: FreelistManager handles the in-kv 
represetnation of the freelist only, while the Allocator implementation 
(StupidAllocator currently) has a different in-memory represetatino that 
allows it to implement it's policy efficiently (in this case, extent 
maps, binned by extent size).

So eliminating the FreelistManager's representation would solve half of 
the memory usage.

> - There isn't any reason to think that rocksdb would be any more
> efficient about concurrent writers writing to overlapping key spaces,
> so we'd want different writers using different allocation regions
> anyway.
> - I think rocksdb does need to do some work which is proportional to
> the number of keys changed, so using small coarse_offsets to avoid
> excessive overlapping might be a problem.
> - Querying the allocation status could require reading several levels
> even if the lowest one has the key since we need to compose all of the
> unmerged changes -- this suggests we'd need an in-memory cache with
> paging anyway to do allocation efficiently.
> 
> I think the above means that whatever representation we choose, we'd
> still have to design for parallelism further up the stack with an
> allocation group like concept.  It also seems like we'd be stuck with
> an explicit paging system for the allocation information above the kv
> store anyway.  At that point, it seems like we might as well use an
> extent representation for all of its other advantages and skip the
> merge operator dependence.

I'm leaning the same way.

Put another way: perhaps the initial focus should not be just on how to 
make the transaction commit and freelist update parallel, but instead how 
to make the allocation decision itself parallel.  We'll need to solve both 
problems to actually get any mileage out of this, and probably the 
solution is related.

For example: each worker thread preallocates some space and doles it out 
in each transaction.  Persistence is done via someting analogous (or the 
same as) the WAL records:

 - preallocate record removes some space from the freelist, and writes out 
a preallocate record with teh same extent.  we keep this in memory, 
divvied up between worker threads, or whatever.
 - each transaction commits with an extra allocate record that 
commits space from the preallocate extent list
 - the next time we preallocate space, or when we do wal cleanup, or on 
some other period, we compact the preallocate add/remove records.

Something along those lines. Basically, we do short-term inserts on a 
per-extent allocated basis and defer the extent merging a bit so that it 
can be batched up.

sage


> -Sam
> 
> On Thu, Mar 10, 2016 at 10:18 AM, Allen Samuels
> <Allen.Samuels@sandisk.com> wrote:
> >> -----Original Message-----
> >> From: Sage Weil [mailto:sweil@redhat.com]
> >> Sent: Thursday, March 10, 2016 8:13 AM
> >> To: Allen Samuels <Allen.Samuels@sandisk.com>
> >> Cc: ceph-devel@vger.kernel.org
> >> Subject: RE: BlueStore Performance issue
> >>
> >> On Thu, 10 Mar 2016, Allen Samuels wrote:
> >> > > > Another important benefit of this is that the WAL code need only
> >> > > > kick in for operations that are less than 4K rather than the current 64K.
> >> > > > This is a big reduction in write-amplification for these
> >> > > > operations which should translate directly into improved
> >> > > > throughput, especially for such benchmark critical areas as random 4K
> >> writes...
> >> > > >
> >> > > > While not terribly useful on hybrid or HDD systems, the bitmap
> >> > > > based code has MUCH shorter CPU paths than does the current code.
> >> > > > On an all flash OSD system this will directly translate into more
> >> > > > performance (quantity unknown of course).
> >> > > >
> >> > > > While the memory consumption reduction is nice, for me the
> >> > > > significant performance improvement implied by virtual elimination
> >> > > > of WAL is the compelling factor.
> >> > >
> >> > > I wouldn't conflate the allcoation size and freelist representation;
> >> > > we get the same avoidance of the WAL path with the current code by
> >> > > changing min_alloc_size to 4k.  Making the freelist represntation
> >> > > more efficient is important for small block sizes, but *any*
> >> > > memory-efficient strategy is fine (and even the current one is
> >> > > probably fine for most workloads).  For example, we could keep an
> >> > > extent-based representation and page in regions instead...
> >> >
> >> > Perhaps I inartfully made my point. I just wanted to say that if you
> >> > set min_alloc_size to 4K you avoid the WAL stuff but you spend more
> >> > memory, in the worst case the memory consumption would be 16 * 320MB
> >> > => 5GB per TB of storage. While I agree that the true worst-case
> >> > pattern requires a pathological use-case, I am concerned that normal
> >> > use-cases will still consume unreasonably large amounts of memory --
> >> > leading to unreliable systems.
> >> >
> >> > I believe that we simply don't want to be using that much memory for
> >> > this part of the system. There are other tradeoffs (time, complexity,
> >> > latency, etc.) that could significantly reduce memory consumption.
> >> > Let's explore these.
> >>
> >> Agreed.  :)
> >>
> >> > > The other thing to keep in mind is that the freelist is
> >> > > representated
> >> > > twice: once in memory in indexed form in StupidAllocator, and once
> >> > > in FreelistManager just to ensure it's persisted properly.  In the
> >> > > second case, I suspect we could leverage a custom rocksdb merge
> >> > > operator to avoid that representation entirely so that adjacent
> >> > > extents are coalesced when the sst is generated (when writing to l0
> >> > > or during compaction).  I'm guessing that functionality isn't present is ZS
> >> though?
> >> >
> >> > Not at present. But since I control the developers, that is something
> >> > that could be added. Clearly it's possible to address the global
> >> > serialization of KV commits if a different mechanism was available for
> >> > representing the allocation lists in the KV store. Having some kind of
> >> > merging primitive allows that to be done. I was going to raise exactly
> >> > this issue yesterday, but tabled it. Let's continue this conversation.
> >>
> >> I haven't really done my homework with the existing rocksdb merge
> >> operators to confirm that they would work in this way.  In particular, I think
> >> we want them to merge adjacent keys together (at least if we stick with the
> >> naive offset=length kv representation), and I'm afraid they might be
> >> intended to merge values with matching keys.  In any case, though, my hope
> >> would be that we'd settle on a single strategy that would work across both ZS
> >> and rocksdb as it'd simplify our life a bit.
> >>
> >> sage
> >
> > I just read the page on the RocksDB merge operator. I don't think it's really going to well with the exiting offset/size representation of the freelist.
> >
> > The merge operator is constrained to operating on a single key value. I suspect that trying to create a version of merge that would allow modification of the key would be very difficult and likely to be error prone (I can think of all sorts of interesting cases that would be ugly to add).
> >
> > One way out of this difficulty is to move to a non-compressed representation of the freelist. Suppose, in the limit, we created a key for each block. The value for that key would be one bit.
> >
> > In this case, we eliminate the need to commit KV operations "in order" because the KV entries for the freelist no longer create a coupling between otherwise independent KV transactions.
> >
> > Naturally, we don't want to actually do one bit per key, but by using the merge operators to simulate bitwise and/or we can easily create the equivalent of this per-bit independence when the bitmap is represented as a fixed string of bits per key. In other words, each KV key entry has a fixed portion of the bitmap (say 128 or 256 bits -- desired size is TBD) and the individual transaction do and'ing and or'ing of the bits using the general-case merge operator(s). Creating the functional equivalent of this kind of bitmask and'ing/or'ing as part of an atomic transaction should be relatively easy in ZetaScale.
> >
> > The larger KV/map seems like a pessimization from the current scheme, but I believe that this is illusory. The number of updates to the KV store is the same between the two schemes (pieces of a bitmap vs. size/offset entries) and the number of bytes being moved/touched is fairly similar. What is different is the reload time on startup -- but I think at the scales we're dealing with that this will be unimportant.
> >
> >
> >
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
