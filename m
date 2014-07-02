From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Wed, 2 Jul 2014 07:00:28 -0700
Message-ID: <CAPYLRziFqZYFn4E22oE+-HXXcRppzwY=h2TbDuCErSixzZ=eWQ@mail.gmail.com>
References: <539B11C4.1010400@profihost.ag>
	<CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
	<53AD1411.101@profihost.ag>
	<CAPYLRzhJ_3WkWSFUAx+w+gt5PTLD7SYmSyQ-xPRZ31ahN4a1Ag@mail.gmail.com>
	<53B40292.2000108@profihost.ag>
	<CACJqLyZYpEJYUn5m5B4LCGGfszY_xPjui5q7HShQuotBkVDt4Q@mail.gmail.com>
	<53B40526.7080907@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:40916 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbaGBOA3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jul 2014 10:00:29 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so10047600qcy.15
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jul 2014 07:00:28 -0700 (PDT)
In-Reply-To: <53B40526.7080907@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Yeah, it's fighting for attention with a lot of other urgent stuff. :(

Anyway, even if you can't look up any details or reproduce at this
time, I'm sure you know what shape the cluster was (number of OSDs,
running on SSDs or hard drives, etc), and that would be useful
guidance. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Jul 2, 2014 at 6:12 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>
> Am 02.07.2014 15:07, schrieb Haomai Wang:
>> Could you give some perf counter from rbd client side? Such as op latency?
>
> Sorry haven't any counters. As this mail was some days unseen - i
> thought nobody has an idea or could help.
>
> Stefan
>
>> On Wed, Jul 2, 2014 at 9:01 PM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>>> Am 02.07.2014 00:51, schrieb Gregory Farnum:
>>>> On Thu, Jun 26, 2014 at 11:49 PM, Stefan Priebe - Profihost AG
>>>> <s.priebe@profihost.ag> wrote:
>>>>> Hi Greg,
>>>>>
>>>>> Am 26.06.2014 02:17, schrieb Gregory Farnum:
>>>>>> Sorry we let this drop; we've all been busy traveling and things.
>>>>>>
>>>>>> There have been a lot of changes to librados between Dumpling and
>>>>>> Firefly, but we have no idea what would have made it slower. Can you
>>>>>> provide more details about how you were running these tests?
>>>>>
>>>>> it's just a normal fio run:
>>>>> fio --ioengine=rbd --bs=4k --name=foo --invalidate=0
>>>>> --readwrite=randwrite --iodepth=32 --rbdname=fio_test2 --pool=teststor
>>>>> --runtime=90 --numjobs=32 --direct=1 --group
>>>>>
>>>>> Running one time with firefly libs and one time with dumpling libs.
>>>>> Traget is always the same pool on a firefly ceph storage.
>>>>
>>>> What's the backing cluster you're running against? What kind of CPU
>>>> usage do you see with both? 25k IOPS is definitely getting up there,
>>>> but I'd like some guidance about whether we're looking for a reduction
>>>> in parallelism, or an increase in per-op costs, or something else.
>>>
>>> Hi Greg,
>>>
>>> i don't have that test cluster anymore. It had to go into production
>>> with dumpling.
>>>
>>> So i can't tell you.
>>>
>>> Sorry.
>>>
>>> Stefan
>>>
>>>> -Greg
>>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>>
