From: Jianjian Huo <samuel.huo@gmail.com>
Subject: Re: Jewel 10.2.7 client IOPS drops to zero freqently
Date: Mon, 26 Jun 2017 10:57:41 -0700
Message-ID: <CAB=cV2Ts8shRZz=PbprekQTYA8kMfk1jwZ763Xadcs3g6_fDcQ@mail.gmail.com>
References: <CAB=cV2RgFVgv+559haqcW50GmKV=629FCOzJtOkZv6HfJk0P3w@mail.gmail.com>
 <CAJ4mKGYPCF36=VMOJHm4Cw8NQjgOhPcCxPxsmO464qwc3vgBOA@mail.gmail.com> <CAMwhyqXfHF+TYqJMhn6cqGiLfrg4ik2fMu=-y8HJgRhv30ZJZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:36082 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdFZR6C (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jun 2017 13:58:02 -0400
Received: by mail-ot0-f180.google.com with SMTP id 95so6376310ott.3
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jun 2017 10:58:02 -0700 (PDT)
In-Reply-To: <CAMwhyqXfHF+TYqJMhn6cqGiLfrg4ik2fMu=-y8HJgRhv30ZJZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks, Greg.
Actually, we found two problems related to this issue. One is NIC
driver memory allocation failure issue, another one is the PR
mentioned by Pan. After those problems were fixed, we don't see those
IOPS drops anymore. :-)

Jianjian

On Sun, Jun 25, 2017 at 6:38 AM, =E6=94=80=E5=88=98 <liupan1111@gmail.com> =
wrote:
> hi Gregory and Sage,
>
> This issue has been resolved by alibaba group with PR
> https://github.com/ceph/ceph/pull/15891. During the debug phrase, we
> added "max latency perf counters=E2=80=9D to dump max latency of each par=
t of
> io path, and finally catch it by perf dump.
>
> For current perf counters in ceph, we could get total latency and
> total count, and it is useful For watching average latency , but not
> very helpful For long tail latency, or latency wave. Yes, we could
> also use lttng, but there will lots of output before bad happens, not
> good user experience, also make cluster slow down. so Do you agree max
> latency perf counter is a good method? We are pleasure to pull a
> request with our changes if you agree.
>
> Thanks
> Pan from Alibaba
>
> 2017-06-15 8:05 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>> On Wed, Jun 14, 2017 at 2:32 PM, Jianjian Huo <samuel.huo@gmail.com> wro=
te:
>>> Hi,
>>>
>>> At Alibaba, we experienced unstable performance with Jewel on one
>>> production cluster, and we can easily reproduce it now with several
>>> small test clusters. One test cluster has 30 SSDs, and another test
>>> one has 120 SSDs, we are using filestore+async messenger on the
>>> backend and fio+librbd to test them. When this issue happens, client
>>> fio IOPS drops to zero (or close to zero) frequently during fio runs.
>>> And the durations of those drops were very short, about 1 second or
>>> so.
>>>
>>> For the 30 SSDs test cluster, we use 135 client fio writing into 135
>>> rbd images individually, each fio has only 1 job and rate limit is
>>> 3MB/s. On this fresh created test cluster, for all 135 client fio
>>> runs, during first 15 minutes or so, client IOPS were very stable and
>>> each OSD server's throughput was very stable as well. After 15 minutes
>>> and 360 GB data written, the test cluster entered an unstable state,
>>> client fio IOPS dropped to zero (or close) frequently and each OSD
>>> server's throughput became very spiky as well (from 500MB/s to less
>>> 1MB/s). We tried let all fio keeping writing for about 16 hours,
>>> cluster was still in this swing state.
>>>
>>> This is very easily reproducible. I don't think it's caused by
>>> filestore folder splitting, since they were all done during the first
>>> 15 minutes. And also, OSD server mem/cpu/disk were far from saturated.
>>> One thing we noticed from perf counter is that op_latency increased
>>> from 0.7 ms to >20 ms after entering this unstable state. Is this
>>> normal Jewel/filestore behavior? Anyone knows what causes it?
>>
>> This sounds a lot like you're overrunning your journal and flushing
>> the data out to xfs isn't going smoothly. You can look at the
>> perfcounters to see what your throttles look like, your journal space
>> used, etc and try adjusting those config values to keep it running at
>> a maintainable level. There's lots of tuning space here and we don't
>> have a good auto-tuning system, unfortunately.
>> -Greg
>>
>>>
>>> Thanks,
>>> Jianjian
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
