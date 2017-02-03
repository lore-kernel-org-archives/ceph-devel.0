From: Dan van der Ster <dan@vanderster.com>
Subject: Re: crush multipick anomaly
Date: Fri, 3 Feb 2017 16:26:18 +0100
Message-ID: <CABZ+qqn13kR+4FjSmWKgt4Fee0+8B2Gi-qJjT8MaXpu2e6=2Ew@mail.gmail.com>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <e5f376bb-925b-17df-ae6e-abc07058f67b@dachary.org> <6a7b52c8-a0fd-41a6-fbf1-fb2af3e347d8@dachary.org>
 <alpine.DEB.2.11.1702031443400.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37205 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdBCP1C (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 10:27:02 -0500
Received: by mail-wm0-f47.google.com with SMTP id v77so33068821wmv.0
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2017 07:27:01 -0800 (PST)
Received: from mail-wj0-f171.google.com (mail-wj0-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id p49sm45366583wrb.10.2017.02.03.07.26.59
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 07:26:59 -0800 (PST)
Received: by mail-wj0-f171.google.com with SMTP id b20so1964387wjs.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2017 07:26:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702031443400.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 3, 2017 at 3:47 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 3 Feb 2017, Loic Dachary wrote:
>> On 01/26/2017 12:13 PM, Loic Dachary wrote:
>> > Hi Sage,
>> >
>> > Still trying to understand what you did :-) I have one question below.
>> >
>> > On 01/26/2017 04:05 AM, Sage Weil wrote:
>> >> This is a longstanding bug,
>> >>
>> >>    http://tracker.ceph.com/issues/15653
>> >>
>> >> that causes low-weighted devices to get more data than they should. Loic's
>> >> recent activity resurrected discussion on the original PR
>> >>
>> >>    https://github.com/ceph/ceph/pull/10218
>> >>
>> >> but since it's closed and almost nobody will see it I'm moving the
>> >> discussion here.
>> >>
>> >> The main news is that I have a simple adjustment for the weights that
>> >> works (almost perfectly) for the 2nd round of placements.  The solution is
>> >> pretty simple, although as with most probabilities it tends to make my
>> >> brain hurt.
>> >>
>> >> The idea is that, on the second round, the original weight for the small
>> >> OSD (call it P(pick small)) isn't what we should use.  Instead, we want
>> >> P(pick small | first pick not small).  Since P(a|b) (the probability of a
>> >> given b) is P(a && b) / P(b),
>> >
>> >>From the record this is explained at https://en.wikipedia.org/wiki/Conditional_probability#Kolmogorov_definition
>> >
>> >>
>> >>  P(pick small | first pick not small)
>> >>  = P(pick small && first pick not small) / P(first pick not small)
>> >>
>> >> The last term is easy to calculate,
>> >>
>> >>  P(first pick not small) = (total_weight - small_weight) / total_weight
>> >>
>> >> and the && term is the distribution we're trying to produce.
>> >
>> > https://en.wikipedia.org/wiki/Conditional_probability describs A && B (using a non ascii symbol...) as the "probability of the joint of events A and B". I don't understand what that means. Is there a definition somewhere ?
>> >
>> >> For exmaple,
>> >> if small has 1/10 the weight, then we should see 1/10th of the PGs have
>> >> their second replica be the small OSD.  So
>> >>
>> >>  P(pick small && first pick not small) = small_weight / total_weight
>> >>
>> >> Putting those together,
>> >>
>> >>  P(pick small | first pick not small)
>> >>  = P(pick small && first pick not small) / P(first pick not small)
>> >>  = (small_weight / total_weight) / ((total_weight - small_weight) / total_weight)
>> >>  = small_weight / (total_weight - small_weight)
>> >>
>> >> This is, on the second round, we should adjust the weights by the above so
>> >> that we get the right distribution of second choices.  It turns out it
>> >> works to adjust *all* weights like this to get hte conditional probability
>> >> that they weren't already chosen.
>> >>
>> >> I have a branch that hacks this into straw2 and it appears to work
>> >
>> > This is https://github.com/liewegas/ceph/commit/wip-crush-multipick
>>
>> In
>>
>> https://github.com/liewegas/ceph/commit/wip-crush-multipick#diff-0df13ad294f6585c322588cfe026d701R316
>>
>> double neww = oldw / (bucketw - oldw) * bucketw;
>>
>> I don't get why we need  "* bucketw" at the end ?
>
> It's just to keep the values within a reasonable range so that we don't
> lose precision by dropping down into small integers.
>
> I futzed around with this some more last week trying to get the third
> replica to work and ended up doubting that this piece is correct.  The
> ratio between the big and small OSDs in my [99 99 99 99 4] example varies
> slightly from what I would expect from first principles and what I get out
> of this derivation by about 1%.. which would explain the bias I as seeing.
>
> I'm hoping we can find someone with a strong stats/probability background
> and loads of free time who can tackle this...
>

I'm *not* that person, but I gave it a go last weekend and realized a
few things:

1. We should add the additional constraint that for all PGs assigned
to an OSD, 1/N of them must be primary replicas, 1/N must be
secondary, 1/N must be tertiary, etc. for N replicas/stripes. E.g. for
a 3 replica pool, the "small" OSD should still have the property that
1/3rd are primaries, 1/3rd are secondary, 1/3rd are tertiary.

2. I believe this is a case of the balls-into-bins problem -- we have
colored balls and weighted bins. I didn't find a definition of the
problem where the goal is to allow users to specify weights which must
be respected after N rounds.

3. I wrote some quick python to simulate different reweighting
algorithms. The solution is definitely not obvious - I often thought
I'd solved it (e.g. for simple OSD weight sets like 3, 3, 3, 1) - but
changing the OSDs weights to e.g. 3, 3, 1, 1 completely broke things.
I can clean up and share that python if it's can help.

My gut feeling is that because CRUSH trees and rulesets can be
arbitrarily complex, the most pragmatic & reliable way to solve this
problem is to balance the PGs with a reweight-by-pg loop at crush
compilation time. This is what admins should do now -- we should just
automate it.

Cheers, Dan

P.S. -- maybe these guys can help: http://math.stackexchange.com/
