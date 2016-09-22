From: Haomai Wang <haomai@xsky.com>
Subject: Re: async messenger random read performance on NVMe
Date: Thu, 22 Sep 2016 11:04:03 +0800
Message-ID: <CACJqLyZuheoQ6nMsYzYpoAxbV7ZarGiS_CbZVJZf0c7rsSuSfw@mail.gmail.com>
References: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0107.outbound.protection.outlook.com ([104.47.93.107]:15527
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932741AbcIVDER (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 23:04:17 -0400
Received: by mail-oi0-f54.google.com with SMTP id t83so83177682oie.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 20:04:11 -0700 (PDT)
In-Reply-To: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 22, 2016 at 2:49 AM, Mark Nelson <mnelson@redhat.com> wrote:
> Recently in master we made async messenger default.  After doing a bunch of
> bisection, it turns out that this caused a fairly dramatic decrease in
> bluestore random read performance.  This is on a cluster with fairly fast
> NVMe cards, 16 OSDs across 4 OSD hosts.  There are 8 fio client processes
> with 32 concurrent threads each.
>
> Ceph master using bluestore
>
> Parameters tweaked:
>
> ms_async_send_inline
> ms_async_op_threads
> ms_async_max_op_threads
>
> simple: 168K IOPS
>
> send_inline: true
> async 3/5   threads: 111K IOPS
> async 4/8   threads: 125K IOPS
> async 8/16  threads: 128K IOPS
> async 16/32 threads: 128K IOPS
> async 24/48 threads: 128K IOPS
> async 25/50 threads: segfault
> async 26/52 threads: segfault
> async 32/64 threads: segfault

YES, it's expected :-(. We don't allow more async threads.... The fix
is we limited async thread in graceful way instead of segment
fault....

>
> send_inline: false
> async 3/5   threads: 153K IOPS
> async 4/8   threads: 153K IOPS
> async 8/16  threads: 152K IOPS

hmm, send_inline means whether caller directly do ::sendmsg()
systemcall and the caller will dive into kernel tcp stack. When RR, I
think bottleneck is caller thread like pg thread, so it will limit max
bandwidth. But in other cases like iops less than 100w or RW,
send_inline will reduce per io latency.

Even false, it looks we still have a gap(10k) iops. Because each pipe
has two threads to serve request. For async, we need to try our best
to eliminate async thread work like fast_dispatch latency.

>
> So definitely setting send_inline to false helps pretty dramatically, though
> we're still a little slower for small random reads than simple messenger.
> Haomai, regarding the segfaults, I took a quick look with gdb at the core
> file but didn't see anything immediately obvious.  It might be worth seeing
> if you can reproduce.
>
> On the performance front, I'll try to see if I can see anything obvious in
> perf.
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
