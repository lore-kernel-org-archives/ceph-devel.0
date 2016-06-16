From: Sage Weil <sage@newdream.net>
Subject: Re: bluestore onode encoding efficiency
Date: Thu, 16 Jun 2016 12:47:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606161232490.1686@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1606151556380.26786@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41770 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbcFPQqj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 12:46:39 -0400
In-Reply-To: <alpine.DEB.2.11.1606151556380.26786@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, Jianjian Huo <jianjian.huo@samsung.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Varada Kari <Varada.Kari@sandisk.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel@vger.kernel.org

Based on some of Allen's comments I've updated my branch with (so far) 
three different encoders:

1) varint - general purpose small integers (lops off high and low zero 
bits)

  first byte:
    low 2 bits = how many low nibbles of zeros
    5 bits = data
    1 high bit = another byte follows
  subsequent bytes:
    7 bits = data
    1 high bit = another byte follows

2) delta varint

  first byte:
    1 low bit = sign (0 = positive, 1 = negative)
    low 2 bits = how many low nibbles of zeros
    4 bits = data
    1 high bit = another byte follows
  subsequent bytes:
    7 bits = data
    1 high bit = another byte follows

3) raw lba:

  first 3 bytes:
    low 2 bits = how many low bits of zeros
      00 = none
      01 = 12 (4k alignment)
      10 = 16 (64k alignment)
      11 = 20 (256k alignment)
    21 bits = data
    1 high bit = another byte follows
  subsequent bytes:
    7 bits = data
    1 high bit = another byte follows

4) lba delta (distance between two lba's, e.g., when encoding a list of 
extents)

  first byte:
    1 low bit = sign (0 = positive, 1 = negative)
    2 bits = how many low bits of zeros
      00 = none
      01 = 12 (4k alignment)
      10 = 16 (64k alignment)
      11 = 20 (256k alignment)
    4 bits = data
    1 bit = another byte follows
  subsequent bytes:
    7 bits = data
    1 bit = another byte follows

  Notably on this one we have 4 bits of data *and* when we roll over to 
  the next value you'll get 4 trailing 0's and we ask for one 
  more nibble of trailing 0's... still in one encoded byte.


I think this'll be a decent set of building blocks to encoding the 
existing structures efficiently (and still in a generic way) before 
getting specific with common patterns.

	https://github.com/ceph/ceph/pull/9728/files

sage


On Wed, 15 Jun 2016, Sage Weil wrote:
> 
> If we have those, I'm not sure #1 will be worth it--the zeroed offset 
> fields will encode with one byte.
> 
> > (3) re-jiggering of blob/extents when possible. Much of the two-level 
> > blob/extent map exists to support compression. When you're not 
> > compressed you can collapse this into a single blob and avoid the 
> > encoding overhead for it.
> 
> Hmm, good idea.  As long as the csum parameters match we can do this.  The 
> existing function
> 
> int bluestore_onode_t::compress_extent_map()
> 
> currently just combines consecutive lextent's that point to contiguous 
> regions in the same blob.  We could extend this to combine blobs that are
> combinable.
> 
> > There are other potential optimizations too that are artifacts of the 
> > current code. For example, we support different checksum 
> > algorithms/values on a per-blob basis. Clearly moving this to a 
> > per-oNode basis is acceptable and would simplify and shrink the encoding 
> > even more.
> 
> The latest csum branch
> 
>         https://github.com/ceph/ceph/pull/9526
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
