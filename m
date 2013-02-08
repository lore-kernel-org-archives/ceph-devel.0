From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: turn off interrupts for open/remove locking
Date: Fri, 08 Feb 2013 13:40:39 -0800
Message-ID: <511570D7.7020707@inktank.com>
References: <51117109.6000504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:51241 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760318Ab3BHVlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 16:41:06 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1991793dak.34
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 13:41:05 -0800 (PST)
In-Reply-To: <51117109.6000504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/05/2013 12:52 PM, Alex Elder wrote:
> This commit:
>      bc7a62ee5 rbd: prevent open for image being removed
> added checking for removing rbd before allowing an open, and used
> the same request spinlock for protecting that and updating the open
> count as is used for the request queue.
>
> However it used the non-irq protected version of the spinlocks.
> Fix that.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 14a6967..91983a60 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -394,12 +394,12 @@ static int rbd_open(struct block_device *bdev,
> fmode_t mode)
>   	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
>   		return -EROFS;
>
> -	spin_lock(&rbd_dev->lock);
> +	spin_lock_irq(&rbd_dev->lock);
>   	if (test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags))
>   		removing = true;
>   	else
>   		rbd_dev->open_count++;
> -	spin_unlock(&rbd_dev->lock);
> +	spin_unlock_irq(&rbd_dev->lock);
>   	if (removing)
>   		return -ENOENT;
>
> @@ -416,9 +416,9 @@ static int rbd_release(struct gendisk *disk, fmode_t
> mode)
>   	struct rbd_device *rbd_dev = disk->private_data;
>   	unsigned long open_count_before;
>
> -	spin_lock(&rbd_dev->lock);
> +	spin_lock_irq(&rbd_dev->lock);
>   	open_count_before = rbd_dev->open_count--;
> -	spin_unlock(&rbd_dev->lock);
> +	spin_unlock_irq(&rbd_dev->lock);
>   	rbd_assert(open_count_before > 0);
>
>   	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> @@ -4099,12 +4099,12 @@ static ssize_t rbd_remove(struct bus_type *bus,
>   		goto done;
>   	}
>
> -	spin_lock(&rbd_dev->lock);
> +	spin_lock_irq(&rbd_dev->lock);
>   	if (rbd_dev->open_count)
>   		ret = -EBUSY;
>   	else
>   		set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
> -	spin_unlock(&rbd_dev->lock);
> +	spin_unlock_irq(&rbd_dev->lock);
>   	if (ret < 0)
>   		goto done;
>

