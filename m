From: Sage Weil <sage@newdream.net>
Subject: Re: More ondisk_finisher thread?
Date: Wed, 5 Aug 2015 05:29:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508050528090.22099@cobra.newdream.net>
References: <CANf+_kKpR6prfna20CtRfq=6QF+vpvCJu2NaO73RwuF=X+HMwA@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDF8A9C@SACMBXIP01.sdcorp.global.sandisk.com> <CANf+_kLHWKdc+7wq=SvnLeZzibDpMOiHi4d+aW58=DnSHVZJVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58064 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbbHEM35 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 08:29:57 -0400
In-Reply-To: <CANf+_kLHWKdc+7wq=SvnLeZzibDpMOiHi4d+aW58=DnSHVZJVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ding Dinghua <dingdinghua85@gmail.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 5 Aug 2015, Ding Dinghua wrote:
> 2015-08-05 0:13 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> > Yes, it has to re-acquire pg_lock today..
> > But, between journal write and initiating the ondisk ack, there is one context switche in the code path. So, I guess the pg_lock is not the only one that is causing this 1 ms delay...
> > Not sure increasing the finisher threads will help in the pg_lock case as it will be more or less serialized by this pg_lock..
> My concern is, if pg lock of pg A has been grabbed, not only ondisk
> callback of pg A is delayed, since ondisk_finisher has only one
> thread,  ondisk callback of other pgs will be delayed too.

I wonder if an optimistic approach might help here by making the 
completion synchronous and doing something like

   if (pg->lock.TryLock()) {
      pg->_finish_thing(completion->op);
      delete completion;
   } else {
      finisher.queue(completion);
   }

or whatever.  We'd need to ensure that we aren't holding any lock or 
throttle budget that the pg could deadlock against.

sage
