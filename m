From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multipick anomaly
Date: Mon, 20 Feb 2017 09:47:07 +0100
Message-ID: <695d7ea8-b9e6-11ab-c356-6f935d59bb51@dachary.org>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org>
 <CAJ4mKGZ8J5VYhsyo5cWT0qRtrh=2jbREixPBUwRCsCX1qY-odw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38945 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdBTIrN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 03:47:13 -0500
In-Reply-To: <CAJ4mKGZ8J5VYhsyo5cWT0qRtrh=2jbREixPBUwRCsCX1qY-odw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 02/13/2017 03:53 PM, Gregory Farnum wrote:
> On Mon, Feb 13, 2017 at 2:36 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
>>
>> Dan van der Ster reached out to colleagues and friends and Pedro López-Adeva Fernández-Layos came up with a well written analysis of the problem and a tentative solution which he described at : https://github.com/plafl/notebooks/blob/master/replication.ipynb
>>
>> Unless I'm reading the document incorrectly (very possible ;) it also means that the probability of each disk needs to take in account the weight of all disks. Which means that whenever a disk is added / removed or its weight is changed, this has an impact on the probability of all disks in the cluster and objects are likely to move everywhere. Am I mistaken ?
> 
> Keep in mind that in the math presented, "all disks" for our purposes
> really means "all items within a CRUSH bucket" (at least, best I can
> tell). So if you reweight a disk, you have to recalculate weights
> within its bucket and within each parent bucket, but each bucket has a
> bounded size N so the calculation should remain feasible. I didn't
> step through the more complicated math at the end but it made
> intuitive sense as far as I went.

When crush chooses the second replica it ensures it does not land on the same host, rack etc. depending on the step CHOOSE* argument of the rule. When looking for the best weights (in the updated https://github.com/plafl/notebooks/blob/master/converted/replication.pdf versions) I think we would focus on the host weights (assuming the failure domain is the host) and not the disk weights. When drawing disks after the host was selected, the probabilities of each disk should not need to be modified because there will never be a rejection at that level (i.e. no conditional probability).

If the failure domain is the host I think the crush map should be something like:

root:
   host1:
     disk1
     disk2
   host2:
     disk3
     disk4
   host3:
     disk5
     disk6

Introducing racks such as in:

root:
 rack0:
   host1:
     disk1
     disk2
   host2:
     disk3
     disk4
 rack1:
   host3:
     disk5
     disk6

Is going to complicate the problem further, for no good reason other than a pretty display / architecture reminder. Since rejecting a second replica on host3 means it will land in rack0 instead of rack1, I think the probability distribution of the racks will need to be adjusted in the same way the probabilty distribution of the failure domain buckets need to.

Does that make sense ?

> -Greg
> 
>>
>> Cheers
>>
>> On 01/26/2017 04:05 AM, Sage Weil wrote:
>>> This is a longstanding bug,
>>>
>>>       http://tracker.ceph.com/issues/15653
>>>
>>> that causes low-weighted devices to get more data than they should. Loic's
>>> recent activity resurrected discussion on the original PR
>>>
>>>       https://github.com/ceph/ceph/pull/10218
>>>
>>> but since it's closed and almost nobody will see it I'm moving the
>>> discussion here.
>>>
>>> The main news is that I have a simple adjustment for the weights that
>>> works (almost perfectly) for the 2nd round of placements.  The solution is
>>> pretty simple, although as with most probabilities it tends to make my
>>> brain hurt.
>>>
>>> The idea is that, on the second round, the original weight for the small
>>> OSD (call it P(pick small)) isn't what we should use.  Instead, we want
>>> P(pick small | first pick not small).  Since P(a|b) (the probability of a
>>> given b) is P(a && b) / P(b),
>>>
>>>  P(pick small | first pick not small)
>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>
>>> The last term is easy to calculate,
>>>
>>>  P(first pick not small) = (total_weight - small_weight) / total_weight
>>>
>>> and the && term is the distribution we're trying to produce.  For exmaple,
>>> if small has 1/10 the weight, then we should see 1/10th of the PGs have
>>> their second replica be the small OSD.  So
>>>
>>>  P(pick small && first pick not small) = small_weight / total_weight
>>>
>>> Putting those together,
>>>
>>>  P(pick small | first pick not small)
>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>  = (small_weight / total_weight) / ((total_weight - small_weight) / total_weight)
>>>  = small_weight / (total_weight - small_weight)
>>>
>>> This is, on the second round, we should adjust the weights by the above so
>>> that we get the right distribution of second choices.  It turns out it
>>> works to adjust *all* weights like this to get hte conditional probability
>>> that they weren't already chosen.
>>>
>>> I have a branch that hacks this into straw2 and it appears to work
>>> properly for num_rep = 2.  With a test bucket of [99 99 99 99 4], and the
>>> current code, you get
>>>
>>> $ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 --max-x 40000000 --num-rep 2
>>> rule 0 (data), x = 0..40000000, numrep = 2..2
>>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
>>>   device 0:             19765965        [9899364,9866601]
>>>   device 1:             19768033        [9899444,9868589]
>>>   device 2:             19769938        [9901770,9868168]
>>>   device 3:             19766918        [9898851,9868067]
>>>   device 6:             929148  [400572,528576]
>>>
>>> which is very close for the first replica (primary), but way off for the
>>> second.  With my hacky change,
>>>
>>> rule 0 (data), x = 0..40000000, numrep = 2..2
>>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
>>>   device 0:             19797315        [9899364,9897951]
>>>   device 1:             19799199        [9899444,9899755]
>>>   device 2:             19801016        [9901770,9899246]
>>>   device 3:             19797906        [9898851,9899055]
>>>   device 6:             804566  [400572,403994]
>>>
>>> which is quite close, but still skewing slightly high (by a big less than
>>> 1%).
>>>
>>> Next steps:
>>>
>>> 1- generalize this for >2 replicas
>>> 2- figure out why it skews high
>>> 3- make this work for multi-level hierarchical descent
>>>
>>> sage
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
