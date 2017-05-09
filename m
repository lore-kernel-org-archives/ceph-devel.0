From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: GSOC on ceph-mgr : SMARTER SMARTER REWEIGHT-BY-UTILIZATION
Date: Tue, 9 May 2017 07:13:32 +0530
Message-ID: <CAAXqJ+qjAoBtG7cDRzO3own9o-KaGpWHJZxekSr+XqXtFztWDA@mail.gmail.com>
References: <CAAXqJ+pv=rGtDFD=e=HPCGJyQE9qVLchDpNaaYQFiPd3iRCohw@mail.gmail.com>
 <CAJE9aON5UwizH80RZjp6UjCM6mbmReXo46QtV-OkBiGN4UU9kQ@mail.gmail.com> <CAAXqJ+qZxuyoD-OasWkANF0OP1TGLHb1HCW2QRaNJ_ewHHOoTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36829 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbdEIBnd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 May 2017 21:43:33 -0400
Received: by mail-oi0-f50.google.com with SMTP id h4so71440651oib.3
        for <ceph-devel@vger.kernel.org>; Mon, 08 May 2017 18:43:33 -0700 (PDT)
In-Reply-To: <CAAXqJ+qZxuyoD-OasWkANF0OP1TGLHb1HCW2QRaNJ_ewHHOoTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 8, 2017 at 8:33 PM, Spandan Kumar Sahu
<spandankumarsahu@gmail.com> wrote:
> On Mon, May 8, 2017 at 4:10 PM, kefu chai <tchaikov@gmail.com> wrote:
>> On Mon, May 8, 2017 at 1:45 PM, Spandan Kumar Sahu
>> <spandankumarsahu@gmail.com> wrote:
>>> Hey evryone
>>>
>>> My name is Spandan Kumar Sahu, a second year undergraduate student
>>> from Indian Institute of Technology, Kharagpur (India), pursuing
>>> Bachelor of Technology in Computer Science and Engineering.
>>
>>
>> Welcome to this community, Spandan!
>>
>>>
>>> It is my pleasure to have been selected under the GSoC program. This
>>> [1] is my proposal. I have also included an example of its working.
>>> [2]
>>>
>>> As a start, Kefu Chai, suggested me to document the problem under
>>> doc/dev and attempt to put together as many documents regarding
>>> reweight, as possible.
>>
>> I think it would serve a good reference for whomever interested in
>> this topic in future. we can start by maintaining a markdown document
>> in your ceph repo, and when it's ready for review you can send a pull
>> request from it.
>>
> I am currently working on it. I will send a PR soon.
>
>>>
>>> I would really appreciate if anyone can go through the proposal, and
>>> suggest me changes/problems.
>>
>> i like your idea of applying PID to ceph. but i am not sure if the PID
>> algorithm applies to Ceph. or put in other words, is a Ceph cluster a
>> linear system? what is it's transfer function? does it satisfy the
>> Nyquist stability criterion? if not, how can we determine its
>> stability? as it's always the most difficult part to tune the PID
>> controller parameters when designing a PID based control system.
>>
> The Ceph cluster is a stochastic process, under a short number of
> trials ( or runs/iterations). However, when the trials are made in
> reasonably large number, the weight distribution is linearly
> proportional to the weight of the OSD, (if the anomaly were not to
> happen). Hence, the weight distribution is linear in terms of weight
> of the OSD for reasonable number of iterations.
> Under normal conditions, the "load percentage the OSD handles" is an
> "expected" linear function of the "ratio of the OSD's weight to the
> total weight".
>
The transfer function and Nyquist stability criterion are difficult to
determine because the cluster behaves stochastic-ally for small
numbers. The stability can be determined by the difference in the
current load percentage of the OSD and the expected load percentage.

As an example, Loic did implement a simpler version of the PID, and
gained significant improvement.This is his algorithm :
" - Distribute the desired number of PGs
    - Subtract 1% of the weight of the OSD that is the most over used
    - Add the subtracted weight to the OSD that is the most under used
    - Repeat until the Kullback=E2=80=93Leibler divergence[8] is small enou=
gh
" (Discussed on " revisiting uneven Crush" in the mailing list)

So, basically, he was more or less implementing only the Proportional
(P) part of the PID system and only for the most and least used OSDs.
This was the performance gain he obtained :
" In all tests the situation improves at least by an order of
magnitude. For instance when there is a 30% difference between two
OSDs, it is down to less than 3% after optimization. "

This made me hopeful that we can go ahead with a stronger form of PID
and expect a better optimisation.

I understand that tuning the PID is the most challenging part. But
there are various PID tuning algorithms, and there are certain PID
tuners, one of which I have worked on and have included in my
proposal.

>> instead, i think Ceph is a stochastic process. as discussed in another
>> thread (with the title of "crush multipick anomaly") in this mailing
>> list.
>>
> Also, should I start with the first part of the project, as to how to
> analyse a reweight algorithm?
>
>>>
>>> Thanks
>>>
>>> Spandan Kumar Sahu
>>> IIT Kharagpur
>>>
>>> [1] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/GSo=
CProposalSMARTERREWEIGHT-BY-UTILIZATION.pdf
>>> [2] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/Rea=
dme
>>
>>
>>
>> --
>> Regards
>> Kefu Chai
>
>
>
> --
> Spandan Kumar Sahu
> IIT Kharagpur



--=20
Spandan Kumar Sahu
IIT Kharagpur
