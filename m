From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] LRC low level plugin configuration can't express
 maximal erasure resilience
Date: Sun, 30 Apr 2017 00:13:15 +0200
Message-ID: <c3861738-1b6e-e02c-2bb5-d14cae17e8b8@dachary.org>
References: <gHAYZJ1TyZwY4DvF8kONBaLjzLW6KAqfoW_smQg5xFxqbPN9pzY0ba35gbKiyobwKIUKsdQC54IriRh37vBwCpxSHFnnEICOkzxvxl7VtBA=@protonmail.com>
 <5d82ecfc-2ddf-e3e2-cf25-6447943d6405@dachary.org>
 <CXqVN-y-wEvzO923ecYL6S32ROGSrVHPPhV_eVs4gSQqoNTjJvweoIDnhthDu8Dc3Kwhvggkd9fkOH1k1aNPvD8H4-5lV9MZLFKUyW8qFhw=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48831 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967277AbdD2WNU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Apr 2017 18:13:20 -0400
In-Reply-To: <CXqVN-y-wEvzO923ecYL6S32ROGSrVHPPhV_eVs4gSQqoNTjJvweoIDnhthDu8Dc3Kwhvggkd9fkOH1k1aNPvD8H4-5lV9MZLFKUyW8qFhw=@protonmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matan Liram <matanl@protonmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/29/2017 11:48 PM, Matan Liram wrote:
> Hi Loïc,
> 
> Thank you for the fast response, I will try rephrasing:
> 
> Consider a Reed-Solomon code with 6 data chunks {a, b, c, d, e, f} and 2 parity chunks {u, v}. Notice that "u" is a linear combination of a, b, c, d, e, f. If we split "u" into x - linear combination of a, b, c, and y - linear combination of d, e, f, we get an LRC code with 9 chunks (a, b, c, d, e, f - data; v - global; x, y - local), which copes with 2 erasures. It is implied from the fact that it has all the information of a (8,6) Reed-Solomon code.
> 
> However, in the LRC construction you proposed there are 10 chunks, which impose a higher overhead than the optimal 9 chunks which I showed in the previous paragraph. I wonder if there's a way to get the optimal LRC construction for this case, using the plugin configuration Ceph provides. In the previous message I added an example which implies why the solution to this problem is not trivial.

Thanks for explaining. I don't think the current LRC plugin allows for that. It would require another plugin with a different implementation.

Cheers


> Thank you,
> Matan Liram
> 
> 
>> -------- Original Message --------
>> Subject: Re: [ceph-users] LRC low level plugin configuration can't express maximal erasure resilience
>> Local Time: April 29, 2017 11:58 PM
>> UTC Time: April 29, 2017 8:58 PM
>> From: loic@dachary.org
>> To: Matan Liram <matanl@protonmail.com>, ceph-users@lists.ceph.com <ceph-users@lists.ceph.com>
>>
>> Hi Matan,
>>
>> On 04/29/2017 10:47 PM, Matan Liram wrote:
>> > LRC low level plugin configuration of the following example copes with a single erasure while it can easily protect from two.
>> >
>> > In case I use the layers:
>> > 1: DDDDDDc_ _
>> > 2: DDD_ _ _ _c_
>> > 3: _ _ _DDD_ _c
>> >
>> > Neither of the rules protect from 2 failures. However, if we calculate the XOR of the two local parities we can treat the calculated value as a second parity disk and cope with two erasures.
>> > This thread discusses the same issue, while according to my understanding it doesn't provide a solution.
>> > http://www.spinics.net/lists/ceph-devel/msg19886.html
>> >
>> > Is there a way to make the proposed construction cope with 2 erasures? A few modifications are acceptable.
>>
>> I'm not sure to understand what you're asking. Would you mind rephrasing ?
>>
>> 1: DDDDDDc_ _
>> 2: DDD_ _ _ _c_
>> 3: _ _ _DDD_ _c
>>
>>
>> 1: DDDDDDc_ __
>> 2: DDD_ _ _ _c__
>> 3: _ _ _DDD_ _cc
>>
>> That would not work ?
>>
>> Cheers
>>
>> >
>> > Thank you,
>> > Matan Liram
>> >
>> >
>> >
>> >
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
