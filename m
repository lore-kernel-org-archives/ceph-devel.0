From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Jewel 10.2.7 client IOPS drops to zero freqently
Date: Wed, 14 Jun 2017 17:05:11 -0700
Message-ID: <CAJ4mKGYPCF36=VMOJHm4Cw8NQjgOhPcCxPxsmO464qwc3vgBOA@mail.gmail.com>
References: <CAB=cV2RgFVgv+559haqcW50GmKV=629FCOzJtOkZv6HfJk0P3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35095 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdFOAFN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 20:05:13 -0400
Received: by mail-io0-f175.google.com with SMTP id k93so1997793ioi.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 17:05:12 -0700 (PDT)
In-Reply-To: <CAB=cV2RgFVgv+559haqcW50GmKV=629FCOzJtOkZv6HfJk0P3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianjian Huo <samuel.huo@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jun 14, 2017 at 2:32 PM, Jianjian Huo <samuel.huo@gmail.com> wrote:
> Hi,
>
> At Alibaba, we experienced unstable performance with Jewel on one
> production cluster, and we can easily reproduce it now with several
> small test clusters. One test cluster has 30 SSDs, and another test
> one has 120 SSDs, we are using filestore+async messenger on the
> backend and fio+librbd to test them. When this issue happens, client
> fio IOPS drops to zero (or close to zero) frequently during fio runs.
> And the durations of those drops were very short, about 1 second or
> so.
>
> For the 30 SSDs test cluster, we use 135 client fio writing into 135
> rbd images individually, each fio has only 1 job and rate limit is
> 3MB/s. On this fresh created test cluster, for all 135 client fio
> runs, during first 15 minutes or so, client IOPS were very stable and
> each OSD server's throughput was very stable as well. After 15 minutes
> and 360 GB data written, the test cluster entered an unstable state,
> client fio IOPS dropped to zero (or close) frequently and each OSD
> server's throughput became very spiky as well (from 500MB/s to less
> 1MB/s). We tried let all fio keeping writing for about 16 hours,
> cluster was still in this swing state.
>
> This is very easily reproducible. I don't think it's caused by
> filestore folder splitting, since they were all done during the first
> 15 minutes. And also, OSD server mem/cpu/disk were far from saturated.
> One thing we noticed from perf counter is that op_latency increased
> from 0.7 ms to >20 ms after entering this unstable state. Is this
> normal Jewel/filestore behavior? Anyone knows what causes it?

This sounds a lot like you're overrunning your journal and flushing
the data out to xfs isn't going smoothly. You can look at the
perfcounters to see what your throttles look like, your journal space
used, etc and try adjusting those config values to keep it running at
a maintainable level. There's lots of tuning space here and we don't
have a good auto-tuning system, unfortunately.
-Greg

>
> Thanks,
> Jianjian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
