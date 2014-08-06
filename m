From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: rework rbd_request_fn()
Date: Wed, 6 Aug 2014 23:09:52 +0400
Message-ID: <CALFYKtDyDawX87v6uudM-_VCBTB0j6r1SPA+P_krA3V22iy-EA@mail.gmail.com>
References: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>
	<53E274AF.8030901@ieee.org>
	<CALFYKtBxee2=8W_6uWT74i1GeOyuNwX85AHWVJ2-CZD3bOj_zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:38206 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772AbaHFTJx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Aug 2014 15:09:53 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so2905042qap.37
        for <ceph-devel@vger.kernel.org>; Wed, 06 Aug 2014 12:09:52 -0700 (PDT)
In-Reply-To: <CALFYKtBxee2=8W_6uWT74i1GeOyuNwX85AHWVJ2-CZD3bOj_zA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 6, 2014 at 11:06 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> On Wed, Aug 6, 2014 at 10:32 PM, Alex Elder <elder@ieee.org> wrote:
>> On 08/05/2014 02:38 AM, Ilya Dryomov wrote:
>>> While it was never a good idea to sleep in request_fn(), commit
>>> 34c6bc2c919a ("locking/mutexes: Add extra reschedule point") made it
>>> a *bad* idea.  mutex_lock() since 3.15 may reschedule *before* putting
>>> task on the mutex wait queue, which for tasks in !TASK_RUNNING state
>>> means block forever.  request_fn() may be called with !TASK_RUNNING on
>>> the way to schedule() in io_schedule().
>>>
>>> Offload request handling to a workqueue, one per rbd device, to avoid
>>> calling blocking primitives from rbd_request_fn().
>>
>> Off topic...  If you supply "--patience" to your git diff command
>> you'll get an easier-to-read result in some cases (like this one).
>> If you like that you can just do:
>>     git config --global --add diff.algorithm patience
>
> I'm generally using (and used to review this patch in particular)
> --histogram.  In my experience it gives slightly better results than
> --patience.  Didn't think of putting it into .gitconfig though.

Looks like --histogram beats --patience in this case too.
alloc_workqueue() hunk is much better, otherwise identical.

Thanks,

                Ilya
