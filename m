From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/9]  rbd: assign header name later
Date: Mon, 10 Sep 2012 15:41:10 -0700
Message-ID: <504E6C86.2030105@inktank.com>
References: <504A152E.4000905@inktank.com> <504A1653.7020609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38574 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab2IJWlO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 18:41:14 -0400
Received: by pbbrr13 with SMTP id rr13so3145199pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 15:41:13 -0700 (PDT)
In-Reply-To: <504A1653.7020609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 08:44 AM, Alex Elder wrote:
> Move the assignment of the header name for an rbd image a bit later,
> outside rbd_add_parse_args() and into its caller.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4dff92f..14034e3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2475,15 +2475,6 @@ static char *rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   	if (!rbd_dev->image_name)
>   		goto out_err;
>
> -	/* Create the name of the header object */
> -
> -	rbd_dev->header_name = kmalloc(rbd_dev->image_name_len
> -						+ sizeof (RBD_SUFFIX),
> -					GFP_KERNEL);
> -	if (!rbd_dev->header_name)
> -		goto out_err;
> -	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);
> -
>   	/* Snapshot name is optional */
>   	len = next_token(&buf);
>   	if (!len) {
> @@ -2501,8 +2492,6 @@ dout("    SNAP_NAME is <%s>, len is %zd\n",
> snap_name, len);
>   	return snap_name;
>
>   out_err:
> -	kfree(rbd_dev->header_name);
> -	rbd_dev->header_name = NULL;
>   	kfree(rbd_dev->image_name);
>   	rbd_dev->image_name = NULL;
>   	rbd_dev->image_name_len = 0;
> @@ -2569,6 +2558,15 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		goto err_out_client;
>   	rbd_dev->pool_id = rc;
>
> +	/* Create the name of the header object */
> +
> +	rbd_dev->header_name = kmalloc(rbd_dev->image_name_len
> +						+ sizeof (RBD_SUFFIX),
> +					GFP_KERNEL);
> +	if (!rbd_dev->header_name)
> +		goto err_out_client;
> +	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);
> +
>   	/* register our block device */
>   	rc = register_blkdev(0, rbd_dev->name);
>   	if (rc < 0)
> @@ -2630,11 +2628,11 @@ err_out_bus:
>   err_out_blkdev:
>   	unregister_blkdev(rbd_dev->major, rbd_dev->name);
>   err_out_client:
> +	kfree(rbd_dev->header_name);
>   	rbd_put_client(rbd_dev);
>   err_put_id:
>   	if (rbd_dev->pool_name) {
>   		kfree(rbd_dev->mapping.snap_name);
> -		kfree(rbd_dev->header_name);
>   		kfree(rbd_dev->image_name);
>   		kfree(rbd_dev->pool_name);
>   	}
>

