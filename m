From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH v2] rbd: convert to blk-mq
Date: Mon, 12 Jan 2015 20:10:48 +0300
Message-ID: <CALFYKtBUONtvGDJtM92bna9utkvnpTHxbL--5P+N3oirgqU7Bg@mail.gmail.com>
References: <1420914688-27563-1-git-send-email-hch@lst.de>
	<54B1B864.4080008@ieee.org>
	<20150112124002.GA29490@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:39228 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbbALRKt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 12:10:49 -0500
Received: by mail-qg0-f52.google.com with SMTP id i50so18525908qgf.11
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jan 2015 09:10:48 -0800 (PST)
In-Reply-To: <20150112124002.GA29490@lst.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alex Elder <elder@ieee.org>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 12, 2015 at 3:40 PM, Christoph Hellwig <hch@lst.de> wrote:
> This converts the rbd driver to use the blk-mq infrastructure.  Except
> for switching to a per-request work item this is almost mechanical.

Hi Christoph,

I too am not up to speed on blk-mq but still have a couple sanity
questions/comments below.

>
> This was tested by Alexandre DERUMIER in November, and found to give
> him 120000 iops, although the only comparism available was an old
> 3.10 kernel which gave 80000iops.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/block/rbd.c | 120 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 67 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3ec85df..c64a798 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -38,6 +38,7 @@
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/blk-mq.h>
>  #include <linux/fs.h>
>  #include <linux/blkdev.h>
>  #include <linux/slab.h>
> @@ -340,9 +341,7 @@ struct rbd_device {
>
>         char                    name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
>
> -       struct list_head        rq_queue;       /* incoming rq queue */
>         spinlock_t              lock;           /* queue, flags, open_count */
> -       struct work_struct      rq_work;
>
>         struct rbd_image_header header;
>         unsigned long           flags;          /* possibly lock protected */
> @@ -360,6 +359,9 @@ struct rbd_device {
>         atomic_t                parent_ref;
>         struct rbd_device       *parent;
>
> +       /* Block layer tags. */
> +       struct blk_mq_tag_set   tag_set;
> +
>         /* protects updating the header */
>         struct rw_semaphore     header_rwsem;
>
> @@ -1817,7 +1819,8 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>
>         /*
>          * We support a 64-bit length, but ultimately it has to be
> -        * passed to blk_end_request(), which takes an unsigned int.
> +        * passed to the block layer, which just supports a 32-bit
> +        * length field.
>          */
>         obj_request->xferred = osd_req->r_reply_op_len[0];
>         rbd_assert(obj_request->xferred < (u64)UINT_MAX);
> @@ -2281,7 +2284,10 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
>                 more = obj_request->which < img_request->obj_request_count - 1;
>         } else {
>                 rbd_assert(img_request->rq != NULL);
> -               more = blk_end_request(img_request->rq, result, xferred);
> +
> +               more = blk_update_request(img_request->rq, result, xferred);
> +               if (!more)
> +                       __blk_mq_end_request(img_request->rq, result);
>         }
>
>         return more;
> @@ -3310,8 +3316,10 @@ out:
>         return ret;
>  }
>
> -static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
> +static void rbd_queue_workfn(struct work_struct *work)
>  {
> +       struct request *rq = blk_mq_rq_from_pdu(work);
> +       struct rbd_device *rbd_dev = rq->q->queuedata;
>         struct rbd_img_request *img_request;
>         struct ceph_snap_context *snapc = NULL;
>         u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
> @@ -3320,6 +3328,13 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
>         u64 mapping_size;
>         int result;
>
> +       if (rq->cmd_type != REQ_TYPE_FS) {
> +               dout("%s: non-fs request type %d\n", __func__,
> +                       (int) rq->cmd_type);
> +               result = -EIO;
> +               goto err;
> +       }

So in !REQ_TYPE_FS case we would error out with blk_mq_end_request(),
while other (probably silly, but still) checks error out to err_rq
label.  Any particular reason for this?


> +
>         if (rq->cmd_flags & REQ_DISCARD)
>                 op_type = OBJ_OP_DISCARD;
>         else if (rq->cmd_flags & REQ_WRITE)
> @@ -3358,6 +3373,8 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
>                 goto err_rq;
>         }
>
> +       blk_mq_start_request(rq);

Why is this call here?  Why not above or below?  I doubt it makes much
difference, but from a clarity standpoint at least, shouldn't it be
placed after all the checks and allocations, say before the call to
rbd_img_request_submit()?

> +
>         if (offset && length > U64_MAX - offset + 1) {
>                 rbd_warn(rbd_dev, "bad request range (%llu~%llu)", offset,
>                          length);
> @@ -3411,52 +3428,18 @@ err_rq:
>                          obj_op_name(op_type), length, offset, result);
>         ceph_put_snap_context(snapc);
>         blk_end_request_all(rq, result);
> +err:
> +       blk_mq_end_request(rq, result);

Expanding on REQ_TYPE_FS comment, isn't blk_mq_end_request() enough?
Swap blk_end_request_all() for blk_mq_end_request() and get rid of err
label?

>  }
>
> -static void rbd_request_workfn(struct work_struct *work)
> +static int rbd_queue_rq(struct blk_mq_hw_ctx *hctx,
> +               const struct blk_mq_queue_data *bd)
>  {
> -       struct rbd_device *rbd_dev =
> -           container_of(work, struct rbd_device, rq_work);
> -       struct request *rq, *next;
> -       LIST_HEAD(requests);
> -
> -       spin_lock_irq(&rbd_dev->lock); /* rq->q->queue_lock */
> -       list_splice_init(&rbd_dev->rq_queue, &requests);
> -       spin_unlock_irq(&rbd_dev->lock);
> -
> -       list_for_each_entry_safe(rq, next, &requests, queuelist) {
> -               list_del_init(&rq->queuelist);
> -               rbd_handle_request(rbd_dev, rq);
> -       }
> -}
> -
> -/*
> - * Called with q->queue_lock held and interrupts disabled, possibly on
> - * the way to schedule().  Do not sleep here!
> - */
> -static void rbd_request_fn(struct request_queue *q)
> -{
> -       struct rbd_device *rbd_dev = q->queuedata;
> -       struct request *rq;
> -       int queued = 0;
> -
> -       rbd_assert(rbd_dev);
> -
> -       while ((rq = blk_fetch_request(q))) {
> -               /* Ignore any non-FS requests that filter through. */
> -               if (rq->cmd_type != REQ_TYPE_FS) {
> -                       dout("%s: non-fs request type %d\n", __func__,
> -                               (int) rq->cmd_type);
> -                       __blk_end_request_all(rq, 0);
> -                       continue;
> -               }
> -
> -               list_add_tail(&rq->queuelist, &rbd_dev->rq_queue);
> -               queued++;
> -       }
> +       struct request *rq = bd->rq;
> +       struct work_struct *work = blk_mq_rq_to_pdu(rq);
>
> -       if (queued)
> -               queue_work(rbd_wq, &rbd_dev->rq_work);
> +       queue_work(rbd_wq, work);

Finally, if we are switching to blk-mq, is there any way to avoid the
"re-queueing to internal rbd_wq" dance?  I introduced it to avoid
blocking in request_fn(), but I remember you mentioning that we should
be able to get rid of it with the switch to blk-mq.  Is "blk-mq: allow
direct dispatch to a driver specific workqueue" related to this?

Thanks,

                Ilya
