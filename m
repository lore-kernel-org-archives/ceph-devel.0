From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/7] rbd: return snap name from rbd_add_parse_args()
Date: Fri, 07 Sep 2012 12:32:23 -0700
Message-ID: <504A4BC7.2030603@inktank.com>
References: <5049F951.2030706@inktank.com> <5049FA78.9080603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58584 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab2IGTc0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 15:32:26 -0400
Received: by dady13 with SMTP id y13so1986669dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 12:32:26 -0700 (PDT)
In-Reply-To: <5049FA78.9080603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 06:45 AM, Alex Elder wrote:
> This is the first of two patches aimed at isolating the code that
> sets the mapping information into a single spot.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   72
> ++++++++++++++++++++++++++-------------------------
>   1 file changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4377a83..1a64ba2 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2477,28 +2477,31 @@ static inline char *dup_token(const char **buf,
> size_t *lenp)
>   }
>
>   /*
> - * This fills in the pool_name, image_name, image_name_len, snap_name,
> - * rbd_dev, rbd_md_name, and name fields of the given rbd_dev, based
> - * on the list of monitor addresses and other options provided via
> - * /sys/bus/rbd/add.
> + * This fills in the pool_name, image_name, image_name_len, rbd_dev,
> + * rbd_md_name, and name fields of the given rbd_dev, based on the
> + * list of monitor addresses and other options provided via
> + * /sys/bus/rbd/add.  Returns a pointer to a dynamically-allocated
> + * copy of the snapshot name to map if successful, or a
> + * pointer-coded error otherwise.
>    *
>    * Note: rbd_dev is assumed to have been initially zero-filled.
>    */
> -static int rbd_add_parse_args(struct rbd_device *rbd_dev,
> -			      const char *buf,
> -			      const char **mon_addrs,
> -			      size_t *mon_addrs_size,
> -			      char *options,
> -			     size_t options_size)
> +static char *rbd_add_parse_args(struct rbd_device *rbd_dev,
> +				const char *buf,
> +				const char **mon_addrs,
> +				size_t *mon_addrs_size,
> +				char *options,
> +				size_t options_size)
>   {
>   	size_t len;
> -	int ret;
> +	char *err_ptr = ERR_PTR(-EINVAL);
> +	char *snap_name;
>
>   	/* The first four tokens are required */
>
>   	len = next_token(&buf);
>   	if (!len)
> -		return -EINVAL;
> +		return err_ptr;
>   	*mon_addrs_size = len + 1;
>   	*mon_addrs = buf;
>
> @@ -2506,9 +2509,9 @@ static int rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>
>   	len = copy_token(&buf, options, options_size);
>   	if (!len || len >= options_size)
> -		return -EINVAL;
> +		return err_ptr;
>
> -	ret = -ENOMEM;
> +	err_ptr = ERR_PTR(-ENOMEM);
>   	rbd_dev->pool_name = dup_token(&buf, NULL);
>   	if (!rbd_dev->pool_name)
>   		goto out_err;
> @@ -2526,26 +2529,21 @@ static int rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   		goto out_err;
>   	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);
>
> -	/*
> -	 * The snapshot name is optional.  If none is is supplied,
> -	 * we use the default value.
> -	 */
> -	rbd_dev->mapping.snap_name = dup_token(&buf, &len);
> -	if (!rbd_dev->mapping.snap_name)
> -		goto out_err;
> +	/* Snapshot name is optional */
> +	len = next_token(&buf);
>   	if (!len) {
> -		/* Replace the empty name with the default */
> -		kfree(rbd_dev->mapping.snap_name);
> -		rbd_dev->mapping.snap_name
> -			= kmalloc(sizeof (RBD_SNAP_HEAD_NAME), GFP_KERNEL);
> -		if (!rbd_dev->mapping.snap_name)
> -			goto out_err;
> -
> -		memcpy(rbd_dev->mapping.snap_name, RBD_SNA
Here are the points to cover on this call with Alcatel Lucent.
Bryan would like for you to run the call and clarify the plan of action.

Primary objectives for Proof of Concept phase:


1. Ceph demo - on Ubuntu 12.04
Show Qemu - kvm migration and recovery
Show block device in a cloud environment

2. Training and demo of RBD access paths
Determine how that matches AL's configuration plans
P_HEAD_NAME,
> -			sizeof (RBD_SNAP_HEAD_NAME));
> +		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
> +		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
>   	}
> +	snap_name = kmalloc(len + 1, GFP_KERNEL);
> +	if (!snap_name)
> +		goto out_err;
> +	memcpy(snap_name, buf, len);
> +	*(snap_name + len) = '\0';
>
> -	return 0;
> +dout("    SNAP_NAME is <%s>, len is %zd\n", snap_name, len);
> +
> +	return snap_name;
>
>   out_err:
>   	kfree(rbd_dev->header_name);
> @@ -2556,7 +2554,7 @@ out_err:
>   	kfree(rbd_dev->pool_name);
>   	rbd_dev->pool_name = NULL;
>
> -	return ret;
> +	return err_ptr;
>   }
>
>   static ssize_t rbd_add(struct bus_type *bus,
> @@ -2569,6 +2567,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	size_t mon_addrs_size = 0;
>   	struct ceph_osd_client *osdc;
>   	int rc = -ENOMEM;
> +	char *snap_name;
>
>   	if (!try_module_get(THIS_MODULE))
>   		return -ENODEV;
> @@ -2595,10 +2594,13 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->dev_id);
>
>   	/* parse add command */
> -	rc = rbd_add_parse_args(rbd_dev, buf, &mon_addrs, &mon_addrs_size,
> -				options, count);
> -	if (rc)
> +	snap_name = rbd_add_parse_args(rbd_dev, buf,
> +				&mon_addrs, &mon_addrs_size, options, count);
> +	if (IS_ERR(snap_name)) {
> +		rc = PTR_ERR(snap_name);
>   		goto err_put_id;
> +	}
> +	rbd_dev->mapping.snap_name = snap_name;
>
>   	rc = rbd_get_client(rbd_dev, mon_addrs, mon_addrs_size - 1, options);
>   	if (rc < 0)
>

