From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: GSOC on ceph-mgr : SMARTER SMARTER REWEIGHT-BY-UTILIZATION
Date: Mon, 8 May 2017 20:33:15 +0530
Message-ID: <CAAXqJ+qZxuyoD-OasWkANF0OP1TGLHb1HCW2QRaNJ_ewHHOoTw@mail.gmail.com>
References: <CAAXqJ+pv=rGtDFD=e=HPCGJyQE9qVLchDpNaaYQFiPd3iRCohw@mail.gmail.com>
 <CAJE9aON5UwizH80RZjp6UjCM6mbmReXo46QtV-OkBiGN4UU9kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33882 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754828AbdEHPDR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 May 2017 11:03:17 -0400
Received: by mail-oi0-f41.google.com with SMTP id b204so53543226oii.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 May 2017 08:03:16 -0700 (PDT)
In-Reply-To: <CAJE9aON5UwizH80RZjp6UjCM6mbmReXo46QtV-OkBiGN4UU9kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 8, 2017 at 4:10 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Mon, May 8, 2017 at 1:45 PM, Spandan Kumar Sahu
> <spandankumarsahu@gmail.com> wrote:
>> Hey evryone
>>
>> My name is Spandan Kumar Sahu, a second year undergraduate student
>> from Indian Institute of Technology, Kharagpur (India), pursuing
>> Bachelor of Technology in Computer Science and Engineering.
>
>
> Welcome to this community, Spandan!
>
>>
>> It is my pleasure to have been selected under the GSoC program. This
>> [1] is my proposal. I have also included an example of its working.
>> [2]
>>
>> As a start, Kefu Chai, suggested me to document the problem under
>> doc/dev and attempt to put together as many documents regarding
>> reweight, as possible.
>
> I think it would serve a good reference for whomever interested in
> this topic in future. we can start by maintaining a markdown document
> in your ceph repo, and when it's ready for review you can send a pull
> request from it.
>
I am currently working on it. I will send a PR soon.

>>
>> I would really appreciate if anyone can go through the proposal, and
>> suggest me changes/problems.
>
> i like your idea of applying PID to ceph. but i am not sure if the PID
> algorithm applies to Ceph. or put in other words, is a Ceph cluster a
> linear system? what is it's transfer function? does it satisfy the
> Nyquist stability criterion? if not, how can we determine its
> stability? as it's always the most difficult part to tune the PID
> controller parameters when designing a PID based control system.
>
The Ceph cluster is a stochastic process, under a short number of
trials ( or runs/iterations). However, when the trials are made in
reasonably large number, the weight distribution is linearly
proportional to the weight of the OSD, (if the anomaly were not to
happen). Hence, the weight distribution is linear in terms of weight
of the OSD for reasonable number of iterations.
Under normal conditions, the "load percentage the OSD handles" is an
"expected" linear function of the "ratio of the OSD's weight to the
total weight".

> instead, i think Ceph is a stochastic process. as discussed in another
> thread (with the title of "crush multipick anomaly") in this mailing
> list.
>
Also, should I start with the first part of the project, as to how to
analyse a reweight algorithm?

>>
>> Thanks
>>
>> Spandan Kumar Sahu
>> IIT Kharagpur
>>
>> [1] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/GSoCProposalSMARTERREWEIGHT-BY-UTILIZATION.pdf
>> [2] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/Readme
>
>
>
> --
> Regards
> Kefu Chai



-- 
Spandan Kumar Sahu
IIT Kharagpur
