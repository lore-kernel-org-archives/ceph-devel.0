From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Object Write Latency
Date: Mon, 23 Sep 2013 09:34:12 +0200
Message-ID: <CABZ+qq=nifAW1ptdtSOGb=bZ5x6TLndfWKm1Yj=JXSG_51begQ@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch> <523C4981.9080406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:41424 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab3IWHez (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 03:34:55 -0400
Received: by mail-bk0-f52.google.com with SMTP id e11so999176bkh.25
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 00:34:54 -0700 (PDT)
Received: by mail-la0-f46.google.com with SMTP id eh20so2179872lab.33
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 00:34:52 -0700 (PDT)
In-Reply-To: <523C4981.9080406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 20, 2013 at 3:11 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> On 09/20/2013 07:27 AM, Andreas Joachim Peters wrote:
>>
>> Hi,
>
>
> Hi Andreas!
>
>
>>
>> we made some benchmarks about object read/write latencies on the CERN ceph
>> installation.
>>
>> The cluster has 44 nodes and ~1k disks, all on 10GE and the pool
>> configuration has 3 copies.
>> Client & Server is 0.67.
>>
>> The latencies we observe (using tiny objects ... 5 bytes) on the idle
>> pool:
>>
>> write full object(sync) ~65-80ms
>> append to object ~60-75ms
>> set xattr object ~65-80ms
>> lock object ~65-80ms
>> stat object ~1ms
>>
>> We seem to saturate the pools writing ~ 20k objects/s (= internally
>> 60k/s).
>
>
> Out of curiosity, how much difference do you see with write latencies if you
> do the same thing to a pool with 1 copy?

# 3 copies:
[root@p05151113777233 ~]# rados bench -p test 10 write -t 1 -b 1
 Maintaining 1 concurrent writes of 1 bytes for up to 10 seconds or 0 objects
...
Average Latency:        0.0655107
Stddev Latency:         0.0156095
Max latency:            0.113482
Min latency:            0.033944


# 1 copy:
[root@p01001532149022 ~]# rados bench -p test 10 write -t 1 -b 5
 Maintaining 1 concurrent writes of 5 bytes for up to 10 seconds or 0 objects
...
Average Latency:        0.0470315
Stddev Latency:         0.0204646
Max latency:            0.097039
Min latency:            0.004141


Cheers, Dan

>
>
>>
>> Is there an easy explanation for 80 ms (quasi without payload) and a
>> possible tuning to reduce that?
>> I measured (append few bytes +fsync) on such a disk around 33ms which
>> explains probably part of the latency.
>
>
> I've been wanting to really dig into object write latency in RADOS but just
> haven't had the time to devote to it yet.  I've been doing some simple rados
> bench tests to a 8-SSD test node and am topping out at about 8-9K write IOPS
> and 26K read IOPS (no replication) though with little tuning.  I suspect
> there are many areas in the code where we could improve things.
>
>
>>
>> Then I tried with the async API to see if there is a difference in the
>> measurement between wait_for_complete or wait_for_safe ... shouldn't
>> wait_for_complete be much shorter, but I get always comparable results ...
>
>
> Hrm, I'm going to let Sage or someone else comment on this.
>
>>
>> Thanks, Andreas.--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
