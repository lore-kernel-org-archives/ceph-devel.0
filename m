From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: bluestore onode encoding efficiency
Date: Fri, 17 Jun 2016 17:15:29 +0300
Message-ID: <9904f66e-62c8-8b02-6154-9bbb11e6ce08@mirantis.com>
References: <alpine.DEB.2.11.1606151556380.26786@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34918 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcFQOPi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 10:15:38 -0400
Received: by mail-lf0-f46.google.com with SMTP id l188so58810130lfe.2
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 07:15:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606151556380.26786@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, Jianjian Huo <jianjian.huo@samsung.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Varada Kari <Varada.Kari@sandisk.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel@vger.kernel.org

Below are some more tricks for onode squeeze:

- Conditional encoding:

1) omit blob::compressed_length encoding/decoding for non-compressed blobs

2) omit blob::unused encoding/decoding for compressed blobs

3) omit csum_chunk_order and csum_data (we always encode buffer length 
using uint32 at the moment) encoding/decoding when check sums are disabled.

- Other tricks:
4) lextent::offset field can be squeezed into 1 byte to identify 
alloc_unit within the blob. Lower bits of logical offset can be used to 
calculate the desired blob offset.
E.g. original mapping:
0x20009 -> 0x10009~1000
can be modified to
0x20009 ->1~1000 and 0x0009 taken as 0x20009 & 0xffff (where 0xffff mask 
built from allocation unit size)

As a result lextent's offset and length can be squeezed into 32 bits 
instead of currently used 64 ones since 24 bits is far enough for 
lextent::length.

5) bluestore_blob_t::length is redundant

6)key value(i.e. offset) in bluestore_extent_ref_map_t can be 32 bits 
instead of 64.

PR for tricks 5 & 6 is at

https://github.com/ceph/ceph/pull/9778


Thanks,

Igor


On 15.06.2016 22:57, Sage Weil wrote:
> [Re-adding ceph-devel]
>
> On Tue, 14 Jun 2016, Allen Samuels wrote:
>> There are several interesting and important optimizations:
> (0) The lextent_t flags field is unused... we can just drop it.
>
>> (1) Recognize "dense" blob and extent maps, i.e., no holes, meaning that
>> the encodings can omit many of the offset and length fields.
>> (2) efficient encoding of addresses and sizes/offsets: Efficient=>
>> per-block not per-byte address AND truncation of high-order zeroes.
> I suggest:
>
> (2.1) Variable length integer encoding
>
> Most of the unsigned values we encode have lots of leading or trailing
> bits (they're either small or multiples of 4k to 64k).  A simple strategy
> for dealing with small numbers is to encode 7 bits of data per byte and
> use the last bit to indicate "more".  That's simple enough given we're
> already doing little-endian encoding (least significant bits first).
>
> Since lots of our values are also small (e.g., flags fields, lextent or
> pextent lengths), I suggest we also use the first 2 bits to indicate out
> many low bits to skip encoding (and assume are zero).  I suggest we use
> this [0..3] value to count nibbles or set of 3 bits... otherwise we'd need
> to spend 4 bits to skip 16 trailing 0 bits and that would mean only 3
> bits of real data in the first byte.  If we spend 2 bits for low 0 bits
> and one bit for the "more" bit that's 5 data bits (0..31), which ought to
> be enough for most of our values (e.g. flags, csum type, csum order,
> etc.).
>
> We can define functions like
>
>   void small_encode(uint32_t v, bufferlist& bl);
>   void small_decode(uint32_t& v, bufferlist::iterator& p);
>
> to mirror the existing encode/decode functions and use them where
> appropriate.  (Obviously not everwhere... the csum data, for example,
> should be encoded raw.  Though maybe not the vector length, since it's
> usually small.)
>
> (2.2) Delta encoding
>
> Lots of structures are naturally sequential, like the keys in
>
>     map<uint64_t,bluestore_lextent_t> extent_map;  ///< extent refs
>
> or the extents in
>
>     vector<bluestore_pextent_t> extents; ///< raw data position on device
>
> which are probably nearby on disk, or everything in extent_ref_map_t.
> We're write specialized code that iterates over the containers to encode
> instead of using the generic encoders/decoders.  The main annoyance is
> that the delta values will be signed, so we'll need to spend another
> bit for a sign bit (and the negate the value and encode the positive value
> similar small_encode above).
>
> If we have those, I'm not sure #1 will be worth it--the zeroed offset
> fields will encode with one byte.
>
>> (3) re-jiggering of blob/extents when possible. Much of the two-level
>> blob/extent map exists to support compression. When you're not
>> compressed you can collapse this into a single blob and avoid the
>> encoding overhead for it.
> Hmm, good idea.  As long as the csum parameters match we can do this.  The
> existing function
>
> int bluestore_onode_t::compress_extent_map()
>
> currently just combines consecutive lextent's that point to contiguous
> regions in the same blob.  We could extend this to combine blobs that are
> combinable.
>
>> There are other potential optimizations too that are artifacts of the
>> current code. For example, we support different checksum
>> algorithms/values on a per-blob basis. Clearly moving this to a
>> per-oNode basis is acceptable and would simplify and shrink the encoding
>> even more.
> The latest csum branch
>
>          https://github.com/ceph/ceph/pull/9526
>
> varies csum_order on a per-blob basis (for example, larger csum chunks for
> compressed blobs and small csum chunks for uncompressed blobs with 4k
> overwrites).  The alg is probably consistent across the onode, but the
> will uglify the code a bit to pass it into the blob_t csum methods.  I'd
> prefer to hold off on this.  With the varint encoding above it'll only be
> one byte per blob at least.
>
> sage
>

