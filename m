From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: BlueStore Performance issue
Date: Thu, 10 Mar 2016 21:11:24 +0000
Message-ID: <CY1PR0201MB18977BA5E2AAF614B439402CE8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com>
 <CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603091033200.14377@cpach.fuggernut.com>
 <CY1PR0201MB18972EAD3EAAC4CDC3BDC602E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603100839170.14377@cpach.fuggernut.com>
 <CY1PR0201MB1897D0D0D818B598F0EA85A6E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603101110071.14377@cpach.fuggernut.com>
 <CY1PR0201MB1897D24DAC3415BCBDFB3F72E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <CAN=+7FUk7QCOKU7Y5-O9SREbknR_UXDn7zbAA9QF5FdNTWsFfQ@mail.gmail.com>
 <alpine.DEB.2.11.1603101355560.14377@cpach.fuggernut.com>
 <CY1PR0201MB189759BA90A29B0365250873E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603101526430.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0082.outbound.protection.outlook.com ([157.56.111.82]:53418
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932231AbcCJVL2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 16:11:28 -0500
In-Reply-To: <alpine.DEB.2.11.1603101526430.14377@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, March 10, 2016 12:41 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Samuel Just <sjust@redhat.com>; ceph-devel@vger.kernel.org
> Subject: RE: BlueStore Performance issue
>
> On Thu, 10 Mar 2016, Allen Samuels wrote:
> > > > I think this does avoid the issue of needing to serialize the
> > > > transactions just before submission, but I don't think it actually
> > > > gets us anything else.
> >
> > I believe deserializing the KV commits will be an important capability.
> > It's likely to be needed to properly do QoS. Even a poor-man's QoS
> > (think HDD) will want to be able to reorder small vs. large
> > transactions. This gets difficult to do without deserialization of the
> > KV commits.
>
> FWIW our assumption so far is that we would not want to do any reordering
> at this layer, and instead do QoS by controlling dispatch from the op wq.
>

Fair enough, it'll provide a cruder level of control, but perhaps that's acceptable.

>
> > > For example: each worker thread preallocates some space and doles it
> out in
> > > each transaction.  Persistence is done via someting analogous (or the
> same
> > > as) the WAL records:
> > >
> > >  - preallocate record removes some space from the freelist, and writes
> out a
> > > preallocate record with teh same extent.  we keep this in memory,
> divvied
> > > up between worker threads, or whatever.
> > >  - each transaction commits with an extra allocate record that commits
> space
> > > from the preallocate extent list
> > >  - the next time we preallocate space, or when we do wal cleanup, or on
> > > some other period, we compact the preallocate add/remove records.
> > >
> > > Something along those lines. Basically, we do short-term inserts on a per-
> > > extent allocated basis and defer the extent merging a bit so that it can be
> > > batched up.
> > >
> >
> > I think you can avoid ANY form of KV mutation for the allocator itself.
> > That's exactly what you're doing with the current "duplicate" copy
> > within StupidAllocator.
> >
> > Preallocation works well, I wouldn't have thought that the preallocation
> > mechanism would require persistence. What am I missing here?
>
> Assume the in-memory Allocator is optimized and threaded and is able to
> make a decision.  We still want parallel threads to persist that an
> allocation has been made.  Because they aren't serialized, FreelistManager
> can't do what it does now to update the offset=length keys.  Assuming for
> a moment that we don't do any weird merge operators either, we have to do
> something else.

Why do you need to persist the allocation prior to the KV commit? Seems to me that as long as the freelist commit is part of the same KV transaction you're covered. What am I missing?

>
> Hmm, and now that I'm writing it down, I think the preallocate step I
> mentioned before is unnecessary.  I think it's as simple as this:
>
> 1/ Each transaction that allocations something includes a record like
>
>   allocate_$unique = list of extents
>
> This is done per-worker, in parallel.
>
> 2/ Periodically, we commit a transaction that deletes a bunch of
> allocate_* records and updates the freelist accordingly.  This is
> serialized with other freelist updates, but it's not in the path for any
> actual allocations.
>
> Notably, this is almost exactly what already happens for deallocates via
> the WAL records:
>
> - the wal_transaction_t has a 'released' list of extents
> - when we do wal cleanup (i.e., delete the wal records because they've
> been applied), we roll the released extents into the freelist.
>
> We could accomplish the above by adding an allocated record to
> wal_transaction_t, and then any op that does an allocation would
> get a wal record and it'd get cleaned up in the normal way.
>
> I suppose if we decided wal_transaction_t is too heavyweight we could
> optimize things, but if that's the case we should fix the wal overhead :)
>

There are lots of ways of breaking the dependence on the way that allocations are stored today. This is one. You can also go with a delta journal and periodic compaction, just like the BlueFS metadata. The merge operator/bitmap is another way. The bitmap scheme seems the simplest to my mind, that's why I proposed it first. I actually did think through the BlueFs-like scheme as well as what you proposed above and concluded that the bitmap approach is just as good and lots easier to implement/stabilize -- but a lot of that decision is based on my belief that I can construct auxiliary searching data structures for a bitmap-based freelist that will yield an allocator that is just as good as the extent-based approach that's been adopted. I think I need to flesh out that allocator before I can w
 in you over to my way of thinking about this.

Let me do that in a different e-mail thread (this one is getting waaay too long). It might be a day or so before I can do that.

allen


> sage
>
>
>
> >
> > I do think that the allocator is a much harder problem in the HDD world
> > than in the Flash world -- especially with pre-allocation. To the extent
> > that I understand the current scheme, it seems to prioritize the sizes
> > of extents over the addresses of extents. Seems to me that there are
> > lots of patterns where more seeking will be generated than is needed.
> >
> > > sage
> > >
> > >
> > > > -Sam
> > > >
> > > > On Thu, Mar 10, 2016 at 10:18 AM, Allen Samuels
> > > > <Allen.Samuels@sandisk.com> wrote:
> > > > >> -----Original Message-----
> > > > >> From: Sage Weil [mailto:sweil@redhat.com]
> > > > >> Sent: Thursday, March 10, 2016 8:13 AM
> > > > >> To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > > >> Cc: ceph-devel@vger.kernel.org
> > > > >> Subject: RE: BlueStore Performance issue
> > > > >>
> > > > >> On Thu, 10 Mar 2016, Allen Samuels wrote:
> > > > >> > > > Another important benefit of this is that the WAL code need
> > > > >> > > > only kick in for operations that are less than 4K rather than the
> > > current 64K.
> > > > >> > > > This is a big reduction in write-amplification for these
> > > > >> > > > operations which should translate directly into improved
> > > > >> > > > throughput, especially for such benchmark critical areas as
> > > > >> > > > random 4K
> > > > >> writes...
> > > > >> > > >
> > > > >> > > > While not terribly useful on hybrid or HDD systems, the
> > > > >> > > > bitmap based code has MUCH shorter CPU paths than does the
> > > current code.
> > > > >> > > > On an all flash OSD system this will directly translate into
> > > > >> > > > more performance (quantity unknown of course).
> > > > >> > > >
> > > > >> > > > While the memory consumption reduction is nice, for me the
> > > > >> > > > significant performance improvement implied by virtual
> > > > >> > > > elimination of WAL is the compelling factor.
> > > > >> > >
> > > > >> > > I wouldn't conflate the allcoation size and freelist
> > > > >> > > representation; we get the same avoidance of the WAL path
> with
> > > > >> > > the current code by changing min_alloc_size to 4k.  Making the
> > > > >> > > freelist represntation more efficient is important for small
> > > > >> > > block sizes, but *any* memory-efficient strategy is fine (and
> > > > >> > > even the current one is probably fine for most workloads).  For
> > > > >> > > example, we could keep an extent-based representation and
> page
> > > in regions instead...
> > > > >> >
> > > > >> > Perhaps I inartfully made my point. I just wanted to say that if
> > > > >> > you set min_alloc_size to 4K you avoid the WAL stuff but you
> > > > >> > spend more memory, in the worst case the memory consumption
> > > would
> > > > >> > be 16 * 320MB => 5GB per TB of storage. While I agree that the
> > > > >> > true worst-case pattern requires a pathological use-case, I am
> > > > >> > concerned that normal use-cases will still consume unreasonably
> > > > >> > large amounts of memory -- leading to unreliable systems.
> > > > >> >
> > > > >> > I believe that we simply don't want to be using that much memory
> > > > >> > for this part of the system. There are other tradeoffs (time,
> > > > >> > complexity, latency, etc.) that could significantly reduce memory
> > > consumption.
> > > > >> > Let's explore these.
> > > > >>
> > > > >> Agreed.  :)
> > > > >>
> > > > >> > > The other thing to keep in mind is that the freelist is
> > > > >> > > representated
> > > > >> > > twice: once in memory in indexed form in StupidAllocator, and
> > > > >> > > once in FreelistManager just to ensure it's persisted properly.
> > > > >> > > In the second case, I suspect we could leverage a custom
> > > > >> > > rocksdb merge operator to avoid that representation entirely so
> > > > >> > > that adjacent extents are coalesced when the sst is generated
> > > > >> > > (when writing to l0 or during compaction).  I'm guessing that
> > > > >> > > functionality isn't present is ZS
> > > > >> though?
> > > > >> >
> > > > >> > Not at present. But since I control the developers, that is
> > > > >> > something that could be added. Clearly it's possible to address
> > > > >> > the global serialization of KV commits if a different mechanism
> > > > >> > was available for representing the allocation lists in the KV
> > > > >> > store. Having some kind of merging primitive allows that to be
> > > > >> > done. I was going to raise exactly this issue yesterday, but tabled
> it.
> > > Let's continue this conversation.
> > > > >>
> > > > >> I haven't really done my homework with the existing rocksdb merge
> > > > >> operators to confirm that they would work in this way.  In
> > > > >> particular, I think we want them to merge adjacent keys together
> > > > >> (at least if we stick with the naive offset=length kv
> > > > >> representation), and I'm afraid they might be intended to merge
> > > > >> values with matching keys.  In any case, though, my hope would be
> > > > >> that we'd settle on a single strategy that would work across both ZS
> and
> > > rocksdb as it'd simplify our life a bit.
> > > > >>
> > > > >> sage
> > > > >
> > > > > I just read the page on the RocksDB merge operator. I don't think it's
> > > really going to well with the exiting offset/size representation of the
> freelist.
> > > > >
> > > > > The merge operator is constrained to operating on a single key value.
> I
> > > suspect that trying to create a version of merge that would allow
> > > modification of the key would be very difficult and likely to be error
> prone (I
> > > can think of all sorts of interesting cases that would be ugly to add).
> > > > >
> > > > > One way out of this difficulty is to move to a non-compressed
> > > representation of the freelist. Suppose, in the limit, we created a key for
> > > each block. The value for that key would be one bit.
> > > > >
> > > > > In this case, we eliminate the need to commit KV operations "in
> order"
> > > because the KV entries for the freelist no longer create a coupling
> between
> > > otherwise independent KV transactions.
> > > > >
> > > > > Naturally, we don't want to actually do one bit per key, but by using
> the
> > > merge operators to simulate bitwise and/or we can easily create the
> > > equivalent of this per-bit independence when the bitmap is represented
> as a
> > > fixed string of bits per key. In other words, each KV key entry has a fixed
> > > portion of the bitmap (say 128 or 256 bits -- desired size is TBD) and the
> > > individual transaction do and'ing and or'ing of the bits using the general-
> case
> > > merge operator(s). Creating the functional equivalent of this kind of
> bitmask
> > > and'ing/or'ing as part of an atomic transaction should be relatively easy in
> > > ZetaScale.
> > > > >
> > > > > The larger KV/map seems like a pessimization from the current
> scheme,
> > > but I believe that this is illusory. The number of updates to the KV store is
> the
> > > same between the two schemes (pieces of a bitmap vs. size/offset
> entries)
> > > and the number of bytes being moved/touched is fairly similar. What is
> > > different is the reload time on startup -- but I think at the scales we're
> > > dealing with that this will be unimportant.
> > > > >
> > > > >
> > > > >
> > > > > PLEASE NOTE: The information contained in this electronic mail
> message
> > > is intended only for the use of the designated recipient(s) named above.
> If
> > > the reader of this message is not the intended recipient, you are hereby
> > > notified that you have received this message in error and that any
> review,
> > > dissemination, distribution, or copying of this message is strictly
> prohibited. If
> > > you have received this communication in error, please notify the sender
> by
> > > telephone or e-mail (as shown above) immediately and destroy any and
> all
> > > copies of this message in your possession (whether hard copies or
> > > electronically stored copies).
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > ceph-devel" in the body of a message to
> majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-
> info.html
> > > >
> > > >
> > PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If the
> reader of this message is not the intended recipient, you are hereby notified
> that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly prohibited. If
> you have received this communication in error, please notify the sender by
> telephone or e-mail (as shown above) immediately and destroy any and all
> copies of this message in your possession (whether hard copies or
> electronically stored copies).
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
