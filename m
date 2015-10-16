From: Alex Elder <elder@ieee.org>
Subject: Fwd: Re: [PATCH] rbd: set max_sectors explicitly
Date: Fri, 16 Oct 2015 07:27:46 -0500
Message-ID: <5620ED42.7080506@ieee.org>
References: <5620EC1F.6070607@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34200 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbbJPM1s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 08:27:48 -0400
Received: by iow1 with SMTP id 1so122642022iow.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Oct 2015 05:27:47 -0700 (PDT)
Received: from [172.22.22.87] (c-24-245-18-91.hsd1.mn.comcast.net. [24.245.18.91])
        by smtp.googlemail.com with ESMTPSA id g10sm1772182igy.22.2015.10.16.05.27.46
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2015 05:27:47 -0700 (PDT)
In-Reply-To: <5620EC1F.6070607@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Forgot to "Reply-all".	-Alex


-------- Forwarded Message --------
Subject: Re: [PATCH] rbd: set max_sectors explicitly
Date: Fri, 16 Oct 2015 07:22:55 -0500
From: Alex Elder <elder@ieee.org>
To: Ilya Dryomov <idryomov@gmail.com>

On 10/07/2015 12:00 PM, Ilya Dryomov wrote:
> Commit 30e2bc08b2bb ("Revert "block: remove artifical max_hw_sectors
> cap"") restored a clamp on max_sectors.  It's now 2560 sectors instead
> of 1024, but it's not good enough: we set max_hw_sectors to rbd object
> size because we don't want object sized I/Os to be split, and the
> default object size is 4M.
> 
> So, set max_sectors to max_hw_sectors in rbd at queue init time.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 05072464d25e..04e69b4df664 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3760,6 +3760,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>  	/* set io sizes to object size */
>  	segment_size = rbd_obj_bytes(&rbd_dev->header);
>  	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
> +	q->limits.max_sectors = queue_max_hw_sectors(q);

This currently is done by default by blk_queue_max_hw_sectors().
Do you see any different behavior with this patch in place?

This change seems at least harmless so if it's not too late:

Reviewed-by: Alex Elder <elder@linaro.org>

>  	blk_queue_max_segments(q, segment_size / SECTOR_SIZE);
>  	blk_queue_max_segment_size(q, segment_size);
>  	blk_queue_io_min(q, segment_size);
> 



