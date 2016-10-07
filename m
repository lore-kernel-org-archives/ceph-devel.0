From: Haomai Wang <haomai@xsky.com>
Subject: Re: bluestore performance snapshot - 20161006
Date: Sat, 8 Oct 2016 01:27:42 +0800
Message-ID: <CACJqLyYkL6kDuzOX2PCggHLpCHm7gdv8oxjBONYCfrKJi9hCNQ@mail.gmail.com>
References: <e3e00cbc-3e97-8582-bb93-7ac03b3da40b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0129.outbound.protection.outlook.com ([104.47.93.129]:1143
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965311AbcJGR1z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 7 Oct 2016 13:27:55 -0400
Received: by mail-vk0-f47.google.com with SMTP id 192so51045251vkl.2
        for <ceph-devel@vger.kernel.org>; Fri, 07 Oct 2016 10:27:51 -0700 (PDT)
In-Reply-To: <e3e00cbc-3e97-8582-bb93-7ac03b3da40b@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Oct 7, 2016 at 10:03 PM, Mark Nelson <mnelson@redhat.com> wrote:
> Hi Guys,
>
> I wanted to give folks a quick snapshot of bluestore performance on our NVMe
> test setup.  There's a lot of things happening very quickly in the code, so
> here's a limited snapshot of how we are doing.  These are short running
> tests, so do keep that in mind (5 minutes each).
>
> https://drive.google.com/uc?export=download&id=0B2gTBZrkrnpZRXFKRDBrTjZiWGc
>
> The gist of it is:
>
> We are now basically faster than filestore in all short write tests.
> Increasing the min_alloc size (and to a lesser extent) the number of cached
> onodes brings 4K random write performance up even further. Likely increasing
> the min_alloc size will improve long running test performance as well due to
> drastically reduced metadata load on rocksdb.  Related to this, the amount
> of memory that we cache with 4k min_alloc is pretty excessive, even when
> limiting the number of cached onodes to 4k  The memory allocator work should
> allow us to make this more flexible, but I suspect that for now we will want
> to increase the min_alloc size to 16k to help alleviate memory consumption
> and metadata overhead (and improve 4k random write performance!).  The extra
> WAL write is probably still worth the tradeoff for now.
>
> On the read side we are seeing some regressions.  The sequential read case
> is interesting.  We're doing quite a bit worse in recent bluestore even vs
> older bluestore, and generally quite a bit worse than filestore.  Increasing
> the min_alloc size reduces the degredation, but we still have ground to make
> up.  In these tests rbd readahead is being used in an attempt to achieve
> client-side readahead since bluestore no longer does it on the OSD side, but
> appears to be fairly ineffective.  These are the settings used:
>
>         rbd readahead disable after bytes = 0
>         rbd readahead max bytes = 4194304
>
> By default we require 10 sequential reads to trigger it.  I don't think that
> should be a problem, but perhaps lowering the threshold will help. In
> general this is an area we still need to focus.
>
> For random reads, the degradation was previously found to be due to the
> async messenger.  Both filestore and bluestore performance has degraded
> relative to Jewel in these tests.  Haomai suspects fast dispatch as the
> primarily bottleneck here.
>
> So in general, the areas I think we still need to focus:
>
>
> 1) memory allocator work (much easier caching configuration, better memory
> usage, better memory fragmentation, etc)
> 2) Long running tests (Somnath has been doing this, thanks Somnath!)
> 2) Sequential read performance in bluestore (Need to understand this better)
> 3) Fast dispatch performance improvement (Dan's RCU work?)

Oh, it would be great to here anyone is working on RCU. Is it really ongoing?

>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
