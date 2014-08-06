From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: rework rbd_request_fn()
Date: Wed, 06 Aug 2014 13:32:15 -0500
Message-ID: <53E274AF.8030901@ieee.org>
References: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36570 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282AbaHFScR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Aug 2014 14:32:17 -0400
Received: by mail-ie0-f170.google.com with SMTP id rl12so3382042iec.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 Aug 2014 11:32:16 -0700 (PDT)
In-Reply-To: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 08/05/2014 02:38 AM, Ilya Dryomov wrote:
> While it was never a good idea to sleep in request_fn(), commit
> 34c6bc2c919a ("locking/mutexes: Add extra reschedule point") made it
> a *bad* idea.  mutex_lock() since 3.15 may reschedule *before* putting
> task on the mutex wait queue, which for tasks in !TASK_RUNNING state
> means block forever.  request_fn() may be called with !TASK_RUNNING on
> the way to schedule() in io_schedule().
> 
> Offload request handling to a workqueue, one per rbd device, to avoid
> calling blocking primitives from rbd_request_fn().

Off topic...  If you supply "--patience" to your git diff command
you'll get an easier-to-read result in some cases (like this one).
If you like that you can just do:
    git config --global --add diff.algorithm patience

I have several comments below, none of which are bugs, just
suggestions.

I was thinking you could use a single work queue for all rbd
devices, but I'm not sure that's very important.  You'd have
to stash the rbd_dev pointer in every request somewhere.

Reviewed-by: Alex Elder <elder@linaro.org>


> Cc: stable@vger.kernel.org # 3.15+
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |  195 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 118 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e3412317d3f9..e07d9d71b187 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -42,6 +42,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> +#include <linux/workqueue.h>
>  
>  #include "rbd_types.h"
>  
> @@ -332,7 +333,10 @@ struct rbd_device {
>  
>  	char			name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
>  
> +	struct list_head	rq_queue;	/* incoming rq queue */
>  	spinlock_t		lock;		/* queue, flags, open_count */
> +	struct workqueue_struct	*rq_wq;
> +	struct work_struct	rq_work;
>  
>  	struct rbd_image_header	header;
>  	unsigned long		flags;		/* possibly lock protected */
> @@ -3176,102 +3180,129 @@ out:
>  	return ret;
>  }
>  
> -static void rbd_request_fn(struct request_queue *q)
> -		__releases(q->queue_lock) __acquires(q->queue_lock)
> +static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
>  {

. . .

> +	if (offset + length > rbd_dev->mapping.size) {
> +		rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
> +			 length, rbd_dev->mapping.size);
> +		result = -EIO;
> +		goto err_rq;
> +	}
>  
> -		spin_unlock_irq(q->queue_lock);
> +	img_request = rbd_img_request_create(rbd_dev, offset, length, wr);

This isn't new with your patch, but perhaps we should consider
having rbd_img_request_create() use GFP_KERNEL or at least GFP_NOIO
rather than GFP_ATOMIC.  In general, I think a pass ought to be
made through all the allocation calls to make sure they have the
right flags.  Some may be too restrictive, some maybe not enough.

Anyway, a task for another day...

> +	if (!img_request) {
> +		result = -ENOMEM;
> +		goto err_rq;
> +	}
> +	img_request->rq = rq;

 . . .

> +/*
> + * Called with q->queue_lock held and interrupts disabled, possibly on
> + * the way to schedule().  Do not sleep here!
> + */
> +static void rbd_request_fn(struct request_queue *q)
> +{
> +	struct rbd_device *rbd_dev = q->queuedata;
> +	struct request *rq;
> +	int queued = 0;
> +
> +	rbd_assert(rbd_dev);
> +
> +	while ((rq = blk_fetch_request(q))) {
> +		/* Ignore any non-FS requests that filter through. */
> +		if (rq->cmd_type != REQ_TYPE_FS) {
> +			dout("%s: non-fs request type %d\n", __func__,
> +				(int) rq->cmd_type);
> +			__blk_end_request_all(rq, 0);
> +			continue;
>  		}
> +
> +		list_add_tail(&rq->queuelist, &rbd_dev->rq_queue);
> +		queued++;
		if (!queued)
			queued++;
Or alternately, make queued be a Boolean.  My point is
to guarantee there is no wrap (which is nearly but not quite
impossible).

>  	}
> +
> +	if (queued)
> +		queue_work(rbd_dev->rq_wq, &rbd_dev->rq_work);
>  }
>  
>  /*

. . .

> @@ -5067,6 +5105,8 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
>  
>  	return ret;
>  
> +err_out_workqueue:
> +	destroy_workqueue(rbd_dev->rq_wq);

	rbd_dev->rq_wq = NULL;

>  err_out_mapping:
>  	rbd_dev_mapping_clear(rbd_dev);
>  err_out_disk:
> @@ -5313,6 +5353,7 @@ static void rbd_dev_device_release(struct device *dev)
>  {
>  	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
>  
> +	destroy_workqueue(rbd_dev->rq_wq);
>  	rbd_free_disk(rbd_dev);
>  	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
>  	rbd_dev_mapping_clear(rbd_dev);
> 

