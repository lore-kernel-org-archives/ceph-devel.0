From: Sage Weil <sweil@redhat.com>
Subject: Re: bluestore: extend/reuse blob on write rather than create a new
 one
Date: Tue, 17 Jan 2017 15:31:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701171529390.1661@piezo.novalocal>
References: <b377a4a8-d9b8-cee0-175f-200f50d3c1dc@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdAQPki (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Jan 2017 10:40:38 -0500
In-Reply-To: <b377a4a8-d9b8-cee0-175f-200f50d3c1dc@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 17 Jan 2017, Igor Fedotov wrote:
> Hi All,
> 
> Let me share some thoughts on another one approach that might help to reduce
> BlueStore Onode size (both in-memory and serialized).
> 
> Brief example showing current write algorithm functioning below first:
> - min_alloc_size = 0x10000
> 
> 1) write 0x0~10000
> At this step we have following Onode/extent/blob structure:
>   Extent1 0x0~10000 -> Blob1(size=0x10000) -> 1 * 0x10000 pextent
> 2) Append: write 0x10000~20000
> Onode/extent/blob structure:
>   Extent1 0x0~10000 -> Blob1(size=0x10000) -> 1 * 0x10000 pextent
>   Extent2 0x10000~20000 -> Blob2(size=0x20000) -> 2 * 0x10000 pextents
> 
> 3) Partially Overwrite Extent2: write 0x10000~10000
> Onode/extent/blob structure:
>   Extent1 0x0~10000 -> Blob1(size=0x10000) -> 1 * 0x10000 pextent
>   Extent2 0x10000~10000 -> Blob3(size=0x10000) -> 1 * 0x10000 pextents
>   Extent3 0x20000~10000 -> Blob2(size=0x10000) -> 1 * 0x10000 pextents
> 
>   So one can see that we have increased Onode structure at step 3 while object
> content layout is unchanged: 0~30000.
>   Moreover at step 2) we could avoid Extent2 creation and extend Extent1/Blob1
> instead.
> 
>   Hence my suggestion is to consider an approach that will allow existing
> extents/blobs reuse and blob internals(pextent+csum vectors) update only
> whenever possible (i.e. big aligned writes/appends).
>   As a result Onode structure becomes more static and Blob's pextent vector
> grows rather than ExtentMap. Surely some limit for Blob growth to be
> introduced.
> 
> 
> 
>   IMHO as we have reduced Onode metadata this approach might impact BlueStore
> performance comparable to the results we achieved by the cases with
> min_alloc_size increased.
>   AFAIR Mark did some tests for 16K MAS and they showed better results. But we
> wouldn't suffer from storage space loss caused by increased granularity this
> way.
>   Onode in-memory representation is positively affected this way too hence
> BlueStore caching becomes more efective.
> 
> The cost for this change is the need for more dynamic behavior of Blob's
> pextent & csum containers - currently their size are 'semi-dynamic' (entry
> count decrease is possible sometimes but no increase is possible)
> 
> Any comments/thoughts?

Yep, I think this makes sense.  We should just try to limit the paths that 
adjsut Blobs in this way to manage the complexity.  The main one I'm 
worried/hopefully about is appends: we definitely want to allow Blobs 
to grow with new extents on the end.  Growing on the 'left' (with earlier 
extents) will be much more difficult as the BufferSpace and all of its 
offsets would need to be updated and there is a lot more opportunity 
for bugs there.

We'll probably have to avoid changing blobs that are shared, too.

sage
