From: Ning Yao <zay11022@gmail.com>
Subject: Re: CRUSH algorithm and its debug method
Date: Thu, 6 Oct 2016 11:52:29 +0800
Message-ID: <CALZt5jxRt7KXF2_jJs5bMo0jyxhAJvEhO8tzQAedsfhJ-eWY6w@mail.gmail.com>
References: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com>
 <alpine.DEB.2.11.1610031319090.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33088 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbcJFDwb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Oct 2016 23:52:31 -0400
Received: by mail-qt0-f172.google.com with SMTP id s49so3149725qta.0
        for <ceph-devel@vger.kernel.org>; Wed, 05 Oct 2016 20:52:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610031319090.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

2016-10-03 21:22 GMT+08:00 Sage Weil <sage@newdream.net>:
> Hi!
>
> On Sat, 1 Oct 2016, Ning Yao wrote:
>> Hi, Sage
>>
>> I find that several issues related to current CRUSH algorithm as below:
>>
>> 1. It is possible to select out the same collision and retry bucket in
>> a crush_choose_firstn() loop. (e.g.  when we set reweight to 0 or mark
>> osd out, it would be definitely rejected if it is selected. However,
>> when the second chance to select out another one based on the
>> different r', it is still possible to select out the same osd
>> previously rejected, right? And until a different one is selected
>> after several retries.).  I think we can record those rejected or
>> collision osds in the same loop so that the process can be converged
>> much faster?
>
> It's sitll possible to pick the same thing with a different r'.
> That's why the max retries values has to be reasonably high.  I'm not sure
> how you would avoid doing the full calculation, though... can you be
> more specific?
I have two ideas to do that:

1) the simplest idea is allocate a bool array in crush_choose_firstn()
whose size is crush_bucket->size. And then pass the array pointer into
crush_bucket_choose(). What we shoud do is:
    i) mark those already selected, collision or rejected items as true
    ii) when determine (hight and high_draw in bucket_straw_choose or
bucket_straw2_choose), we can skip those items already marked TRUE.
    But the drawback is that  we always need to allocate an dynamic
array within each iteration, And memory allocation in heap is an
expensive operation.

2) So the second idea is to use a uint64_t s_mask (said selected_mask
to indicate those items already been selected). What we should do is:
    i) init uint64_t s_mask = 0; in crush_choose_firstn()
    ii) pass value by reference into  bucket_straw_choose or
bucket_straw2_choose and mark the corresponding bit as one if item is
selected, collision or rejected.  s_mask  = s_mask | (1ul << high)
    iii) do not consider those whose bit (s_mask & (1ul << high)) is
marked as one.
    But here is an explicit limitation, the number of items in the
bucket should be smaller than sizeof(int64_t). So we need to run the
previous strategy if crush_bucket->size > 64.

Furthermore, the strategy is just suitable for straw algorithm, so we
need to remain the strategy for tree, list and uniform algorithm.

Any other better ideas? @Wei-Chung Cheng


>> 2. Currently, the reweight params in crushmap is memoryless (e.g we
>> balance our data by reducing reweight, which will be lost after this
>> osd DOWN and OUT automatically. And we mark its IN again because
>> currently ceph osd in directly marks the reweight to 1.0 and out marks
>> the reweight to 0.0).  It is quite awkward when we use ceph osd
>> reweight-by-utilization to make data balance (If some osds down and
>> out, our previous effort is totally lost).   So I think marking osd
>> "in"  does not simply modify reweight to "1.0". Actually, we can
>> iteration the previous osdmap and find out the value of the reweight
>> or records it anywhere we can retrieve this value again?
>
> The old value is stored here
>
> https://github.com/ceph/ceph/blob/master/src/osd/OSDMap.h#L89
>
> and restored when the OSD is marked back up, although IIRC there is a
> config option that controls when the old value is stored (it might only
> happen when the osd is marked out automatically, not when it is done
> manually?).  That behavior could be changed, though.
Thanks, fix in PR #11293 is what we expect.

>> 3. Currently, there is no debug option in the mapping progress in
>> Mapper.c. dprintk is default disabled so that it will be hard to dig
>> into the algorithm if something unexpected result happens. I think we
>> can introduce the debug options and output the debug information when
>> we use "ceph osd map xxx xxx" so that it is much more easier to find
>> the shortness in current mapping process?
>
> Yeah, it's hard to debug.  I usually uncomment the dprintk define and
> rebuild osdmaptool, which has a --test-map-pg option so that I can run
> a specific problematic mapping.  We could do something a bit more clever
> as long as it is a simple conditional--we don't want to slow down the
> mapping code as it is performance sensitive.

Yeah, I think it is enough to print out the debug information when we
run "ceph osd map data object_1". So we can pass ostream* into the
function, gathering the information. Normally, we can default pass the
ostream*  as a NULL pointer so that we can skip all of the dprintk?

> Thanks!
> sage
