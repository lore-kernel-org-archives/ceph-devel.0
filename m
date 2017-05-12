From: Loic Dachary <loic@dachary.org>
Subject: Re: An algorithm to fix uneven CRUSH distributions in Ceph
Date: Fri, 12 May 2017 23:18:05 +0200
Message-ID: <c9d73e7a-37a3-0bdd-5bec-c23d7895def5@dachary.org>
References: <66e67a16-9cb2-aa2c-cf81-fc66b03e16d8@dachary.org>
 <CAFdhnjds6kV5FwWbGpz0z3LcfDY3rR7CnfTdK2arNV0bUxxc+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58393 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758146AbdELVSK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 May 2017 17:18:10 -0400
In-Reply-To: <CAFdhnjds6kV5FwWbGpz0z3LcfDY3rR7CnfTdK2arNV0bUxxc+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Pedro_L=c3=b3pez-Adeva?= <plopezadeva@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 05/12/2017 10:39 PM, Pedro López-Adeva wrote:
> Hi,
> 
> I will have a look in more detail but the first thing that has come to
> my mind is Coordinate Descent
> (https://en.wikipedia.org/wiki/Coordinate_descent), so it might make
> sense it converges to some point. 

Cool, I'll take a look :-)

> The fact that it converges always to
> zero or near zero error seems more related maybe to this particular
> problem and I wonder if it's possible to engineer some instance where
> the algorithm gets stuck on some local minimum.

I tried various combinations of weights, hoping to find a border case. But maybe there is a pattern I missed ?

2 replicas [ 1, 2, 3, 4, ..., 98, 100 ]
2 replicas [ 5, 1, 1, 1, 1 ] (this one gave me a hard time because it really is [ 4, 1, 1, 1, 1 ] in disguise ;-)
2 replicas [ 5, 1, 1, 1, 1, 1, 1, 1, 1 ]
3 replicas [ 1, 2, 3, 1, 2, 3, 1, 2, 3 ]
2 replicas [ 1, 1, 1, 1, 1 ]

I'd happily try [ 5, 4, 3, 2, 1, 2, 3, 4, 5 ] because it looks interesting or other combinations. But I really have no clue if it is different.

Cheers

> 
> Cheers,
> Pedro.
> 
> 
> 2017-05-12 13:26 GMT+02:00 Loic Dachary <loic@dachary.org>:
>> Hi Pedro,
>>
>> After significant testing I believe the algorithm described at http://dachary.org/?p=4055 works. I'll publish an implementation next week with python-crush[1]. There is however something I don't understand other than intuitively. Why does it converge in all cases ? The core of the algorithm is:
>>
>> repeat while the distribution improves
>>          run a simulation
>>          lower the weight of the most overfilled device
>>          increase the weight of the most underfilled device
>>
>> Which we can do because we can run a simulation with all the values. We always know the full set of values (PGs in the Ceph parlance but you can think of them as files) that are distributed to devices. The loss function is the sum of the absolute value of the difference between the expected distribution and the actual distribution for each device. The Kullback-Liebler divergence also works and has a fancier name but that does not seem to be better.
>>
>> With a better understanding of why it works we may be able to come up with a faster faster implementation and get closer to the perfect distribution in some cases.
>>
>> I'm curious to know what you think about that :-)
>>
>> Cheers
>>
>> [1] http://crush.readthedocs.io/
>> --
>> Loïc Dachary, Artisan Logiciel Libre
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
