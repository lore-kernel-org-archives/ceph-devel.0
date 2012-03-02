From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] rbd: don't drop the rbd_id too early
Date: Fri, 2 Mar 2012 13:33:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021333230.6413@cobra.newdream.net>
References: <4F4DACCB.8000404@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35677 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab2CBVdb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:33:31 -0500
In-Reply-To: <4F4DACCB.8000404@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Yay!

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> Currently an rbd device's id is released when it is removed, but it
> is done before the code is run to clean up sysfs-related files (such
> as /sys/bus/rbd/devices/1).
> 
> It's possible that an rbd is still in use after the rbd_remove()
> call has been made.  It's essentially the same as an active inode
> that stays around after it has been removed--until its final close
> operation.  This means that the id shows up as free for reuse at a
> time it should not be.
> 
> The effect of this was seen by Jens Rehpoehler, who:
>     - had a filesystem mounted on an rbd device
>     - unmapped that filesystem (without unmounting)
>     - found that the mount still worked properly
>     - but hit a panic when he attempted to re-map a new rbd device
> 
> This re-map attempt found the previously-unmapped id available.
> The subsequent attempt to reuse it was met with a panic while
> attempting to (re-)install the sysfs entry for the new mapped
> device.
> 
> Fix this by holding off "putting" the rbd id, until the rbd_device
> release function is called--when the last reference is finally
> dropped.
> 
> Note: This fixes: http://tracker.newdream.net/issues/1907
> 
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
>  drivers/block/rbd.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index da38804..7cae4a3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2440,7 +2440,12 @@ static ssize_t rbd_add(struct bus_type *bus,
>  	if (rc)
>  		goto err_out_blkdev;
> 
> -	/* set up and announce blkdev mapping */
> +	/*
> +	 * At this point cleanup in the event of an error is the job
> +	 * of the sysfs code (initiated by rbd_bus_del_dev()).
> +	 *
> +	 * Set up and announce blkdev mapping.
> +	 */
>  	rc = rbd_init_disk(rbd_dev);
>  	if (rc)
>  		goto err_out_bus;
> @@ -2452,8 +2457,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>  	return count;
> 
>  err_out_bus:
> -	rbd_id_put(rbd_dev);
> -
>  	/* this will also clean up rest of rbd_dev stuff */
> 
>  	rbd_bus_del_dev(rbd_dev);
> @@ -2511,6 +2514,9 @@ static void rbd_dev_release(struct device *dev)
>  	/* clean up and free blkdev */
>  	rbd_free_disk(rbd_dev);
>  	unregister_blkdev(rbd_dev->major, rbd_dev->name);
> +
> +	/* done with the id, and with the rbd_dev */
> +	rbd_id_put(rbd_dev);
>  	kfree(rbd_dev);
> 
>  	/* release module ref */
> @@ -2543,8 +2549,6 @@ static ssize_t rbd_remove(struct bus_type *bus,
>  		goto done;
>  	}
> 
> -	rbd_id_put(rbd_dev);
> -
>  	__rbd_remove_all_snaps(rbd_dev);
>  	rbd_bus_del_dev(rbd_dev);
> 
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
