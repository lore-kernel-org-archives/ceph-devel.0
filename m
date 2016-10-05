From: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Subject: Re: CRUSH algorithm and its debug method
Date: Wed, 5 Oct 2016 15:55:23 +0800
Message-ID: <CABF_e-GQQ_LJDDmQnLSbRLFxhd7ahDRAr7UvfGFx2B+5vnvk8A@mail.gmail.com>
References: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com>
 <alpine.DEB.2.11.1610031319090.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36260 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbcJEHzZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Oct 2016 03:55:25 -0400
Received: by mail-yw0-f175.google.com with SMTP id u124so59868553ywg.3
        for <ceph-devel@vger.kernel.org>; Wed, 05 Oct 2016 00:55:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610031319090.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ning Yao <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

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
>

Hi all,
I also have the same question and I already do a simple version for
skipping the item that is already selected. (now ONLY for straw(2)
algorithm)

I wanna to know why we don't skip the selected item?
I thought that behavior would try to avoid choose the not suitable
item in specific scenario (like the weight of 2 item with huge gap)

thanks!


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
>
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
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
