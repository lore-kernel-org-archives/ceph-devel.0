From: Loic Dachary <loic@dachary.org>
Subject: Re: Calculating the expected PGs distribution
Date: Tue, 9 May 2017 18:23:01 +0200
Message-ID: <f2e21f6e-5373-25de-f000-43a713902896@dachary.org>
References: <4538c9b9-18a2-11b9-e5f1-00a0243c1d88@dachary.org>
 <CAJRHzqn5D24EDts1RbJfP0Kn60Y+1E2MQDMdY1_M0Y2zaJxhqg@mail.gmail.com>
 <443c9da8-54a7-7e3c-0603-3887865628fa@dachary.org>
 <ca0b9821-fc03-9bbe-423f-568827d5ff96@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34461 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdEIQXF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 12:23:05 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by relay7-d.mail.gandi.net (Postfix) with ESMTPS id 0933E2B6A
        for <ceph-devel@vger.kernel.org>; Tue,  9 May 2017 18:23:04 +0200 (CEST)
In-Reply-To: <ca0b9821-fc03-9bbe-423f-568827d5ff96@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xavier Villaneau <xvillaneau+ceph@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 05/09/2017 05:38 PM, Loic Dachary wrote:
> 
> 
> On 05/09/2017 03:53 PM, Loic Dachary wrote:
>> Hi Xavier,
>>
>> On 05/09/2017 08:18 AM, Xavier Villaneau wrote:
>>> Hello Loïc,
>>>
>>> On Mon, May 8, 2017 at 5:49 AM, Loic Dachary <loic@dachary.org <mailto:loic@dachary.org>> wrote:
>>>> I can't figure out the formula myself, my maths are not good enough. Could you please guide me in the right direction ?
>>>
>>> That's quite an interesting problem, and not a trivial one. As you mentioned in that other discussion with Sage, the way collision is handled results in the probabilities of picking items dependent on the previous items picked. So there is can actually be a big gap between weights and the resulting mappings.
>>>
>>> I did some rough calculations by hand on your case and found the following result:
>>>   84 29 29 29 29
>>> I haven't tested with an actual crushmap yet, but from what I understand of the code it should be close to that.
>>> For curiosity, if you tried to improve the result by setting the weight of OSD.0 to infinity, you'd still have at best:
>>>   100 25 25 25 25
>>>
>>> So here are my thoughts about this:
>>> 1 - There is a theoretical limit to how skewed the distribution of PGs can be; some target weights are impossible to achieve because of how the rules work. I have a rough idea of the limit: if taking N items, then a single bucket at the failure domain level cannot have more than 1/N of the weight. But that needs to proven, and I'm not sure how it would apply to more complex rules.
>>
>> 1/N makes intuitive sense, indeed ! So, for each item the weight has an upper bound of (sum of item weights) / N. Since this is a border case, I'm inclined to just cap the weight to its upper bound when optimizing or analyzing the crushmap. A warning was added to crush analyze when this is the case:
>>
>>         ~id~  ~weight~  ~objects~  ~over/under used %~
>> ~name~                                                
>> host3     -5       1.0        646                34.06
>> host4     -6       1.0        610                26.59
>> host2     -4       1.0        575                19.32
>> host1     -3       1.0        571                18.49
>> host0     -2       4.5       1694               -21.88
>>
>> Worst case scenario if a host fails:
>>
>>         ~over used %~
>> ~type~               
>> host            41.33
>> root             0.00
>>
>> The following weights have been modified
>>
>>         ~id~  ~original weight~  ~weight~
>> ~name~                                   
>> host0     -2                  5       4.5
> 
> Hum, this is wrong. The overweight item can get 50% and the other items need to share the remaining 50%...

Here is what I have so far:

For N replicas, the weight of the item i (Wi) must be capped to 1/N if
Wi > 1/N.

The difference (Wi - 1 / N) is the remainder Ri and it must
be distributed evenly among the remaining items.

There can be at most M = N - 1 overweight items.

R = sum of all remainder Ri

for each overweight item, distribute the remainder to all items that are not overweight and that are not already at the maximum weight in proportion of their weight Wj += R * Wj * M

as a result of the redistribution an item that was not overweight could become overweight and the same process must be repeated until there are no more overweight items

I realize this is a bit naïve...

> 
>>
>> Cheers
>>
>>> 2 - If the target weights are reachable, then the effective weights could be either pre-computed (using libcrush to simulate how changing weights affects the PGs) or adjust weights once the skew is observed on the actual data. Or why not both?
>>>
>>> Side notes:
>>>  - For massively skewed weights, the CHOOSE_TRIES tunable can become limiting; if set too low, there starts to be a significant chance that crush gives up on trying to find non-conflicting results and spits out mappings with holes. I'm guessing that's a known thing already.
>>>  - This is not only an issue for massively skewed weights; I believe it also affects any non-uniform hierarchy (since the probabilities to pick a bucket change after each pick), albeit at a lesser magnitude. But as long as the target weights are within the theoretical limit, the distribution can be fixed so that they are achieved.
>>>  - What we're seeing is similar to a more common crush "problem": N replicas on N buckets will always give one replica per bucket regardless of the weights. That is actually a corner case of what we're seeing here.
>>>
>>> --
>>> Xavier Villaneau
>>> Software Engineer, Concurrent Computer Corp.
>>
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
