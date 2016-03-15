From: Sage Weil <sage@newdream.net>
Subject: Re: Adding compression support for bluestore.
Date: Tue, 15 Mar 2016 13:12:07 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
References: <56C1FCF3.4030505@mirantis.com> <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com> <56C3BAA3.3070804@mirantis.com> <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com> <56CDF40C.9060405@mirantis.com> <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com> <56D08E30.20308@mirantis.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1875399114-1458061930=:32086"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51216 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934816AbcCORM0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2016 13:12:26 -0400
In-Reply-To: <56D08E30.20308@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1875399114-1458061930=:32086
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 26 Feb 2016, Igor Fedotov wrote:
> Allen,
> sounds good! Thank you.
> 
> Please find the updated proposal below. It extends proposed Block Map to
> contain "full tuple".
> Some improvements and better algorithm overview were added as well.
> 
> Preface:
> Bluestore keeps object content using a set of dispersed extents aligned by 64K
> (configurable param). It also permits gaps in object content i.e. it prevents
> storage space allocation for object data regions unaffected by user writes.
> A sort of following mapping is used for tracking stored object content
> disposition (actual current implementation may differ but representation below
> seems to be sufficient for our purposes):
> Extent Map
> {
> < logical offset 0 -> extent 0 'physical' offset, extent 0 size >
> ...
> < logical offset N -> extent N 'physical' offset, extent N size >
> }
> 
> 
> Compression support approach:
> The aim is to provide generic compression support allowing random object
> read/write.
> To do that compression engine to be placed (logically - actual implementation
> may be discussed later) on top of bluestore to "intercept" read-write requests
> and modify them as needed.

I think it is going to make the most sense to do the compression and 
decompression in _do_write and _do_read (or helpers), within 
bluestore--not in some layer that sits above it but communicates metadata 
down to it.

> The major idea is to split object content into variable sized logical blocks
> that are compressed independently. Resulting block offsets and sizes depends
> mostly on client writes spreading and block merging algorithm that compression
> engine can provide. Maximum size of each block to be limited ( MAX_BLOCK_SIZE,
> e.g. 4 Mb ) to prevent from huge block processing when handling
> read/overwrites.

bluestore_max_compressed_block or similar -- it should be a configurable 
value like everything else.
 
> Due to compression each block can potentially occupy smaller store space
> comparing to its original size. Each block is addressed using original data
> offset ( AKA 'logical offset' above ). After compression is applied each
> compressed block is written using the existing bluestore infra. Updated write
> request to the bluestore specifies the block's logical offset similar to the
> one from the original request but data length can be reduced.
> As a result stored object content:
> a) Has gaps
> b) Uses less space if compression was beneficial enough.
> 
> To track compressed content additional block mapping to be introduced:
> Block Map
> {
> < logical block offset, logical block size -> compression method, target
> offset, compressed size >
> ...
> < logical block offset, logical block size -> compression method, target
> offset, compressed size >
> }
> Note 1: Actually for the current proposal target offset is always equal to the
> logical one. It's crucial that compression doesn't perform complete
> address(offset) translation but simply brings "space saving holes" into
> existing object content layout. This eliminates the need for significant
> bluestore interface modifications.

I'm not sure I understand what the target offset field is needed for, 
then.  In practice, this will mean expanding bluestore_extent_t to have 
compression_type and decompressed_length fields.  The logical offset is 
the key in the block_map map<>...

> To effectively use store space one needs an additional ability from the
> bluestore interface - release logical extent within object content as well as
> underlying physical extents allocated for it. In fact current interface (Write
> request) allows to "allocate" ( by writing data) logical extent while leaving
> some of them "unallocated" (by omitting corresponding range). But there is no
> release procedure - move extent to "unallocated" space. Please note - this is
> mainly about logical extent - a region within object content. Means for
> allocate/release physical extents (regions at block device) are present.
> In case of compression such logical extent release is most probably paired
> with writing to the same ( but reduced ) extent. And it looks like there is no
> need for standalone "release" request. So the suggestion is to introduce
> extended write request (WRITE+RELEASE) that releases specified logical extent
> and writes new data block. The key parameters for the request are:
> DATA2WRITE_LOFFSET, DATA2WRITE_SIZE, RELEASED_EXTENT_LOFFSET,
> RELEASED_EXTENT_SIZE
> where:
> assert(DATA2WRITE_LOFFSET >= RELEASED_EXTENT_LOFFSET)
> assert(RELEASED_EXTENT_LOFFSET + RELEASED_EXTENT_SIZE >= DATA2WRITE_LOFFSET +
> DATA2WRITE_SIZE)

I'm not following this.  You can logically release a range with zero() (it 
will mostly deallocate extents, but write zeros into a partial extent).  
But it sounds like this is only needed if you want to manage the 
compressed extents above BlueStore... which I think is going to be a more 
difficult approach.
 
> Due to the fact that bluestore infrastructure tracks extents with some
> granularity (bluestore_min_alloc_size, 64Kb by default)
> RELEASED_EXTENT_LOFFSET & RELEASED_EXTENT_SIZE should by aligned at
> bluestore_min_alloc_size boundary:
> assert(RELEASED_EXTENT_LOFFSET % min_alloc_size == 0);
> assert(RELEASED_EXTENT_SIZE % min_alloc_size == 0);
> 
> As a result compression engine gains a responsibility to properly handle cases
> when some blocks use the same bluestore allocation unit but aren't fully
> adjacent (see below for details).

The rest of this is mostly about overwrite policy, which should be pretty 
general regardless of where we implement.  I think the first and more 
important thing to sort out though is where we do it.

My current thinking is that we do something like:

- add a bluestore_extent_t flag for FLAG_COMPRESSED
- add uncompressed_length and compression_alg fields
(- add a checksum field we are at it, I guess)

- in _do_write, when we are writing a new extent, we need to compress it 
in memory (up to the max compression block), and feed that size into 
_do_allocate so we know how much disk space to allocate.  this is probably 
reasonably tricky to do, and handles just the simplest case (writing a new 
extent to a new object, or appending to an existing one, and writing the 
new data compressed).  The current _do_allocate interface and 
responsibilities will probably need to change quite a bit here.

- define the general (partial) overwrite strategy.  I would like for this 
to be part of the WAL strategy.  That is, we do the read/modify/write as 
deferred work for the partial regions that overlap existing extents.  
Then _do_wal_op would read the compressed extent, merge it with the new 
piece, and write out the new (compressed) extents.  The problem is that 
right now the WAL path *just* does IO--it doesn't do any kv 
metadata updates, which would be required here to do the final allocation 
(we won't know how big the resulting extent will be until we decompress 
the old thing, merge it with the new thing, and recompress).

But, we need to address this anyway to support CRCs (where we will 
similarly do a read/modify/write, calculate a new checksum, and need 
to update the onode).  I think the answer here is just that the _do_wal_op 
updates some in-memory-state attached to the wal operation that gets 
applied when the wal entry is cleaned up in _kv_sync_thread (wal_cleaning 
list).

Calling into the allocator in the WAL path will be more complicated than 
just updating the checksum in the onode, but I think it's doable.

The alternative is that we either

a) do the read side of the overwrite in the first phase of the op, 
before we commit it.  That will mean a higher commit latency and will slow 
down the pipeline, but would avoid the double-write of the overlap/wal 
regions.  Or,

b) we could just leave the overwritten extents alone and structure the 
block_map so that they are occluded.  This will 'leak' space for some 
write patterns, but that might be okay given that we can come back later 
and clean it up, or refine our strategy to be smarter.

What do you think?

It would be nice to choose a simpler strategy for the first pass that 
handles a subset of write patterns (i.e., sequential writes, possibly 
unaligned) that is still a step in the direction of the more robust 
strategy we expect to implement after that.

sage



> Overwrite request handling can be done following way:
> 0) Write request <logical offset(OFFS), Data Len(LEN)> is received by the
> compression engine.
> 1) Engine inspects the Block Map and checks if new block <OFFS, LEN>
> intersects with existing ones.
> Following cases for existing blocks are possible -
>   a) Detached
>   b) Adjacent
>   c) Partially overwritten
>   d) Completely overwritten
> 2) Engine retrieves(and decompresses if needed) content for existing blocks
> from case c) and, optionally, b). Blocks for case b) are handled if
> compression engine should provide block merge algorithm, i.e. it has to merge
> adjacent blocks to decrease block fragmentation. There are two options here
> with regard to what to be considered as adjacent. The first is a regular
> notion (henceforth - fully adjacent) - blocks are next to each other and there
> are no holes between them. The second is that blocks are adjacent when they
> are either fully adjacent or reside in the same (or probably neighboring)
> bluestore allocation unit(s). It looks like the second notion provides better
> space reuse and simplifies handling the case when blocks reside at the same
> allocation unit but are not fully adjacent. We can treat that the same manner
> as fully adjacent blocks. The cost is potential increase in amount of data
> overwrite request handling has to process (i.e.
> read/decompress/compress/write). But that's the general caveat if block merge
> is used.
> 3) Retrieved block contents and the new one are merged. Resulting block might
> have different logical offset/len pair: <OFFS_MERGED, LEN_MERGED>. If
> resulting block is longer than BLOCK_MAX_LEN it's broken up into smaller
> blocks that are processed independently in the same manner.
> 4) Generated block is compressed. Corresponding tuple <OFFS_MERGED,
> LEN_MERGED, LEN_COMPRESSED, ALG>.
> 5) Block map is updated: merged/overwritten blocks are removed - the generated
> ones are appended.
> 6) If generated block ( OFFS_MERGED, LEN_MERGED ) still shares bluestore
> allocation units with some existing blocks, e.g. if block merge algorithm
> isn't used(implemented), then overlapping regions to be excluded from the
> release procedure performed at step 8:
> if( shares_head )
>   RELEASE_EXTENT_OFFSET = ROUND_UP_TO( OFFS_MERGED, min_alloc_unit_size )
> else
>   RELEASE_EXTENT_OFFSET = ROUND_DOWN_TO( OFFS_MERGED, min_alloc_unit_size )
> if( shares_tail )
>   RELEASE_EXTENT_OFFSET_END = ROUND_DOWN_TO( OFFS_MERGED + LEN_MERGED,
> min_alloc_unit_size )
> else
>   RELEASE_EXTENT_OFFSET_END = ROUND_UP_TO( OFFS_MERGED + LEN_MERGED,
> min_alloc_unit_size )
> 
> Thus we might squeeze the extent to release if other blocks use that space.
> 
> 7) If compressed block ( OFFS_MERGED, LEN_COMPRESSED ) still shares bluestore
> allocation units with some existing blocks, e.g. if block merge algorithm
> isn't used(implemented), then overlapping regions (head and tail) to be
> written to bluestore using regular bluestore writes. HEAD_LEN & HEAD_TAIL
> bytes are written correspondingly.
> 8) The rest part of the new block should be written using above mentioned
> WRITE+RELEASE request. Following parameters to be used for the request:
> DATA2WRITE_LOFFSET = OFFS_MERGED + HEAD_LEN
> DATA2WRITE_SIZE = LEN_COMPRESSED - HEAD_LEN - TAIL_LEN
> RELEASED_EXTENT_LOFFSET = RELEASED_EXTENT_OFFSET
> RELEASED_EXTENT_SIZE =  RELEASE_EXTENT_OFFSET_END - RELEASE_EXTENT_OFFSET
> where:
> #define ROUND_DOWN_TO( a, size ) (a - a % size)
> 
> This way we release the extent corresponding to the newly generated block (
> except partially overlapping tail and head parts if any ) and write compressed
> block to the store that allocates a new extent.
> 
> Below is a sample of mappings transform. All values are in Kb.
> 1) Block merge is used.
> 
> Original Block Map
> {
>    0, 50 -> 0, 50 , No compress
>    140, 50 -> 140, 50, No Compress       ( will merge this block, partially
> overwritten )
>    255, 100 -> 255, 100, No Compress     ( will merge this block, implicitly
> adjacent )
>    512, 64 -> 512, 64, No Compress
> }
> 
> => Write ( 150, 100 )
> 
> New Block Map
> {
>    0, 50 -> 0, 50 Kb, No compress
>    140, 215 -> 140, 100, zlib   ( 215 Kb compressed into 100 Kb )
>    512, 64 -> 512, 64, No Compress
> }
> 
> Operations on the bluestore:
> READ( 140, 50)
> READ( 255, 100)
> WRITE-RELEASE( <140, 100>, <128, 256> )
> 
> 2) No block merge.
> 
> Original Block Map
> {
>    0, 50 -> 0, 50 , No compress
>    140, 50 -> 140, 50, No Compress
>    255, 100 -> 255, 100, No Compress
>    512, 64 -> 512, 64, No Compress
> }
> 
> => Write ( 150, 100 )
> 
> New Block Map
> {
>    0, 50 -> 0, 50 Kb, No compress
>    140, 110 -> 140, 110, No Compress
>    255, 100 -> 255, 100, No Compress
>    512, 64 -> 512, 64, No Compress
> }
> 
> Operations on the bluestore:
> READ(140, 50)
> WRITE-RELEASE( <140, 52>, <128, 64> )
> WRITE( <192, 58> )
> 
> 
> Any comments/suggestions are highly appreciated.
> 
> Kind regards,
> Igor.
> 
> 
> On 24.02.2016 21:43, Allen Samuels wrote:
> > w.r.t. (1) Except for "permanent" -- essentially yes. My central point is
> > that by having the full tuple you decouple the actual algorithm from its
> > persistent expression. In the example that you give, you have one
> > representation of the final result. There are other possible final results
> > (i.e., by RMWing some of the smaller chunks -- as you originally proposed).
> > You even have the option of doing the RMWing/compaction in a background
> > low-priority process (part of the scrub?).
> > 
> > You may be right about the effect of (2), but maybe not.
> > 
> > I agree that more discussion about checksums is useful. It's essential that
> > BlueStore properly augment device-level integrity checks.
> > 
> > Allen Samuels
> > Software Architect, Emerging Storage Solutions
> > 
> > 2880 Junction Avenue, Milpitas, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416
> > allen.samuels@SanDisk.com
> > 
> > 
> > -----Original Message-----
> > From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> > Sent: Wednesday, February 24, 2016 10:19 AM
> > To: Sage Weil <sage@newdream.net>; Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel <ceph-devel@vger.kernel.org>
> > Subject: Re: Adding compression support for bluestore.
> > 
> > Allen, Sage
> > 
> > thanks a lot for interesting input.
> > 
> > May I have some clarification and highlight some caveats though?
> > 
> > 1) Allen, are you suggesting to have permanent logical blocks layout
> > established after the initial writing?
> > Please find what I mean at the example below ( logical offset/size are
> > provided only for the sake of simplicity).
> > Imagine client has performed multiple writes that created following map
> > <logical offset, logical size>:
> > <0, 100>
> > <100, 50>
> > <150, 70>
> > <230, 70>
> > and an overwrite request <120,70> is coming.
> > The question is if resulting mapping to be the same or should be updated as
> > below:
> > <0,100>
> > <100, 20>    //updated extent
> > <120, 100> //new extent
> > <220, 10>   //updated extent
> > <230, 70>
> > 
> > 2) In fact "Application units" that write requests delivers to BlueStore are
> > pretty( or even completely) distorted by Ceph internals (Caching infra,
> > striping, EC). Thus there is a chance we are dealing with a broken picture
> > and suggested modification brings no/minor benefit.
> > 
> > 3) Sage - could you please elaborate the per-extent checksum use case - how
> > are we planing to use that?
> > 
> > Thanks,
> > Igor.
> > 
> > On 22.02.2016 15:25, Sage Weil wrote:
> > > On Fri, 19 Feb 2016, Allen Samuels wrote:
> > > > This is a good start to an architecture for performing compression.
> > > > 
> > > > I am concerned that it's a bit too simple at the expense of
> > > > potentially significant performance. In particular, I believe it's
> > > > often inefficient to force compression to be performed in block sizes
> > > > and alignments that may not match the application's usage.
> > > > 
> > > >    I think that extent mapping should be enhanced to include the full
> > > >    tuple: <Logical offset, Logical Size, Physical offset, Physical size,
> > > >    compression algo>
> > > I agree.
> > >    
> > > > With the full tuple, you can compress data in the natural units of
> > > > the application (which is most likely the size of the write operation
> > > > that you received) and on its natural alignment (which will eliminate
> > > > a lot of expensive-and-hard-to-handle partial overwrites) rather than
> > > > the proposal of a fixed size compression block on fixed boundaries.
> > > > 
> > > > Using the application's natural block size for performing compression
> > > > may allow you a greater choice of compression algorithms. For
> > > > example, if you're doing 1MB object writes, then you might want to be
> > > > using bzip-ish algorithms that have large compression windows rather
> > > > than the 32-K limited zlib algorithm or the 64-k limited snappy. You
> > > > wouldn't want to do that if all compression was limited to a fixed 64K
> > > > window.
> > > > 
> > > > With this extra information a number of interesting algorithm choices
> > > > become available. For example, in the partial-overwrite case you can
> > > > just delay recovering the partially overwritten data by having an
> > > > extent that overlaps a previous extent.
> > > Yep.
> > > 
> > > > One objection to the increased extent tuple is that amount of
> > > > space/memory it would consume. This need not be the case, the
> > > > existing BlueStore architecture stores the extent map in a serialized
> > > > format different from the in-memory format. It would be relatively
> > > > simple to create multiple serialization formats that optimize for the
> > > > typical cases of when the logical space is contiguous (i.e., logical
> > > > offset is previous logical offset + logical size) and when there's no
> > > > compression (logical size == physical size). Only the deserialized
> > > > in-memory format of the extent table has the fully populated tuples.
> > > > In fact this is a desirable optimization for the current bluestore
> > > > regardless of whether this compression proposal is adopted or not.
> > > Yeah.
> > > 
> > > The other bit we should probably think about here is how to store
> > > checksums.  In the compressed extent case, a simple approach would be
> > > to just add the checksum (either compressed, uncompressed, or both) to
> > > the extent tuple, since the extent will generally need to be read in
> > > its entirety anyway.  For uncompressed extents, that's not the case,
> > > and having an independent map of checksums over smaller block sizes
> > > makes sense, but that doesn't play well with the variable
> > > alignment/extent size approach.  I kind of sucks to have multiple
> > > formats here, but if we can hide it behind the in-memory
> > > representation and/or interface (so that, e.g., each extent has a
> > > checksum block size and a vector of checksums) we can optimize the
> > > encoding however we like without affecting other code.
> > > 
> > > sage
> > > 
> > > > Allen Samuels
> > > > Software Architect, Fellow, Systems and Software Solutions
> > > > 
> > > > 2880 Junction Avenue, San Jose, CA 95134
> > > > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: ceph-devel-owner@vger.kernel.org
> > > > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Igor Fedotov
> > > > Sent: Tuesday, February 16, 2016 4:11 PM
> > > > To: Haomai Wang <haomaiwang@gmail.com>
> > > > Cc: ceph-devel <ceph-devel@vger.kernel.org>
> > > > Subject: Re: Adding compression support for bluestore.
> > > > 
> > > > Hi Haomai,
> > > > Thanks for your comments.
> > > > Please find my response inline.
> > > > 
> > > > On 2/16/2016 5:06 AM, Haomai Wang wrote:
> > > > > On Tue, Feb 16, 2016 at 12:29 AM, Igor Fedotov <ifedotov@mirantis.com>
> > > > > wrote:
> > > > > > Hi guys,
> > > > > > Here is my preliminary overview how one can add compression support
> > > > > > allowing random reads/writes for bluestore.
> > > > > > 
> > > > > > Preface:
> > > > > > Bluestore keeps object content using a set of dispersed extents
> > > > > > aligned by 64K (configurable param). It also permits gaps in object
> > > > > > content i.e. it prevents storage space allocation for object data
> > > > > > regions unaffected by user writes.
> > > > > > A sort of following mapping is used for tracking stored object
> > > > > > content disposition (actual current implementation may differ but
> > > > > > representation below seems to be sufficient for our purposes):
> > > > > > Extent Map
> > > > > > {
> > > > > > < logical offset 0 -> extent 0 'physical' offset, extent 0 size >
> > > > > > ...
> > > > > > < logical offset N -> extent N 'physical' offset, extent N size > }
> > > > > > 
> > > > > > 
> > > > > > Compression support approach:
> > > > > > The aim is to provide generic compression support allowing random
> > > > > > object read/write.
> > > > > > To do that compression engine to be placed (logically - actual
> > > > > > implementation may be discussed later) on top of bluestore to
> > > > > > "intercept"
> > > > > > read-write requests and modify them as needed.
> > > > > > The major idea is to split object content into fixed size logical
> > > > > > blocks ( MAX_BLOCK_SIZE,  e.g. 1Mb). Blocks are compressed
> > > > > > independently. Due to compression each block can potentially occupy
> > > > > > smaller store space comparing to their original size. Each block is
> > > > > > addressed using original data offset ( AKA 'logical offset' above ).
> > > > > > After compression is applied each block is written using the
> > > > > > existing
> > > > > > bluestore infra. In fact single original write request may affect
> > > > > > multiple blocks thus it transforms into multiple sub-write requests.
> > > > > > Block logical offset, compressed block data and compressed data
> > > > > > length are the parameters for injected sub-write requests.
> > > > > > As a result stored object content:
> > > > > > a) Has gaps
> > > > > > b) Uses less space if compression was beneficial enough.
> > > > > > 
> > > > > > Overwrite request handling is pretty simple. Write request data is
> > > > > > splitted into fully and partially overlapping blocks. Fully
> > > > > > overlapping blocks are compressed and written to the store (given
> > > > > > the
> > > > > > extended write functionality described below). For partially
> > > > > > overwlapping blocks ( no more than 2 of them
> > > > > > - head and tail in general case)  we need to retrieve already stored
> > > > > > blocks, decompress them, merge the existing and received data into a
> > > > > > block, compress it and save to the store using new size.
> > > > > > The tricky thing for any written block is that it can be both longer
> > > > > > and shorter than previously stored one.  However it always has upper
> > > > > > limit
> > > > > > (MAX_BLOCK_SIZE) since we can omit compression and use original
> > > > > > block
> > > > > > if compression ratio is poor. Thus corresponding bluestore extent
> > > > > > for
> > > > > > this block is limited too and existing bluestore mapping doesn't
> > > > > > suffer: offsets are permanent and are equal to originally ones
> > > > > > provided by the caller.
> > > > > > The only extension required for bluestore interface is to provide an
> > > > > > ability to remove existing extents( specified by logical offset,
> > > > > > size). In other words we need write request semantics extension (
> > > > > > rather by introducing an additional extended write method).
> > > > > > Currently
> > > > > > overwriting request can either increase allocated space or leave it
> > > > > > unaffected only. And it can have arbitrary offset,size parameters
> > > > > > pair. Extended one should be able to squeeze store space ( e.g. by
> > > > > > removing existing extents for a block and allocating reduced set of
> > > > > > new ones) as well. And extended write should be applied to a
> > > > > > specific
> > > > > > block only, i.e. logical offset to be aligned with block start
> > > > > > offset
> > > > > > and size limited to MAX_BLOCK_SIZE. It seems this is pretty simple
> > > > > > to
> > > > > > add - most of the functionality for extent append/removal if already
> > > > > > present.
> > > > > > 
> > > > > > To provide reading and (over)writing compression engine needs to
> > > > > > track additional block mapping:
> > > > > > Block Map
> > > > > > {
> > > > > > < logical offset 0 -> compression method, compressed block 0 size >
> > > > > > ...
> > > > > > < logical offset N -> compression method, compressed block N size >
> > > > > > }
> > > > > > Please note that despite the similarity with the original bluestore
> > > > > > extent map the difference is in record granularity: 1Mb vs 64Kb.
> > > > > > Thus
> > > > > > each block mapping record might have multiple corresponding extent
> > > > > > mapping records.
> > > > > > 
> > > > > > Below is a sample of mappings transform for a pair of overwrites.
> > > > > > 1) Original mapping ( 3 Mb were written before, compress ratio 2 for
> > > > > > each
> > > > > > block)
> > > > > > Block Map
> > > > > > {
> > > > > >     0 -> zlib, 512Kb
> > > > > >     1Mb -> zlib, 512Kb
> > > > > >     2Mb -> zlib, 512Kb
> > > > > > }
> > > > > > Extent Map
> > > > > > {
> > > > > >     0 -> 0, 512Kb
> > > > > >     1Mb -> 512Kb, 512Kb
> > > > > >     2Mb -> 1Mb, 512Kb
> > > > > > }
> > > > > > 1.5Mb allocated [ 0, 1.5 Mb] range )
> > > > > > 
> > > > > > 1) Result mapping ( after overwriting 1Mb data at 512 Kb offset,
> > > > > > compress ratio 1 for both affected blocks) Block Map {
> > > > > >     0 -> none, 1Mb
> > > > > >     1Mb -> none, 1Mb
> > > > > >     2Mb -> zlib, 512Kb
> > > > > > }
> > > > > > Extent Map
> > > > > > {
> > > > > >     0 -> 1.5Mb, 1Mb
> > > > > >     1Mb -> 2.5Mb, 1Mb
> > > > > >     2Mb -> 1Mb, 512Kb
> > > > > > }
> > > > > > 2.5Mb allocated ( [1Mb, 3.5 Mb] range )
> > > > > > 
> > > > > > 2) Result mapping ( after (over)writing 3Mb data at 1Mb offset,
> > > > > > compress ratio 4 for all affected blocks) Block Map {
> > > > > >     0 -> none, 1Mb
> > > > > >     1Mb -> zlib, 256Kb
> > > > > >     2Mb -> zlib, 256Kb
> > > > > >     3Mb -> zlib, 256Kb
> > > > > > }
> > > > > > Extent Map
> > > > > > {
> > > > > >     0 -> 1.5Mb, 1Mb
> > > > > >     1Mb -> 0Mb, 256Kb
> > > > > >     2Mb -> 0.25Mb, 256Kb
> > > > > >     3Mb -> 0.5Mb, 256Kb
> > > > > > }
> > > > > > 1.75Mb allocated (  [0Mb-0.75Mb] [1.5 Mb, 2.5 Mb )
> > > > > > 
> > > > > Thanks for Igore!
> > > > > 
> > > > > Maybe I'm missing something, is it compressed inline not offline?
> > > > That's about inline compression.
> > > > > If so, I guess we need to provide with more flexible controls to
> > > > > upper, like explicate compression flag or compression unit.
> > > > Yes I agree. We need a sort of control for compression - on per object
> > > > or per pool basis...
> > > > But at the overview above I was more concerned about algorithmic aspect
> > > > i.e. how to implement random read/write handling for compressed objects.
> > > > Compression management from the user side can be considered a bit later.
> > > > 
> > > > > > Any comments/suggestions are highly appreciated.
> > > > > > 
> > > > > > Kind regards,
> > > > > > Igor.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > > ceph-devel"
> > > > > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > > > > info at  http://vger.kernel.org/majordomo-info.html
> > > > Thanks,
> > > > Igor
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org More majordomo info
> > > > at  http://vger.kernel.org/majordomo-info.html
> > > > PLEASE NOTE: The information contained in this electronic mail message
> > > > is intended only for the use of the designated recipient(s) named above.
> > > > If the reader of this message is not the intended recipient, you are
> > > > hereby notified that you have received this message in error and that
> > > > any review, dissemination, distribution, or copying of this message is
> > > > strictly prohibited. If you have received this communication in error,
> > > > please notify the sender by telephone or e-mail (as shown above)
> > > > immediately and destroy any and all copies of this message in your
> > > > possession (whether hard copies or electronically stored copies).
> > > > N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j ??f???h??????w???
> > ???j:+v???w???????? ????zZ+???????j"????i
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1875399114-1458061930=:32086--
