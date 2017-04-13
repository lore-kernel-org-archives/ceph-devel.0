From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Measuring lock conention
Date: Thu, 13 Apr 2017 16:38:33 -0400
Message-ID: <CANP1eJFwsSrEchc0cMxtQKBnDWV6r9gPTerXywA0DpebwL0AGA@mail.gmail.com>
References: <90991cbf-c59e-d080-783e-e712540a99b1@suse.com>
 <61444443-9337-c5ce-76ba-7e8a7a765232@redhat.com> <6481e2a7-0913-de41-2f35-40e44043bb0a@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35958 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756231AbdDMUil (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Apr 2017 16:38:41 -0400
Received: by mail-wm0-f43.google.com with SMTP id o81so119398768wmb.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Apr 2017 13:38:36 -0700 (PDT)
In-Reply-To: <6481e2a7-0913-de41-2f35-40e44043bb0a@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 13, 2017 at 2:02 PM, Mohamad Gebai <mgebai@suse.com> wrote:
>
> On 04/13/2017 01:20 PM, Mark Nelson wrote:
>>
>> Nice!  I will give it a try and see how it goes. Specifically I want to
>> compare it to what I ended up working on yesterday.  After the meeting I
>> ended up doing major surgery on an existing gdb based wallclock profiler and
>> modified it to a) work b) be thread aware c) print inverse call-graphs.  The
>> code is still pretty rough but you can see it here:
>>
>> https://github.com/markhpc/gdbprof
>
> Very neat, thank you for this. Please let me know what happens, I'm
> interested to see which tool ends up working best for this use case. Also,
> could you share some information about what you're trying to find out?
>
> If I'm not mistaken, there's work being done to add the call stack of a
> process within the context of LTTng events. That way we could have this
> information when a process blocks in sys_futex.
>
> PS: found it, it's still in RFC -
> https://lists.lttng.org/pipermail/lttng-dev/2017-March/026985.html
>
>

You can also use perf's syscall tracepoints to capture the
syscalls:sys_enter_futex event. This way you get contended mutex. The
nice thing about it is all the normal perf tools apply, so you can see
source annotation, frequency (hot points) and also examine the
callgraph of the hot points.

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
