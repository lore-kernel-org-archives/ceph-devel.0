From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: set max_segments to USHRT_MAX
Date: Mon, 8 Jan 2018 17:35:50 -0600
Message-ID: <adc1a943-2532-d878-6706-cddb4adebc1f@ieee.org>
References: <1515437475-25789-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34059 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756802AbeAHXfw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 18:35:52 -0500
Received: by mail-io0-f194.google.com with SMTP id q188so16529748iod.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jan 2018 15:35:52 -0800 (PST)
In-Reply-To: <1515437475-25789-1-git-send-email-idryomov@gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 01/08/2018 12:51 PM, Ilya Dryomov wrote:
> Commit d3834fefcfe5 ("rbd: bump queue_max_segments") bumped
> max_segments (unsigned short) to max_hw_sectors (unsigned int).
> max_hw_sectors is set to the number of 512-byte sectors in an object
> and overflows unsigned short for 32M (largest possible) objects, making
> the block layer resort to handing us single segment (i.e. single page
> or even smaller) bios in that case.
> 
> Cc: stable@vger.kernel.org
> Fixes: d3834fefcfe5 ("rbd: bump queue_max_segments")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Is it OK for max_segments to be bigger than max_hw_sectors?

I didn't investigate but the question occurred to me, since you're
fixing max_segments regardless of segment size, but not doing that
to the other limits being set.

If that is not a problem:
Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f40050c97bb3..0bda823a90ca 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4381,7 +4381,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>  	segment_size = rbd_obj_bytes(&rbd_dev->header);
>  	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
>  	q->limits.max_sectors = queue_max_hw_sectors(q);
> -	blk_queue_max_segments(q, segment_size / SECTOR_SIZE);
> +	blk_queue_max_segments(q, USHRT_MAX);
>  	blk_queue_max_segment_size(q, segment_size);
>  	blk_queue_io_min(q, segment_size);
>  	blk_queue_io_opt(q, segment_size);
> 

