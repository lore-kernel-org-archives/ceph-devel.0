From: Xavier Villaneau <xavier.ceph@villaneau.fr>
Subject: Re: Calculating the expected PGs distribution
Date: Wed, 10 May 2017 21:52:04 -0400
Message-ID: <19453021-17e0-a39a-bb22-8ab73a9a8789@villaneau.fr>
References: <4538c9b9-18a2-11b9-e5f1-00a0243c1d88@dachary.org>
 <CAJRHzqn5D24EDts1RbJfP0Kn60Y+1E2MQDMdY1_M0Y2zaJxhqg@mail.gmail.com>
 <443c9da8-54a7-7e3c-0603-3887865628fa@dachary.org>
 <ca0b9821-fc03-9bbe-423f-568827d5ff96@dachary.org>
 <f2e21f6e-5373-25de-f000-43a713902896@dachary.org>
 <491efe42-07f3-5142-e181-fad958a860bf@villaneau.fr>
 <07685bf4-61fc-fd56-d128-838ed5692965@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mo20.mail-out.ovh.net ([178.32.228.20]:42320 "EHLO
        mo20.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdEKBwK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 21:52:10 -0400
In-Reply-To: <07685bf4-61fc-fd56-d128-838ed5692965@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Le 05/10/2017 à 02:45 AM, Loic Dachary a écrit :
> The best we can do is to lower the weight of the overweight item to get a set of weights that can lead to an even distribution. We cannot fix the fact that the overweight item will be underfilled. But by fixing the weights we can fix the fact that the other items are overfilled which is what causes problems to the sysadmin.
I'm not sure that's the correct approach; over/under filled are relative 
notions, meaning that if there are drives filling up slower than the 
average cluster usage, then there must be drives filling up faster. 
Whatever happens, that first large OSD won't be full when the other 
drives are.
> In our example (with 2 replicas)
>
> ( 5 + 1 + 1 + 1 + 1 ) / 2 = 4.5 therefore all items with a weight > 4.5 are overweight
>
> we remove the overweight items and sum the weight of the remaining items:
>
> ( 1 + 1 + 1 + 1 ) = 4
>
> and we divide by the number of replicas minus the number of overweight items
>
> 4 / ( 2 - 1 ) = 4
>
> and we set the weight of the overweight item to this number
>
> ( 4 + 1 + 1 + 1 + 1 ) / 2 = 4 therefore all items are <= maximum weight
Actually, taking those weights would be worse: Because the weight of the 
large drive is lower, Crush will favor putting data on the other drives 
a bit more and will lead to them filling up faster.

In the details with 4 1 1 1 1, numbered 0 through 4 with 2 replicas and 
100 PGs:
- There is a 4/8 = 50% chance of picking 0 as a primary drive, so that's 
50 PGs using it already.
- There is a 12.5% (1/8) chance of picking 1 as primary. Once that is 
done, the remaining weights are 4 . 1 1 1 for a total of 7, meaning 
there is a 4/7 = 57% chance of picking 0 as second OSD. Therefore the 
chance of mapping to [1, 0] is 7.14%. Same for 2, 3 and 4 as primary, so 
the total chance of having 0 as second OSD is 28.6%.
On average, 78.6 PGs will be mapped to OSD 0 in either position. If we 
round up the numbers nicely, the final expected PGs for 4 1 1 1 1 is 
around 80 30 30 30 30. This is indeed more even, but actually worse for 
drive usage if the size ratios are 5 1 1 1 1.

-- 
Xavier Villaneau
Software Engineer, Concurrent Computer Corp.

