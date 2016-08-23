From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore blobs REVISITED
Date: Tue, 23 Aug 2016 11:44:57 -0500
Message-ID: <8f51e3e7-4f8f-3e6c-713f-a363038129ec@redhat.com>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608211601350.14754@piezo.us.to>
 <2F51EC8C-D280-4DFF-8FF6-4AC97071A7D5@sandisk.com>
 <BLUPR0201MB15245054714F66FC2AB92935E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222158190.25681@piezo.us.to>
 <BLUPR0201MB152454CA00246E35A1AE08C0E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222249560.25681@piezo.us.to>
 <BLUPR0201MB1524C52747AF115A4C178D0FE8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231548080.25678@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754112AbcHWQpB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 12:45:01 -0400
In-Reply-To: <alpine.DEB.2.11.1608231548080.25678@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 08/23/2016 11:02 AM, Sage Weil wrote:
> I just got the onode, including the full lextent map, down to ~1500 bytes.
> The lextent map encoding optimizations went something like this:
>
> - 1 blobid bit to indicate that this lextent starts where the last one
> ended. (6500->5500)
>
> - 1 blobid bit to indicate offset is 0; 1 blobid bit to indicate length is
> same as previous lextent.  (5500->3500)
>
> - make blobid signed (1 bit) and delta encode relative to previous blob.
> (3500->1500).  In practice we'd get something between 1500 and 3500
> because blobids won't have as much temporal locality as my test workload.
> OTOH, this is really important because blobids will also get big over time
> (we don't (yet?) have a way to reuse blobids and/or keep them unique to a
> hash key, so they grow as the osd ages).
>
> https://github.com/liewegas/ceph/blob/wip-bluestore-blobwise/src/os/bluestore/bluestore_types.cc#L826
>
> This makes the metadata update for a 4k write look like
>
>   1500 byte onode update
>   20 byte blob update
>   182 byte + 847(*) byte omap updates (pg log)
>
>   * pg _info key... def some room for optimization here I think!
>
> In any case, this is pretty encouraging.  I think we have a few options:
>
> 1) keep extent map in onode and (re)encode fully each time (what I have
> now).  blobs live in their own keys.
>
> 2) keep extent map in onode but shard it in memory and only reencode the
> part(s) that get modified.  this will alleviate the cpu concerns around a
> more complex encoding.  no change to on-disk format.
>
> 3) join lextents and blobs (Allen's proposal) and dynamically bin based on
> the encoded size.
>
> 4) #3, but let shard_size=0 in onode (or whatever) put it inline with
> onode, so that simple objects avoid any additional kv op.
>
> I currently like #2 for its simplicity, but I suspect we'll need to try
> #3/#4 too.

I was gravitating toward #2 right before I read the above line fwiw.  I 
think the idea to try 3/4 is a good one though.  There's enough 
complexity in all of this that I think we're (at some level) just 
guessing until we actually have some rocksdb and perf data to look at 
regarding actual IO activity and CPU usage.

Mark

>
> sage
>
>
> On Mon, 22 Aug 2016, Allen Samuels wrote:
>
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sweil@redhat.com]
>>> Sent: Monday, August 22, 2016 6:55 PM
>>> To: Allen Samuels <Allen.Samuels@sandisk.com>
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: RE: bluestore blobs REVISITED
>>>
>>> On Mon, 22 Aug 2016, Allen Samuels wrote:
>>>>> -----Original Message-----
>>>>> From: Sage Weil [mailto:sweil@redhat.com]
>>>>> Sent: Monday, August 22, 2016 6:09 PM
>>>>> To: Allen Samuels <Allen.Samuels@sandisk.com>
>>>>> Cc: ceph-devel@vger.kernel.org
>>>>> Subject: RE: bluestore blobs REVISITED
>>>>>
>>>>> On Mon, 22 Aug 2016, Allen Samuels wrote:
>>>>>> Another possibility is to "bin" the lextent table into known,
>>>>>> fixed, offset ranges. Suppose each oNode had a fixed range of LBA
>>>>>> keys associated with the lextent table: say [0..128K), [128K..256K), ...
>>>>>
>>>>> Yeah, I think that's the way to do it.  Either a set<uint32_t>
>>>>> lextent_key_offsets or uint64_t lextent_map_chunk_size to specify
>>>>> the granularity.
>>>>
>>>> Need to do some actual estimates on this scheme to make sure we're
>>>> actually landing on a real solution and not just another band-aid that
>>>> we have to rip off (painfully) at some future time.
>>>
>>> Yeah
>>>
>>>>>> It eliminates the need to put a "lower_bound" into the KV Store
>>>>>> directly. Though it'll likely be a bit more complex above and
>>>>>> somewhat less efficient.
>>>>>
>>>>> FWIW this is basically wat the iterator does, I think.  It's a
>>>>> separate rocksdb operation to create a snapshot to iterate over (and
>>>>> we don't rely on that feature anywhere).  It's still more expensive
>>>>> than raw gets just because it has to have fingers in all the levels
>>>>> to ensure that it finds all the keys for the given range, while get
>>>>> can stop once it finds a key or a tombstone (either in a cache or a higher
>>> level of the tree).
>>>>>
>>>>> But I'm not super thrilled about this complexity.  I still hope
>>>>> (wishfully?) we can get the lextent map small enough that we can
>>>>> leave it in the onode.  Otherwise we really are going to net +1 kv
>>>>> fetch for every operation (3, in the clone case... onode, then lextent,
>>> then shared blob).
>>>>
>>>> I don't see the feasibility of leaving the lextent map in the oNode.
>>>> It's just too big for the 4K random write case. I know that's not
>>>> indicative of real-world usage. But it's what people use to measure
>>>> systems....
>>>
>>> How small do you think it would need to be to be acceptable (in teh worst-
>>> case, 1024 4k lextents in a 4m object)?  2k?  3k?  1k?
>>>
>>> You're probably right, but I think I can still cut the full map encoding further.
>>> It was 6500, I did a quick tweak to get it to 5500, and I think I can drop another
>>> 1-2 bytes per entry for common cases (offset of 0, length == previous lextent
>>> length), which would get it under the 4k mark.
>>>
>>
>> I don't think there's a hard number on the size, but the fancy differential encoding is going to really chew up CPU time re-inflating it. All for the purpose of doing a lower-bound on the inflated data.
>>
>>>> BTW, w.r.t. lower-bound, my reading of the BloomFilter / Prefix stuff
>>>> suggests that it's would relatively trivial to ensure that
>>>> bloom-filters properly ignore the "offset" portion of an lextent key.
>>>> Meaning that I believe that a "lower_bound" operator ought to be
>>>> relatively easy to implement without triggering the overhead of a
>>>> snapshot, again, provided that you provided a custom bloom-filter
>>>> implementation that did the right thing.
>>>
>>> Hmm, that might help.  It may be that this isn't super significant, though,
>>> too... as I mentioned there is no snapshot involved with a vanilla iterator.
>>
>> Technically correct, however, the iterator is stated as providing a consistent view of the data, meaning that it has some kind of micro-snapshot equivalent associated with it -- which I suspect is where the extra expense comes in (it must bump an internal ref-count on the .sst files in the range of the iterator as well as some kind of filddling with the memtable). The lower_bound that I'm talking about ought not be any more expensive than a regular get would be (assuming the correct bloom filter behavior) it's just a tweak of the existing search logic for a regular Get operation (though I suspect there are some edge cases where you're exactly on the end of at .sst range, blah blah blah -- perhaps by providing only one of lower_bound or upper_bound (but not both) that extra edge case mig
 ht be eliminated)
>>
>>>
>>>> So the question is do we want to avoid monkeying with RocksDB and go
>>>> with a binning approach (TBD ensuring that this is a real solution to
>>>> the problem) OR do we bite the bullet and solve the lower-bound lookup
>>>> problem?
>>>>
>>>> BTW, on the "binning" scheme, perhaps the solution is just put the
>>>> current "binning value" [presumeably some log2 thing] into the oNode
>>>> itself -- it'll just be a byte. Then you're only stuck with the
>>>> complexity of deciding when to do a "split" if the current bin has
>>>> gotten too large (some arbitrary limit on size of the encoded
>>>> lexent-bin)
>>>
>>> I think simple is better, but it's annoying because one big bin means splitting
>>> all other bins, and we don't know when to merge without seeing all bin sizes.
>>
>> I was thinking of something simple. One binning value for the entire oNode. If you split, you have to read all of the lextents, re-bin them and re-write them -- which shouldn't be --that-- difficult to do.... Maybe we just ignore the un-split case [do it later ?].
>>
>>>
>>> sage
>>>
>>>
>>>>
>>>>>
>>>>> sage
>>>>>
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>>>>>> owner@vger.kernel.org] On Behalf Of Allen Samuels
>>>>>>> Sent: Sunday, August 21, 2016 10:27 AM
>>>>>>> To: Sage Weil <sweil@redhat.com>
>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>> Subject: Re: bluestore blobs REVISITED
>>>>>>>
>>>>>>> I wonder how hard it would be to add a "lower-bound" fetch like stl.
>>>>>>> That would allow the kv store to do the fetch without incurring
>>>>>>> the overhead of a snapshot for the iteration scan.
>>>>>>>
>>>>>>> Shared blobs were always going to trigger an extra kv fetch no
>>>>>>> matter
>>>>> what.
>>>>>>>
>>>>>>> Sent from my iPhone. Please excuse all typos and autocorrects.
>>>>>>>
>>>>>>>> On Aug 21, 2016, at 12:08 PM, Sage Weil <sweil@redhat.com>
>>> wrote:
>>>>>>>>
>>>>>>>>> On Sat, 20 Aug 2016, Allen Samuels wrote:
>>>>>>>>> I have another proposal (it just occurred to me, so it might
>>>>>>>>> not survive more scrutiny).
>>>>>>>>>
>>>>>>>>> Yes, we should remove the blob-map from the oNode.
>>>>>>>>>
>>>>>>>>> But I believe we should also remove the lextent map from the
>>>>>>>>> oNode and make each lextent be an independent KV value.
>>>>>>>>>
>>>>>>>>> However, in the special case where each extent --exactly--
>>>>>>>>> maps onto a blob AND the blob is not referenced by any other
>>>>>>>>> extent (which is the typical case, unless you're doing
>>>>>>>>> compression with strange-ish
>>>>>>>>> overlaps)
>>>>>>>>> -- then you encode the blob in the lextent itself and there's
>>>>>>>>> no separate blob entry.
>>>>>>>>>
>>>>>>>>> This is pretty much exactly the same number of KV fetches as
>>>>>>>>> what you proposed before when the blob isn't shared (the
>>>>>>>>> typical case)
>>>>>>>>> -- except the oNode is MUCH MUCH smaller now.
>>>>>>>>
>>>>>>>> I think this approach makes a lot of sense!  The only thing
>>>>>>>> I'm worried about is that the lextent keys are no longer known
>>>>>>>> when they are being fetched (since they will be a logical
>>>>>>>> offset), which means we'll have to use an iterator instead of a
>>> simple get.
>>>>>>>> The former is quite a bit slower than the latter (which can
>>>>>>>> make use of the rocksdb caches and/or key bloom filters more
>>> easily).
>>>>>>>>
>>>>>>>> We could augment your approach by keeping *just* the lextent
>>>>>>>> offsets in the onode, so that we know exactly which lextent
>>>>>>>> key to fetch, but then I'm not sure we'll get much benefit
>>>>>>>> (lextent metadata size goes down by ~1/3, but then we have an
>>>>>>>> extra get for
>>>>> cloned objects).
>>>>>>>>
>>>>>>>> Hmm, the other thing to keep in mind is that for RBD the
>>>>>>>> common case is that lots of objects have clones, and many of
>>>>>>>> those objects' blobs will be shared.
>>>>>>>>
>>>>>>>> sage
>>>>>>>>
>>>>>>>>> So for the non-shared case, you fetch the oNode which is
>>>>>>>>> dominated by the xattrs now (so figure a couple of hundred
>>>>>>>>> bytes and not much CPU cost to deserialize). And then fetch
>>>>>>>>> from the KV for the lextent (which is 1 fetch -- unless it
>>>>>>>>> overlaps two previous lextents). If it's the optimal case,
>>>>>>>>> the KV fetch is small (10-15 bytes) and trivial to
>>>>>>>>> deserialize. If it's an unshared/local blob then you're ready
>>>>>>>>> to go. If the blob is shared (locally or globally) then you'll have to go
>>> fetch that one too.
>>>>>>>>>
>>>>>>>>> This might lead to the elimination of the local/global blob
>>>>>>>>> thing (I think you've talked about that before) as now the only
>>> "local"
>>>>>>>>> blobs are the unshared single extent blobs which are stored
>>>>>>>>> inline with the lextent entry. You'll still have the special
>>>>>>>>> cases of promoting unshared
>>>>>>>>> (inline) blobs to global blobs -- which is probably similar
>>>>>>>>> to the current promotion "magic" on a clone operation.
>>>>>>>>>
>>>>>>>>> The current refmap concept may require some additional work.
>>>>>>>>> I believe that we'll have to do a reconstruction of the
>>>>>>>>> refmap, but fortunately only for the range of the current
>>>>>>>>> I/O. That will be a bit more expensive, but still less
>>>>>>>>> expensive than reconstructing the entire refmap for every
>>>>>>>>> oNode deserialization, Fortunately I believe the refmap is
>>>>>>>>> only really needed for compression cases or RBD cases
>>>>>>> without "trim"
>>>>>>>>> (this is the case to optimize -- it'll make trim really
>>>>>>>>> important for performance).
>>>>>>>>>
>>>>>>>>> Best of both worlds????
>>>>>>>>>
>>>>>>>>> Allen Samuels
>>>>>>>>> SanDisk |a Western Digital brand
>>>>>>>>> 2880 Junction Avenue, Milpitas, CA 95134
>>>>>>>>> T: +1 408 801 7030| M: +1 408 780 6416
>>>>>>>>> allen.samuels@SanDisk.com
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>>>>>>>>> owner@vger.kernel.org] On Behalf Of Allen Samuels
>>>>>>>>>> Sent: Friday, August 19, 2016 7:16 AM
>>>>>>>>>> To: Sage Weil <sweil@redhat.com>
>>>>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>>>>> Subject: RE: bluestore blobs
>>>>>>>>>>
>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>> From: Sage Weil [mailto:sweil@redhat.com]
>>>>>>>>>>> Sent: Friday, August 19, 2016 6:53 AM
>>>>>>>>>>> To: Allen Samuels <Allen.Samuels@sandisk.com>
>>>>>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>>>>>> Subject: RE: bluestore blobs
>>>>>>>>>>>
>>>>>>>>>>> On Fri, 19 Aug 2016, Allen Samuels wrote:
>>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>>> From: Sage Weil [mailto:sweil@redhat.com]
>>>>>>>>>>>>> Sent: Thursday, August 18, 2016 8:10 AM
>>>>>>>>>>>>> To: Allen Samuels <Allen.Samuels@sandisk.com>
>>>>>>>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>>>>>>>> Subject: RE: bluestore blobs
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Thu, 18 Aug 2016, Allen Samuels wrote:
>>>>>>>>>>>>>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-
>>>>> devel-
>>>>>>>>>>>>>>> owner@vger.kernel.org] On Behalf Of Sage Weil
>>>>>>>>>>>>>>> Sent: Wednesday, August 17, 2016 7:26 AM
>>>>>>>>>>>>>>> To: ceph-devel@vger.kernel.org
>>>>>>>>>>>>>>> Subject: bluestore blobs
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I think we need to look at other changes in addition to
>>>>>>>>>>>>>>> the encoding performance improvements.  Even if they
>>>>>>>>>>>>>>> end up being good enough, these changes are somewhat
>>>>>>>>>>>>>>> orthogonal and at
>>>>>>> least
>>>>>>>>>>>>>>> one of them should give us something that is even faster.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 1. I mentioned this before, but we should keep the
>>>>>>>>>>>>>>> encoding bluestore_blob_t around when we load the blob
>>>>>>>>>>>>>>> map.  If it's not changed, don't reencode it.  There
>>>>>>>>>>>>>>> are no blockers for implementing this
>>>>>>>>>>>>> currently.
>>>>>>>>>>>>>>> It may be difficult to ensure the blobs are properly
>>>>>>>>>>>>>>> marked
>>>>> dirty...
>>>>>>>>>>>>>>> I'll see if we can use proper accessors for the blob to
>>>>>>>>>>>>>>> enforce this at compile time.  We should do that anyway.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If it's not changed, then why are we re-writing it? I'm
>>>>>>>>>>>>>> having a hard time thinking of a case worth optimizing
>>>>>>>>>>>>>> where I want to re-write the oNode but the blob_map is
>>> unchanged.
>>>>>>>>>>>>>> Am I missing
>>>>>>>>>>> something obvious?
>>>>>>>>>>>>>
>>>>>>>>>>>>> An onode's blob_map might have 300 blobs, and a single
>>>>>>>>>>>>> write only updates one of them.  The other 299 blobs need
>>>>>>>>>>>>> not be reencoded, just
>>>>>>>>>>> memcpy'd.
>>>>>>>>>>>>
>>>>>>>>>>>> As long as we're just appending that's a good optimization.
>>>>>>>>>>>> How often does that happen? It's certainly not going to
>>>>>>>>>>>> help the RBD 4K random write problem.
>>>>>>>>>>>
>>>>>>>>>>> It won't help the (l)extent_map encoding, but it avoids
>>>>>>>>>>> almost all of the blob reencoding.  A 4k random write will
>>>>>>>>>>> update one blob out of
>>>>>>>>>>> ~100 (or whatever it is).
>>>>>>>>>>>
>>>>>>>>>>>>>>> 2. This turns the blob Put into rocksdb into two memcpy
>>>>> stages:
>>>>>>>>>>>>>>> one to assemble the bufferlist (lots of bufferptrs to
>>>>>>>>>>>>>>> each untouched
>>>>>>>>>>>>>>> blob) into a single rocksdb::Slice, and another memcpy
>>>>>>>>>>>>>>> somewhere inside rocksdb to copy this into the write
>>> buffer.
>>>>>>>>>>>>>>> We could extend the rocksdb interface to take an iovec
>>>>>>>>>>>>>>> so that the first memcpy isn't needed (and rocksdb will
>>>>>>>>>>>>>>> instead iterate over our buffers and copy them directly
>>>>>>>>>>>>>>> into its
>>>>> write buffer).
>>>>>>>>>>>>>>> This is probably a pretty small piece of the overall time...
>>>>>>>>>>>>>>> should verify with a profiler
>>>>>>>>>>>>> before investing too much effort here.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I doubt it's the memcpy that's really the expensive part.
>>>>>>>>>>>>>> I'll bet it's that we're transcoding from an internal to
>>>>>>>>>>>>>> an external representation on an element by element
>>>>>>>>>>>>>> basis. If the iovec scheme is going to help, it presumes
>>>>>>>>>>>>>> that the internal data structure essentially matches the
>>>>>>>>>>>>>> external data structure so that only an iovec copy is
>>>>>>>>>>>>>> required. I'm wondering how compatible this is with the
>>>>>>>>>>>>>> current concepts of
>>>>>>> lextext/blob/pextent.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm thinking of the xattr case (we have a bunch of
>>>>>>>>>>>>> strings to copy
>>>>>>>>>>>>> verbatim) and updated-one-blob-and-kept-99-unchanged
>>> case:
>>>>>>>>>>>>> instead of memcpy'ing them into a big contiguous buffer
>>>>>>>>>>>>> and having rocksdb memcpy
>>>>>>>>>>>>> *that* into it's larger buffer, give rocksdb an iovec so
>>>>>>>>>>>>> that they smaller buffers are assembled only once.
>>>>>>>>>>>>>
>>>>>>>>>>>>> These buffers will be on the order of many 10s to a
>>>>>>>>>>>>> couple 100s of
>>>>>>>>>> bytes.
>>>>>>>>>>>>> I'm not sure where the crossover point for constructing
>>>>>>>>>>>>> and then traversing an iovec vs just copying twice would be...
>>>>>>>>>>>>
>>>>>>>>>>>> Yes this will eliminate the "extra" copy, but the real
>>>>>>>>>>>> problem is that the oNode itself is just too large. I
>>>>>>>>>>>> doubt removing one extra copy is going to suddenly "solve"
>>>>>>>>>>>> this problem. I think we're going to end up rejiggering
>>>>>>>>>>>> things so that this will be much less of a problem than it is now
>>> -- time will tell.
>>>>>>>>>>>
>>>>>>>>>>> Yeah, leaving this one for last I think... until we see
>>>>>>>>>>> memcpy show up in the profile.
>>>>>>>>>>>
>>>>>>>>>>>>>>> 3. Even if we do the above, we're still setting a big
>>>>>>>>>>>>>>> (~4k or
>>>>>>>>>>>>>>> more?) key into rocksdb every time we touch an object,
>>>>>>>>>>>>>>> even when a tiny
>>>>>>>>>>>>
>>>>>>>>>>>> See my analysis, you're looking at 8-10K for the RBD
>>>>>>>>>>>> random write case
>>>>>>>>>>>> -- which I think everybody cares a lot about.
>>>>>>>>>>>>
>>>>>>>>>>>>>>> amount of metadata is getting changed.  This is a
>>>>>>>>>>>>>>> consequence of embedding all of the blobs into the
>>>>>>>>>>>>>>> onode (or bnode).  That seemed like a good idea early
>>>>>>>>>>>>>>> on when they were tiny (i.e., just an extent), but now
>>>>>>>>>>>>>>> I'm not so sure.  I see a couple of different
>>>>>>>>>>> options:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> a) Store each blob as ($onode_key+$blobid).  When we
>>>>>>>>>>>>>>> load the onode, load the blobs too.  They will
>>>>>>>>>>>>>>> hopefully be sequential in rocksdb (or definitely sequential
>>> in zs).
>>>>>>>>>>>>>>> Probably go back to using an
>>>>>>>>>>> iterator.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> b) Go all in on the "bnode" like concept.  Assign blob
>>>>>>>>>>>>>>> ids so that they are unique for any given hash value.
>>>>>>>>>>>>>>> Then store the blobs as $shard.$poolid.$hash.$blobid
>>>>>>>>>>>>>>> (i.e., where the bnode is now).  Then when clone
>>>>>>>>>>>>>>> happens there is no onode->bnode migration magic
>>>>>>>>>>>>>>> happening--we've already committed to storing blobs in
>>>>>>>>>>>>>>> separate keys.  When we load the onode, keep the
>>>>>>>>>>>>>>> conditional bnode loading we already have.. but when
>>>>>>>>>>>>>>> the bnode is loaded load up all the blobs for the hash
>>>>>>>>>>>>>>> key.  (Okay, we could fault in blobs individually, but
>>>>>>>>>>>>>>> that code will be more
>>>>>>>>>>>>>>> complicated.)
>>>>>>>>>>>>
>>>>>>>>>>>> I like this direction. I think you'll still end up demand
>>>>>>>>>>>> loading the blobs in order to speed up the random read case.
>>>>>>>>>>>> This scheme will result in some space-amplification, both
>>>>>>>>>>>> in the lextent and in the blob-map, it's worth a bit of
>>>>>>>>>>>> study too see how bad the metadata/data ratio becomes
>>>>>>>>>>>> (just as a guess, $shard.$poolid.$hash.$blobid is probably
>>>>>>>>>>>> 16 +
>>>>>>>>>>>> 16 + 8 + 16 bytes in size, that's ~60 bytes of key for
>>>>>>>>>>>> each Blob
>>>>>>>>>>>> -- unless your KV store does path compression. My reading
>>>>>>>>>>>> of RocksDB sst file seems to indicate that it doesn't, I
>>>>>>>>>>>> *believe* that ZS does [need to confirm]). I'm wondering
>>>>>>>>>>>> if the current notion
>>>>>>> of local vs.
>>>>>>>>>>>> global blobs isn't actually beneficial in that we can give
>>>>>>>>>>>> local blobs different names that sort with their
>>>>>>>>>>>> associated oNode (which probably makes the space-amp
>>>>>>>>>>>> worse) which is an important optimization. We do need to
>>>>>>>>>>>> watch the space amp, we're going to be burning DRAM to
>>>>>>>>>>>> make KV accesses cheap and the amount of DRAM
>>>>>>> is
>>>>>>>>>> proportional to the space amp.
>>>>>>>>>>>
>>>>>>>>>>> I got this mostly working last night... just need to sort
>>>>>>>>>>> out the clone case (and clean up a bunch of code).  It was
>>>>>>>>>>> a relatively painless transition to make, although in its
>>>>>>>>>>> current form the blobs all belong to the bnode, and the
>>>>>>>>>>> bnode if ephemeral but remains in
>>>>>>>>>> memory until all referencing onodes go away.
>>>>>>>>>>> Mostly fine, except it means that odd combinations of clone
>>>>>>>>>>> could leave lots of blobs in cache that don't get trimmed.
>>>>>>>>>>> Will address that
>>>>>>> later.
>>>>>>>>>>>
>>>>>>>>>>> I'll try to finish it up this morning and get it passing tests and
>>> posted.
>>>>>>>>>>>
>>>>>>>>>>>>>>> In both these cases, a write will dirty the onode
>>>>>>>>>>>>>>> (which is back to being pretty small.. just xattrs and
>>>>>>>>>>>>>>> the lextent
>>>>>>>>>>>>>>> map) and 1-3 blobs (also
>>>>>>>>>>>>> now small keys).
>>>>>>>>>>>>
>>>>>>>>>>>> I'm not sure the oNode is going to be that small. Looking
>>>>>>>>>>>> at the RBD random 4K write case, you're going to have 1K
>>>>>>>>>>>> entries each of which has an offset, size and a blob-id
>>>>>>>>>>>> reference in them. In my current oNode compression scheme
>>>>>>>>>>>> this compresses to about 1 byte
>>>>>>> per entry.
>>>>>>>>>>>> However, this optimization relies on being able to cheaply
>>>>>>>>>>>> renumber the blob-ids, which is no longer possible when
>>>>>>>>>>>> the blob-ids become parts of a key (see above). So now
>>>>>>>>>>>> you'll have a minimum of 1.5-3 bytes extra for each
>>>>>>>>>>>> blob-id (because you can't assume that the blob-ids
>>>>>>>>>>> become "dense"
>>>>>>>>>>>> anymore) So you're looking at 2.5-4 bytes per entry or
>>>>>>>>>>>> about 2.5-4K Bytes of lextent table. Worse, because of the
>>>>>>>>>>>> variable length encoding you'll have to scan the entire
>>>>>>>>>>>> table to deserialize it (yes, we could do differential
>>>>>>>>>>>> editing when we write but that's another
>>>>>>>>>> discussion).
>>>>>>>>>>>> Oh and I forgot to add the 200-300 bytes of oNode and xattrs
>>> :).
>>>>>>>>>>>> So while this looks small compared to the current ~30K for
>>>>>>>>>>>> the entire thing oNode/lextent/blobmap, it's NOT a huge
>>>>>>>>>>>> gain over 8-10K of the compressed oNode/lextent/blobmap
>>>>>>>>>>>> scheme that I
>>>>>>> published earlier.
>>>>>>>>>>>>
>>>>>>>>>>>> If we want to do better we will need to separate the
>>>>>>>>>>>> lextent from the oNode also. It's relatively easy to move
>>>>>>>>>>>> the lextents into the KV store itself (there are two
>>>>>>>>>>>> obvious ways to deal with this, either use the native
>>>>>>>>>>>> offset/size from the lextent itself OR create 'N' buckets
>>>>>>>>>>>> of logical offset into which we pour entries -- both of
>>>>>>>>>>>> these would add somewhere between 1 and 2 KV look-ups
>>>>>>> per
>>>>>>>>>>>> operation
>>>>>>>>>>>> -- here is where an iterator would probably help.
>>>>>>>>>>>>
>>>>>>>>>>>> Unfortunately, if you only process a portion of the
>>>>>>>>>>>> lextent (because you've made it into multiple keys and you
>>>>>>>>>>>> don't want to load all of
>>>>>>>>>>>> them) you no longer can re-generate the refmap on the fly
>>>>>>>>>>>> (another key space optimization). The lack of refmap
>>>>>>>>>>>> screws up a number of other important algorithms -- for
>>>>>>>>>>>> example the overlapping blob-map
>>>>>>>>>> thing, etc.
>>>>>>>>>>>> Not sure if these are easy to rewrite or not -- too
>>>>>>>>>>>> complicated to think about at this hour of the evening.
>>>>>>>>>>>
>>>>>>>>>>> Yeah, I forgot about the extent_map and how big it gets.  I
>>>>>>>>>>> think, though, that if we can get a 4mb object with 1024 4k
>>>>>>>>>>> lextents to encode the whole onode and extent_map in under
>>>>>>>>>>> 4K that will be good enough.  The blob update that goes
>>>>>>>>>>> with it will be ~200 bytes, and benchmarks aside, the 4k
>>>>>>>>>>> random write 100% fragmented object is a worst
>>>>>>>>>> case.
>>>>>>>>>>
>>>>>>>>>> Yes, it's a worst-case. But it's a
>>>>>>>>>> "worst-case-that-everybody-looks-at" vs. a
>>>>>>>>>> "worst-case-that-almost-
>>>>>>> nobody-looks-at".
>>>>>>>>>>
>>>>>>>>>> I'm still concerned about having an oNode that's larger than
>>>>>>>>>> a 4K
>>>>> block.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Anyway, I'll get the blob separation branch working and we
>>>>>>>>>>> can go from there...
>>>>>>>>>>>
>>>>>>>>>>> sage
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>> ceph-devel" in the body of a message to
>>>>>>>>>> majordomo@vger.kernel.org More majordomo info at
>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-
>>> devel"
>>>>>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>>>> majordomo
>>>>>>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>
>>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> ceph-devel" in the body of a message to
>>>>>>> majordomo@vger.kernel.org More majordomo info at
>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
