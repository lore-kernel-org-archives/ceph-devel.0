From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/9] rbd: lay out header probe infrastructure
Date: Wed, 19 Sep 2012 11:35:40 -0700
Message-ID: <505A107C.40309@inktank.com>
References: <504A6273.7030807@inktank.com> <504A636F.9070106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42984 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab2ISSfm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 14:35:42 -0400
Received: by pbbrr13 with SMTP id rr13so3116887pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 11:35:42 -0700 (PDT)
In-Reply-To: <504A636F.9070106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 02:13 PM, Alex Elder wrote:
> This defines a new function rbd_dev_probe() as a top-level
> function for populating detailed information about an rbd device.
>
> It first checks for the existence of a format 2 rbd image id object.
> If it exists, the image is assumed to be a format 2 rbd image, and
> another function rbd_dev_v2() is called to finish populating
> header data for that image.  If it does not exist, it is assumed to
> be an old (format 1) rbd image, and calls a similar function
> rbd_dev_v1() to populate its header information.
>
> A new field, rbd_dev->format, is defined to record which version
> of the rbd image format the device represents.  For a valid mapped
> rbd device it will have one of two values, 1 or 2.
>
> So far, the format 2 images are not really supported; this is
> laying out the infrastructure for fleshing out that support.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |  126
> ++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 99 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e6b8fa6..019e695 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -170,6 +170,7 @@ struct rbd_device {
>   	int			major;		/* blkdev assigned major */
>   	struct gendisk		*disk;		/* blkdev's gendisk and rq */
>
> +	u32			image_format;	/* Either 1 or 2 */
>   	struct rbd_options	rbd_opts;
>   	struct rbd_client	*rbd_client;
>
> @@ -507,6 +508,11 @@ static void rbd_coll_release(struct kref *kref)
>   	kfree(coll);
>   }
>
> +static bool rbd_image_format_valid(u32 image_format)
> +{
> +	return image_format == 1 || image_format == 2;
> +}
> +
>   static bool rbd_dev_ondisk_valid(struct rbd_image_header_ondisk *ondisk)
>   {
>   	size_t size;
> @@ -2579,6 +2585,96 @@ out:
>   	return ret;
>   }
>
> +static int rbd_dev_v1_probe(struct rbd_device *rbd_dev)
> +{
> +	int ret;
> +	size_t size;
> +
> +	/* Version 1 images have no id; empty string is used */
> +
> +	rbd_dev->image_id = kstrdup("", GFP_KERNEL);
> +	if (!rbd_dev->image_id)
> +		return -ENOMEM;
> +	rbd_dev->image_id_len = 0;
> +
> +	/* Record the header object name for this rbd image. */
> +
> +	size = rbd_dev->image_name_len + sizeof (RBD_SUFFIX);
> +	rbd_dev->header_name = kmalloc(size, GFP_KERNEL);
> +	if (!rbd_dev->header_name) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);
> +
> +	/* Populate rbd image metadata */
> +
> +	ret = rbd_read_header(rbd_dev, &rbd_dev->header);
> +	if (ret < 0)
> +		goto out_err;
> +	rbd_dev->image_format = 1;
> +
> +	dout("discovered version 1 image, header name is %s\n",
> +		rbd_dev->header_name);
> +
> +	return 0;
> +
> +out_err:
> +	kfree(rbd_dev->header_name);
> +	rbd_dev->header_name = NULL;
> +	kfree(rbd_dev->image_id);
> +	rbd_dev->image_id = NULL;
> +
> +	return ret;
> +}
> +
> +static int rbd_dev_v2_probe(struct rbd_device *rbd_dev)
> +{
> +	size_t size;
> +
> +	/*
> +	 * Image id was filled in by the caller.  Record the header
> +	 * object name for this rbd image.
> +	 */
> +	size = sizeof (RBD_HEADER_PREFIX) + rbd_dev->image_id_len;
> +	rbd_dev->header_name = kmalloc(size, GFP_KERNEL);
> +	if (!rbd_dev->header_name)
> +		return -ENOMEM;
> +	sprintf(rbd_dev->header_name, "%s%s",
> +			RBD_HEADER_PREFIX, rbd_dev->image_id);
> +	rbd_dev->image_format = 2;
> +
> +	dout("discovered version 2 image, header name is %s\n",
> +		rbd_dev->header_name);
> +
> +	return -ENOTSUPP;
> +}
> +
> +/*
> + * Probe for the existence of the header object for the given rbd
> + * device.  For format 2 images this includes determining the image
> + * id.
> + */
> +static int rbd_dev_probe(struct rbd_device *rbd_dev)
> +{
> +	int ret;
> +
> +	/*
> +	 * Get the id from the image id object.  If it's not a
> +	 * format 2 image, we'll get ENOENT back, and we'll assume
> +	 * it's a format 1 image.
> +	 */
> +	ret = rbd_dev_image_id(rbd_dev);
> +	if (ret == -ENOENT)
> +		ret = rbd_dev_v1_probe(rbd_dev);
> +	else if (!ret)
> +		ret = rbd_dev_v2_probe(rbd_dev);
> +	if (ret)
> +		dout("probe failed, returning %d\n", ret);
> +
> +	return ret;
> +}
> +
>   static ssize_t rbd_add(struct bus_type *bus,
>   		       const char *buf,
>   		       size_t count)
> @@ -2628,34 +2724,10 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		goto err_out_client;
>   	rbd_dev->pool_id = rc;
>
> -	rc = rbd_dev_image_id(rbd_dev);
> -	if (rc == -ENOENT) {
> -		/* Version 1 images have no id; empty string is used */
> -		rbd_dev->image_id = kstrdup("", GFP_KERNEL);
> -		if (!rbd_dev->image_id) {
> -			rc = -ENOMEM;
> -			goto err_out_client;
> -		}
> -		rbd_dev->image_id_len = 0;
> -	} else {
> -	        /* Not actually supporting format 2 yet */
> -		goto err_out_client;
> -	}
> -
> -	/* Create the name of the header object */
> -
> -	rbd_dev->header_name = kmalloc(rbd_dev->image_name_len
> -						+ sizeof (RBD_SUFFIX),
> -					GFP_KERNEL);
> -	if (!rbd_dev->header_name)
> -		goto err_out_client;
> -	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);
> -
> -	/* Get information about the image being mapped */
> -
> -	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
> -	if (rc)
> +	rc = rbd_dev_probe(rbd_dev);
> +	if (rc < 0)
>   		goto err_out_client;
> +	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>
>   	rc = rbd_dev_snaps_update(rbd_dev);
>   	if (rc)
>

