From: Xavier Villaneau <xavier.ceph@villaneau.fr>
Subject: Re: Calculating the expected PGs distribution
Date: Tue, 9 May 2017 23:31:31 -0400
Message-ID: <491efe42-07f3-5142-e181-fad958a860bf@villaneau.fr>
References: <4538c9b9-18a2-11b9-e5f1-00a0243c1d88@dachary.org>
 <CAJRHzqn5D24EDts1RbJfP0Kn60Y+1E2MQDMdY1_M0Y2zaJxhqg@mail.gmail.com>
 <443c9da8-54a7-7e3c-0603-3887865628fa@dachary.org>
 <ca0b9821-fc03-9bbe-423f-568827d5ff96@dachary.org>
 <f2e21f6e-5373-25de-f000-43a713902896@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mo19.mail-out.ovh.net ([178.32.228.19]:44528 "EHLO
        mo19.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdEJDk6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 23:40:58 -0400
In-Reply-To: <f2e21f6e-5373-25de-f000-43a713902896@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 05/09/2017 at 12:23 PM, Loic Dachary wrote:

> Here is what I have so far:
>
> For N replicas, the weight of the item i (Wi) must be capped to 1/N if
> Wi > 1/N.
>
> The difference (Wi - 1 / N) is the remainder Ri and it must
> be distributed evenly among the remaining items.
>
> There can be at most M = N - 1 overweight items.
>
> R = sum of all remainder Ri
>
> for each overweight item, distribute the remainder to all items that are not overweight and that are not already at the maximum weight in proportion of their weight Wj += R * Wj * M
>
> as a result of the redistribution an item that was not overweight could become overweight and the same process must be repeated until there are no more overweight items
>
> I realize this is a bit naïve...
Hello Loïc,

Sorry if I missed some previous discussions where the context of this 
was explained, but I'm not sure I understand the goal of that 
calculation. Are you trying to predict a distribution from a set of 
weights, or trying to find how to rectify a distribution to make it 
closer to some target weights?

If you're trying to predict a distribution, then there is actually no 
such thing as an "overweighted", the distribution are what they are and 
the same calculations apply regardless of if the weights are 
"unreachable" or not. If you want, I can give a detail of what I did for 
the 5-1-1-1-1 case (and maybe another "regular" case); it's just a 
question of adding up the right probabilities in the right order.

If the goal is to achieve a target distribution, then it's a bit more 
tricky. This would require the algorithm to:
1. Identify cases where a given target distribution has "overweighted" items
2. If that's the case, identify the limit (i.e. "best" distribution 
possible) and use it to decide on a new target distribution that's 
within the space of reachable distributions
3. From there, a "regular" approach could apply.
Maybe there are other approaches to that issue too.

Just one last question: Is there a requirement to solve this problem 
with inexpensive calculations? Otherwise, couldn't calls to libcrush be 
used to get an estimate of the distribution or to do trial-and-error 
re-balancing?

Sorry if I'm asking about stuff that was answered before; I'm lacking 
the context of this talk.

Regards,
-- 
Xavier Villaneau
Software Engineer, Concurrent Computer Corp.

