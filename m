From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: mgr balancer module
Date: Fri, 4 Aug 2017 00:05:26 +0530
Message-ID: <CAAXqJ+o2utqxOCUibq9_xVOszR_y1mJxfi+ffNCuHtUxhHa_3g@mail.gmail.com>
References: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal>
 <CAAXqJ+ovmFtC3dNo_5R5x9cj6smFev2Q9wgXVL_4NcHQCnA2tA@mail.gmail.com>
 <alpine.DEB.2.11.1707301814040.5035@piezo.novalocal> <CAAXqJ+r1CrBk1mHeHXK4_34uqLPtL9D+BBaKT=SU4s584Bk_sA@mail.gmail.com>
 <alpine.DEB.2.11.1708031545131.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35873 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdHCSf2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Aug 2017 14:35:28 -0400
Received: by mail-wm0-f52.google.com with SMTP id t201so2336067wmt.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Aug 2017 11:35:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708031545131.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 3, 2017 at 9:23 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi Spandan,
>
> On Thu, 3 Aug 2017, Spandan Kumar Sahu wrote:
>> Sage
>>
>> I think it would be a good idea to include a command in the balancer
>> module itself, that would optimize the crushmap using the
>> python-crush, and set the optimized crushmap.
>>
>> As far as I believe, uneven distributions can be majorly attributed to
>> the factors:
>> * using an unoptimized crushmap
>> * unevenness that occurs due to the (pseudo) random nature of CRUSH
>> * objects having different sizes.
>>
>> If we set an optimized crushmap, at the very initial stages, we have
>> to move very less data in the due course, in order to maintain a
>> proper distribution. Hence the necessity of including it in the
>> balancer module. Please give a look at the PR[1], I sent in this
>> regard, and let me know if I am moving in the right direction.
>
> There are a few problems with using python-crush, the main one being that
> the dependencies are problematic: it's built from a forked repo and is not
> packaged properly (has to be installed with pip).  It also may not
> match the CRUSH version being used by the cluster.
>
I tried adding it to the install-deps.sh, but I missed the fact that,
the python-crush, will not get an updated with changes in the crush
directory of the Ceph source.

> The larger issue though is that it doesn't address all of the other
> problems I highlighted in my earlier email.  The main thing it *does* to
> properly is it does the optimization based on a model; this was the main
> problem with the old reweight-by-utilization.  The new framework in
> balancer.py has all the pieces now to let you do that.
>

Okay, may be then, I will try to port only the logic Loic's work and
see how this works.

> I think the main value in the python-crush optimize code is that it
> demonstrably works, which means we know that the cost/score fuction being
> used and the descent method work together.  I think the best path forward
> is to look at the core of what those two pieces are doing and port it into
> the balancer environment.  Most recently I've been working on the
> 'eval' method that will generate a score for a given distribution, but I'm
> working from first principles (just calculating the layout, its deviation
> from the target, the standard deviation, etc.) but I'm not sure what

I had done some-work regarding assigning a score to the distribution
at this[1] PR. It was however done in the pre-existing
reweight-by-utilization. Would you give a look over it and let me
know, if I should proceed to port it into the balancer module?

> Loic's optimizer was doing.  Also, my first attempt at a descent function
> to correct weights was pretty broken, and I know a lot of experimentation
> went into Loic's method.
>

Loic's optimizer only fixed defects in the crushmap, and was not (in
the true sense) a reweight-by-utilization.
In short, Loic's optimizer was optimizing a pool, on the basis of a
rule, and then, ran a simulation to determine the new weights. Using
the `take` in rules, it used to determine a list of OSDs, and move
weights (about 1% of the overload%) from one OSD to another. This way,
the weights of the buckets on the next hierarchical level in
crush-tree wasn't affected. I went through the Loic's optimizer in
details and also added my own improvisations.

I will try to port the logic, but I am not sure, where would I fit the
optimizer in? Would that go in as a separate function in module.py or
would it have different implementations for each of upmaps, crush,
crush-compat? Loic's python-crush didn't take upmaps into account. But
the logic will apply in case of upmaps too.

> Do you see any problems with that approach, or things that the
> balancer framework does not cover?
>

I was hoping that we have an optimizer that fixes the faults in
crushmap, whenever, a crushmap is set and/or a new device get added or
deleted. The current balancer would also fix it, but it would take
much more time, and much more movement of data to achieve better
distribution, compared to if we had fixed the crushmap itself, in the
very beginning. Nevertheless, the balancer module, will eventually
reach a reasonably good distribution.

Correct me, if I am wrong. :)

[1]: https://github.com/ceph/ceph/pull/16361/files#diff-ecab4c883be988760d61a8a883ddc23fR4559

> Thanks!
> sage
>



-- 
Spandan Kumar Sahu
IIT Kharagpur
