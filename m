From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Thu, 31 Mar 2016 19:58:21 +0300
Message-ID: <56FD572D.6070608@mirantis.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35858 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbcCaQ6Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 12:58:24 -0400
Received: by mail-lb0-f179.google.com with SMTP id qe11so56230270lbc.3
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 09:58:23 -0700 (PDT)
In-Reply-To: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 30.03.2016 22:46, Allen Samuels wrote:
> [snip]
>
> Time to talk about checksums.
>
> First let's divide the world into checksums for data and checksums for metadata -- and defer the discussion about checksums for metadata (important, but one at a time...)
>
> I believe it's a requirement that when checksums are enabled that 100% of data reads must be validated against their corresponding checksum. This leads you to conclude that you must store a checksum for each independently readable piece of data.
>
> When compression is disabled, it's relatively straightforward -- there's a checksum for each 4K readable block of data. Presumably this is a simple vector stored in the pextent structure with one entry for each 4K block of data.
>
> Things get more complicated when compression is enabled. At a minimum, you'll need a checksum for each blob of compressed data (I'm using blob here as unit of data put into the compressor, but what I really mean is the minimum amount of *decompressable* data). As I've pointed out before, many of the compression algorithms do their own checksum validation. For algorithms that don't do their own checksum we'll want one checksum to protect the block -- however, there's no reason that we can't implement this as one checksum for each 4K physical blob, the runtime cost is nearly equivalent and it will considerably simplify the code.

> Thus I think we really end up with a single, simple design. The pextent structure contains a vector of checksums. Either that vector is empty (checksum disabled) OR there is a checksum for each 4K block of data (not this is NOT min_allocation size, it's minimum_read_size [if that's even a parameter or does the code assume 4K readable blocks? [or worse, 512 readable blocks?? -- if so, we'll need to cripple this]).
>
> When compressing with a compression algorithm that does checksuming we can automatically suppress checksum generation. There should also be an administrative switch for this.
>
> This allows the checksuming to be pretty much independent of compression -- which is nice :)
Mostly agree.

But I think we should consider compression algorithm as a black box and 
rely on a standalone checksum verification only.
And I suppose that the main purpose of the checksum validation at 
bluestore level is to protect from HW failures. Thus we need to check 
*physical* data. That is data before decompressing.

Another thing to consider is an ability to use introduced checksums for 
scrubbing. One can probably extend objectstore interface to be able to 
validate stored data without data sending back.
I don't see such an option at the moment. Please correct me if I missed 
that.

> This got me thinking, we have another issue to discuss and resolve.
>
> The scenario is when compression is enabled. Assume that we've taken a big blob of data and compressed it into a smaller blob. We then call the allocator for that blob. What do we do if the allocator can't find a CONTIGUOUS block of storage of that size??? In the non-compressed case, it's relatively easy to simply break it up into smaller chunks -- but that doesn't work well with compression.
>
> This isn't that unlikely a case, worse it could happen with shockingly high amounts of freespace (>>75%) with some pathological access patterns.
>
> There's really only two choices. You either fracture the logical data and recompress OR you modify the pextent data structure to handle this case. The later isn't terribly difficult to do, you just make the size/address values into a vector of pairs. The former scheme could be quite expensive CPU wise as you may end up fracturing and recompressing multiple times (granted, in a pathological case). The latter case adds space to each onode for a rare case. The space is recoverable with an optimized serialize/deserializer (in essence you could burn a flag to indicate when a vector of physical chunks/sizes is needed instead of the usual scalar pair).
>
> IMO, we should pursue the later scenario as it avoids the variable latency problem. I see the code/testing complexity of either choice as about the same.
>
>

