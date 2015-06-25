From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: bump queue_max_segments
Date: Thu, 25 Jun 2015 09:36:44 -0500
Message-ID: <558C11FC.6040807@ieee.org>
References: <1435222868-34966-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36725 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbFYOgr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 10:36:47 -0400
Received: by pdcu2 with SMTP id u2so54757866pdc.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 07:36:47 -0700 (PDT)
In-Reply-To: <1435222868-34966-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 06/25/2015 04:01 AM, Ilya Dryomov wrote:
> The default queue_limits::max_segments value (BLK_MAX_SEGMENTS = 128)
> unnecessarily limits bio sizes to 512k (assuming 4k pages).  rbd, being
> a virtual block device, doesn't have any restrictions on the number of
> physical segments, so bump max_segments to max_hw_sectors, in theory
> allowing a sector per segment (although the only case this matters that
> I can think of is some readv/writev style thing).  In practice this is
> going to give us 1M bios - the number of segments in a bio is limited
> in bio_get_nr_vecs() by BIO_MAX_PAGES = 256.
>
> Note that this doesn't result in any improvement on a typical direct
> sequential test.  This is because on a box with a not too badly
> fragmented memory the default BLK_MAX_SEGMENTS is enough to see nice
> rbd object size sized requests.  The only difference is the size of
> bios being merged - 512k vs 1M for something like
>
>      $ dd if=/dev/zero of=/dev/rbd0 oflag=direct bs=$RBD_OBJ_SIZE
>      $ dd if=/dev/rbd0 iflag=direct of=/dev/null bs=$RBD_OBJ_SIZE
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

This looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/block/rbd.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 89fe8a4bc02e..bc88fbcb9715 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3791,6 +3791,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	/* set io sizes to object size */
>   	segment_size = rbd_obj_bytes(&rbd_dev->header);
>   	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
> +	blk_queue_max_segments(q, segment_size / SECTOR_SIZE);
>   	blk_queue_max_segment_size(q, segment_size);
>   	blk_queue_io_min(q, segment_size);
>   	blk_queue_io_opt(q, segment_size);
>

