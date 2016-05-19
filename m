From: Sage Weil <sage@newdream.net>
Subject: Re: Initial proposal for bluestore compression control and
 statistics
Date: Thu, 19 May 2016 15:40:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605191520270.6221@cpach.fuggernut.com>
References: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47880 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbcESTjw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 15:39:52 -0400
In-Reply-To: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Igor!

On Thu, 19 May 2016, Igor Fedotov wrote:
> Hi cephers,
> 
> please find my initial proposal with regard to bluestore compression control
> and related statistics.
> 
> Any comments/thoughts are highly appreciated.
> 
> ==================================================================
> 
> COMPRESSION CONTROL OPTIONS
> 
> One can see following means to control  compression at BlueStore level.
> 
> 1) Per-store setting to enable/disable compression and specify default
> compression method
> 
> bluestore_compression = <zlib | snappy> / <force | optional | disable>
> 
> E.g.
> 
> bluestore_compression = zlib/force
> 
> The first token denotes default/applied compression algorithm.
> The second one:
> 
> 'force' - enables compression for any objects
> 
> 'optional' - burden the caller with the need to enable compression by
> different means (see below)
> 
> 'disable' - unconditionally disables any compression for the store.
> 
> This option is definitely useful for testing/debugging and has probably
> limited use in production.

Do we need the 'disable' option?  i.e., is there any difference between

 bluestore compression = snappy/disable

and

 bluestore compression =

Also, since we don't need to list multiple algorithms, we can probably 
just simplify this to be

 bluestore compression algorithm = snappy

and then

 bluestore compression = force | optional | disable

or maybe just

 bluestore compression force = true/false
 bluestore compression allow = true/false

with a check that prevents nonsensical (force + allow).  Right now we 
don't have a enum config option type (although we perhaps should).

> 2) Per-object compression specification. One should be able to enable/disable
> compression for specific object.
> 
> Following sub-option can be provided:
> 
>   a) Specify compression mode (along with disablement option) at object
> creation
> 
>   b) Specify compression mode at arbitrary moment via specific method/ioctl
> call. Compression to be applied for subsequent write requests
> 
>   c) Force object compression/decompression at arbitrary moment via specific
> method/ioctl call. Existing object content to be compressed/decompressed and
> appropriate mode to be set for subsequent write requests.
> 
>   d) Disable compression for short-lived objects if corresponding hint has
> been provided via set_alloc_hint2 call. See PR at
> https://github.com/ceph/ceph/pull/6208/files/306c5e148cd2f538b3b6c8c2a1a3d5f38ef8e15a#r63775941

I think a, b, and d can be address by adding two hints to the 
set_alloc_hint2 operation:

 COMPRESSIBLE
 INCOMPRESSBILE

The first would attempt compression if bluestore compression = allow, and 
the second would not try even if compression = force.

Alternatively, we could have

 bluestore compression = force | aggressive | passive | disable

where aggressive would try unless INCOMPRESSIBLE and passive would not try 
unless COMPRESSIBLE.

I would make the SHORTLIVED inference an independent heuristic that is 
optional, and basically makes SHORTLIVED => INCOMPRESSIBLE and LONGLIVED 
=> COMPRESSIBLE.

> Along with specific compression algorithm one should be able to specify
> default algorithm selection. E.g. user can specify 'default' compression for
> an object instead of specific 'zlib' or 'snappy' value.
> 
> This way one can avoid the need to care about the proper algorithm selection
> for each object.
> 
> Default algorithm to be taken from the store setting (see above)

Do we need to vary the alg per object?

For your c above, I think we probably want a 'compress' and 'decompress' 
rados op, but until we have an actual user that would make use of it, I 
don't think we should worry about it.  In the meantime, someone can 
just set the hint and rewrite the object if they want to force 
compression on existing data.

> Such an option provides pretty good level of flexibility. Upper level can
> introduce additional logic to control compression this way, e.g.
> enable/disable it for specific pools or dynamically control depending on how
> compressible object content is.
> 
> 3) Per-write request compression control.
> 
> This option provides the highest level of flexibility but is probably an
> overkill.
> 
> Any rationales to have it?

I don't think we need it.

> ==================================================================
> 
> PER-STORE STATISTICS
> 
> Following statistics parameters to be introduced on per-store basis:
> 
> 1) Allocated - total amount of data in allocated blobs
> 
> 2) Stored - actual amount of stored object content, i.e. sum of all objects
> uncompressed content
> 
> 3) StoredCompressed - amount of stored compressed data
> 
> 4) StoredCompressedOriginal - original amount of stored compressed data
> 
> 5) CompressionProcessed - amount of data processed by the compression. This
> differ from 'StoredCompressed' as some data can be finally stored uncompressed
> or removed. Also potentially the parameter can be reset by some means.
> 
> 6) CompressOpsCount - amount of compression operations completed. The
> parameter can be reset by some means.
> 
> 7) CompressTime - amount of time spent for compression. The parameter can be
> reset by some means.
> 
> 8) WriteOpsCount - amount of write operations completed. The parameter can be
> reset by some means.
> 
> 9) WriteTime - amount of time spent for write requests processing. The
> parameter can be reset by some means.
> 
> 10) WrittenTotal - amount of written data.
> 
> 11) DecompressionProcessed - amount of data processed by decompression. The
> parameter can be reset by some means.
> 
> 12) DecompressOpsCount - amount of decompression operations completed. The
> parameter can be reset by some means.
> 
> 13) DecompressTime - amount of time spent for compression. The parameter can
> be reset by some means.
> 
> 14) ReadOpsCount - amount of read operations completed. The parameter can be
> reset by some means.
> 
> 15) ReadTime - amount of time spent for read requests processing. The
> parameter can be reset by some means.
> 
> 16) ReadTotal - amount of read data. The parameter can be reset by some means.
> 
> Handling parameters 11)-16) can be a bit tricky as we might want to avoid KV
> updates during reading. Thus we need some means to periodically store these
> parameters or just track them in-memory.

These seem to break down into two categories:

 - stuff that tracks performance, and would probably just map to 
perfcounters, to be slurped up by your metrics and graphing infrastructure 
along with other performance stuff

 - stats about utilized storage that we might want to see from a 'df'.  
Specifically, 1-4.  I suspect we can keep some high-level global counters 
for this and update on a per-transaction basis... probably using a rocksdb 
merge operator for addition/subtraction?  Then we can extend the 
ObjectStore statfs() interface to pass these stats up to the OSD for 
reporting through the mon for 'ceph df' and 'ceph osd df'.

What that doesn't give you is per-pg stats.  Is that important?  If so, we 
need to do the accounting on a per-collection basis, and add a new 
ObjectStore statfs-like op for collections.

> ==================================================================
> 
> PER-OBJECT STATISTICS NOTES
> 
> It might be useful to have per-object statistics similar to the above
> mentioned per-store one. This way upper level can revise compression results
> and adjust the process accordingly.
> 
> The drawbacks are onode footprint increase and additional complexities for
> read op handling though.
> 
> If collected per-object statistics should be retrieved by using specific
> method/ioctl.
> 
> Perhaps we can introduce some object creation flag ( or extend alloc_hints or
> provide an ioctl ) to enable statistics collection for specific objects only?
> 
> Any thought on the need for that?

I think pool granularity would be enough.  I would expect users to be 
interested about a corpus, and object types generally break down by pool.
 
> ==================================================================
> 
> ADDITIONAL NOTES
> 
> 1) It seems helpful to introduce additional means to indicate NO-MORE_WRITES
> event from upper level to BlueStore. This way one provides a hint that allows
> bluestore to trigger some background optimization on the object, e.g. garbage
> collection, defragmentation, etc.

We could have a rados op for 'seal' that would prevent further writes.  
Just a hint would be sufficient for gc/optimization purposes, but here it 
probably makes sense to make it an enforcing flag.  Sam has been 
looking for something like this for a while.


The other topic not covered here is the compressed_blob_size.  The new 
write code will create a single large blob to satisfy an entire 
write currently.  With compression, we'll want to cap the blob size unless 
there is an IMMUTABLE or APPEND_ONLY hint (in which case we don't care 
about overwrites and may as well keep metadata compact).

Is that just

 bluestore compression max blob size = 128*1024

?

sage
