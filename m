From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] locking/mutexes: Revert "locking/mutexes: Add extra
 reschedule point"
Date: Thu, 31 Jul 2014 18:37:40 +0400
Message-ID: <CALFYKtDxF_NApZ010W7-BGCf4fkXSYca_g1=Kn8jV_jrf2tWGA@mail.gmail.com>
References: <1406801797-20139-1-git-send-email-ilya.dryomov@inktank.com>
	<20140731115759.GS19379@twins.programming.kicks-ass.net>
	<CALFYKtBGQpxaZ0EFXbdvuEHeDeASeU-7XxQ_1a6ZDM=aJS651w@mail.gmail.com>
	<20140731131331.GT19379@twins.programming.kicks-ass.net>
	<1406817052.17194.12.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:48404 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbaGaOhl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 10:37:41 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so2338997qap.37
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 07:37:40 -0700 (PDT)
In-Reply-To: <1406817052.17194.12.camel@marge.simpson.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, davidlohr@hp.com, jason.low2@hp.com

On Thu, Jul 31, 2014 at 6:30 PM, Mike Galbraith
<umgwanakikbuti@gmail.com> wrote:
> On Thu, 2014-07-31 at 15:13 +0200, Peter Zijlstra wrote:
>
>> Smells like maybe current->state != TASK_RUNNING

It just triggered for me too, took longer than usual.  Sorry for the
churn Peter, this was really confusing.  Onto finding the real bug..

Thanks,

                Ilya
