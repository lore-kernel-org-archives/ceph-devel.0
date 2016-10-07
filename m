From: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Subject: Re: CRUSH algorithm and its debug method
Date: Fri, 7 Oct 2016 11:20:10 +0800
Message-ID: <CABF_e-HYn6qSt8vsUB0+t-SdjToJSa0=FKCwzi=UYVdF116wCA@mail.gmail.com>
References: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com>
 <alpine.DEB.2.11.1610031319090.19850@piezo.us.to> <CALZt5jxRt7KXF2_jJs5bMo0jyxhAJvEhO8tzQAedsfhJ-eWY6w@mail.gmail.com>
 <alpine.DEB.2.11.1610061325150.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33010 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbcJGDUM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 23:20:12 -0400
Received: by mail-yw0-f170.google.com with SMTP id t192so5102036ywf.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 20:20:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610061325150.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ning Yao <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

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



hi ning:

I agree first idea. If we could handle the array (or selected item)
scope well, maybe the memory usage would not be a problem.

I am not sure about second idea.
did you mean we store the high result and skip it next item we found
the same high result?

I don't have any better ideas now and I perfer first idea ; )





>
> This PR is doing something very similar in order to solve what we've been
> calling the 'multi-pick anomaly,' which tends to allocate more data to
> very low-weighted devices.
>
>         https://github.com/ceph/ceph/pull/10218
>
> The effect is only noticeable with very small (relative) weights, but it
> comes up in practice on large clusters semi-frequently.
>
> sage
>
>



hi sage:

as you say, this pr solve the problem that would allocate more data to
very low-weighted devices with the configurable parameter.

did it still choose the same item with straw2?
I think it could reduce the retry times (did we avoid the retry?), and
we still need to do the thing that would avoid/skip the selected item?

thanks!!
vicente





>
>
>>
>>
>> >> 2. Currently, the reweight params in crushmap is memoryless (e.g we
>> >> balance our data by reducing reweight, which will be lost after this
>> >> osd DOWN and OUT automatically. And we mark its IN again because
>> >> currently ceph osd in directly marks the reweight to 1.0 and out marks
>> >> the reweight to 0.0).  It is quite awkward when we use ceph osd
>> >> reweight-by-utilization to make data balance (If some osds down and
>> >> out, our previous effort is totally lost).   So I think marking osd
>> >> "in"  does not simply modify reweight to "1.0". Actually, we can
>> >> iteration the previous osdmap and find out the value of the reweight
>> >> or records it anywhere we can retrieve this value again?
>> >
>> > The old value is stored here
>> >
>> > https://github.com/ceph/ceph/blob/master/src/osd/OSDMap.h#L89
>> >
>> > and restored when the OSD is marked back up, although IIRC there is a
>> > config option that controls when the old value is stored (it might only
>> > happen when the osd is marked out automatically, not when it is done
>> > manually?).  That behavior could be changed, though.
>> Thanks, fix in PR #11293 is what we expect.
>>
>> >> 3. Currently, there is no debug option in the mapping progress in
>> >> Mapper.c. dprintk is default disabled so that it will be hard to dig
>> >> into the algorithm if something unexpected result happens. I think we
>> >> can introduce the debug options and output the debug information when
>> >> we use "ceph osd map xxx xxx" so that it is much more easier to find
>> >> the shortness in current mapping process?
>> >
>> > Yeah, it's hard to debug.  I usually uncomment the dprintk define and
>> > rebuild osdmaptool, which has a --test-map-pg option so that I can run
>> > a specific problematic mapping.  We could do something a bit more clever
>> > as long as it is a simple conditional--we don't want to slow down the
>> > mapping code as it is performance sensitive.
>>
>> Yeah, I think it is enough to print out the debug information when we
>> run "ceph osd map data object_1". So we can pass ostream* into the
>> function, gathering the information. Normally, we can default pass the
>> ostream*  as a NULL pointer so that we can skip all of the dprintk?
>>
>> > Thanks!
>> > sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
