From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: rework rbd_request_fn()
Date: Wed, 6 Aug 2014 23:06:09 +0400
Message-ID: <CALFYKtBxee2=8W_6uWT74i1GeOyuNwX85AHWVJ2-CZD3bOj_zA@mail.gmail.com>
References: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>
	<53E274AF.8030901@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34203 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaHFTGK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Aug 2014 15:06:10 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so3249196qge.30
        for <ceph-devel@vger.kernel.org>; Wed, 06 Aug 2014 12:06:09 -0700 (PDT)
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

I'm generally using (and used to review this patch in particular)
--histogram.  In my experience it gives slightly better results than
--patience.  Didn't think of putting it into .gitconfig though.

>
> I have several comments below, none of which are bugs, just
> suggestions.
>
> I was thinking you could use a single work queue for all rbd
> devices, but I'm not sure that's very important.  You'd have
> to stash the rbd_dev pointer in every request somewhere.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>
>> Cc: stable@vger.kernel.org # 3.15+
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  drivers/block/rbd.c |  195 +++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 118 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index e3412317d3f9..e07d9d71b187 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -42,6 +42,7 @@
>>  #include <linux/blkdev.h>
>>  #include <linux/slab.h>
>>  #include <linux/idr.h>
>> +#include <linux/workqueue.h>
>>
>>  #include "rbd_types.h"
>>
>> @@ -332,7 +333,10 @@ struct rbd_device {
>>
>>       char                    name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
>>
>> +     struct list_head        rq_queue;       /* incoming rq queue */
>>       spinlock_t              lock;           /* queue, flags, open_count */
>> +     struct workqueue_struct *rq_wq;
>> +     struct work_struct      rq_work;
>>
>>       struct rbd_image_header header;
>>       unsigned long           flags;          /* possibly lock protected */
>> @@ -3176,102 +3180,129 @@ out:
>>       return ret;
>>  }
>>
>> -static void rbd_request_fn(struct request_queue *q)
>> -             __releases(q->queue_lock) __acquires(q->queue_lock)
>> +static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
>>  {
>
> . . .
>
>> +     if (offset + length > rbd_dev->mapping.size) {
>> +             rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
>> +                      length, rbd_dev->mapping.size);
>> +             result = -EIO;
>> +             goto err_rq;
>> +     }
>>
>> -             spin_unlock_irq(q->queue_lock);
>> +     img_request = rbd_img_request_create(rbd_dev, offset, length, wr);
>
> This isn't new with your patch, but perhaps we should consider
> having rbd_img_request_create() use GFP_KERNEL or at least GFP_NOIO
> rather than GFP_ATOMIC.  In general, I think a pass ought to be
> made through all the allocation calls to make sure they have the
> right flags.  Some may be too restrictive, some maybe not enough.

Definitely, I already have a patch that switches img_request to NOIO -
allocating it with ATOMIC in workfn doesn't make sense.

As for the general pass, I think there is a ticket for that, so
hopefully I'll get to it sometime..

Thanks,

                Ilya
