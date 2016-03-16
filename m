From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression support for bluestore.
Date: Wed, 16 Mar 2016 19:41:56 +0000
Message-ID: <BLUPR0201MB1890D5927BA82CC2E7ED7132E88A0@BLUPR0201MB1890.namprd02.prod.outlook.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bn0100.outbound.protection.outlook.com ([157.56.110.100]:61985
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755335AbcCPTmA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 15:42:00 -0400
In-Reply-To: <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Wednesday, March 16, 2016 2:28 PM
> To: Igor Fedotov <ifedotov@mirantis.com>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: Re: Adding compression support for bluestore.
> 
> On Wed, 16 Mar 2016, Igor Fedotov wrote:
> > On 15.03.2016 20:12, Sage Weil wrote:
> > > My current thinking is that we do something like:
> > >
> > > - add a bluestore_extent_t flag for FLAG_COMPRESSED
> > > - add uncompressed_length and compression_alg fields
> > > (- add a checksum field we are at it, I guess)
> > >
> > > - in _do_write, when we are writing a new extent, we need to
> > > compress it in memory (up to the max compression block), and feed
> > > that size into _do_allocate so we know how much disk space to
> > > allocate.  this is probably reasonably tricky to do, and handles
> > > just the simplest case (writing a new extent to a new object, or
> > > appending to an existing one, and writing the new data compressed).
> > > The current _do_allocate interface and responsibilities will probably need
> to change quite a bit here.
> > sounds good so far
> > > - define the general (partial) overwrite strategy.  I would like for
> > > this to be part of the WAL strategy.  That is, we do the
> > > read/modify/write as deferred work for the partial regions that overlap
> existing extents.
> > > Then _do_wal_op would read the compressed extent, merge it with the
> > > new piece, and write out the new (compressed) extents.  The problem
> > > is that right now the WAL path *just* does IO--it doesn't do any kv
> > > metadata updates, which would be required here to do the final
> > > allocation (we won't know how big the resulting extent will be until
> > > we decompress the old thing, merge it with the new thing, and
> recompress).
> > >
> > > But, we need to address this anyway to support CRCs (where we will
> > > similarly do a read/modify/write, calculate a new checksum, and need
> > > to update the onode).  I think the answer here is just that the
> > > _do_wal_op updates some in-memory-state attached to the wal
> > > operation that gets applied when the wal entry is cleaned up in
> > > _kv_sync_thread (wal_cleaning list).
> > >
> > > Calling into the allocator in the WAL path will be more complicated
> > > than just updating the checksum in the onode, but I think it's doable.
> > Could you please name the issues for calling allocator in WAL path?
> > Proper locking? What else?
> 
> I think this bit isn't so bad... we need to add another field to the in-memory
> wal_op struct that includes space allocated in the WAL stage, and make sure
> that gets committed by the kv thread for all of the wal_cleaning txc's.
> 
> > A potential issue with using WAL for compressed block overwrites is
> > significant WAL data volume increase. IIUC currently WAL record can
> > have up to 2*bluestore_min_alloc_size (i.e. 128K) client data per
> > single write request - overlapped head and tail.
> > In case of compressed blocks this will be up to
> > 2*bluestore_max_compressed_block ( i.e. 8Mb ) as you can't simply
> > overwrite fully overlapped extents - one should operate compression
> blocks now...
> >
> > Seems attractive otherwise...
> 
> I think the way to address this is to make bluestore_max_compressed_block
> *much* smaller.  Like, 4x or 8x min_alloc_size, but no more.  That gives us a
> smallish rounding error of "lost" efficiency, but keeps the size of extents we
> have to read+decompress in the overwrite or small read cases reasonable.
> 

Yes, this is generally what people do.  It's very hard to have a large compression window without having the CPU times balloon up.

> The tradeoff is the onode_t's block_map gets bigger... but for a ~4MB it's still
> only 5-10 records, which sounds fine to me.
> 
> > > The alternative is that we either
> > >
> > > a) do the read side of the overwrite in the first phase of the op,
> > > before we commit it.  That will mean a higher commit latency and
> > > will slow down the pipeline, but would avoid the double-write of the
> > > overlap/wal regions.  Or,
> > This is probably the simplest approach without hidden caveats but
> > latency increase.
> > >
> > > b) we could just leave the overwritten extents alone and structure
> > > the block_map so that they are occluded.  This will 'leak' space for
> > > some write patterns, but that might be okay given that we can come
> > > back later and clean it up, or refine our strategy to be smarter.
> > Just to clarify I understand the idea properly. Are you suggesting to
> > simply write out new block to a new extent and update block map (and
> > read procedure) to use that new extent or remains of the overwritten
> > extents depending on the read offset? And overwritten extents are
> > preserved intact until they are fully hidden or some background cleanup
> procedure merge them.
> > If so I can see following pros and cons:
> > + write is faster
> > - compressed data read is potentially slower as you might need to
> > decompress more compressed blocks.
> > - space usage is higher
> > - need for garbage collector i.e. additional complexity
> >
> > Thus the question is what use patterns are at foreground and should be
> > the most effective.
> > IMO read performance and space saving are more important for the cases
> > where compression is needed.
> >
> > > What do you think?
> > >
> > > It would be nice to choose a simpler strategy for the first pass
> > > that handles a subset of write patterns (i.e., sequential writes,
> > > possibly
> > > unaligned) that is still a step in the direction of the more robust
> > > strategy we expect to implement after that.
> > >
> > I'd probably agree but.... I don't see a good way how one can
> > implement compression for specific write patterns only.
> > We need to either ensure that these patterns are used exclusively (
> > append only / sequential only flags? ) or provide some means to fall
> > back to regular mode when inappropriate write occurs.
> > Don't think both are good and/or easy enough.
> 
> Well, if we simply don't implement a garbage collector, then for
> sequential+aligned writes we don't end up with stuff that needs garbage
> collection.  Even the sequential case might be doable if we make it possible
> to fill the extent with a sequence of compressed strings (as long as we
> haven't reached the compressed length, try to restart the decompression
> stream).
> 
> > In this aspect my original proposal to have compression engine more or
> > less segregated from the bluestore seems more attractive - there is no
> > need to refactor bluestore internals in this case. One can easily
> > start using compression or drop it and fall back to the current code
> > state. No significant modifications in run-time data structures and
> algorithms....
> 
> It sounds like in theory, but when I try to sort out how it would actually work,
> it seems like you have to either expose all of the block_map metadata up to
> this layer, at which point you may as well do it down in BlueStore and have
> the option of deferred WAL work, or you do something really simple with
> fixed compression block sizes and get a weak final result.  Not to mention the
> EC problems (although some of that will go away when EC overwrites come
> along)...
> 
> sage
