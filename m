From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [ceph-users] Write back mode Cach-tier behavior
Date: Tue, 6 Jun 2017 08:02:22 -0500
Message-ID: <06cd0624-6d6b-a43b-2b62-0c1fd8be6f4d@redhat.com>
References: <8841B22B-1A20-4D79-9EAB-32D0BBFB2DD9@gmail.com>
 <CAJ4mKGZR_VQi+8Poyq-zGXVev2Nh3EjC88tQ_5D1qmcmgkbPyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdFFNCX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Jun 2017 09:02:23 -0400
In-Reply-To: <CAJ4mKGZR_VQi+8Poyq-zGXVev2Nh3EjC88tQ_5D1qmcmgkbPyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: TYLin <wooertim@gmail.com>



On 06/05/2017 08:22 PM, Gregory Farnum wrote:
> [ Moving to ceph-devel ]
>
> On Sun, Jun 4, 2017 at 9:25 PM, TYLin <wooertim@gmail.com> wrote:
>> Hi all,
>>
>> We’re using cache-tier with write-back mode but the write throughput is not
>> as good as we expect. We use CephFS and create a 20GB file in it. While data
>> is writing, we use iostat to get the disk statistics. From iostat, we saw
>> that ssd (cache-tier) is idle most of the time and hdd (storage-tier) is
>> busy all the time. From the document
>>
>> “When admins configure tiers with writeback mode, Ceph clients write data to
>> the cache tier and receive an ACK from the cache tier. In time, the data
>> written to the cache tier migrates to the storage tier and gets flushed from
>> the cache tier.”
>>
>> So the data is write to cache-tier and then flush to storage tier when dirty
>> ratio is more than 0.4? The word “in time” in the document confused me.
>>
>> We found that the throughput of creating a new file is slower than overwrite
>> an existing file, and ssd has more write when doing overwrite. We then look
>> into the source code and log. A newly created file goes to proxy_write,
>> which is followed by a promote_object. Does this means that the object
>> actually goes to storage pool directly and then be promoted to the
>> cache-tier when creating a new file?
>
> So I skimmed this thread and thought it was very wrong, since we don't
> need to proxy when we're doing fresh writes. But looking at current
> master, that does indeed appear to be the case when creating new
> objects: they always get proxied (I didn't follow the whole chain, but
> PrimaryLogPG::maybe_handle_cache_detail unconditionally calls
> do_proxy_write() if the OSD cluster supports proxying and we aren't
> must_promote!).
>
> Was this intentional? I know we've flipped around a bit on ideal
> tiering behavior but it seems like at the very least it should be
> configurable — proxying then promoting is a very inefficient pattern
> for workloads that involve generating lots of data, modifying it, and
> then never reading it again.

Back when I was looking at this in detail the cache tier was becoming 
overwhelmed with initial writes and promotions slowing everything way 
down.  I think we really want to limit promotions dramatically and favor 
big IOs going straight to the base tier and little writes to the cache 
tier, with slightly relaxed constraints when the cache is initially 
being filled.  I recall that we greatly improved things but still had 
things we could do to make it better.

Mark


> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
