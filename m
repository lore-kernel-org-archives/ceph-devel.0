From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: Rados bench decreasing performance for large data
Date: Thu, 10 Aug 2017 10:54:37 +0300
Message-ID: <CAODUPsEDHu6Ug4Mb0HUo8tAs46Qa0gEPTHXV-LVqSy57S1L0oQ@mail.gmail.com>
References: <CAODUPsE80Dan4YULo26OeEJtyghCUT9r-ux1qOOaT3A_w6gv0A@mail.gmail.com>
 <CAFMfnwog0HMyRnQWbH+uG5E2S7aSuAmgSiEo4BqaeHXbat7BoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33016 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdHJHyi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Aug 2017 03:54:38 -0400
Received: by mail-oi0-f48.google.com with SMTP id f11so117385oic.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Aug 2017 00:54:38 -0700 (PDT)
In-Reply-To: <CAFMfnwog0HMyRnQWbH+uG5E2S7aSuAmgSiEo4BqaeHXbat7BoQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gala Yadgar <gala@cs.technion.ac.il>

Hi
I've noticed the decreased performance in 4MB experiment as well. For
Jerasure for example, my profile is a simple k=4 m=5 configuration.
Being more precise, the decrease occurs near the end of the reads,
when ~80% of reads were done.
Looks like the amount of reads reduces toward the end of the
experiment, and it create a distortion of the avg MB/s and avg lat.

First, when reaching 80% of total reads, it is visible that not every
sec has a read done, meaning we done have a real value per each sec.
Second, when there is no sample, MB/s is regarded as 0, and this value
is inserted into avg MB/s - This is clearly incorrect!

My questions is this:
What happens toward the end of the experiment (80%) causing the reads
to reduce drastically and the latency to increase?

Thanks,
Oleg

On Thu, Aug 10, 2017 at 7:32 AM, Kyle Bader <kyle.bader@gmail.com> wrote:
> 64MB is pretty large for a rados bench object - most of the interfaces
> above rados stripe at a 4MB boundary. It could be that larger sized
> writes like those require adjusting various knobs in the OSD.
>
> Do you see the same thing happen with 4MB work workloads?
>
> What are your EC profile(s)?
>
> On Wed, Aug 9, 2017 at 4:44 AM, Oleg Kolosov <olekol@gmail.com> wrote:
>> Hi
>> I've began experimenting with rados bench and I've noticed bizarre
>> behavior for jerasure and lrc plugins. I'm writing very large amounts
>> of data: ~2000 objects of size 64MB.
>> When reading the data with 9 parallel client, I'm noticing a linear
>> increase in latency around the middle of the read experiment (latency
>> was steady up to that point).
>> Is that an expected behavior?
>> How can it be explained?
>>
>> Thanks,
>> Oleg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
>
> Kyle Bader
