From: =?UTF-8?Q?Pawe=c5=82_Sadowski?= <pawel@sadziu.pl>
Subject: Re: Single slow OSD can cause unfound object
Date: Tue, 11 Oct 2016 21:34:29 +0200
Message-ID: <8b92ccce-1e31-7a0d-06d0-9126c3d02ffd@sadziu.pl>
References: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl>
 <alpine.DEB.2.11.1610111340430.31080@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from h82-143-163-170-static.e-wro.net.pl ([82.143.163.170]:39544
        "EHLO mail.sadziu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbcJKUKV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 16:10:21 -0400
In-Reply-To: <alpine.DEB.2.11.1610111340430.31080@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

W dniu 11.10.2016 o 15:45, Sage Weil pisze:

> Hi Pawel,
>
> On Tue, 11 Oct 2016, Paweł Sadowski wrote:
>> Hi,
>>
>> I managed to trigger unfound objects on a pool with size 3 and min_size
>> 2 just by removing 'slow' OSD (out and then stop) which is quite
>> frightening. Shouldn't Ceph stop IO if there is only one copy in this
>> case (even during recovery/peering/etc)? I'm able to reproduce this on
>> Hammer (0.94.5, 0.94.9) and Jewel (10.2.3). So far I wasn't able to
>> trigger this behavior by just stopping such OSD (still testing).
> This is definitely concerning.  I have a couple questions...
>
> 1. Looking at the log, I see that at one point all of the OSDs mark
> themselves down, here:
>
> 2016-10-11 08:46:23.473335 mon.0 10.99.128.50:6789/0 3275 : cluster [INF]
> osd.1 marked itself down
>
> Do you know why they do that?

It's probably due to load triggered by rebalance after marking OSD out.
In other tests OSDs stayed up during this period. It didn't happen
in my last test (logs posted via ceph-post-file).

> 2. Are you throttling the CPU on just a single OSD, or on a whole host?  I
> also see that the monitors are calling elections.  (This shouldn't have
> anything to do with the problem, but I'm not sure I understand the test
> setup.)

I'm throttling CPU for single OSD process (in our production we had disk
that was slowing down OSD). Monitors share device with one of the OSD.
Sometimes election happens after marking OSD out, sometimes not. Probably
caused by load on the underlaying device (didn't happen in last test).

>> Second thing: throttling mechanism is blocking recovery operations/whole
>> OSD[4] when there is a lot of client requests for missing objects. I
>> think it shouldn't be like that.
> Yeah, there is a similar problem with a PG is inactive and requests pile
> up, eventually preventing ops even on active PGs... and 'ceph tell $pgid
> query' admin commands.  It's non-trivial to fix, though: we need a way to
> inform the client that a PG or individual object is blocked so that they
> stop sending requests... and then also a way to inform them that the PG is
> unblocked so they can start again.

OK. Is it wise to increase this throttling limit and if yes how much?
Anyway, in the end it'll probably just delay moment until OSD is blocked.

>> 1: logs from Jewel
>> https://gist.github.com/anonymous/c8618adca8984132c82f16c351222883
> Do you mind reproducing this sequence with debug ms = 1, debug osd = 20,
> and capture all of the OSD logs as well as the cluster ceph.log?  You can
> send us the tarball with the ceph-post-file utility.

Sure. Gzipped logs are about ~2.7G, ceph-post-file id:
7e16f69e-c410-49c2-b11c-e727854ce7b3

> Thanks!
> sage
>
>> 2: steps to reproduce
>>   - put some load on the cluster (run FIO with high iodepth)
>>   - slow down single OSD (in my case reduce CPU time using cgroups:
>> cpu.cfs_quota_us 15000)
>>   - sleep 120
>>   - ceph osd out 6
>>   - sleep 15
>>   - stop ceph-osd id=6
>>   - unfound objects appear
>>
>> This is not 100% reproducible but in my test lab (9 OSDs) I'm able to
>> trigger this very easily.
>>
>> 3:
>> mon-01:~ # ceph osd pool get rbd size
>> size: 3
>> mon-01:~ # ceph osd pool get rbd min_size
>> min_size: 2
>> mon-01:~ # ceph --version
>> ceph version 10.2.3 (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)
>>
>> 4:
>> perf dump | grep -A 2 'throttle-osd_client_messages'
>>      "throttle-osd_client_messages": {
>>          "val": 100,
>>          "max": 100,
>>
>> ops_in_flight:
>> https://gist.github.com/anonymous/643607fa3f959c91ba7a9794e5d99dea

Thanks!


-- 
PS

