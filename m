From: kefu chai <tchaikov@gmail.com>
Subject: Re: GSOC on ceph-mgr : SMARTER SMARTER REWEIGHT-BY-UTILIZATION
Date: Mon, 8 May 2017 18:40:27 +0800
Message-ID: <CAJE9aON5UwizH80RZjp6UjCM6mbmReXo46QtV-OkBiGN4UU9kQ@mail.gmail.com>
References: <CAAXqJ+pv=rGtDFD=e=HPCGJyQE9qVLchDpNaaYQFiPd3iRCohw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35579 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbdEHKk3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 May 2017 06:40:29 -0400
Received: by mail-ua0-f181.google.com with SMTP id e55so38227587uaa.2
        for <ceph-devel@vger.kernel.org>; Mon, 08 May 2017 03:40:29 -0700 (PDT)
In-Reply-To: <CAAXqJ+pv=rGtDFD=e=HPCGJyQE9qVLchDpNaaYQFiPd3iRCohw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 8, 2017 at 1:45 PM, Spandan Kumar Sahu
<spandankumarsahu@gmail.com> wrote:
> Hey evryone
>
> My name is Spandan Kumar Sahu, a second year undergraduate student
> from Indian Institute of Technology, Kharagpur (India), pursuing
> Bachelor of Technology in Computer Science and Engineering.


Welcome to this community, Spandan!

>
> It is my pleasure to have been selected under the GSoC program. This
> [1] is my proposal. I have also included an example of its working.
> [2]
>
> As a start, Kefu Chai, suggested me to document the problem under
> doc/dev and attempt to put together as many documents regarding
> reweight, as possible.

I think it would serve a good reference for whomever interested in
this topic in future. we can start by maintaining a markdown document
in your ceph repo, and when it's ready for review you can send a pull
request from it.

>
> I would really appreciate if anyone can go through the proposal, and
> suggest me changes/problems.

i like your idea of applying PID to ceph. but i am not sure if the PID
algorithm applies to Ceph. or put in other words, is a Ceph cluster a
linear system? what is it's transfer function? does it satisfy the
Nyquist stability criterion? if not, how can we determine its
stability? as it's always the most difficult part to tune the PID
controller parameters when designing a PID based control system.

instead, i think Ceph is a stochastic process. as discussed in another
thread (with the title of "crush multipick anomaly") in this mailing
list.

>
> Thanks
>
> Spandan Kumar Sahu
> IIT Kharagpur
>
> [1] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/GSoCProposalSMARTERREWEIGHT-BY-UTILIZATION.pdf
> [2] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/Readme



-- 
Regards
Kefu Chai
