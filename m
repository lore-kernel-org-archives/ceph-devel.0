From: Vikas Sinha-SSI <v.sinha@ssi.samsung.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Wed, 30 Mar 2016 20:41:16 +0000
Message-ID: <EC1BE61F68296D4A8CE45AD3DEDB99E21AEF7D1C@SSIEXCH-MB3.ssi.samsung.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:50094 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcC3Ule convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 16:41:34 -0400
In-Reply-To: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Allen Samuels
> Sent: Wednesday, March 30, 2016 12:47 PM
> To: Sage Weil; Igor Fedotov
> Cc: ceph-devel
> Subject: Adding compression/checksum support for bluestore.
> 
> [snip]
> 
> Time to talk about checksums.
> 
> First let's divide the world into checksums for data and checksums for
> metadata -- and defer the discussion about checksums for metadata
> (important, but one at a time...)
> 
> I believe it's a requirement that when checksums are enabled that 100% of
> data reads must be validated against their corresponding checksum. This
> leads you to conclude that you must store a checksum for each
> independently readable piece of data.
> 
> When compression is disabled, it's relatively straightforward -- there's a
> checksum for each 4K readable block of data. Presumably this is a simple
> vector stored in the pextent structure with one entry for each 4K block of
> data.
> 
> Things get more complicated when compression is enabled. At a minimum,
> you'll need a checksum for each blob of compressed data (I'm using blob
> here as unit of data put into the compressor, but what I really mean is the
> minimum amount of *decompressable* data). As I've pointed out before,
> many of the compression algorithms do their own checksum validation. For
> algorithms that don't do their own checksum we'll want one checksum to
> protect the block -- however, there's no reason that we can't implement this
> as one checksum for each 4K physical blob, the runtime cost is nearly
> equivalent and it will considerably simplify the code.
> 
> Thus I think we really end up with a single, simple design. The pextent
> structure contains a vector of checksums. Either that vector is empty
> (checksum disabled) OR there is a checksum for each 4K block of data (not
> this is NOT min_allocation size, it's minimum_read_size [if that's even a
> parameter or does the code assume 4K readable blocks? [or worse, 512
> readable blocks?? -- if so, we'll need to cripple this]).
> 
> When compressing with a compression algorithm that does checksuming we
> can automatically suppress checksum generation. There should also be an
> administrative switch for this.
> 
> This allows the checksuming to be pretty much independent of compression
> -- which is nice :)
> 
> This got me thinking, we have another issue to discuss and resolve.
> 
> The scenario is when compression is enabled. Assume that we've taken a big
> blob of data and compressed it into a smaller blob. We then call the allocator
> for that blob. What do we do if the allocator can't find a CONTIGUOUS block
> of storage of that size??? In the non-compressed case, it's relatively easy to
> simply break it up into smaller chunks -- but that doesn't work well with
> compression.
> 
> This isn't that unlikely a case, worse it could happen with shockingly high
> amounts of freespace (>>75%) with some pathological access patterns.
> 
> There's really only two choices. You either fracture the logical data and
> recompress OR you modify the pextent data structure to handle this case.
> The later isn't terribly difficult to do, you just make the size/address values
> into a vector of pairs. The former scheme could be quite expensive CPU wise
> as you may end up fracturing and recompressing multiple times (granted, in a
> pathological case). The latter case adds space to each onode for a rare case.
> The space is recoverable with an optimized serialize/deserializer (in essence
> you could burn a flag to indicate when a vector of physical chunks/sizes is
> needed instead of the usual scalar pair).
> 
> IMO, we should pursue the later scenario as it avoids the variable latency
> problem. I see the code/testing complexity of either choice as about the
> same.
> 

If I understand correctly, then there would still be a cost associated with writing dis-contiguously
to disk. In cases such as this where the resources for compression are not easily available, I wonder
if it is reasonable to simply not do compression for that Write. The cost of not compressing would be
a missed space optimization, but the cost of compressing in any and all cases could be significant to latency.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
