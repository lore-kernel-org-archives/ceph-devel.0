From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: mgr balancer module
Date: Mon, 7 Aug 2017 14:25:14 +0530
Message-ID: <CAAXqJ+qB8FGFaOyPisXPAXsbK+_PPP9BnT8b-7LCVTY4V8zzVA@mail.gmail.com>
References: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal>
 <CAAXqJ+ovmFtC3dNo_5R5x9cj6smFev2Q9wgXVL_4NcHQCnA2tA@mail.gmail.com>
 <alpine.DEB.2.11.1707301814040.5035@piezo.novalocal> <CAAXqJ+r1CrBk1mHeHXK4_34uqLPtL9D+BBaKT=SU4s584Bk_sA@mail.gmail.com>
 <alpine.DEB.2.11.1708031545131.20435@piezo.novalocal> <CAAXqJ+o2utqxOCUibq9_xVOszR_y1mJxfi+ffNCuHtUxhHa_3g@mail.gmail.com>
 <alpine.DEB.2.11.1708040256220.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37359 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbdHGIzQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Aug 2017 04:55:16 -0400
Received: by mail-wm0-f47.google.com with SMTP id t201so1762264wmt.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Aug 2017 01:55:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708040256220.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Aug 4, 2017 at 9:20 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 4 Aug 2017, Spandan Kumar Sahu wrote:
>> On Thu, Aug 3, 2017 at 9:23 PM, Sage Weil <sweil@redhat.com> wrote:
>> > I think the main value in the python-crush optimize code is that it
>> > demonstrably works, which means we know that the cost/score fuction being
>> > used and the descent method work together.  I think the best path forward
>> > is to look at the core of what those two pieces are doing and port it into
>> > the balancer environment.  Most recently I've been working on the
>> > 'eval' method that will generate a score for a given distribution, but I'm
>> > working from first principles (just calculating the layout, its deviation
>> > from the target, the standard deviation, etc.) but I'm not sure what
>>
>> I had done some-work regarding assigning a score to the distribution
>> at this[1] PR. It was however done in the pre-existing
>> reweight-by-utilization. Would you give a look over it and let me
>> know, if I should proceed to port it into the balancer module?
>
> This seems reasonable...  I'm not sure we can really tell what the best
> function is without trying it in combination with some optimization
> method, though.
>
> I just pushed a semi-complete/working eval function in the wip-balancer
> branch that uses a normalized standard deviation for pgs, objects, and
> bytes.  (Normalized meaning the standard deviation is divided by the
> total count of pgs or objects or whatever so that it is unitless.)  The
> final score is just the average of those three values.  Pretty sure that's
> not the most sensible thing but its a start.  FWIW I can do
>
>  bin/init-ceph stop
>  MON=1 OSD=8 MDS=0 ../src/vstart.sh -d -n -x -l
>  bin/ceph osd pool create foo 64
>  bin/ceph osd set-require-min-compat-client luminous
>  bin/ceph balancer mode upmap
>  bin/rados -p foo bench 10 write -b 4096 --no-cleanup
>  bin/ceph balancer eval
>  bin/ceph balancer optimize foo
>  bin/ceph balancer eval foo
>  bin/ceph balancer execute foo
>  bin/ceph balancer eval
>
> and the score goes from .02 to .001 (and pgs get balanced).
>

I have sent a PR for a better scoring method at
                                      https://github.com/liewegas/ceph/pull/59.

Standard deviation is unbounded, and it depends significantly on the
'key' ('pg' or 'objects' or 'bytes'). This is not the case with the
scoring method that I suggest. Plus, there are additional benefits
like:
1. The new method can distinguish between the [ 5 overweighted + 1
heavily underweighted] vs [5 underweighted + 1 heavily overweighted].
(Discussed in previous mails)
2. It gives score in the similar range for all keys.
3. It takes into consideration of only the over-weighted devices.

The need of such a scoring algorithm, has been mentioned in comments
and commit message.

>> > Loic's optimizer was doing.  Also, my first attempt at a descent function
>> > to correct weights was pretty broken, and I know a lot of experimentation
>> > went into Loic's method.
>> >
>>
>> Loic's optimizer only fixed defects in the crushmap, and was not (in
>> the true sense) a reweight-by-utilization.
>> In short, Loic's optimizer was optimizing a pool, on the basis of a
>> rule, and then, ran a simulation to determine the new weights. Using
>> the `take` in rules, it used to determine a list of OSDs, and move
>> weights (about 1% of the overload%) from one OSD to another. This way,
>> the weights of the buckets on the next hierarchical level in
>> crush-tree wasn't affected. I went through the Loic's optimizer in
>> details and also added my own improvisations.
>>
>> I will try to port the logic, but I am not sure, where would I fit the
>> optimizer in? Would that go in as a separate function in module.py or
>> would it have different implementations for each of upmaps, crush,
>> crush-compat? Loic's python-crush didn't take upmaps into account. But
>> the logic will apply in case of upmaps too.
>
> The 'crush-compat' mode in balancer is the one to target.  There is a
> partial implementation there that needs to be updated to use the new
> framework; I'll fiddle with it a bit more to make it use the new Plan
> approach (currently it makes changes to the changes to the cluster,
> which doesn't work well!).  For now the latest is at
>
>         https://github.com/ceph/ceph/pull/16272
>
> You can ignore the other modes (upmap etc) for now.  Eventually we could
> make it so that transitioning from one mode to another will somehow phase
> out the old changes, but that's complicated and not needed yet.
>
>> > Do you see any problems with that approach, or things that the
>> > balancer framework does not cover?
>> >
>>
>> I was hoping that we have an optimizer that fixes the faults in
>> crushmap, whenever, a crushmap is set and/or a new device get added or
>> deleted. The current balancer would also fix it, but it would take
>> much more time, and much more movement of data to achieve better
>> distribution, compared to if we had fixed the crushmap itself, in the
>> very beginning. Nevertheless, the balancer module, will eventually
>> reach a reasonably good distribution.
>>
>> Correct me, if I am wrong. :)
>
> No, I think you're right.  I don't expect that people will be importing
> crush maps that often, though... and if they do they are hopefully clever
> enough to do their own thing.  The goal is for everything to be manageable
> via the CLI or (better yet) simply handled automatically by the system.
>
> I think the main thing to worry about is the specific cases that people
> are likely to encounter (and tend ot complain about), like adding new
> devices and wanting the system to weight them in gradually.
>
> sage
>
>
>
>>
>> [1]: https://github.com/ceph/ceph/pull/16361/files#diff-ecab4c883be988760d61a8a883ddc23fR4559
>>
>> > Thanks!
>> > sage
>> >
>>
>>
>>
>> --
>> Spandan Kumar Sahu
>> IIT Kharagpur
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



-- 
Regards
Spandan Kumar Sahu
