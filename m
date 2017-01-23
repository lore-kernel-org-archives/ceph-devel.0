From: kefu chai <tchaikov@gmail.com>
Subject: Re: monitor port closed
Date: Mon, 23 Jan 2017 21:12:43 +0800
Message-ID: <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com>
References: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38388 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWNMp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 08:12:45 -0500
Received: by mail-wm0-f49.google.com with SMTP id r144so154375479wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 05:12:44 -0800 (PST)
In-Reply-To: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ming Lin <minggr@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 1:32 PM, Ming Lin <minggr@gmail.com> wrote:
> Hi,
>
> [mon]
> mon initial members = a
>
> [mon.a]
> mon addr = 192.168.0.1:7000
>
> jewel release with 1 monitor and 3 OSDs.
>
> After hours of fio rbd test, the monitor binded port(7000) was closed
> for unknown reason.

is this reproduciable? can you enable ms-debug=1 and attach the log?

> But monitor is still running,
>
> # pidof ceph-mon
> 21980
>
> Another strange thing is there are more than 1000 threads for the
> ceph-mon process.
>
> # ls /proc/21980/task/ |wc -l
> 1022
>
> Any possible reason?

are you using the simple messenger? maybe you can use pstree to check
the thread names?

>
> Thanks,
> Ming
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
