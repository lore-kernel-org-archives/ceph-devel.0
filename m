From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 15/47] block-rbd: Rename jump labels in rbd_dev_create()
Date: Tue, 13 Sep 2016 10:07:42 +0200
Message-ID: <CAOi1vP-1ULnxmyrRkTq2Dm1LXvBmczq9f0F1cPE0bUGwK4XF1Q@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net> <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
 <475899b2-a0fc-7bd9-43fe-c83c390158ff@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <475899b2-a0fc-7bd9-43fe-c83c390158ff@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Mon, Sep 12, 2016 at 9:00 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 12 Sep 2016 18:12:39 +0200
>
> Adjust jump labels according to the current Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/rbd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6acddc53..262805a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4930,23 +4930,22 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>                                          minor_to_rbd_dev_id(1 << MINORBITS),
>                                          GFP_KERNEL);
>         if (rbd_dev->dev_id < 0)
> -               goto fail_rbd_dev;
> +               goto free_device;
>
>         sprintf(rbd_dev->name, RBD_DRV_NAME "%d", rbd_dev->dev_id);
>         rbd_dev->task_wq = alloc_ordered_workqueue("%s-tasks", WQ_MEM_RECLAIM,
>                                                    rbd_dev->name);
>         if (!rbd_dev->task_wq)
> -               goto fail_dev_id;
> +               goto remove_id;
>
>         /* we have a ref from do_rbd_add() */
>         __module_get(THIS_MODULE);
>
>         dout("%s rbd_dev %p dev_id %d\n", __func__, rbd_dev, rbd_dev->dev_id);
>         return rbd_dev;
> -
> -fail_dev_id:
> + remove_id:
>         ida_simple_remove(&rbd_dev_id_ida, rbd_dev->dev_id);
> -fail_rbd_dev:
> + free_device:
>         rbd_dev_free(rbd_dev);
>         return NULL;
>  }
> --
> 2.10.0
>

Really?  I mean out_err -> free_device I can understand, but this?

Thanks,

                Ilya
