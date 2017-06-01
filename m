From: han vincent <hangzws@gmail.com>
Subject: Re: Beta testing crush optimization
Date: Thu, 1 Jun 2017 19:38:32 +0800
Message-ID: <CANNfkuZF219VWnCYYQoPY7CXXBAFq1=BrfOyC_vL7-+nU5ixMg@mail.gmail.com>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org> <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org>
 <CANNfkubxHfAYn-aLkHCQV_YZoMuVTzug9nRbvaTSE4UyKiQLuw@mail.gmail.com>
 <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org> <CANNfkuZbfNSW5CQHaV0yyF3744FPf-gh0vKBj45bZKrvZ27MhA@mail.gmail.com>
 <eefdcd45-e6fa-4bf0-56b3-76e155f45de2@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36156 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdFALid (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 07:38:33 -0400
Received: by mail-it0-f45.google.com with SMTP id m47so34971300iti.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 04:38:33 -0700 (PDT)
In-Reply-To: <eefdcd45-e6fa-4bf0-56b3-76e155f45de2@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

2017-06-01 18:21 GMT+08:00 Loic Dachary <loic@dachary.org>:
>
>
> On 06/01/2017 12:05 PM, han vincent wrote:
>> Hi loic:
>>    I still have two questions, in the following to commands:
>>
>>    1. crush optimize --crushmap /tmp/han-vincent-report.json --out-path =
/tmp/han-vincent-report-optimized.txt --out-format txt --pool 49
>>
>>    Is "--pool" options must specified in this command? if not, will it o=
ptimize all the pools without "--pool" option?
>>    if there are several pools in my cluster and each pool has a lot of p=
gs. If I optimize one of the, will it affect the other pools?
>>    how to use it to optimize multiple pools in a cluster of hammer?
>>
>>    2. crush analyze --crushmap /tmp/han-vincent-report-optimized.txt --p=
ool 49 --replication-count=3D2 --pg-num=3D1024 --pgp-num=3D1024 --rule=3Dre=
plicated_ruleset --choose-args=3D49
>>    In this command, the value of the "--choose-args" option is 49, it is=
 same as the pool id, what is the mean of "--choose-args" option?
>>
>
> The --pool option is required. You can only optimize one pool at a time.
>
> If multiple pools use the same crush rule or the same crush hierarchy, re=
balancing one of them will hurt the balance of the others. It is possible t=
o optimize multiple pools but only if they have different rules and crush h=
iearchies.
>
> The --choose-args option is the name of the weights that achieve the reba=
lancing. By convention it is the same as the pool id: this is required by L=
uminous clusters. Even though your cluster is not luminous, we stick to thi=
s convention.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

 if the pools use the same crush rule or the same crush hierarchy, is
there any way to optimize the cluster?
