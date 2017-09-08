From: Mark Nelson <mnelson@redhat.com>
Subject: Re: very slow backfill on Luminous + Bluestore
Date: Fri, 8 Sep 2017 10:46:15 -0500
Message-ID: <f60827b0-fc54-b72e-adec-a2df6a822b04@redhat.com>
References: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
 <alpine.DEB.2.11.1709081528560.16664@piezo.novalocal>
 <CAEYCsVJEiFra_gun33a=ROvQhosmPLZtYr04w+q5TcCU8C+6MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdIHPqR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 8 Sep 2017 11:46:17 -0400
In-Reply-To: <CAEYCsVJEiFra_gun33a=ROvQhosmPLZtYr04w+q5TcCU8C+6MQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Anything strange with CPU/IO usage?  perf or gdbprof might be useful to 
see if it's hanging up on anything.

Mark

On 09/08/2017 10:41 AM, Xiaoxi Chen wrote:
> Not changing significantly, still like
>
> 8192 pgs: 36 active+degraded+remapped+backfill_wait, 89
> active+recovery_wait+degraded+remapped, 95
> active+undersized+degraded+remapped+backfilling, 2498
> active+undersized+degraded
> +remapped+backfill_wait, 1159 active+clean, 75
> active+remapped+backfilling, 4240 active+remapped+backfill_wait; 5494
> GB data, 20554 GB used, 3061 TB / 3082 TB avail; 920 kB/s wr,
> 163 op/s; 413811/4301073 objects degraded (9.621%); 3126592/4301073
> objects misplaced (72.693%); 9832 kB/s, 2 objects/s recovering
>
> 2017-09-08 23:29 GMT+08:00 Sage Weil <sage@newdream.net>:
>> On Fri, 8 Sep 2017, Xiaoxi Chen wrote:
>>> Hi,
>>>
>>>      We consistently saw very slow backfilling speed on our cluster,
>>> although max_backfill set to 50 and do have tens of PGs in
>>> backfilling, but the recovery speed still are only tens of MB, even 0
>>> in some time.
>>>
>>>       The background is, we first have a pool with all bluestore(on
>>> hdd, db also on hdd) hosting ~ 6TB data across 24 OSDs.  Then we have
>>> another 24 OSDs with db on SSD.  I was trying to migrade the data from
>>> the old 24 OSDs to new 24 OSDs, with DB on SSD.
>>>       So what I did is reweight crush weight of all old OSD to 0 and
>>> all new OSDs to 5, obviously almost all object will goes to misplaced
>>> state and PGs are in "active + remaped+ backfilling/wait_backfill".
>>> Everything looks fine except the backfilling speed is extermply low.
>>>
>>> See below pg stat output for instance, pls ignore the degraded PG ,
>>> that was due to I manually mark down 2 old OSDs, just to see if it
>>> could change anything, but nothing.
>>>
>>>     Every 2.0s: ceph pg stat --cluster pre-prod
>>>
>>>                  Fri Sep  8 08:13:10 2017
>>>
>>> 8192 pgs: 89 undersized+degraded+remapped+backfilling+peered, 324
>>> undersized+degraded+remapped+backfill_wait+peered, 36
>>> active+undersized+degraded+remapped+backfilling, 2595 activ
>>> e+undersized+degraded+remapped+backfill_wait, 1088 active+clean, 46
>>> active+remapped+backfilling, 4014 active+remapped+backfill_wait; 5494
>>> GB data, 18768 GB used, 3047 TB / 3065 TB
>>>  avail; 325 kB/s wr, 64 op/s; 539794/4301028 objects degraded
>>> (12.550%); 3025778/4301028 objects misplaced (70.350%); 28794 kB/s, 7
>>> objects/s recovering
>>
>> Can you try setting
>>
>>   osd_recovery_sleep = 0
>>
>> on the OSDs and see if that makes a difference?
>>
>> sage
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
