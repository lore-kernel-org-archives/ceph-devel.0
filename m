From: han vincent <hangzws@gmail.com>
Subject: Re: Beta testing crush optimization
Date: Thu, 1 Jun 2017 19:52:54 +0800
Message-ID: <CANNfkuY1KfLb=WR2scJKb82RKqGAwUB3wWSrPzvht-=ixsfhGg@mail.gmail.com>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org> <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org>
 <CANNfkubxHfAYn-aLkHCQV_YZoMuVTzug9nRbvaTSE4UyKiQLuw@mail.gmail.com>
 <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org> <CANNfkuZbfNSW5CQHaV0yyF3744FPf-gh0vKBj45bZKrvZ27MhA@mail.gmail.com>
 <eefdcd45-e6fa-4bf0-56b3-76e155f45de2@dachary.org> <CANNfkuZF219VWnCYYQoPY7CXXBAFq1=BrfOyC_vL7-+nU5ixMg@mail.gmail.com>
 <6721f5e4-4da0-868c-6d65-c180fdb564e0@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:36280 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdFALw4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 07:52:56 -0400
Received: by mail-it0-f42.google.com with SMTP id m47so35344987iti.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 04:52:55 -0700 (PDT)
In-Reply-To: <6721f5e4-4da0-868c-6d65-c180fdb564e0@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

2017-06-01 19:43 GMT+08:00 Loic Dachary <loic@dachary.org>:
>
>
> On 06/01/2017 01:38 PM, han vincent wrote:
>> 2017-06-01 18:21 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>
>>>
>>> On 06/01/2017 12:05 PM, han vincent wrote:
>>>> Hi loic:
>>>>    I still have two questions, in the following to commands:
>>>>
>>>>    1. crush optimize --crushmap /tmp/han-vincent-report.json --out-pat=
h /tmp/han-vincent-report-optimized.txt --out-format txt --pool 49
>>>>
>>>>    Is "--pool" options must specified in this command? if not, will it=
 optimize all the pools without "--pool" option?
>>>>    if there are several pools in my cluster and each pool has a lot of=
 pgs. If I optimize one of the, will it affect the other pools?
>>>>    how to use it to optimize multiple pools in a cluster of hammer?
>>>>
>>>>    2. crush analyze --crushmap /tmp/han-vincent-report-optimized.txt -=
-pool 49 --replication-count=3D2 --pg-num=3D1024 --pgp-num=3D1024 --rule=3D=
replicated_ruleset --choose-args=3D49
>>>>    In this command, the value of the "--choose-args" option is 49, it =
is same as the pool id, what is the mean of "--choose-args" option?
>>>>
>>>
>>> The --pool option is required. You can only optimize one pool at a time=
.
>>>
>>> If multiple pools use the same crush rule or the same crush hierarchy, =
rebalancing one of them will hurt the balance of the others. It is possible=
 to optimize multiple pools but only if they have different rules and crush=
 hiearchies.
>>>
>>> The --choose-args option is the name of the weights that achieve the re=
balancing. By convention it is the same as the pool id: this is required by=
 Luminous clusters. Even though your cluster is not luminous, we stick to t=
his convention.
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>  if the pools use the same crush rule or the same crush hierarchy, is
>> there any way to optimize the cluster?
>
> It depends on the pools. In your cluster it does not matter because all p=
ools except pool 49 are mostly empty. You can rebalance pool 49 and leave t=
he other pool alone.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

the crushmap of which cluster I send to you is in lab environment, I
have a much bigger cluster in production.
I will send the crushmap to you later, could you help me to optimize
this cluster?
If you have detailed steps, please send it to me.
