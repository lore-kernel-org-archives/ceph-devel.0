From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Wed, 16 Mar 2016 21:34:15 +0300
Message-ID: <56E9A727.1030400@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36573 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934941AbcCPSeK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 14:34:10 -0400
Received: by mail-lf0-f46.google.com with SMTP id l83so25925079lfd.3
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 11:34:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage, Allen,

thanks a lot for your feedback.
Please find my comments inline.

On 15.03.2016 20:12, Sage Weil wrote:
> On Fri, 26 Feb 2016, Igor Fedotov wrote:
>> Allen,
>> sounds good! Thank you.
>>
>> Please find the updated proposal below. It extends proposed Block Map to
>> contain "full tuple".
>> Some improvements and better algorithm overview were added as well.
>>
>> Preface:
>> Bluestore keeps object content using a set of dispersed extents aligned by 64K
>> (configurable param). It also permits gaps in object content i.e. it prevents
>> storage space allocation for object data regions unaffected by user writes.
>> A sort of following mapping is used for tracking stored object content
>> disposition (actual current implementation may differ but representation below
>> seems to be sufficient for our purposes):
>> Extent Map
>> {
>> < logical offset 0 -> extent 0 'physical' offset, extent 0 size >
>> ...
>> < logical offset N -> extent N 'physical' offset, extent N size >
>> }
>>
>>
>> Compression support approach:
>> The aim is to provide generic compression support allowing random object
>> read/write.
>> To do that compression engine to be placed (logically - actual implementation
>> may be discussed later) on top of bluestore to "intercept" read-write requests
>> and modify them as needed.
> I think it is going to make the most sense to do the compression and
> decompression in _do_write and _do_read (or helpers), within
> bluestore--not in some layer that sits above it but communicates metadata
> down to it.
My original intention was to minimize bluestore modifications needed to 
add compression support. Particularly this helps to avoid additional 
bluestore complication.
Another point for a segregation is a potential ability to move 
compression engine out of store level to a pool one in the future. 
Remember we still have 200% CPU utilization overhead for current 
approach with replicated pools as each replica is compressed independently.
Will proceed with monolithic design though...
>> The major idea is to split object content into variable sized logical blocks
>> that are compressed independently. Resulting block offsets and sizes depends
>> mostly on client writes spreading and block merging algorithm that compression
>> engine can provide. Maximum size of each block to be limited ( MAX_BLOCK_SIZE,
>> e.g. 4 Mb ) to prevent from huge block processing when handling
>> read/overwrites.
> bluestore_max_compressed_block or similar -- it should be a configurable
> value like everything else.
>   
100% agree
>> Due to compression each block can potentially occupy smaller store space
>> comparing to its original size. Each block is addressed using original data
>> offset ( AKA 'logical offset' above ). After compression is applied each
>> compressed block is written using the existing bluestore infra. Updated write
>> request to the bluestore specifies the block's logical offset similar to the
>> one from the original request but data length can be reduced.
>> As a result stored object content:
>> a) Has gaps
>> b) Uses less space if compression was beneficial enough.
>>
>> To track compressed content additional block mapping to be introduced:
>> Block Map
>> {
>> < logical block offset, logical block size -> compression method, target
>> offset, compressed size >
>> ...
>> < logical block offset, logical block size -> compression method, target
>> offset, compressed size >
>> }
>> Note 1: Actually for the current proposal target offset is always equal to the
>> logical one. It's crucial that compression doesn't perform complete
>> address(offset) translation but simply brings "space saving holes" into
>> existing object content layout. This eliminates the need for significant
>> bluestore interface modifications.
> I'm not sure I understand what the target offset field is needed for,
> then.  In practice, this will mean expanding bluestore_extent_t to have
> compression_type and decompressed_length fields.  The logical offset is
> the key in the block_map map<>...
Agree, target offset is probably redundant here
>> To effectively use store space one needs an additional ability from the
>> bluestore interface - release logical extent within object content as well as
>> underlying physical extents allocated for it. In fact current interface (Write
>> request) allows to "allocate" ( by writing data) logical extent while leaving
>> some of them "unallocated" (by omitting corresponding range). But there is no
>> release procedure - move extent to "unallocated" space. Please note - this is
>> mainly about logical extent - a region within object content. Means for
>> allocate/release physical extents (regions at block device) are present.
>> In case of compression such logical extent release is most probably paired
>> with writing to the same ( but reduced ) extent. And it looks like there is no
>> need for standalone "release" request. So the suggestion is to introduce
>> extended write request (WRITE+RELEASE) that releases specified logical extent
>> and writes new data block. The key parameters for the request are:
>> DATA2WRITE_LOFFSET, DATA2WRITE_SIZE, RELEASED_EXTENT_LOFFSET,
>> RELEASED_EXTENT_SIZE
>> where:
>> assert(DATA2WRITE_LOFFSET >= RELEASED_EXTENT_LOFFSET)
>> assert(RELEASED_EXTENT_LOFFSET + RELEASED_EXTENT_SIZE >= DATA2WRITE_LOFFSET +
>> DATA2WRITE_SIZE)
> I'm not following this.  You can logically release a range with zero() (it
> will mostly deallocate extents, but write zeros into a partial extent).
> But it sounds like this is only needed if you want to manage the
> compressed extents above BlueStore... which I think is going to be a more
> difficult approach.
Looks like I missed the ability to use zero() for extent release. Thus 
there is no need to introduce additional write+release request for any 
approach.

>   
>> Due to the fact that bluestore infrastructure tracks extents with some
>> granularity (bluestore_min_alloc_size, 64Kb by default)
>> RELEASED_EXTENT_LOFFSET & RELEASED_EXTENT_SIZE should by aligned at
>> bluestore_min_alloc_size boundary:
>> assert(RELEASED_EXTENT_LOFFSET % min_alloc_size == 0);
>> assert(RELEASED_EXTENT_SIZE % min_alloc_size == 0);
>>
>> As a result compression engine gains a responsibility to properly handle cases
>> when some blocks use the same bluestore allocation unit but aren't fully
>> adjacent (see below for details).
> The rest of this is mostly about overwrite policy, which should be pretty
> general regardless of where we implement.  I think the first and more
> important thing to sort out though is where we do it.
>
> My current thinking is that we do something like:
>
> - add a bluestore_extent_t flag for FLAG_COMPRESSED
> - add uncompressed_length and compression_alg fields
> (- add a checksum field we are at it, I guess)
>
> - in _do_write, when we are writing a new extent, we need to compress it
> in memory (up to the max compression block), and feed that size into
> _do_allocate so we know how much disk space to allocate.  this is probably
> reasonably tricky to do, and handles just the simplest case (writing a new
> extent to a new object, or appending to an existing one, and writing the
> new data compressed).  The current _do_allocate interface and
> responsibilities will probably need to change quite a bit here.
sounds good so far
> - define the general (partial) overwrite strategy.  I would like for this
> to be part of the WAL strategy.  That is, we do the read/modify/write as
> deferred work for the partial regions that overlap existing extents.
> Then _do_wal_op would read the compressed extent, merge it with the new
> piece, and write out the new (compressed) extents.  The problem is that
> right now the WAL path *just* does IO--it doesn't do any kv
> metadata updates, which would be required here to do the final allocation
> (we won't know how big the resulting extent will be until we decompress
> the old thing, merge it with the new thing, and recompress).
>
> But, we need to address this anyway to support CRCs (where we will
> similarly do a read/modify/write, calculate a new checksum, and need
> to update the onode).  I think the answer here is just that the _do_wal_op
> updates some in-memory-state attached to the wal operation that gets
> applied when the wal entry is cleaned up in _kv_sync_thread (wal_cleaning
> list).
>
> Calling into the allocator in the WAL path will be more complicated than
> just updating the checksum in the onode, but I think it's doable.
Could you please name the issues for calling allocator in WAL path? 
Proper locking? What else?
A potential issue with using WAL for compressed block overwrites is 
significant WAL data volume increase. IIUC currently WAL record can have 
up to 2*bluestore_min_alloc_size (i.e. 128K) client data per single 
write request - overlapped head and tail.
In case of compressed blocks this will be up to 
2*bluestore_max_compressed_block ( i.e. 8Mb ) as you can't simply 
overwrite fully overlapped extents - one should operate compression 
blocks now...

Seems attractive otherwise...
>
> The alternative is that we either
>
> a) do the read side of the overwrite in the first phase of the op,
> before we commit it.  That will mean a higher commit latency and will slow
> down the pipeline, but would avoid the double-write of the overlap/wal
> regions.  Or,
This is probably the simplest approach without hidden caveats but 
latency increase.
>
> b) we could just leave the overwritten extents alone and structure the
> block_map so that they are occluded.  This will 'leak' space for some
> write patterns, but that might be okay given that we can come back later
> and clean it up, or refine our strategy to be smarter.
Just to clarify I understand the idea properly. Are you suggesting to 
simply write out new block to a new extent and update block map (and 
read procedure)  to use that new extent or remains of the overwritten 
extents depending on the read offset? And overwritten extents are 
preserved intact until they are fully hidden or some background cleanup 
procedure merge them.
If so I can see following pros and cons:
+ write is faster
- compressed data read is potentially slower as you might need to 
decompress more compressed blocks.
- space usage is higher
- need for garbage collector i.e. additional complexity

Thus the question is what use patterns are at foreground and should be 
the most effective.
IMO read performance and space saving are more important for the cases 
where compression is needed.

> What do you think?
>
> It would be nice to choose a simpler strategy for the first pass that
> handles a subset of write patterns (i.e., sequential writes, possibly
> unaligned) that is still a step in the direction of the more robust
> strategy we expect to implement after that.
>
I'd probably agree but.... I don't see a good way how one can implement 
compression for specific write patterns only.
We need to either ensure that these patterns are used exclusively ( 
append only / sequential only flags? ) or provide some means to fall 
back to regular mode when inappropriate write occurs.
Don't think both are good and/or easy enough.

In this aspect my original proposal to have compression engine more or 
less segregated from the bluestore seems more attractive - there is no 
need to refactor bluestore internals in this case. One can easily start 
using compression or drop it and fall back to the current code state. No 
significant modifications in run-time data structures and algorithms....

> sage
>
>
>
Thanks,
Igor
