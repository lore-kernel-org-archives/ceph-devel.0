From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multipick anomaly
Date: Mon, 20 Feb 2017 20:31:01 +0100
Message-ID: <1a6479b9-9f3c-2670-2e07-0dcf45189911@dachary.org>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org>
 <CAJ4mKGZ8J5VYhsyo5cWT0qRtrh=2jbREixPBUwRCsCX1qY-odw@mail.gmail.com>
 <695d7ea8-b9e6-11ab-c356-6f935d59bb51@dachary.org>
 <CAJ4mKGb8ZKsq9-24uy8E=GC3M_P9OaaqewUzwMsfw7YBGd598w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56257 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdBTTbG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 14:31:06 -0500
In-Reply-To: <CAJ4mKGb8ZKsq9-24uy8E=GC3M_P9OaaqewUzwMsfw7YBGd598w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 02/20/2017 06:32 PM, Gregory Farnum wrote:
> On Mon, Feb 20, 2017 at 12:47 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 02/13/2017 03:53 PM, Gregory Farnum wrote:
>>> On Mon, Feb 13, 2017 at 2:36 AM, Loic Dachary <loic@dachary.org> wrote:
>>>> Hi,
>>>>
>>>> Dan van der Ster reached out to colleagues and friends and Pedro López-Adeva Fernández-Layos came up with a well written analysis of the problem and a tentative solution which he described at : https://github.com/plafl/notebooks/blob/master/replication.ipynb
>>>>
>>>> Unless I'm reading the document incorrectly (very possible ;) it also means that the probability of each disk needs to take in account the weight of all disks. Which means that whenever a disk is added / removed or its weight is changed, this has an impact on the probability of all disks in the cluster and objects are likely to move everywhere. Am I mistaken ?
>>>
>>> Keep in mind that in the math presented, "all disks" for our purposes
>>> really means "all items within a CRUSH bucket" (at least, best I can
>>> tell). So if you reweight a disk, you have to recalculate weights
>>> within its bucket and within each parent bucket, but each bucket has a
>>> bounded size N so the calculation should remain feasible. I didn't
>>> step through the more complicated math at the end but it made
>>> intuitive sense as far as I went.
>>
>> When crush chooses the second replica it ensures it does not land on the same host, rack etc. depending on the step CHOOSE* argument of the rule. When looking for the best weights (in the updated https://github.com/plafl/notebooks/blob/master/converted/replication.pdf versions) I think we would focus on the host weights (assuming the failure domain is the host) and not the disk weights. When drawing disks after the host was selected, the probabilities of each disk should not need to be modified because there will never be a rejection at that level (i.e. no conditional probability).
> 
> Well, you'd have changed the number of disks, so you'd need to
> recalculate within the host that got a new disk added. And then you'd
> need to recalculate the host and its peer buckets, and if it was in a
> rack then the rack and its peer buckets, and on up the chain.

I meant to say that you do not need to change the weight of the disks within other hosts. But you need to change the weight of all other hosts, not just the host in which a new disk was inserted/removed.

> 
>>
>> If the failure domain is the host I think the crush map should be something like:
>>
>> root:
>>    host1:
>>      disk1
>>      disk2
>>    host2:
>>      disk3
>>      disk4
>>    host3:
>>      disk5
>>      disk6
>>
>> Introducing racks such as in:
>>
>> root:
>>  rack0:
>>    host1:
>>      disk1
>>      disk2
>>    host2:
>>      disk3
>>      disk4
>>  rack1:
>>    host3:
>>      disk5
>>      disk6
>>
>> Is going to complicate the problem further, for no good reason other than a pretty display / architecture reminder.
> 
> Well, there's not much point if you're replicating across hosts, since
> the rack layer is very unbalanced here. But that's essentially a
> misconfiguration which is going to cause problems with any CRUSH-like
> system.
> 
> 
>> Since rejecting a second replica on host3 means it will land in rack0 instead of rack1, I think the probability distribution of the racks will need to be adjusted in the same way the probabilty distribution of the failure domain buckets need to.
> 
> I think maybe you're saying what I did before? "All disks" for our
> purposes really means "all items within a CRUSH bucket". The racks are
> CRUSH items within the root bucket.
> -Greg
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
