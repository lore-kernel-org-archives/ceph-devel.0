From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/4] rbd: expand lock protection in rbd_add()
Date: Mon, 10 Sep 2012 15:05:46 -0700
Message-ID: <504E643A.4050003@inktank.com>
References: <504A090F.7000706@inktank.com> <504A09AD.80905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50938 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2IJWFs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 18:05:48 -0400
Received: by pbbrr13 with SMTP id rr13so3110612pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 15:05:48 -0700 (PDT)
In-Reply-To: <504A09AD.80905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Looking closer, I don't think we need to protect this section at all.
The device isn't initialized yet, so nothing else can access the
rbd_dev->header. It'd be good to have a comment to that effect.

Josh

On 09/07/2012 07:50 AM, Alex Elder wrote:
> Expand the region of code in rbd_add() protected by the header
> semaphore to include the complete initialization sequence.  It may
> not be strictly necessary, but it doesn't hurt.  And with the
> upcoming changes to the order of steps here this offers easy
> protection.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 214c937..6af09f1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2553,6 +2553,8 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	INIT_LIST_HEAD(&rbd_dev->snaps);
>   	init_rwsem(&rbd_dev->header_rwsem);
>
> +	down_write(&rbd_dev->header_rwsem);
> +
>   	/* generate unique id: find highest unique id, add one */
>   	rbd_dev_id_get(rbd_dev);
>
> @@ -2598,18 +2600,17 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	/* contact OSD, request size info about the object being mapped */
>   	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
>   	if (rc)
> -		goto err_out_bus;
> +		goto err_out_unlock;
>
> -	/* no need to lock here, as rbd_dev is not registered yet */
>   	rc = rbd_dev_snap_devs_update(rbd_dev);
>   	if (rc)
> -		goto err_out_bus;
> +		goto err_out_unlock;
>
> -	down_write(&rbd_dev->header_rwsem);
>   	rc = rbd_header_set_snap(rbd_dev, snap_name);
> -	up_write(&rbd_dev->header_rwsem);
>   	if (rc)
> -		goto err_out_bus;
> +		goto err_out_unlock;
> +
> +	up_write(&rbd_dev->header_rwsem);
>
>   	/* Set up the blkdev mapping. */
>
> @@ -2630,6 +2631,8 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	return count;
>
> +err_out_unlock:
> +	up_write(&rbd_dev->header_rwsem);
>   err_out_bus:
>   	/* this will also clean up rest of rbd_dev stuff */
>
> @@ -2649,6 +2652,7 @@ err_put_id:
>   		kfree(rbd_dev->pool_name);
>   	}
>   	rbd_dev_id_put(rbd_dev);
> +	up_write(&rbd_dev->header_rwsem);
>   err_nomem:
>   	kfree(rbd_dev);
>   	kfree(options);
>

