From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/9] rbd: do not allow remove of mounted-on image
Date: Fri, 14 Dec 2012 17:19:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212141719190.14354@cobra.newdream.net>
References: <50CA0915.1090801@inktank.com> <50CA09D4.9070902@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40447 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab2LOBTZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 20:19:25 -0500
In-Reply-To: <50CA09D4.9070902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Thu, 13 Dec 2012, Alex Elder wrote:

> There is no check in rbd_remove() to see if anybody holds open the
> image being removed.  That's not cool.
> 
> Add a simple open count that goes up and down with opens and closes
> (releases) of the device, and don't allow an rbd image to be removed
> if the count is non-zero.
> 
> Protect the updates of the open count value with ctl_mutex to ensure
> the underlying rbd device doesn't get removed while concurrently
> being opened.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 842caf4..c7bf961 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -235,6 +235,7 @@ struct rbd_device {
> 
>  	/* sysfs related */
>  	struct device		dev;
> +	unsigned long		open_count;
>  };
> 
>  static DEFINE_MUTEX(ctl_mutex);	  /* Serialize open/close/setup/teardown */
> @@ -309,8 +310,11 @@ static int rbd_open(struct block_device *bdev,
> fmode_t mode)
>  	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
>  		return -EROFS;
> 
> +	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>  	rbd_get_dev(rbd_dev);
>  	set_device_ro(bdev, rbd_dev->mapping.read_only);
> +	rbd_dev->open_count++;
> +	mutex_unlock(&ctl_mutex);
> 
>  	return 0;
>  }
> @@ -319,7 +323,11 @@ static int rbd_release(struct gendisk *disk,
> fmode_t mode)
>  {
>  	struct rbd_device *rbd_dev = disk->private_data;
> 
> +	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> +	rbd_assert(rbd_dev->open_count > 0);
> +	rbd_dev->open_count--;
>  	rbd_put_dev(rbd_dev);
> +	mutex_unlock(&ctl_mutex);
> 
>  	return 0;
>  }
> @@ -3745,6 +3753,11 @@ static ssize_t rbd_remove(struct bus_type *bus,
>  		goto done;
>  	}
> 
> +	if (rbd_dev->open_count) {
> +		ret = -EBUSY;
> +		goto done;
> +	}
> +
>  	rbd_remove_all_snaps(rbd_dev);
>  	rbd_bus_del_dev(rbd_dev);
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
