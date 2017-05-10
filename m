From: Loic Dachary <loic@dachary.org>
Subject: Re: Calculating the expected PGs distribution
Date: Wed, 10 May 2017 08:45:12 +0200
Message-ID: <07685bf4-61fc-fd56-d128-838ed5692965@dachary.org>
References: <4538c9b9-18a2-11b9-e5f1-00a0243c1d88@dachary.org>
 <CAJRHzqn5D24EDts1RbJfP0Kn60Y+1E2MQDMdY1_M0Y2zaJxhqg@mail.gmail.com>
 <443c9da8-54a7-7e3c-0603-3887865628fa@dachary.org>
 <ca0b9821-fc03-9bbe-423f-568827d5ff96@dachary.org>
 <f2e21f6e-5373-25de-f000-43a713902896@dachary.org>
 <491efe42-07f3-5142-e181-fad958a860bf@villaneau.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57318 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdEJGpQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 02:45:16 -0400
In-Reply-To: <491efe42-07f3-5142-e181-fad958a860bf@villaneau.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xavier Villaneau <xavier.ceph@villaneau.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 05/10/2017 05:31 AM, Xavier Villaneau wrote:
> On 05/09/2017 at 12:23 PM, Loic Dachary wrote:
> 
>> Here is what I have so far:
>>
>> For N replicas, the weight of the item i (Wi) must be capped to 1/N if
>> Wi > 1/N.
>>
>> The difference (Wi - 1 / N) is the remainder Ri and it must
>> be distributed evenly among the remaining items.
>>
>> There can be at most M = N - 1 overweight items.
>>
>> R = sum of all remainder Ri
>>
>> for each overweight item, distribute the remainder to all items that are not overweight and that are not already at the maximum weight in proportion of their weight Wj += R * Wj * M
>>
>> as a result of the redistribution an item that was not overweight could become overweight and the same process must be repeated until there are no more overweight items
>>
>> I realize this is a bit naïve...
> Hello Loïc,
> 
> Sorry if I missed some previous discussions where the context of this was explained, but I'm not sure I understand the goal of that calculation. Are you trying to predict a distribution from a set of weights, or trying to find how to rectify a distribution to make it closer to some target weights?

I was trying to rectify a distribution that has overweight items.
> 
> If you're trying to predict a distribution, then there is actually no such thing as an "overweighted", the distribution are what they are and the same calculations apply regardless of if the weights are "unreachable" or not. If you want, I can give a detail of what I did for the 5-1-1-1-1 case (and maybe another "regular" case); it's just a question of adding up the right probabilities in the right order.

Understood.

> 
> If the goal is to achieve a target distribution, then it's a bit more tricky. This would require the algorithm to:
> 1. Identify cases where a given target distribution has "overweighted" items
> 2. If that's the case, identify the limit (i.e. "best" distribution possible) and use it to decide on a new target distribution that's within the space of reachable distributions
> 3. From there, a "regular" approach could apply.
> Maybe there are other approaches to that issue too.
> 
> Just one last question: Is there a requirement to solve this problem with inexpensive calculations? Otherwise, couldn't calls to libcrush be used to get an estimate of the distribution or to do trial-and-error re-balancing?
> 
> Sorry if I'm asking about stuff that was answered before; I'm lacking the context of this talk.

You're not actually: this was not discussed in any context so far (unless I missed something in the distant past which is possible ;-).

The problem with 5 1 1 1 1 is that the admin who set this weights expects a distribution that cannot happen. The 5TB disk will always be underfull and the 1TB disks will always be overfull, even if the probability bias is fixed. I was hoping that we could find a way to set the weights so that an even distribution is achieved and the sysadmin does not have to know about that corner case. It does not need to be inexpensive.

Thinking a bit more about it, there does not seem to be any way to get an even distribution. It's not a matter of tweaking the weights, as you explained in your previous mail even with an infinite weight the overweight item will still miss the desired number of PGs. The best we can do is to lower the weight of the overweight item to get a set of weights that can lead to an even distribution. We cannot fix the fact that the overweight item will be underfilled. But by fixing the weights we can fix the fact that the other items are overfilled which is what causes problems to the sysadmin.

In our example (with 2 replicas)

( 5 + 1 + 1 + 1 + 1 ) / 2 = 4.5 therefore all items with a weight > 4.5 are overweight

we remove the overweight items and sum the weight of the remaining items:

( 1 + 1 + 1 + 1 ) = 4

and we divide by the number of replicas minus the number of overweight items

4 / ( 2 - 1 ) = 4

and we set the weight of the overweight item to this number

( 4 + 1 + 1 + 1 + 1 ) / 2 = 4 therefore all items are <= maximum weight

With three replicas:

( 7 + 7 + 1 + 1 + 1 + 1 + 1 + 1 ) / 3 = 6.66

we set the weight to ( 1 + 1 + 1 + 1 + 1 + 1 ) /  ( 3 - 2 ) = 6 

( 6 + 6 + 1 + 1 + 1 + 1 + 1 + 1 ) / 3 = 6

With four replicas:

(7 + 7 + 7 + 3 + 3) / 4 = 6.75

we set the weight to ( 3 + 3 ) / ( 4 - 3 ) = 6

(6 + 6 + 6 + 3 + 3) / 4 = 6

With four replicas again:

(5 + 5 + 3 + 3 + 3) / 4 = 4.75

we set the weight to ( 3 + 3 + 3 ) / ( 4 - 2 ) = 4.5

(4.5 + 4.5 + 3 + 3 + 3) / 4 = 4.5

Does that make sense ?

-- 
Loïc Dachary, Artisan Logiciel Libre
