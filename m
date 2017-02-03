From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multipick anomaly
Date: Fri, 3 Feb 2017 16:08:23 +0100
Message-ID: <bcf2f102-cee9-4070-c027-e8baf5f428f2@dachary.org>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <e5f376bb-925b-17df-ae6e-abc07058f67b@dachary.org>
 <6a7b52c8-a0fd-41a6-fbf1-fb2af3e347d8@dachary.org>
 <alpine.DEB.2.11.1702031443400.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44553 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdBCPIc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 10:08:32 -0500
In-Reply-To: <alpine.DEB.2.11.1702031443400.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 02/03/2017 03:47 PM, Sage Weil wrote:
> On Fri, 3 Feb 2017, Loic Dachary wrote:
>> On 01/26/2017 12:13 PM, Loic Dachary wrote:
>>> Hi Sage,
>>>
>>> Still trying to understand what you did :-) I have one question below.
>>>
>>> On 01/26/2017 04:05 AM, Sage Weil wrote:
>>>> This is a longstanding bug,
>>>>
>>>> 	http://tracker.ceph.com/issues/15653
>>>>
>>>> that causes low-weighted devices to get more data than they should. Loic's 
>>>> recent activity resurrected discussion on the original PR
>>>>
>>>> 	https://github.com/ceph/ceph/pull/10218
>>>>
>>>> but since it's closed and almost nobody will see it I'm moving the 
>>>> discussion here.
>>>>
>>>> The main news is that I have a simple adjustment for the weights that 
>>>> works (almost perfectly) for the 2nd round of placements.  The solution is 
>>>> pretty simple, although as with most probabilities it tends to make my 
>>>> brain hurt.
>>>>
>>>> The idea is that, on the second round, the original weight for the small 
>>>> OSD (call it P(pick small)) isn't what we should use.  Instead, we want 
>>>> P(pick small | first pick not small).  Since P(a|b) (the probability of a 
>>>> given b) is P(a && b) / P(b),
>>>
>>> >From the record this is explained at https://en.wikipedia.org/wiki/Conditional_probability#Kolmogorov_definition
>>>
>>>>
>>>>  P(pick small | first pick not small)
>>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>>
>>>> The last term is easy to calculate,
>>>>
>>>>  P(first pick not small) = (total_weight - small_weight) / total_weight
>>>>
>>>> and the && term is the distribution we're trying to produce.  
>>>
>>> https://en.wikipedia.org/wiki/Conditional_probability describs A && B (using a non ascii symbol...) as the "probability of the joint of events A and B". I don't understand what that means. Is there a definition somewhere ?
>>>
>>>> For exmaple, 
>>>> if small has 1/10 the weight, then we should see 1/10th of the PGs have 
>>>> their second replica be the small OSD.  So
>>>>
>>>>  P(pick small && first pick not small) = small_weight / total_weight
>>>>
>>>> Putting those together,
>>>>
>>>>  P(pick small | first pick not small)
>>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>>  = (small_weight / total_weight) / ((total_weight - small_weight) / total_weight)
>>>>  = small_weight / (total_weight - small_weight)
>>>>
>>>> This is, on the second round, we should adjust the weights by the above so 
>>>> that we get the right distribution of second choices.  It turns out it 
>>>> works to adjust *all* weights like this to get hte conditional probability 
>>>> that they weren't already chosen.
>>>>
>>>> I have a branch that hacks this into straw2 and it appears to work 
>>>
>>> This is https://github.com/liewegas/ceph/commit/wip-crush-multipick
>>
>> In
>>
>> https://github.com/liewegas/ceph/commit/wip-crush-multipick#diff-0df13ad294f6585c322588cfe026d701R316
>>
>> double neww = oldw / (bucketw - oldw) * bucketw;
>>
>> I don't get why we need  "* bucketw" at the end ?
> 
> It's just to keep the values within a reasonable range so that we don't 
> lose precision by dropping down into small integers.
> 
> I futzed around with this some more last week trying to get the third 
> replica to work and ended up doubting that this piece is correct.  The 
> ratio between the big and small OSDs in my [99 99 99 99 4] example varies 
> slightly from what I would expect from first principles and what I get out 
> of this derivation by about 1%.. which would explain the bias I as seeing.
> 
> I'm hoping we can find someone with a strong stats/probability background 
> and loads of free time who can tackle this...
> 

It would help to formulate the problem into a self contained puzzle to present a mathematician. I tried to do it last week but failed. I'll give it another shot and submit a draft, hoping something bad could be the start of something better ;-)
 
> sage
> 
> 
>>
>>>
>>>> properly for num_rep = 2.  With a test bucket of [99 99 99 99 4], and the 
>>>> current code, you get
>>>>
>>>> $ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 --max-x 40000000 --num-rep 2
>>>> rule 0 (data), x = 0..40000000, numrep = 2..2
>>>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
>>>>   device 0:             19765965        [9899364,9866601]
>>>>   device 1:             19768033        [9899444,9868589]
>>>>   device 2:             19769938        [9901770,9868168]
>>>>   device 3:             19766918        [9898851,9868067]
>>>>   device 6:             929148  [400572,528576]
>>>>
>>>> which is very close for the first replica (primary), but way off for the 
>>>> second.  With my hacky change,
>>>>
>>>> rule 0 (data), x = 0..40000000, numrep = 2..2
>>>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
>>>>   device 0:             19797315        [9899364,9897951]
>>>>   device 1:             19799199        [9899444,9899755]
>>>>   device 2:             19801016        [9901770,9899246]
>>>>   device 3:             19797906        [9898851,9899055]
>>>>   device 6:             804566  [400572,403994]
>>>>
>>>> which is quite close, but still skewing slightly high (by a big less than 
>>>> 1%).
>>>>
>>>> Next steps:
>>>>
>>>> 1- generalize this for >2 replicas
>>>> 2- figure out why it skews high
>>>> 3- make this work for multi-level hierarchical descent
>>>>
>>>> sage
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

-- 
Loïc Dachary, Artisan Logiciel Libre
