From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: add ioctl for rbd
Date: Mon, 16 Sep 2013 20:57:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309162050450.16397@cobra.newdream.net>
References: <1379310153-8799-1-git-send-email-guangliang@unitedstack.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43341 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3IQD56 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Sep 2013 23:57:58 -0400
In-Reply-To: <1379310153-8799-1-git-send-email-guangliang@unitedstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <guangliang@unitedstack.com>
Cc: ceph-devel@vger.kernel.org, josh.durgin@inktank.com, alex.elder@linaro.org, lucienchao@gmail.com

On Mon, 16 Sep 2013, Guangliang Zhao wrote:
> When running the following commands:
>     [root@ceph0 mnt]# blockdev --setro /dev/rbd2
>     [root@ceph0 mnt]# blockdev --getro /dev/rbd2
>     0
> 
> The block setro didn't take effect, it is because
> the rbd doesn't support ioctl of block driver.
> 
> This resolves:
> 	http://tracker.ceph.com/issues/6265
> 
> Signed-off-by: Guangliang Zhao <guangliang@unitedstack.com>
> ---
>  drivers/block/rbd.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2f00778..9f2057a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -508,10 +508,64 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
>  	put_device(&rbd_dev->dev);
>  }
>  
> +static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
> +			unsigned int cmd, unsigned long arg)
> +{
> +	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
> +	int ro, ret = 0;
> +
> +	BUG_ON(!rbd_dev);
> +	spin_lock_irq(&rbd_dev->lock);
> +	if (rbd_dev->open_count > 1) {
> +		spin_unlock_irq(&rbd_dev->lock);
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	spin_unlock_irq(&rbd_dev->lock);
> +
> +	switch (cmd) {
> +	case BLKROSET:
> +		if (get_user(ro, (int __user *)(arg))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		/* Snapshot doesn't allow to write*/
> +		if (rbd_dev->spec->snap_id != CEPH_NOSNAP && ro) {
> +			ret = -EROFS;
> +			goto out;
> +		}
> +
> +		if (rbd_dev->mapping.read_only != ro) {
> +			rbd_dev->mapping.read_only = ro;
> +			goto out;
> +		}

I'm not too familiar with this code, but I did a quick grep for ROSET and 
it looks like md.c and dasd_ioctl.c both use the set_disk_ro() helper.  
Should we call that in addition to setting our own read_only flag?

Also, do you mind making a simple test for this?  A bash script that does 
rbd map, sets the disk as ro, and verifies it can't write to it via dd, or 
something along those lines.  It should go into ceph.git/qa/workunits/rbd/ 
somewhere.

Thanks!
sage


> +
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static int rbd_compat_ioctl(struct block_device *bdev, fmode_t mode,
> +				unsigned int cmd, unsigned long arg)
> +{
> +	return rbd_ioctl(bdev, mode, cmd, arg);
> +}
> +#endif /* CONFIG_COMPAT */
> +
>  static const struct block_device_operations rbd_bd_ops = {
>  	.owner			= THIS_MODULE,
>  	.open			= rbd_open,
>  	.release		= rbd_release,
> +	.ioctl			= rbd_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl		= rbd_compat_ioctl,
> +#endif
>  };
>  
>  /*
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
