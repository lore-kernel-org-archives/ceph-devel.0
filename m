From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 10/11] rbd: check for overflow in rbd_get_num_segments()
Date: Thu, 30 Aug 2012 10:50:21 -0700
Message-ID: <CAC-hyiEOHuvxRQKM-CjXFyLpJV+vxPxf6TwW3-R3nHYDrbHtBw@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037AD7A.4080300@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64685 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab2H3RuW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 13:50:22 -0400
Received: by bkwj10 with SMTP id j10so935630bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 10:50:21 -0700 (PDT)
In-Reply-To: <5037AD7A.4080300@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Aug 24, 2012 at 9:36 AM, Alex Elder <elder@inktank.com> wrote:
> It is possible in rbd_get_num_segments() for an overflow to occur
> when adding the offset and length.  This is easily avoided.
>
> Since the function returns an int and the one caller is already
> prepared to handle errors, have it return -ERANGE if overflow would
> occur.
>
> The overflow check would not work if a zero-length request was
> being tested, so short-circuit that case, returning 0 for the
> number of segments required.  (This condition might be avoided
> elsewhere already, I don't know.)
>
> Have the caller end the request if either an error or 0 is returned.
> The returned value is passed to __blk_end_request_all(), meaning
> a 0 length request is not treated an error.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fad4ecb..b649446 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -50,6 +50,10 @@
>  #define        SECTOR_SHIFT    9
>  #define        SECTOR_SIZE     (1ULL << SECTOR_SHIFT)
>
> +/* It might be useful to have this defined elsewhere too */
> +
> +#define        U64_MAX ((u64) (~0ULL))

ULLONG_MAX defined in include/linux/kernel.h

> +
>  #define RBD_DRV_NAME "rbd"
>  #define RBD_DRV_NAME_LONG "rbd (rados block device)"
>
> @@ -678,8 +682,17 @@ static u64 rbd_get_segment(struct rbd_image_header
> *header,
>  static int rbd_get_num_segments(struct rbd_image_header *header,
>                                 u64 ofs, u64 len)
>  {
> -       u64 start_seg = ofs >> header->obj_order;
> -       u64 end_seg = (ofs + len - 1) >> header->obj_order;
> +       u64 start_seg;
> +       u64 end_seg;
> +
> +       if (!len)
> +               return 0;
> +       if (len - 1 > U64_MAX - ofs)
> +               return -ERANGE;
> +
> +       start_seg = ofs >> header->obj_order;
> +       end_seg = (ofs + len - 1) >> header->obj_order;
> +
>         return end_seg - start_seg + 1;
>  }
>
> @@ -1502,6 +1515,12 @@ static void rbd_rq_fn(struct request_queue *q)
>                      size, (unsigned long long) blk_rq_pos(rq) * SECTOR_SIZE);
>
>                 num_segs = rbd_get_num_segments(&rbd_dev->header, ofs, size);
> +               if (num_segs <= 0) {
> +                       spin_lock_irq(q->queue_lock);
> +                       __blk_end_request_all(rq, num_segs);
> +                       ceph_put_snap_context(snapc);
> +                       continue;
> +               }
>                 coll = rbd_alloc_coll(num_segs);
>                 if (!coll) {
>                         spin_lock_irq(q->queue_lock);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
