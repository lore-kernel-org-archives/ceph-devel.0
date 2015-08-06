From: Ding Dinghua <dingdinghua85@gmail.com>
Subject: Re: More ondisk_finisher thread?
Date: Thu, 6 Aug 2015 18:47:33 +0800
Message-ID: <CANf+_k+aYrhWDY=dKdDJ7ErOFQ2heScLOuo9V-qo-O7g20zEzw@mail.gmail.com>
References: <CANf+_kKpR6prfna20CtRfq=6QF+vpvCJu2NaO73RwuF=X+HMwA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CDF8A9C@SACMBXIP01.sdcorp.global.sandisk.com>
	<CANf+_kLHWKdc+7wq=SvnLeZzibDpMOiHi4d+aW58=DnSHVZJVw@mail.gmail.com>
	<alpine.DEB.2.00.1508050528090.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33394 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbbHFKre (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 06:47:34 -0400
Received: by ykoo205 with SMTP id o205so58833048yko.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 03:47:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508050528090.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry for the noise.
I have find out the cause in our setup and case: We gathered too many
logs in our RADOS IO path, and the latency seems to be
reasonable(about 0.026 ms) if we don't gather that many logs...

2015-08-05 20:29 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 5 Aug 2015, Ding Dinghua wrote:
>> 2015-08-05 0:13 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
>> > Yes, it has to re-acquire pg_lock today..
>> > But, between journal write and initiating the ondisk ack, there is one context switche in the code path. So, I guess the pg_lock is not the only one that is causing this 1 ms delay...
>> > Not sure increasing the finisher threads will help in the pg_lock case as it will be more or less serialized by this pg_lock..
>> My concern is, if pg lock of pg A has been grabbed, not only ondisk
>> callback of pg A is delayed, since ondisk_finisher has only one
>> thread,  ondisk callback of other pgs will be delayed too.
>
> I wonder if an optimistic approach might help here by making the
> completion synchronous and doing something like
>
>    if (pg->lock.TryLock()) {
>       pg->_finish_thing(completion->op);
>       delete completion;
>    } else {
>       finisher.queue(completion);
>    }
>
> or whatever.  We'd need to ensure that we aren't holding any lock or
> throttle budget that the pg could deadlock against.
>
> sage



-- 
Ding Dinghua
