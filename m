From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: Rados bench decreasing performance for large data
Date: Wed, 9 Aug 2017 21:32:50 -0700
Message-ID: <CAFMfnwog0HMyRnQWbH+uG5E2S7aSuAmgSiEo4BqaeHXbat7BoQ@mail.gmail.com>
References: <CAODUPsE80Dan4YULo26OeEJtyghCUT9r-ux1qOOaT3A_w6gv0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:32907 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdHJEcv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Aug 2017 00:32:51 -0400
Received: by mail-yw0-f175.google.com with SMTP id p68so51985893ywg.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 21:32:51 -0700 (PDT)
In-Reply-To: <CAODUPsE80Dan4YULo26OeEJtyghCUT9r-ux1qOOaT3A_w6gv0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

64MB is pretty large for a rados bench object - most of the interfaces
above rados stripe at a 4MB boundary. It could be that larger sized
writes like those require adjusting various knobs in the OSD.

Do you see the same thing happen with 4MB work workloads?

What are your EC profile(s)?

On Wed, Aug 9, 2017 at 4:44 AM, Oleg Kolosov <olekol@gmail.com> wrote:
> Hi
> I've began experimenting with rados bench and I've noticed bizarre
> behavior for jerasure and lrc plugins. I'm writing very large amounts
> of data: ~2000 objects of size 64MB.
> When reading the data with 9 parallel client, I'm noticing a linear
> increase in latency around the middle of the read experiment (latency
> was steady up to that point).
> Is that an expected behavior?
> How can it be explained?
>
> Thanks,
> Oleg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Kyle Bader
