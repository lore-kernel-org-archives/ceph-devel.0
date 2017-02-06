From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Possible bug in krbd (4.4.0)
Date: Mon, 6 Feb 2017 19:40:51 +0100
Message-ID: <CAOi1vP-NvU3adKdrZURfuyM4sb8F1b_xCReC3OM9tez8qxMRCw@mail.gmail.com>
References: <CAJDfiske056EADPT4g0fRUx=uh7C-F3ZzUh6A1ummfUZ6vMuTg@mail.gmail.com>
 <CAOi1vP9Jvnepv3PxFA1PO_vZnEJ-DRBsax_+U136GSWPzCc1Xw@mail.gmail.com>
 <CAJDfiskjz2H-D9xmanZ9opw+0pVAK=VmSPtFz1+fbcfPofOpmg@mail.gmail.com>
 <CAOi1vP9y2rSC=ZKQom0n+0RSHREpaPJ60497qpjYMGywTATJQA@mail.gmail.com> <CAJDfisku2Ld3F5hOAPjBqqnjV3gUWwC2kVXs3t2D+i=6waMmtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33992 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdBFSkx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 13:40:53 -0500
Received: by mail-wm0-f42.google.com with SMTP id 196so36607311wmm.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 10:40:53 -0800 (PST)
In-Reply-To: <CAJDfisku2Ld3F5hOAPjBqqnjV3gUWwC2kVXs3t2D+i=6waMmtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Max Yehorov <myehorov@skytap.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 6, 2017 at 7:26 PM, Max Yehorov <myehorov@skytap.com> wrote:
>> For hours?  Does it succeed after X number of hours?
> Still mounted from Feb 6. There is an attempt to unmount every 10 minutes.
>
>> This doesn't say that /dev/rbd0 is in use by pid 5926.  It says that
>> there is a process with the name "dio/rbd0", that's all.
>>
>> I'm guessing you ran plain "lsof" with no arguments here.  Were there
>> other */rbd0 matches, like jbd2/rbd0?
>
> The entire output
>
> :~# lsof | grep rbd
>
> dio/rbd0   5926             root  cwd       DIR                8,5
>     4096          2 /
> dio/rbd0   5926             root  rtd       DIR                8,5
>     4096          2 /
> dio/rbd0   5926             root  txt   unknown
>                     /proc/5926/exe
> rbd        5996             root  cwd       DIR                8,5
>     4096          2 /
> rbd        5996             root  rtd       DIR                8,5
>     4096          2 /
> rbd        5996             root  txt   unknown
>                     /proc/5996/exe

Is this xfs or ext4?

What is the output of "rbd showmapped"?

Is there anything in dmesg?  Can you provide a snippet?

Can you provide the output I requested in my first reply?

$ cat /sys/kernel/debug/ceph/<fsid>/osdc
$ echo w >/proc/sysrq-trigger
$ echo t >/proc/sysrq-trigger

Thanks,

                Ilya
