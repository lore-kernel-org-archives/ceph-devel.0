From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: "exe" ceph-mds processes
Date: Mon, 28 Nov 2016 15:50:01 -0500
Message-ID: <CA+2bHPa2CrrJr_-7_bzOOdpyLSy87Z-H_y1EH4ORxU7Nk3Z2Nw@mail.gmail.com>
References: <CALe9h7fort-NWax8LUXMB1gGycvUXNundNzdbzVaypcpQWEC6w@mail.gmail.com>
 <alpine.DEB.2.11.1611261433390.28496@piezo.us.to> <432789e85f484dfca805b29e8c82d929@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35447 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcK1Uuc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2016 15:50:32 -0500
Received: by mail-io0-f173.google.com with SMTP id a124so252599642ioe.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2016 12:50:32 -0800 (PST)
In-Reply-To: <432789e85f484dfca805b29e8c82d929@R01UKEXCASM222.r01.fujitsu.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 28, 2016 at 6:29 AM, Igor.Podoski@ts.fujitsu.com
<Igor.Podoski@ts.fujitsu.com> wrote:
>> > I guess we could:
>> >  * Switch the logic to try resolving argv[0] and only use
>> > proc/self/exe if we can't find argv[0]?
>> >  * Create a link to /proc/self/exe named ceph-mds, and exec that?
>>
>> We could also check if argv[0] is 'exe' and, if so, rewrite it so that the ps
>> output shows ceph-mds...
>
> For ps/pgrep/pkill it'll work, but 'top' reports process name differently and you'll see 'exe' there. I think this is because 'ps' is looking on command line and 'top' on something else in procfs. You need to run also prctl(PR_SET_NAME, argv[0]) shortly after process starts. This could be a race condition, when system will be under big load, for a moment process name would change from 'ceph-mds' to 'exe' and then back to 'ceph-mds', pid will remain the same but some third party monitoring software could be confused (depends how they check the process name).
>
> I'm not sure, but I think you could pass argv again here, then respawn will short to:
> execv("/proc/self/exe", argv);
>
> And process name will be kept, since first start will set argv[0] and passing argv to execv + prctl will propagate it.

The process name (/proc/self/comm) is the first argument to execve:

https://github.com/torvalds/linux/blob/master/fs/exec.c#L1691-L1713

and

https://github.com/torvalds/linux/blob/master/fs/exec.c#L1296

Changing argv[0] will not help.

The only options I'm aware of to fix this are (a) change the first
argument to execve (and use a symlink as John suggested) or (b) use
prctl at startup.

Probably (b) is more palatable and maybe something we'd want to
unconditionally set to the "ideal" name of the exectuable. In this
case, that would be "ceph-mds".

-- 
Patrick Donnelly
