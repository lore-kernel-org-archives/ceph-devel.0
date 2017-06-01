From: Loic Dachary <loic@dachary.org>
Subject: Re: Beta testing crush optimization
Date: Thu, 1 Jun 2017 14:49:05 +0200
Message-ID: <62744992-f6d9-7577-eb84-47c794a5fad4@dachary.org>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org>
 <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org>
 <CANNfkubxHfAYn-aLkHCQV_YZoMuVTzug9nRbvaTSE4UyKiQLuw@mail.gmail.com>
 <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org>
 <CANNfkuZbfNSW5CQHaV0yyF3744FPf-gh0vKBj45bZKrvZ27MhA@mail.gmail.com>
 <eefdcd45-e6fa-4bf0-56b3-76e155f45de2@dachary.org>
 <CANNfkuZF219VWnCYYQoPY7CXXBAFq1=BrfOyC_vL7-+nU5ixMg@mail.gmail.com>
 <6721f5e4-4da0-868c-6d65-c180fdb564e0@dachary.org>
 <CANNfkuY1KfLb=WR2scJKb82RKqGAwUB3wWSrPzvht-=ixsfhGg@mail.gmail.com>
 <5c2c692a-99c3-4b33-33bd-b9523943d7a4@dachary.org>
 <CANNfkubHKXhdaF5p2kOxfhTe-W3H=OmyyJ4hM+e10X=UB+rjEg@mail.gmail.com>
 <e7c26a8f-e0cc-ff35-e4ae-6326846a1e02@dachary.org>
 <CANNfkubUEyxupv_fc=X6yNht1enwwjWbwXsX4T=DDHiLeDYkGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52861 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdFAMtL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 08:49:11 -0400
In-Reply-To: <CANNfkubUEyxupv_fc=X6yNht1enwwjWbwXsX4T=DDHiLeDYkGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: han vincent <hangzws@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 06/01/2017 02:32 PM, han vincent wrote:
> OK, but i do not want to upgrade my cluster to Luminous. There are
> lots of data in my cluster and it have run stable for nearly one year.
> I think the risk of upgrade to Luminous will be relatively large.

In that case the first step is to move from straw to straw2. It will modify the following mappings:

2017-06-01 14:26:12,675 152.213a map to [432, 271, 451] instead of [432, 324, 275]
2017-06-01 14:26:12,693 152.7115 map to [334, 359, 0] instead of [334, 359, 229]
2017-06-01 14:26:12,715 152.1867 map to [416, 368, 433] instead of [416, 204, 19]
2017-06-01 14:26:12,741 152.6e3e map to [11, 161, 67] instead of [372, 161, 67]
2017-06-01 14:26:12,745 152.3385 map to [430, 325, 35] instead of [430, 325, 387]
2017-06-01 14:26:12,747 152.5c2c map to [303, 351, 0] instead of [303, 351, 90]
2017-06-01 14:26:12,777 152.d27 map to [171, 133, 52] instead of [171, 133, 63]
2017-06-01 14:26:12,780 152.c3d map to [235, 366, 83] instead of [235, 370, 83]
2017-06-01 14:26:12,826 152.54ad map to [86, 298, 92] instead of [86, 298, 318]
2017-06-01 14:26:12,832 152.18cb map to [17, 389, 97] instead of [17, 439, 97]
2017-06-01 14:26:12,852 152.716 map to [93, 37, 306] instead of [318, 37, 306]
2017-06-01 14:26:12,866 152.640e map to [220, 21, 120] instead of [220, 397, 120]
2017-06-01 14:26:12,883 152.6a3c map to [328, 245, 223] instead of [328, 347, 223]
2017-06-01 14:26:12,946 152.1bb6 map to [110, 302, 318] instead of [110, 207, 318]
2017-06-01 14:26:12,957 152.3366 map to [128, 78, 75] instead of [128, 78, 327]
2017-06-01 14:26:13,005 153.1a98 map to [320, 22, 180] instead of [320, 22, 181]
2017-06-01 14:26:13,026 153.5cf map to [9, 418, 344] instead of [9, 418, 435]
2017-06-01 14:26:13,069 153.f5d map to [168, 445, 7] instead of [168, 445, 236]

> 
> 2017-06-01 20:23 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>
>>
>> On 06/01/2017 02:17 PM, han vincent wrote:
>>> you can get the crushmap from
>>> https://drive.google.com/open?id=0B5Kd4hBGEUvnUU9BcWY1NWtWNHM.
>>
>> Got it. You may want to remove it now as you probably don't want to expose all the informations it contains to the general public.
>>
>> Cheers
>>
>>>
>>> 2017-06-01 20:08 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>
>>>>
>>>> On 06/01/2017 01:52 PM, han vincent wrote:
>>>>> 2017-06-01 19:43 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>>>
>>>>>>
>>>>>> On 06/01/2017 01:38 PM, han vincent wrote:
>>>>>>> 2017-06-01 18:21 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 06/01/2017 12:05 PM, han vincent wrote:
>>>>>>>>> Hi loic:
>>>>>>>>>    I still have two questions, in the following to commands:
>>>>>>>>>
>>>>>>>>>    1. crush optimize --crushmap /tmp/han-vincent-report.json --out-path /tmp/han-vincent-report-optimized.txt --out-format txt --pool 49
>>>>>>>>>
>>>>>>>>>    Is "--pool" options must specified in this command? if not, will it optimize all the pools without "--pool" option?
>>>>>>>>>    if there are several pools in my cluster and each pool has a lot of pgs. If I optimize one of the, will it affect the other pools?
>>>>>>>>>    how to use it to optimize multiple pools in a cluster of hammer?
>>>>>>>>>
>>>>>>>>>    2. crush analyze --crushmap /tmp/han-vincent-report-optimized.txt --pool 49 --replication-count=2 --pg-num=1024 --pgp-num=1024 --rule=replicated_ruleset --choose-args=49
>>>>>>>>>    In this command, the value of the "--choose-args" option is 49, it is same as the pool id, what is the mean of "--choose-args" option?
>>>>>>>>>
>>>>>>>>
>>>>>>>> The --pool option is required. You can only optimize one pool at a time.
>>>>>>>>
>>>>>>>> If multiple pools use the same crush rule or the same crush hierarchy, rebalancing one of them will hurt the balance of the others. It is possible to optimize multiple pools but only if they have different rules and crush hiearchies.
>>>>>>>>
>>>>>>>> The --choose-args option is the name of the weights that achieve the rebalancing. By convention it is the same as the pool id: this is required by Luminous clusters. Even though your cluster is not luminous, we stick to this convention.
>>>>>>>>
>>>>>>>> Cheers
>>>>>>>>
>>>>>>>> --
>>>>>>>> Loïc Dachary, Artisan Logiciel Libre
>>>>>>>
>>>>>>>  if the pools use the same crush rule or the same crush hierarchy, is
>>>>>>> there any way to optimize the cluster?
>>>>>>
>>>>>> It depends on the pools. In your cluster it does not matter because all pools except pool 49 are mostly empty. You can rebalance pool 49 and leave the other pool alone.
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>> --
>>>>>> Loïc Dachary, Artisan Logiciel Libre
>>>>>
>>>>> the crushmap of which cluster I send to you is in lab environment, I
>>>>> have a much bigger cluster in production.
>>>>> I will send the crushmap to you later, could you help me to optimize
>>>>> this cluster?
>>>>
>>>> It is an interesting use case, I will help.
>>>>
>>>>> If you have detailed steps, please send it to me.
>>>>
>>>> Using the output of "ceph report" cluster, I will be able to verify it works as expected. The steps are simple but they will require an upgrade to Luminous.
>>>>
>>>> Cheers
>>>>
>>>> --
>>>> Loïc Dachary, Artisan Logiciel Libre
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
