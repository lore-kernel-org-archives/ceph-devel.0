From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: rework rbd_request_fn()
Date: Thu, 7 Aug 2014 11:21:25 +0400
Message-ID: <CALFYKtBKfTERgA_oR_NSsH2GKW7accsi3GFPqa597KVX7w4qJw@mail.gmail.com>
References: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>
	<53E274AF.8030901@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:58415 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbaHGHV0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Aug 2014 03:21:26 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so3596585qap.37
        for <ceph-devel@vger.kernel.org>; Thu, 07 Aug 2014 00:21:25 -0700 (PDT)
In-Reply-To: <53E274AF.8030901@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 6, 2014 at 10:32 PM, Alex Elder <elder@ieee.org> wrote:
> On 08/05/2014 02:38 AM, Ilya Dryomov wrote:
>> While it was never a good idea to sleep in request_fn(), commit
>> 34c6bc2c919a ("locking/mutexes: Add extra reschedule point") made it
>> a *bad* idea.  mutex_lock() since 3.15 may reschedule *before* putting
>> task on the mutex wait queue, which for tasks in !TASK_RUNNING state
>> means block forever.  request_fn() may be called with !TASK_RUNNING on
>> the way to schedule() in io_schedule().
>>
>> Offload request handling to a workqueue, one per rbd device, to avoid
>> calling blocking primitives from rbd_request_fn().
>
> Off topic...  If you supply "--patience" to your git diff command
> you'll get an easier-to-read result in some cases (like this one).
> If you like that you can just do:
>     git config --global --add diff.algorithm patience
>
> I have several comments below, none of which are bugs, just
> suggestions.
>
> I was thinking you could use a single work queue for all rbd
> devices, but I'm not sure that's very important.  You'd have
> to stash the rbd_dev pointer in every request somewhere.

That's possible, but workqueues are not threads and are supposed to be
relatively cheap.  And for the future, it's probably worth switching to
blk-mq infrastructure, as Christoph suggested.

Thanks,

                Ilya
