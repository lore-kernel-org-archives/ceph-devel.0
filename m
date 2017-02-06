From: Max Yehorov <myehorov@skytap.com>
Subject: Re: Possible bug in krbd (4.4.0)
Date: Mon, 6 Feb 2017 10:26:55 -0800
Message-ID: <CAJDfisku2Ld3F5hOAPjBqqnjV3gUWwC2kVXs3t2D+i=6waMmtQ@mail.gmail.com>
References: <CAJDfiske056EADPT4g0fRUx=uh7C-F3ZzUh6A1ummfUZ6vMuTg@mail.gmail.com>
 <CAOi1vP9Jvnepv3PxFA1PO_vZnEJ-DRBsax_+U136GSWPzCc1Xw@mail.gmail.com>
 <CAJDfiskjz2H-D9xmanZ9opw+0pVAK=VmSPtFz1+fbcfPofOpmg@mail.gmail.com> <CAOi1vP9y2rSC=ZKQom0n+0RSHREpaPJ60497qpjYMGywTATJQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37687 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdBFS11 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 13:27:27 -0500
Received: by mail-wm0-f52.google.com with SMTP id v77so126897762wmv.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 10:27:26 -0800 (PST)
In-Reply-To: <CAOi1vP9y2rSC=ZKQom0n+0RSHREpaPJ60497qpjYMGywTATJQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> For hours?  Does it succeed after X number of hours?
Still mounted from Feb 6. There is an attempt to unmount every 10 minutes.

> This doesn't say that /dev/rbd0 is in use by pid 5926.  It says that
> there is a process with the name "dio/rbd0", that's all.
>
> I'm guessing you ran plain "lsof" with no arguments here.  Were there
> other */rbd0 matches, like jbd2/rbd0?

The entire output

:~# lsof | grep rbd

dio/rbd0   5926             root  cwd       DIR                8,5
    4096          2 /
dio/rbd0   5926             root  rtd       DIR                8,5
    4096          2 /
dio/rbd0   5926             root  txt   unknown
                    /proc/5926/exe
rbd        5996             root  cwd       DIR                8,5
    4096          2 /
rbd        5996             root  rtd       DIR                8,5
    4096          2 /
rbd        5996             root  txt   unknown
                    /proc/5996/exe



On Sun, Feb 5, 2017 at 4:26 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Sat, Feb 4, 2017 at 12:20 AM, Max Yehorov <myehorov@skytap.com> wrote:
>> It is certainly annoying. It does not allow to umount for hours.
>
> For hours?  Does it succeed after X number of hours?
>
>>> Does umount error out or hang forever?
>> umount errors out. with
>> umount: target is busy
>>         (In some cases useful info about processes that
>>          use the device is found by lsof(8) or fuser(1).)
>>
>> Maybe this will help?
>>
>> - lsof, for the rbd device in question, shows it is in use by pid 5926
>>
>> dio/rbd0  5926  root  cwd   DIR                8,5   4096          2 /
>> dio/rbd0  5926  root  rtd     DIR                8,5   4096          2 /
>> dio/rbd0  5926  root  txt     unknown                   /proc/5926/exe
>
> This doesn't say that /dev/rbd0 is in use by pid 5926.  It says that
> there is a process with the name "dio/rbd0", that's all.
>
> I'm guessing you ran plain "lsof" with no arguments here.  Were there
> other */rbd0 matches, like jbd2/rbd0?
>
>>
>> - PID 5926 is dio, it seems like a kernel thread
>> ps ax | grep 5926
>>  5926 ?        S<     0:00 [dio/rbd0]
>>
>> - Also, there is no more dio but that one
>> ps ax | grep dio
>>  5926 ?        S<     0:00 [dio/rbd0]
>
> It's a kernel workqueue, its presence itself doesn't mean much:
>
> $ sudo mkfs.ext4 /dev/rbd0
> ...
> $ sudo mount /dev/rbd0 /mnt
> $ pgrep -a dio # nothing
> $ sudo fio --ioengine=libaio --direct=1 --name=test
> --filename=/mnt/test --bs=4k --size=16M --readwrite=randwrite
> ...
> $ pgrep -a dio
> 1254 dio/rbd0
> $ ps 1254
>   PID TTY      STAT   TIME COMMAND
>  1254 ?        S<     0:00 [dio/rbd0]
> $ sudo umount /mnt # OK
>
> Thanks,
>
>                 Ilya
