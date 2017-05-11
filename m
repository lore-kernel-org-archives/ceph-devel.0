From: kefu chai <tchaikov@gmail.com>
Subject: Re: GSOC on ceph-mgr : SMARTER SMARTER REWEIGHT-BY-UTILIZATION
Date: Thu, 11 May 2017 15:18:23 +0800
Message-ID: <CAJE9aON0cqmfRWYK-QyhA04Gqmm4a8Cs71bCoyc07Wt-REW=0g@mail.gmail.com>
References: <CAAXqJ+pv=rGtDFD=e=HPCGJyQE9qVLchDpNaaYQFiPd3iRCohw@mail.gmail.com>
 <CAJE9aON5UwizH80RZjp6UjCM6mbmReXo46QtV-OkBiGN4UU9kQ@mail.gmail.com>
 <CAAXqJ+qZxuyoD-OasWkANF0OP1TGLHb1HCW2QRaNJ_ewHHOoTw@mail.gmail.com> <CAAXqJ+qjAoBtG7cDRzO3own9o-KaGpWHJZxekSr+XqXtFztWDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36126 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdEKHS2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 03:18:28 -0400
Received: by mail-ua0-f178.google.com with SMTP id j17so20195321uag.3
        for <ceph-devel@vger.kernel.org>; Thu, 11 May 2017 00:18:28 -0700 (PDT)
In-Reply-To: <CAAXqJ+qjAoBtG7cDRzO3own9o-KaGpWHJZxekSr+XqXtFztWDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 9, 2017 at 9:43 AM, Spandan Kumar Sahu
<spandankumarsahu@gmail.com> wrote:
>>
>>>>
>>>> I would really appreciate if anyone can go through the proposal, and
>>>> suggest me changes/problems.
>>>
>>> i like your idea of applying PID to ceph. but i am not sure if the PID
>>> algorithm applies to Ceph. or put in other words, is a Ceph cluster a
>>> linear system? what is it's transfer function? does it satisfy the
>>> Nyquist stability criterion? if not, how can we determine its
>>> stability? as it's always the most difficult part to tune the PID
>>> controller parameters when designing a PID based control system.
>>>
>> The Ceph cluster is a stochastic process, under a short number of
>> trials ( or runs/iterations). However, when the trials are made in
>> reasonably large number, the weight distribution is linearly
>> proportional to the weight of the OSD, (if the anomaly were not to

the weight is a *distribution*, but not a function of time. could you
explain a little bit its input and output using the model explained by
https://en.wikipedia.org/wiki/Linear_system ?

>> happen). Hence, the weight distribution is linear in terms of weight

the function of "distribution" does not have the property of
superposition, that's the crux of the problem we are facing. we
assumed that it was, but it turns out to be not. that's why Lo=C3=AFc and
other developers are trying to use some optimization methods to reach
an optimum solution.

>> of the OSD for reasonable number of iterations.
>> Under normal conditions, the "load percentage the OSD handles" is an
>> "expected" linear function of the "ratio of the OSD's weight to the
>> total weight".
>>
> The transfer function and Nyquist stability criterion are difficult to
> determine because the cluster behaves stochastic-ally for small
> numbers. The stability can be determined by the difference in the
> current load percentage of the OSD and the expected load percentage.

but you mentioned above that it is a linear system if the number of
trials is large enough. so let's assume that we have large number of
trials.

>
> As an example, Loic did implement a simpler version of the PID, and
> gained significant improvement.This is his algorithm :
> " - Distribute the desired number of PGs
>     - Subtract 1% of the weight of the OSD that is the most over used
>     - Add the subtracted weight to the OSD that is the most under used
>     - Repeat until the Kullback=E2=80=93Leibler divergence[8] is small en=
ough
> " (Discussed on " revisiting uneven Crush" in the mailing list)

this is an iterative method to approach the optimum weights.

>
> So, basically, he was more or less implementing only the Proportional
> (P) part of the PID system and only for the most and least used OSDs.
> This was the performance gain he obtained :
> " In all tests the situation improves at least by an order of
> magnitude. For instance when there is a 30% difference between two
> OSDs, it is down to less than 3% after optimization. "
>
> This made me hopeful that we can go ahead with a stronger form of PID
> and expect a better optimisation.
>
> I understand that tuning the PID is the most challenging part. But
> there are various PID tuning algorithms, and there are certain PID
> tuners, one of which I have worked on and have included in my
> proposal.

there are.  but i think PID has its limitation.

>
>>> instead, i think Ceph is a stochastic process. as discussed in another
>>> thread (with the title of "crush multipick anomaly") in this mailing
>>> list.
>>>
>> Also, should I start with the first part of the project, as to how to
>> analyse a reweight algorithm?

yes! please see Lo=C3=AFc's crush tool it offers a subcommand "analyze"
which will show how the PG is distributed among OSDs. the more even
the better.

>>
>>>>
>>>> Thanks
>>>>
>>>> Spandan Kumar Sahu
>>>> IIT Kharagpur
>>>>
>>>> [1] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/GS=
oCProposalSMARTERREWEIGHT-BY-UTILIZATION.pdf
>>>> [2] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/Re=
adme
>>>
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>
>>
>>
>> --
>> Spandan Kumar Sahu
>> IIT Kharagpur
>
>
>
> --
> Spandan Kumar Sahu
> IIT Kharagpur



--=20
Regards
Kefu Chai
