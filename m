From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: global backfill reservation?
Date: Sun, 4 Jun 2017 00:58:15 +0200
Message-ID: <dbe60a96-8873-6457-70f4-048b129376ff@brockmann-consult.de>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
 <CABZ+qqmtqL7Dgzu4XNsfyqgdJRZrkRXbfxRaRH+1bWg8zvDCBA@mail.gmail.com>
 <c59514c6-c817-dcea-ba16-4cc6003316de@brockmann-consult.de>
 <CABZ+qq=0FCRcoKAn88FradsW17s3d0aT4H5gAkXSbz_yY0fRaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCW6Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Jun 2017 18:58:25 -0400
In-Reply-To: <CABZ+qq=0FCRcoKAn88FradsW17s3d0aT4H5gAkXSbz_yY0fRaQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On 06/03/17 09:51, Dan van der Ster wrote:
> On Fri, Jun 2, 2017 at 4:05 PM, Peter Maloney
> <peter.maloney@brockmann-consult.de> wrote:
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
>>
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
>>
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
> Here's what we do:
>   1. Create and start new OSDs with initial crush weight = 0.0. No PGs
> should re-peer when these are booted.
>   2. Run the reweight script, e.g. like this for some 6T drives:
>
>    ceph-gentle-reweight -o osd.10,osd.11,osd.12 -l 15 -b 50 -d 0.01 -t 5.46
>
> In practice we've added >150 drives at once with that script -- using
> that tiny delta.
>
> We use crush reweight because it "works for us (tm)". We haven't seen
> any strange peering hangs, though we exercise this on hammer, not
> (yet) jewel.
> I hadn't thought of your method using osd reweight -- how do you add
> new osds with an initial osd reweight? Maybe you create the osds in a
> non-default root then move them after being reweighted to 0.0?
>
> Cheers, Dan

I added them with crush weight 0, then my plan was to raise the weight
like you do. That's basically what I did for all the other servers. But
I fiddled with the crush map and had them in another root when I set the
reweight 0, then weight 6, then moved them to root default (long
peering), then reweight 1 (short peering). But that wasn't what I
planned on doing or plan to do in the future.

I expect that would be the same as crush weight 0 and in the normal root
when created, then when ready for peering, set reweight 0 first, then
crush weight 6, then after peering is done, reweight 1 for a few at a
time (ceph osd reweight ...; sleep 2; while ceph health | grep peering;
do sleep 1; done ...).

The next step in this upgrade is to replace 18 2TB disks with 6TB
ones... I'll do it that way and find out if it works without the extra root.

