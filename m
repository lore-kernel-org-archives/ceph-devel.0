From: Loic Dachary <loic@dachary.org>
Subject: Re: Beta testing crush optimization
Date: Thu, 1 Jun 2017 14:08:17 +0200
Message-ID: <5c2c692a-99c3-4b33-33bd-b9523943d7a4@dachary.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33879 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFAMIV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 08:08:21 -0400
In-Reply-To: <CANNfkuY1KfLb=WR2scJKb82RKqGAwUB3wWSrPzvht-=ixsfhGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: han vincent <hangzws@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 06/01/2017 01:52 PM, han vincent wrote:
> 2017-06-01 19:43 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>
>>
>> On 06/01/2017 01:38 PM, han vincent wrote:
>>> 2017-06-01 18:21 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>
>>>>
>>>> On 06/01/2017 12:05 PM, han vincent wrote:
>>>>> Hi loic:
>>>>>    I still have two questions, in the following to commands:
>>>>>
>>>>>    1. crush optimize --crushmap /tmp/han-vincent-report.json --out-path /tmp/han-vincent-report-optimized.txt --out-format txt --pool 49
>>>>>
>>>>>    Is "--pool" options must specified in this command? if not, will it optimize all the pools without "--pool" option?
>>>>>    if there are several pools in my cluster and each pool has a lot of pgs. If I optimize one of the, will it affect the other pools?
>>>>>    how to use it to optimize multiple pools in a cluster of hammer?
>>>>>
>>>>>    2. crush analyze --crushmap /tmp/han-vincent-report-optimized.txt --pool 49 --replication-count=2 --pg-num=1024 --pgp-num=1024 --rule=replicated_ruleset --choose-args=49
>>>>>    In this command, the value of the "--choose-args" option is 49, it is same as the pool id, what is the mean of "--choose-args" option?
>>>>>
>>>>
>>>> The --pool option is required. You can only optimize one pool at a time.
>>>>
>>>> If multiple pools use the same crush rule or the same crush hierarchy, rebalancing one of them will hurt the balance of the others. It is possible to optimize multiple pools but only if they have different rules and crush hiearchies.
>>>>
>>>> The --choose-args option is the name of the weights that achieve the rebalancing. By convention it is the same as the pool id: this is required by Luminous clusters. Even though your cluster is not luminous, we stick to this convention.
>>>>
>>>> Cheers
>>>>
>>>> --
>>>> Loïc Dachary, Artisan Logiciel Libre
>>>
>>>  if the pools use the same crush rule or the same crush hierarchy, is
>>> there any way to optimize the cluster?
>>
>> It depends on the pools. In your cluster it does not matter because all pools except pool 49 are mostly empty. You can rebalance pool 49 and leave the other pool alone.
>>
>> Cheers
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
> 
> the crushmap of which cluster I send to you is in lab environment, I
> have a much bigger cluster in production.
> I will send the crushmap to you later, could you help me to optimize
> this cluster?

It is an interesting use case, I will help.

> If you have detailed steps, please send it to me.

Using the output of "ceph report" cluster, I will be able to verify it works as expected. The steps are simple but they will require an upgrade to Luminous.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
