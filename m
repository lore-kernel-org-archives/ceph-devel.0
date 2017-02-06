From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multipick anomaly
Date: Mon, 6 Feb 2017 09:31:59 +0100
Message-ID: <267c8448-a3f0-e21e-f5e6-dffb3ffdf836@dachary.org>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <e5f376bb-925b-17df-ae6e-abc07058f67b@dachary.org>
 <6a7b52c8-a0fd-41a6-fbf1-fb2af3e347d8@dachary.org>
 <alpine.DEB.2.11.1702031443400.3654@piezo.novalocal>
 <CABZ+qqn13kR+4FjSmWKgt4Fee0+8B2Gi-qJjT8MaXpu2e6=2Ew@mail.gmail.com>
 <CABZ+qqnHh+iJFbaLE7b-Kn4VSidHrDT8LuW4oB5wDD3=c=QG3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59549 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdBFIcE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 03:32:04 -0500
In-Reply-To: <CABZ+qqnHh+iJFbaLE7b-Kn4VSidHrDT8LuW4oB5wDD3=c=QG3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Szymon Datko <szymon.datko@gmail.com>, Tomasz Kuzemko <tomasz@kuzemko.net>

Hi Dan,

Your script turns out to be a nice self contained problem statement :-) Tomasz & Szymon discussed it today @ FOSDEM and I was enlightened by the way Szymon described how to calculate P(E|A) using a probability tree (see the picture at http://dachary.org/loic/crush-probability-schema.jpg).

Cheers

On 02/03/2017 06:37 PM, Dan van der Ster wrote:
> Anyway, here's my simple simulation. It might be helpful for testing
> ideas quickly: https://gist.github.com/anonymous/929d799d5f80794b293783acb9108992
> 
> Below is the output using the P(pick small | first pick not small)
> observation, using OSDs having weights 3, 3, 3, & 1 respectively. It
> seems to *almost* work, but only when we have just one small OSD.
> 
> See the end of the script for other various ideas.
> 
> -- Dan
> 
>> python mpa.py
> OSDs (id: weight): {0: 3, 1: 3, 2: 3, 3: 1}
> 
> Expected PGs per OSD:       {0: 90000, 1: 90000, 2: 90000, 3: 30000}
> 
> Simulating with existing CRUSH
> 
> Observed:                   {0: 85944, 1: 85810, 2: 85984, 3: 42262}
> Observed for Nth replica:   [{0: 29936, 1: 30045, 2: 30061, 3: 9958},
> {0: 29037, 1: 29073, 2: 29041, 3: 12849}, {0: 26971, 1: 26692, 2:
> 26882, 3: 19455}]
> 
> Now trying your new algorithm
> 
> Observed:                   {0: 89423, 1: 89443, 2: 89476, 3: 31658}
> Observed for Nth replica:   [{0: 30103, 1: 30132, 2: 29805, 3: 9960},
> {0: 29936, 1: 29964, 2: 29796, 3: 10304}, {0: 29384, 1: 29347, 2:
> 29875, 3: 11394}]
> 
> 
> On Fri, Feb 3, 2017 at 4:26 PM, Dan van der Ster <dan@vanderster.com> wrote:
>> On Fri, Feb 3, 2017 at 3:47 PM, Sage Weil <sweil@redhat.com> wrote:
>>> On Fri, 3 Feb 2017, Loic Dachary wrote:
>>>> On 01/26/2017 12:13 PM, Loic Dachary wrote:
>>>>> Hi Sage,
>>>>>
>>>>> Still trying to understand what you did :-) I have one question below.
>>>>>
>>>>> On 01/26/2017 04:05 AM, Sage Weil wrote:
>>>>>> This is a longstanding bug,
>>>>>>
>>>>>>    http://tracker.ceph.com/issues/15653
>>>>>>
>>>>>> that causes low-weighted devices to get more data than they should. Loic's
>>>>>> recent activity resurrected discussion on the original PR
>>>>>>
>>>>>>    https://github.com/ceph/ceph/pull/10218
>>>>>>
>>>>>> but since it's closed and almost nobody will see it I'm moving the
>>>>>> discussion here.
>>>>>>
>>>>>> The main news is that I have a simple adjustment for the weights that
>>>>>> works (almost perfectly) for the 2nd round of placements.  The solution is
>>>>>> pretty simple, although as with most probabilities it tends to make my
>>>>>> brain hurt.
>>>>>>
>>>>>> The idea is that, on the second round, the original weight for the small
>>>>>> OSD (call it P(pick small)) isn't what we should use.  Instead, we want
>>>>>> P(pick small | first pick not small).  Since P(a|b) (the probability of a
>>>>>> given b) is P(a && b) / P(b),
>>>>>
>>>>> >From the record this is explained at https://en.wikipedia.org/wiki/Conditional_probability#Kolmogorov_definition
>>>>>
>>>>>>
>>>>>>  P(pick small | first pick not small)
>>>>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>>>>
>>>>>> The last term is easy to calculate,
>>>>>>
>>>>>>  P(first pick not small) = (total_weight - small_weight) / total_weight
>>>>>>
>>>>>> and the && term is the distribution we're trying to produce.
>>>>>
>>>>> https://en.wikipedia.org/wiki/Conditional_probability describs A && B (using a non ascii symbol...) as the "probability of the joint of events A and B". I don't understand what that means. Is there a definition somewhere ?
>>>>>
>>>>>> For exmaple,
>>>>>> if small has 1/10 the weight, then we should see 1/10th of the PGs have
>>>>>> their second replica be the small OSD.  So
>>>>>>
>>>>>>  P(pick small && first pick not small) = small_weight / total_weight
>>>>>>
>>>>>> Putting those together,
>>>>>>
>>>>>>  P(pick small | first pick not small)
>>>>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>>>>  = (small_weight / total_weight) / ((total_weight - small_weight) / total_weight)
>>>>>>  = small_weight / (total_weight - small_weight)
>>>>>>
>>>>>> This is, on the second round, we should adjust the weights by the above so
>>>>>> that we get the right distribution of second choices.  It turns out it
>>>>>> works to adjust *all* weights like this to get hte conditional probability
>>>>>> that they weren't already chosen.
>>>>>>
>>>>>> I have a branch that hacks this into straw2 and it appears to work
>>>>>
>>>>> This is https://github.com/liewegas/ceph/commit/wip-crush-multipick
>>>>
>>>> In
>>>>
>>>> https://github.com/liewegas/ceph/commit/wip-crush-multipick#diff-0df13ad294f6585c322588cfe026d701R316
>>>>
>>>> double neww = oldw / (bucketw - oldw) * bucketw;
>>>>
>>>> I don't get why we need  "* bucketw" at the end ?
>>>
>>> It's just to keep the values within a reasonable range so that we don't
>>> lose precision by dropping down into small integers.
>>>
>>> I futzed around with this some more last week trying to get the third
>>> replica to work and ended up doubting that this piece is correct.  The
>>> ratio between the big and small OSDs in my [99 99 99 99 4] example varies
>>> slightly from what I would expect from first principles and what I get out
>>> of this derivation by about 1%.. which would explain the bias I as seeing.
>>>
>>> I'm hoping we can find someone with a strong stats/probability background
>>> and loads of free time who can tackle this...
>>>
>>
>> I'm *not* that person, but I gave it a go last weekend and realized a
>> few things:
>>
>> 1. We should add the additional constraint that for all PGs assigned
>> to an OSD, 1/N of them must be primary replicas, 1/N must be
>> secondary, 1/N must be tertiary, etc. for N replicas/stripes. E.g. for
>> a 3 replica pool, the "small" OSD should still have the property that
>> 1/3rd are primaries, 1/3rd are secondary, 1/3rd are tertiary.
>>
>> 2. I believe this is a case of the balls-into-bins problem -- we have
>> colored balls and weighted bins. I didn't find a definition of the
>> problem where the goal is to allow users to specify weights which must
>> be respected after N rounds.
>>
>> 3. I wrote some quick python to simulate different reweighting
>> algorithms. The solution is definitely not obvious - I often thought
>> I'd solved it (e.g. for simple OSD weight sets like 3, 3, 3, 1) - but
>> changing the OSDs weights to e.g. 3, 3, 1, 1 completely broke things.
>> I can clean up and share that python if it's can help.
>>
>> My gut feeling is that because CRUSH trees and rulesets can be
>> arbitrarily complex, the most pragmatic & reliable way to solve this
>> problem is to balance the PGs with a reweight-by-pg loop at crush
>> compilation time. This is what admins should do now -- we should just
>> automate it.
>>
>> Cheers, Dan
>>
>> P.S. -- maybe these guys can help: http://math.stackexchange.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre

