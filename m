From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 1/2] rbd: move calls that may sleep out of spin lock range
Date: Tue, 01 Oct 2013 16:17:25 -0500
Message-ID: <524B3BE5.5080406@linaro.org>
References: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com> <1380604559-5331-2-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49127 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab3JAVRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Oct 2013 17:17:12 -0400
Received: by mail-ie0-f173.google.com with SMTP id ar20so15087264iec.4
        for <ceph-devel@vger.kernel.org>; Tue, 01 Oct 2013 14:17:11 -0700 (PDT)
In-Reply-To: <1380604559-5331-2-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 10/01/2013 12:15 AM, Josh Durgin wrote:
> get_user() and set_disk_ro() may allocate memory, leading to a
> potential deadlock if theye are called while a spin lock is held.
> 
> Move the acquisition and release of rbd_dev->lock from rbd_ioctl()
> into rbd_ioctl_set_ro(), so it can occur between get_user() and
> set_disk_ro().

This fix looks good.  I have a couple small comments to consider.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |   36 +++++++++++++++++++++++-------------
>  1 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 34bcdb7..b3b1b57 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -510,23 +510,42 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
>  
>  static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
>  {
> +	int ret = 0;
>  	int val;
>  	bool ro;
> +	bool ro_changed = false;
>  
> +	/* get_user() may sleep, so call it before taking rbd_dev->lock */
>  	if (get_user(val, (int __user *)(arg)))
>  		return -EFAULT;
>  
> +	spin_lock_irq(&rbd_dev->lock);
> +	/* prevent others open this device */
> +	if (rbd_dev->open_count > 1) {
> +		ret = -EBUSY;
> +		goto out;
> +	}

I like to do as little as possible inside spinlock protection.

> +
>  	ro = val ? true : false;

This assignment can be made outside the lock.

>  	/* Snapshot doesn't allow to write*/
> -	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !ro)
> -		return -EROFS;
> +	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !ro) {
> +		ret = -EROFS;
> +		goto out;
> +	}

This check can be too.

>  
>  	if (rbd_dev->mapping.read_only != ro) {
>  		rbd_dev->mapping.read_only = ro;
> -		set_disk_ro(rbd_dev->disk, ro ? 1 : 0);
> +		ro_changed = true;
>  	}
>  
> -	return 0;
> +out:
> +	spin_unlock_irq(&rbd_dev->lock);
> +	/* set_disk_ro() may sleep, so call it after releasing rbd_dev->lock */
> +	if (ret == 0 && ro_changed)
> +		set_disk_ro(rbd_dev->disk, ro ? 1 : 0);
> +

I like white space a lot, but this is one too many.

> +
> +	return ret;
>  }
>  
>  static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
> @@ -535,13 +554,6 @@ static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
>  	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
>  	int ret = 0;
>  
> -	spin_lock_irq(&rbd_dev->lock);
> -	/* prevent others open this device */
> -	if (rbd_dev->open_count > 1) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> -
>  	switch (cmd) {
>  	case BLKROSET:
>  		ret = rbd_ioctl_set_ro(rbd_dev, arg);
> @@ -550,8 +562,6 @@ static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
>  		ret = -ENOTTY;
>  	}
>  
> -out:
> -	spin_unlock_irq(&rbd_dev->lock);
>  	return ret;
>  }
>  
> 

