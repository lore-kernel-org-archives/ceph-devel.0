From: han vincent <hangzws@gmail.com>
Subject: Re: Beta testing crush optimization
Date: Thu, 1 Jun 2017 20:32:42 +0800
Message-ID: <CANNfkubUEyxupv_fc=X6yNht1enwwjWbwXsX4T=DDHiLeDYkGw@mail.gmail.com>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org> <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org>
 <CANNfkubxHfAYn-aLkHCQV_YZoMuVTzug9nRbvaTSE4UyKiQLuw@mail.gmail.com>
 <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org> <CANNfkuZbfNSW5CQHaV0yyF3744FPf-gh0vKBj45bZKrvZ27MhA@mail.gmail.com>
 <eefdcd45-e6fa-4bf0-56b3-76e155f45de2@dachary.org> <CANNfkuZF219VWnCYYQoPY7CXXBAFq1=BrfOyC_vL7-+nU5ixMg@mail.gmail.com>
 <6721f5e4-4da0-868c-6d65-c180fdb564e0@dachary.org> <CANNfkuY1KfLb=WR2scJKb82RKqGAwUB3wWSrPzvht-=ixsfhGg@mail.gmail.com>
 <5c2c692a-99c3-4b33-33bd-b9523943d7a4@dachary.org> <CANNfkubHKXhdaF5p2kOxfhTe-W3H=OmyyJ4hM+e10X=UB+rjEg@mail.gmail.com>
 <e7c26a8f-e0cc-ff35-e4ae-6326846a1e02@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35873 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdFAMcn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 08:32:43 -0400
Received: by mail-it0-f41.google.com with SMTP id m47so36486222iti.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 05:32:43 -0700 (PDT)
In-Reply-To: <e7c26a8f-e0cc-ff35-e4ae-6326846a1e02@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

OK, but i do not want to upgrade my cluster to Luminous. There are
lots of data in my cluster and it have run stable for nearly one year.
I think the risk of upgrade to Luminous will be relatively large.

2017-06-01 20:23 GMT+08:00 Loic Dachary <loic@dachary.org>:
>
>
> On 06/01/2017 02:17 PM, han vincent wrote:
>> you can get the crushmap from
>> https://drive.google.com/open?id=3D0B5Kd4hBGEUvnUU9BcWY1NWtWNHM.
>
> Got it. You may want to remove it now as you probably don't want to expos=
e all the informations it contains to the general public.
>
> Cheers
>
>>
>> 2017-06-01 20:08 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>
>>>
>>> On 06/01/2017 01:52 PM, han vincent wrote:
>>>> 2017-06-01 19:43 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>>
>>>>>
>>>>> On 06/01/2017 01:38 PM, han vincent wrote:
>>>>>> 2017-06-01 18:21 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>>>>
>>>>>>>
>>>>>>> On 06/01/2017 12:05 PM, han vincent wrote:
>>>>>>>> Hi loic:
>>>>>>>>    I still have two questions, in the following to commands:
>>>>>>>>
>>>>>>>>    1. crush optimize --crushmap /tmp/han-vincent-report.json --out=
-path /tmp/han-vincent-report-optimized.txt --out-format txt --pool 49
>>>>>>>>
>>>>>>>>    Is "--pool" options must specified in this command? if not, wil=
l it optimize all the pools without "--pool" option?
>>>>>>>>    if there are several pools in my cluster and each pool has a lo=
t of pgs. If I optimize one of the, will it affect the other pools?
>>>>>>>>    how to use it to optimize multiple pools in a cluster of hammer=
?
>>>>>>>>
>>>>>>>>    2. crush analyze --crushmap /tmp/han-vincent-report-optimized.t=
xt --pool 49 --replication-count=3D2 --pg-num=3D1024 --pgp-num=3D1024 --rul=
e=3Dreplicated_ruleset --choose-args=3D49
>>>>>>>>    In this command, the value of the "--choose-args" option is 49,=
 it is same as the pool id, what is the mean of "--choose-args" option?
>>>>>>>>
>>>>>>>
>>>>>>> The --pool option is required. You can only optimize one pool at a =
time.
>>>>>>>
>>>>>>> If multiple pools use the same crush rule or the same crush hierarc=
hy, rebalancing one of them will hurt the balance of the others. It is poss=
ible to optimize multiple pools but only if they have different rules and c=
rush hiearchies.
>>>>>>>
>>>>>>> The --choose-args option is the name of the weights that achieve th=
e rebalancing. By convention it is the same as the pool id: this is require=
d by Luminous clusters. Even though your cluster is not luminous, we stick =
to this convention.
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> --
>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>
>>>>>>  if the pools use the same crush rule or the same crush hierarchy, i=
s
>>>>>> there any way to optimize the cluster?
>>>>>
>>>>> It depends on the pools. In your cluster it does not matter because a=
ll pools except pool 49 are mostly empty. You can rebalance pool 49 and lea=
ve the other pool alone.
>>>>>
>>>>> Cheers
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>> the crushmap of which cluster I send to you is in lab environment, I
>>>> have a much bigger cluster in production.
>>>> I will send the crushmap to you later, could you help me to optimize
>>>> this cluster?
>>>
>>> It is an interesting use case, I will help.
>>>
>>>> If you have detailed steps, please send it to me.
>>>
>>> Using the output of "ceph report" cluster, I will be able to verify it =
works as expected. The steps are simple but they will require an upgrade to=
 Luminous.
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
