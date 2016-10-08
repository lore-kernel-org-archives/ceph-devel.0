From: Ning Yao <zay11022@gmail.com>
Subject: Re: CRUSH algorithm and its debug method
Date: Sat, 8 Oct 2016 16:36:45 +0800
Message-ID: <CALZt5jzUpOaeS7esS+KCv0P1nB1eRmd3tzh+1ciVK_zJp6YAHw@mail.gmail.com>
References: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com>
 <alpine.DEB.2.11.1610031319090.19850@piezo.us.to> <CALZt5jxRt7KXF2_jJs5bMo0jyxhAJvEhO8tzQAedsfhJ-eWY6w@mail.gmail.com>
 <alpine.DEB.2.11.1610061325150.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36114 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755960AbcJHInF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2016 04:43:05 -0400
Received: by mail-qt0-f178.google.com with SMTP id m5so30449339qtb.3
        for <ceph-devel@vger.kernel.org>; Sat, 08 Oct 2016 01:43:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610061325150.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2016-10-06 21:27 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Thu, 6 Oct 2016, Ning Yao wrote:
>> Hi,
>>
>> 2016-10-03 21:22 GMT+08:00 Sage Weil <sage@newdream.net>:
>> > Hi!
>> >
>> > On Sat, 1 Oct 2016, Ning Yao wrote:
>> >> Hi, Sage
>> >>
>> >> I find that several issues related to current CRUSH algorithm as below:
>> >>
>> >> 1. It is possible to select out the same collision and retry bucket in
>> >> a crush_choose_firstn() loop. (e.g.  when we set reweight to 0 or mark
>> >> osd out, it would be definitely rejected if it is selected. However,
>> >> when the second chance to select out another one based on the
>> >> different r', it is still possible to select out the same osd
>> >> previously rejected, right? And until a different one is selected
>> >> after several retries.).  I think we can record those rejected or
>> >> collision osds in the same loop so that the process can be converged
>> >> much faster?
>> >
>> > It's sitll possible to pick the same thing with a different r'.
>> > That's why the max retries values has to be reasonably high.  I'm not sure
>> > how you would avoid doing the full calculation, though... can you be
>> > more specific?
>> I have two ideas to do that:
>>
>> 1) the simplest idea is allocate a bool array in crush_choose_firstn()
>> whose size is crush_bucket->size. And then pass the array pointer into
>> crush_bucket_choose(). What we shoud do is:
>>     i) mark those already selected, collision or rejected items as true
>>     ii) when determine (hight and high_draw in bucket_straw_choose or
>> bucket_straw2_choose), we can skip those items already marked TRUE.
>>     But the drawback is that  we always need to allocate an dynamic
>> array within each iteration, And memory allocation in heap is an
>> expensive operation.
>>
>> 2) So the second idea is to use a uint64_t s_mask (said selected_mask
>> to indicate those items already been selected). What we should do is:
>>     i) init uint64_t s_mask = 0; in crush_choose_firstn()
>>     ii) pass value by reference into  bucket_straw_choose or
>> bucket_straw2_choose and mark the corresponding bit as one if item is
>> selected, collision or rejected.  s_mask  = s_mask | (1ul << high)
>>     iii) do not consider those whose bit (s_mask & (1ul << high)) is
>> marked as one.
>>     But here is an explicit limitation, the number of items in the
>> bucket should be smaller than sizeof(int64_t). So we need to run the
>> previous strategy if crush_bucket->size > 64.
>>
>> Furthermore, the strategy is just suitable for straw algorithm, so we
>> need to remain the strategy for tree, list and uniform algorithm.
>>
>> Any other better ideas? @Wei-Chung Cheng
>
> This PR is doing something very similar in order to solve what we've been
> calling the 'multi-pick anomaly,' which tends to allocate more data to
> very low-weighted devices.
>
>         https://github.com/ceph/ceph/pull/10218
>
> The effect is only noticeable with very small (relative) weights, but it
> comes up in practice on large clusters semi-frequently.

Hi,
It seems partially resolves the problem.  In this PR,  index is passed
back to crush_choose_firstn(),  it is easy to record it when collision
and rejection, so why not?
