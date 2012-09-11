From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/9] rbd: defer setting device id
Date: Tue, 11 Sep 2012 08:03:49 -0700
Message-ID: <504F52D5.9060905@inktank.com>
References: <504A152E.4000905@inktank.com> <504A167D.7000405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63345 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759287Ab2IKPDw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 11:03:52 -0400
Received: by pbbrr13 with SMTP id rr13so911668pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 08:03:51 -0700 (PDT)
In-Reply-To: <504A167D.7000405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 08:45 AM, Alex Elder wrote:
> Hold off setting the device id and formatting the device name
> in rbd_add() until just before it's needed.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   44 ++++++++++++++++++++++----------------------
>   1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 89d8ed7..53e5308 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2549,10 +2549,10 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	options = kmalloc(count, GFP_KERNEL);
>   	if (!options)
> -		goto err_nomem;
> +		goto err_out_mem;
>   	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
>   	if (!rbd_dev)
> -		goto err_nomem;
> +		goto err_out_mem;
>
>   	/* static rbd_device initialization */
>   	spin_lock_init(&rbd_dev->lock);
> @@ -2562,25 +2562,17 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	down_write(&rbd_dev->header_rwsem);
>
> -	/* generate unique id: find highest unique id, add one */
> -	rbd_dev_id_get(rbd_dev);
> -
> -	/* Fill in the device name, now that we have its id. */
> -	BUILD_BUG_ON(DEV_NAME_LEN
> -			< sizeof (RBD_DRV_NAME) + MAX_INT_FORMAT_WIDTH);
> -	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->dev_id);
> -
>   	/* parse add command */
>   	snap_name = rbd_add_parse_args(rbd_dev, buf,
>   				&mon_addrs, &mon_addrs_size, options, count);
>   	if (IS_ERR(snap_name)) {
>   		rc = PTR_ERR(snap_name);
> -		goto err_put_id;
> +		goto err_out_mem;
>   	}
>
>   	rc = rbd_get_client(rbd_dev, mon_addrs, mon_addrs_size - 1, options);
>   	if (rc < 0)
> -		goto err_put_id;
> +		goto err_out_args;
>
>   	/* pick the pool */
>   	osdc = &rbd_dev->rbd_client->client->osdc;
> @@ -2612,10 +2604,19 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	if (rc)
>   		goto err_out_header;
>
> -	/* register our block device */
> +	/* generate unique id: find highest unique id, add one */
> +	rbd_dev_id_get(rbd_dev);
> +
> +	/* Fill in the device name, now that we have its id. */
> +	BUILD_BUG_ON(DEV_NAME_LEN
> +			< sizeof (RBD_DRV_NAME) + MAX_INT_FORMAT_WIDTH);
> +	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->dev_id);
> +
> +	/* Get our block major device number. */
> +
>   	rc = register_blkdev(0, rbd_dev->name);
>   	if (rc < 0)
> -		goto err_out_header;
> +		goto err_out_id;
>   	rbd_dev->major = rc;
>
>   	rc = rbd_bus_add_dev(rbd_dev);
> @@ -2663,20 +2664,19 @@ err_out_bus:
>
>   err_out_blkdev:
>   	unregister_blkdev(rbd_dev->major, rbd_dev->name);
> +err_out_id:
> +	rbd_dev_id_put(rbd_dev);
>   err_out_header:
>   	rbd_header_free(&rbd_dev->header);
>   err_out_client:
>   	kfree(rbd_dev->header_name);
>   	rbd_put_client(rbd_dev);
> -err_put_id:
> -	if (rbd_dev->pool_name) {
> -		kfree(rbd_dev->mapping.snap_name);
> -		kfree(rbd_dev->image_name);
> -		kfree(rbd_dev->pool_name);
> -	}
> -	rbd_dev_id_put(rbd_dev);
> +err_out_args:
> +	kfree(rbd_dev->mapping.snap_name);
> +	kfree(rbd_dev->image_name);
> +	kfree(rbd_dev->pool_name);
>   	up_write(&rbd_dev->header_rwsem);
> -err_nomem:
> +err_out_mem:
>   	kfree(rbd_dev);
>   	kfree(options);
>

