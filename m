From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: global backfill reservation?
Date: Fri, 2 Jun 2017 16:05:50 +0200
Message-ID: <c59514c6-c817-dcea-ba16-4cc6003316de@brockmann-consult.de>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
 <CABZ+qqmtqL7Dgzu4XNsfyqgdJRZrkRXbfxRaRH+1bWg8zvDCBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62706 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdFBOGE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 10:06:04 -0400
In-Reply-To: <CABZ+qqmtqL7Dgzu4XNsfyqgdJRZrkRXbfxRaRH+1bWg8zvDCBA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On 05/13/17 18:55, Dan van der Ster wrote:
> +1, this is something I've wanted for awhile. Using my "gentle
> reweight" scripts, I've found that backfilling stays pretty
> transparent as long as we limit to <5% of OSDs backfilling on our
> large clusters. I think it will take some experimentation to find the
> best default ratio to ship.
>
> On the other hand, the *other* reason that we operators like to make
> small changes is to limit the number of PGs that go through peering
> all at once. Correct me if I'm wrong, but as an operator I'd hesitate
> to trigger a re-peering of *all* PGs in an active pool -- users would
> surely notice such an operation. Does luminous or luminous++ have some
> improvements to this half of the problem?
>
> Cheers, Dan
>

Hi Dan,

I have read your script:
https://github.com/cernceph/ceph-scripts/blob/master/tools/ceph-gentle-reweight#L42

And at that line I see you using "ceph osd crush reweight" instead of
"ceph osd reweight".

And I just added 2 nodes to my cluster and had some related issues and
solved them. Doing it like your script, crush reweighting a tiny bit a
time causes blocked requests for long durations, even just moving 1 pg
... I let one go for 40s before stopping it. It seemed impossible to
ever get one pg to peer without such a long block. I also tried making a
special pool with those 12 osds to test and it took 1 minute to make 64
pgs without any clients using them, which is still unreasonable for a
blocked request. (Also the "normal" way to just blindly add osds with
full weight and not take any special care would just do the same in one
big jump instead of many.)

And the solution in the end was quite painless... have osds up (with
either weight 0), then just set reweight 0, crush weight normal (TB) and
then it does peering (one sort of peering?) and then after peering is
done, change "ceph osd reweight", even a bunch at once and it has barely
any impact... it does peering (the other sort of peering, not repeating
the slow terrible sort it did already?), but very fast and with only a
few 5s blocked requests (which is fairly normal here due to rbd
snapshots). Maybe the crush weight peering with 0 reweight makes it do
the slow terrible sort of peering, but without blocking any real pgs,
and therefore without blocking clients, so it's tolerable (blocking
empty osds, not used pools and pgs). And then the other peering is fast.

And Sage, if that's true, then couldn't ceph by default just do the
first kind of peering work before any pgs, pools, clients, etc. are
affected, before moving on to the stuff that affects clients, regardless
of which steps were used? At some point during adding t hose 2 nodes I
was thinking how could ceph be so broken and mysterious... why does it
just hang there? Would it do this during recovery of a dead osd too? Now
I know how to avoid it and that it shouldn't affect recovering dead osds
(not changing crush weight)... but it would be nice for all users not to
ever think that way. :)

And Dan, I am curious about why you use crush reweight for this (which I
failed to), and whether you tried it the way I describe above, or
another way.

And I'm using jewel 10.2.7. I don't know how other versions behave.


