From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: set the 'device' link in sysfs
Date: Thu, 23 Jan 2020 19:45:32 +0100
Message-ID: <CAOi1vP8Q44jLNoq+LTm8GRX687wfwLkJ3WRW_DWvY7nYUtPQxQ@mail.gmail.com>
References: <20200123124433.121939-1-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200123124433.121939-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Sage Weil <sage@redhat.com>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, David Disseldorp <ddiss@suse.com>, Hannes Reinecke <hare@suse.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, Jan 23, 2020 at 1:44 PM Hannes Reinecke <hare@suse.de> wrote:
>
> The rbd driver already provides additional information in sysfs
> under /sys/bus/rbd, so we should set the 'device' link in the block
> device to reference this information.
>
> Cc: David Disseldorp <ddiss@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9f1f8689e316..3240b7744aeb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6938,7 +6938,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>         if (rc)
>                 goto err_out_image_lock;
>
> -       add_disk(rbd_dev->disk);
> +       device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
>         /* see rbd_init_disk() */
>         blk_put_queue(rbd_dev->disk->queue);

Hi Hannes,

I looked at this a while ago and didn't go through with the patch
because I wasn't sure whether this symlink can point to something
arbitrary.  IIRC it usually points a couple of levels up, to some
parent.  In the rbd case, this would be a completely different tree:
/sys/devices/virtual -> /sys/bus/rbd.

Do you know if there is precedent for this in some other driver?
Are you sure it's not going to break any assumptions?

How did this came up?  I'm curious because rbd(8) is only utility
that I know of that (somewhat) cares.

Thanks,

                Ilya
