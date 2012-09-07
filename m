From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 7/7] rbd: simplify rbd_init_disk() a bit
Date: Fri, 07 Sep 2012 13:32:55 -0700
Message-ID: <504A59F7.5010300@inktank.com>
References: <5049F951.2030706@inktank.com> <5049FAB9.30607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37255 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab2IGUc6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 16:32:58 -0400
Received: by dady13 with SMTP id y13so2013994dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 13:32:57 -0700 (PDT)
In-Reply-To: <5049FAB9.30607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 06:46 AM, Alex Elder wrote:
> This just simplifies a few things in rbd_init_disk(), now that the
> previous patch has moved a bunch of initialization code out if it.
> Done separately to facilitate review.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6e735a7..634a16c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1870,14 +1870,12 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   {
>   	struct gendisk *disk;
>   	struct request_queue *q;
> -	int rc;
>   	u64 segment_size;
>
>   	/* create gendisk info */
> -	rc = -ENOMEM;
>   	disk = alloc_disk(RBD_MINORS_PER_MAJOR);
>   	if (!disk)
> -		goto out;
> +		return -ENOMEM;
>
>   	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
>   		 rbd_dev->dev_id);
> @@ -1887,7 +1885,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	disk->private_data = rbd_dev;
>
>   	/* init rq */
> -	rc = -ENOMEM;
>   	q = blk_init_queue(rbd_rq_fn, &rbd_dev->lock);
>   	if (!q)
>   		goto out_disk;
> @@ -1910,11 +1907,10 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	rbd_dev->disk = disk;
>
>   	return 0;
> -
>   out_disk:
>   	put_disk(disk);
> -out:
> -	return rc;
> +
> +	return -ENOMEM;
>   }
>
>   /*
>

