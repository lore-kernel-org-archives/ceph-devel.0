From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: add timeout function to rbd driver
Date: Thu, 27 Jul 2017 13:32:02 +0200
Message-ID: <CAOi1vP_pHS=B4Pyni4ipjY5YmAvb9=_S0+5MMvb5n1P03Jh5ug@mail.gmail.com>
References: <20170727103257.11608-1-xiongwei.jiang@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727103257.11608-1-xiongwei.jiang@alibaba-inc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xiongweijiang666@gmail.com
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, chenggang.qcg@alibaba-inc.com, xiongwei.jiang@alibaba-inc.com
List-Id: ceph-devel.vger.kernel.org

On Thu, Jul 27, 2017 at 12:32 PM,  <xiongweijiang666@gmail.com> wrote:
> From: Xiongwei Jiang <xiongwei.jiang@alibaba-inc.com>
>
> when an application is writing or reading on rbd device, if some or all
> OSDs crash, the application will hang and can't be killed because it is
> in D state. Even though OSDs comes up later, the application may still
> keeps in D state. So we need a timeout mechanism to solve this problem.

Hi Xiongwei,

This shouldn't happen -- when the OSDs come back up, all requests
should be properly resent and completed.  If you have a scenario where
the OSDs come back up into HEALTH_OK and this doesn't happen, that's
likely a bug.

>
> Signed-off-by: Xiongwei Jiang <xiongwei.jiang@alibaba-inc.com>
> ---
>  drivers/block/rbd.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index c16f745..33a1c97 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -159,6 +159,13 @@ struct rbd_image_header {
>         u64 *snap_sizes;        /* format 1 only */
>  };
>
> +
> +struct rbd_request_linker {
> +       struct work_struct work;
> +       void *img_request;
> +};
> +
> +
>  /*
>   * An rbd image specification.
>   *
> @@ -4013,6 +4020,7 @@ static void rbd_queue_workfn(struct work_struct *work)
>         struct request *rq = blk_mq_rq_from_pdu(work);
>         struct rbd_device *rbd_dev = rq->q->queuedata;
>         struct rbd_img_request *img_request;
> +       struct rbd_request_linker *linker;
>         struct ceph_snap_context *snapc = NULL;
>         u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
>         u64 length = blk_rq_bytes(rq);
> @@ -4120,6 +4128,7 @@ static void rbd_queue_workfn(struct work_struct *work)
>                 goto err_unlock;
>         }
>         img_request->rq = rq;
> +       linker->img_request = img_request;
>         snapc = NULL; /* img_request consumes a ref */
>
>         if (op_type == OBJ_OP_DISCARD)
> @@ -4358,9 +4367,32 @@ static int rbd_init_request(struct blk_mq_tag_set *set, struct request *rq,
>         return 0;
>  }
>
> +static enum blk_eh_timer_return rbd_request_timeout(struct request *rq,
> +               bool reserved)
> +{
> +       struct rbd_obj_request *obj_request;
> +       struct rbd_obj_request *next_obj_request;
> +       struct rbd_img_request *img_request;
> +       struct rbd_request_linker *linker = blk_mq_rq_to_pdu(rq);
> +
> +       img_request = (struct rbd_img_request *)linker->img_request;
> +       for_each_obj_request_safe(img_request, obj_request, next_obj_request) {
> +               struct ceph_osd_request *osd_req = obj_request->osd_req;
> +
> +               if (!osd_req)
> +                       printk(KERN_INFO "osd_req is null \n");
> +               else
> +                       ceph_osdc_cancel_request(osd_req);
> +       }
> +       return BLK_EH_HANDLED;
> +}
> +
> +
> +
>  static const struct blk_mq_ops rbd_mq_ops = {
>         .queue_rq       = rbd_queue_rq,
>         .init_request   = rbd_init_request,
> +       .timeout       = rbd_request_timeout,

The default blk-mq timeout is 30 seconds.  This means that any "slow"
request (osd_op_complaint_time ceph.conf option) will be timed out,
forcing the mounted filesystem into read-only mode at best.

>  };
>
>  static int rbd_init_disk(struct rbd_device *rbd_dev)
> @@ -4392,7 +4424,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>         rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
>         rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
>         rbd_dev->tag_set.nr_hw_queues = 1;
> -       rbd_dev->tag_set.cmd_size = sizeof(struct work_struct);
> +       rbd_dev->tag_set.cmd_size = sizeof(struct rbd_request_linker);
>
>         err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
>         if (err)

We already have such a timeout at libceph level -- osd_request_timeout
(similar to rados_osd_op_timeout ceph.conf option).  Note that just as
rados_osd_op_timeout in userspace, osd_request_timeout is disabled by
default and is NOT recommended for use with librbd/krbd.

Thanks,

                Ilya
