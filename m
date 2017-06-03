From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: global backfill reservation?
Date: Sun, 4 Jun 2017 01:11:47 +0200
Message-ID: <ba500cf4-2bc5-3669-5d03-ec1bdfa4cc80@brockmann-consult.de>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
 <CABZ+qqmtqL7Dgzu4XNsfyqgdJRZrkRXbfxRaRH+1bWg8zvDCBA@mail.gmail.com>
 <c59514c6-c817-dcea-ba16-4cc6003316de@brockmann-consult.de>
 <alpine.DEB.2.11.1706021535560.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:54328 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCXLz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Jun 2017 19:11:55 -0400
In-Reply-To: <alpine.DEB.2.11.1706021535560.3646@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/02/17 17:38, Sage Weil wrote:
> On Fri, 2 Jun 2017, Peter Maloney wrote:
>> On 05/13/17 18:55, Dan van der Ster wrote:
>>> +1, this is something I've wanted for awhile. Using my "gentle
>>> reweight" scripts, I've found that backfilling stays pretty
>>> transparent as long as we limit to <5% of OSDs backfilling on our
>>> large clusters. I think it will take some experimentation to find the
>>> best default ratio to ship.
>>>
>>> On the other hand, the *other* reason that we operators like to make
>>> small changes is to limit the number of PGs that go through peering
>>> all at once. Correct me if I'm wrong, but as an operator I'd hesitate
>>> to trigger a re-peering of *all* PGs in an active pool -- users would
>>> surely notice such an operation. Does luminous or luminous++ have some
>>> improvements to this half of the problem?
>>>
>>> Cheers, Dan
>>>
>> Hi Dan,
>>
>> I have read your script:
>> https://github.com/cernceph/ceph-scripts/blob/master/tools/ceph-gentle-reweight#L42
>>
>> And at that line I see you using "ceph osd crush reweight" instead of
>> "ceph osd reweight".
>>
>> And I just added 2 nodes to my cluster and had some related issues and
>> solved them. Doing it like your script, crush reweighting a tiny bit a
>> time causes blocked requests for long durations, even just moving 1 pg
>> ... I let one go for 40s before stopping it. It seemed impossible to
>> ever get one pg to peer without such a long block. I also tried making a
>> special pool with those 12 osds to test and it took 1 minute to make 64
>> pgs without any clients using them, which is still unreasonable for a
>> blocked request. (Also the "normal" way to just blindly add osds with
>> full weight and not take any special care would just do the same in one
>> big jump instead of many.)
> FWIW this sounds a lot like the problem that Josh is solving now (deletes 
> in the workload can make peering slow).  "Slow peering" is not very 
> specific, I guess, but that's the one known issue that makes peering 10s 
> of seconds slow.
>
>> And the solution in the end was quite painless... have osds up (with
>> either weight 0), then just set reweight 0, crush weight normal (TB) and
>> then it does peering (one sort of peering?) and then after peering is
>> done, change "ceph osd reweight", even a bunch at once and it has barely
>> any impact... it does peering (the other sort of peering, not repeating
>> the slow terrible sort it did already?), but very fast and with only a
>> few 5s blocked requests (which is fairly normal here due to rbd
>> snapshots). Maybe the crush weight peering with 0 reweight makes it do
>> the slow terrible sort of peering, but without blocking any real pgs,
>> and therefore without blocking clients, so it's tolerable (blocking
>> empty osds, not used pools and pgs). And then the other peering is fast.
> I don't see how this would be any different from a peering perspective.  
> The pattern of data movement and remapping would be different, but there's 
> no difference in this sequence that seems like it relate to peering 
> taking 10s of seconds.  :/
Maybe I explained it badly.... I mean it took just as long to change the
crush weight and peer, but when reweight was 0, the clients weren't
affected. Then when I set reweight 1, it was faster and clients seemed
happy still.
> How confident are you that this was a real effect?  Could it be that when 
> you tried the second method your disk caches were warm vs the first time 
> around when they were cold?
I don't know how to judge whether it cached anything... what is there to
cache on an empty disk? And does repating the test use the same data? It
was trying to peer the same pg each time.

I repeatedly re-tested the same osd to try to get it to peer many
times...like 30 or 40 times probably, spread over 2 days. Each time I
just let it block clients for about 5-20 seconds, and then when I
managed to somehow get it to only block 1 pg I know didn't matter much
(a basically idle pool), then I let it go 40s or longer.

I considered that doing the test with the separate root prepared the
osds for peering in the real root... but thought that's probably wrong
since the first osd was still slow doing my same test as before, until I
thought of using reweight instead of crush reweight. So that's like 40
times trying crush weight on one osd (a few times with 2-3 osds)... one
time testing separate a root and it fully peered... then a few times
trying crush weight again... then the reweight idea with one disk, then
one more, etc. and then the last 3 or 4 at once.

And I checked iostat and didn't think the disks looked very busy while
peering. I'll pay closer attention to that stuff (and anything you
suggest before then) when I do the next 18 osds (first removing, then
adding larger ones).

>
> sage
>
>> And Sage, if that's true, then couldn't ceph by default just do the
>> first kind of peering work before any pgs, pools, clients, etc. are
>> affected, before moving on to the stuff that affects clients, regardless
>> of which steps were used? At some point during adding t hose 2 nodes I
>> was thinking how could ceph be so broken and mysterious... why does it
>> just hang there? Would it do this during recovery of a dead osd too? Now
>> I know how to avoid it and that it shouldn't affect recovering dead osds
>> (not changing crush weight)... but it would be nice for all users not to
>> ever think that way. :)
>>
>> And Dan, I am curious about why you use crush reweight for this (which I
>> failed to), and whether you tried it the way I describe above, or
>> another way.
>>
>> And I'm using jewel 10.2.7. I don't know how other versions behave.
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


