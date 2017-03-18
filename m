From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multipick anomaly
Date: Sat, 18 Mar 2017 10:21:38 +0100
Message-ID: <649a0116-6f61-0470-69bd-41f64214ad5a@dachary.org>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org>
 <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal>
 <CAFdhnje5hJMsU8ZCSL8mFj=d4UH6b41=nnddNvcfemhyWXg6aw@mail.gmail.com>
 <4dbab28a-220b-2cef-fcbc-aca4dd17ab3b@dachary.org>
 <CAFdhnjf=WPmC+CEwX1QWe_v1HXmZu2cv7983zHGG4muKR_G0jw@mail.gmail.com>
 <43736207-9e38-9389-4b99-d246716092ed@dachary.org>
 <CAFdhnjfGKdmOFnT-imHo55O7LLPCdOV=_pbU50ruxo1x9C3NDA@mail.gmail.com>
 <cbcf592e-a0c0-bc5b-0f2a-11c4a110d485@dachary.org>
 <CAFdhnjcDfUG6Dzm2R_Fu16d7rT1z_h+mFy6ngYLUcLtURn_pVA@mail.gmail.com>
 <63256e6b-ec48-e369-afc3-6d65eb5230f8@dachary.org>
 <eca40695-44b3-6843-b1c3-8359231e4d87@dachary.org>
 <CAFdhnjfYK43=ZdQ-cPG0k8KzKnTZ=T5VNoYdfdSdPH8gRG_i+A@mail.gmail.com>
 <alpine.DEB.2.11.1703072259520.24356@piezo.novalocal>
 <CAFdhnjeAdCgqS3N7yvZXEanEc8c_q2hR_HciUD2gdFGcRyaZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:40464 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbdCRJ5z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Mar 2017 05:57:55 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 3430D47F019
        for <ceph-devel@vger.kernel.org>; Sat, 18 Mar 2017 10:22:42 +0100 (CET)
In-Reply-To: <CAFdhnjeAdCgqS3N7yvZXEanEc8c_q2hR_HciUD2gdFGcRyaZXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Pedro_L=c3=b3pez-Adeva?= <plopezadeva@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Pedro,

I'm going to experiment with what you did at

https://github.com/plafl/notebooks/blob/master/replication.ipynb

and the latest python-crush published today. A comparison function was added that will help measure the data movement. I'm hoping we can release an offline tool based on your solution. Please let me know if I should wait before diving into this, in case you have unpublished drafts or new ideas.

Cheers

On 03/09/2017 09:47 AM, Pedro López-Adeva wrote:
> Great, thanks for the clarifications.
> I also think that the most natural way is to keep just a set of
> weights in the CRUSH map and update them inside the algorithm.
> 
> I keep working on it.
> 
> 
> 2017-03-08 0:06 GMT+01:00 Sage Weil <sage@newdream.net>:
>> Hi Pedro,
>>
>> Thanks for taking a look at this!  It's a frustrating problem and we
>> haven't made much headway.
>>
>> On Thu, 2 Mar 2017, Pedro López-Adeva wrote:
>>> Hi,
>>>
>>> I will have a look. BTW, I have not progressed that much but I have
>>> been thinking about it. In order to adapt the previous algorithm in
>>> the python notebook I need to substitute the iteration over all
>>> possible devices permutations to iteration over all the possible
>>> selections that crush would make. That is the main thing I need to
>>> work on.
>>>
>>> The other thing is of course that weights change for each replica.
>>> That is, they cannot be really fixed in the crush map. So the
>>> algorithm inside libcrush, not only the weights in the map, need to be
>>> changed. The weights in the crush map should reflect then, maybe, the
>>> desired usage frequencies. Or maybe each replica should have their own
>>> crush map, but then the information about the previous selection
>>> should be passed to the next replica placement run so it avoids
>>> selecting the same one again.
>>
>> My suspicion is that the best solution here (whatever that means!)
>> leaves the CRUSH weights intact with the desired distribution, and
>> then generates a set of derivative weights--probably one set for each
>> round/replica/rank.
>>
>> One nice property of this is that once the support is added to encode
>> multiple sets of weights, the algorithm used to generate them is free to
>> change and evolve independently.  (In most cases any change is
>> CRUSH's mapping behavior is difficult to roll out because all
>> parties participating in the cluster have to support any new behavior
>> before it is enabled or used.)
>>
>>> I have a question also. Is there any significant difference between
>>> the device selection algorithm description in the paper and its final
>>> implementation?
>>
>> The main difference is the "retry_bucket" behavior was found to be a bad
>> idea; any collision or failed()/overload() case triggers the
>> retry_descent.
>>
>> There are other changes, of course, but I don't think they'll impact any
>> solution we come with here (or at least any solution can be suitably
>> adapted)!
>>
>> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
