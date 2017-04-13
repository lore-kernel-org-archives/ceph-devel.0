From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Measuring lock conention
Date: Fri, 14 Apr 2017 08:30:56 +1000
Message-ID: <CAF-wwdGD6WbtC6VFuTxtxQB2SEtb-wDoG4DbcNY9hC41-Du6=Q@mail.gmail.com>
References: <90991cbf-c59e-d080-783e-e712540a99b1@suse.com>
 <61444443-9337-c5ce-76ba-7e8a7a765232@redhat.com> <6481e2a7-0913-de41-2f35-40e44043bb0a@suse.com>
 <CANP1eJFwsSrEchc0cMxtQKBnDWV6r9gPTerXywA0DpebwL0AGA@mail.gmail.com> <be8aaf0b-5d48-793a-9f40-ce35d8c75b3f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33223 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdDMWa6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Apr 2017 18:30:58 -0400
Received: by mail-io0-f176.google.com with SMTP id k87so76054640ioi.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Apr 2017 15:30:57 -0700 (PDT)
In-Reply-To: <be8aaf0b-5d48-793a-9f40-ce35d8c75b3f@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, Mohamad Gebai <mgebai@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

Ah, nice to see poor man's getting a mention, a favoured weapon of mine.

Another possibility is systemtap. The following examples can be
modified to give additional information (stack traces, etc.).

https://sourceware.org/systemtap/examples/keyword-index.html#FUTEX

I can probably help with a systemtap approach, at least getting up and
running and probably with the probes.

My favourite sites for perf are:

https://perf.wiki.kernel.org/index.php/Main_Page

http://www.brendangregg.com/perf.html


On Fri, Apr 14, 2017 at 6:54 AM, Mark Nelson <mnelson@redhat.com> wrote:
> On 04/13/2017 03:38 PM, Milosz Tanski wrote:
>>
>> On Thu, Apr 13, 2017 at 2:02 PM, Mohamad Gebai <mgebai@suse.com> wrote:
>>>
>>>
>>> On 04/13/2017 01:20 PM, Mark Nelson wrote:
>>>>
>>>>
>>>> Nice!  I will give it a try and see how it goes. Specifically I want to
>>>> compare it to what I ended up working on yesterday.  After the meeting I
>>>> ended up doing major surgery on an existing gdb based wallclock profiler
>>>> and
>>>> modified it to a) work b) be thread aware c) print inverse call-graphs.
>>>> The
>>>> code is still pretty rough but you can see it here:
>>>>
>>>> https://github.com/markhpc/gdbprof
>>>
>>>
>>> Very neat, thank you for this. Please let me know what happens, I'm
>>> interested to see which tool ends up working best for this use case.
>>> Also,
>>> could you share some information about what you're trying to find out?
>>>
>>> If I'm not mistaken, there's work being done to add the call stack of a
>>> process within the context of LTTng events. That way we could have this
>>> information when a process blocks in sys_futex.
>>>
>>> PS: found it, it's still in RFC -
>>> https://lists.lttng.org/pipermail/lttng-dev/2017-March/026985.html
>>>
>>>
>>
>> You can also use perf's syscall tracepoints to capture the
>> syscalls:sys_enter_futex event. This way you get contended mutex. The
>> nice thing about it is all the normal perf tools apply, so you can see
>> source annotation, frequency (hot points) and also examine the
>> callgraph of the hot points.
>>
>
> Hi Milosz,
>
> Do you know of any examples showing this technique?  I've suspected there
> was a way to do this (and similar things) with perf, but always ran into
> roadblocks that made it not work.  Potentially one of those roadblocks might
> have been errors on my part. ;)
>
> Mark
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
