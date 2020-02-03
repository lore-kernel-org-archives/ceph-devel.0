From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 02/15] rbd: use READ_ONCE() when checking the mapping size
Date: Mon, 3 Feb 2020 17:50:03 +0100
Message-ID: <CAOi1vP--6qWHtifpeBVWRYOP8J_CC+fvKOkG7Xdsjoxaa7mrDQ@mail.gmail.com>
References: <20200131103739.136098-1-hare@suse.de> <20200131103739.136098-3-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200131103739.136098-3-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jan 31, 2020 at 11:38 AM Hannes Reinecke <hare@suse.de> wrote:
>
> The mapping size is changed only very infrequently, so we don't
> need to take the header mutex for checking; using READ_ONCE()
> is sufficient here. And it avoids having to take a mutex in the
> hot path.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/block/rbd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index db80b964d8ea..792180548e89 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4788,13 +4788,13 @@ static void rbd_queue_workfn(struct work_struct *work)
>
>         blk_mq_start_request(rq);
>
> -       down_read(&rbd_dev->header_rwsem);
> -       mapping_size = rbd_dev->mapping.size;
> +       mapping_size = READ_ONCE(rbd_dev->mapping.size);
>         if (op_type != OBJ_OP_READ) {
> +               down_read(&rbd_dev->header_rwsem);
>                 snapc = rbd_dev->header.snapc;
>                 ceph_get_snap_context(snapc);
> +               up_read(&rbd_dev->header_rwsem);
>         }
> -       up_read(&rbd_dev->header_rwsem);
>
>         if (offset + length > mapping_size) {
>                 rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
> @@ -4981,9 +4981,9 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>         u64 mapping_size;
>         int ret;
>
> -       down_write(&rbd_dev->header_rwsem);
> -       mapping_size = rbd_dev->mapping.size;
> +       mapping_size = READ_ONCE(rbd_dev->mapping.size);
>
> +       down_write(&rbd_dev->header_rwsem);
>         ret = rbd_dev_header_info(rbd_dev);
>         if (ret)
>                 goto out;
> @@ -4999,7 +4999,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>         }
>
>         rbd_assert(!rbd_is_snap(rbd_dev));
> -       rbd_dev->mapping.size = rbd_dev->header.image_size;
> +       WRITE_ONCE(rbd_dev->mapping.size, rbd_dev->header.image_size);
>
>  out:
>         up_write(&rbd_dev->header_rwsem);

Does this result in a measurable performance improvement?

I'd rather not go down the READ/WRITE_ONCE path and continue using
proper locking, especially given that it's only for reads.  FWIW the
plan is to replace header_rwsem with a spin lock, after refactoring
header read-in code to use a private buffer instead of reading into
rbd_dev directly.

Thanks,

                Ilya
