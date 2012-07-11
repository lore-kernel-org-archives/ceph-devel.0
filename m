From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 09/16] rbd: dynamically allocate image header name
Date: Wed, 11 Jul 2012 13:41:12 -0700
Message-ID: <4FFDE4E8.4050502@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8764.9040607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:42708 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220Ab2GKUlQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 16:41:16 -0400
Received: by yhpp61 with SMTP id p61so1962385yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 13:41:15 -0700 (PDT)
In-Reply-To: <4FFD8764.9040607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 07/11/2012 07:02 AM, Alex Elder wrote:
> There is no need to impose a small limit the length of the header
> name recorded for an rbd image in a struct rbd_dev.  Remove the
> limitation by allocating space for the header name dynamically.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |   33 +++++++++++++++++++++------------
>   1 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 76e978c..4d11337 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -55,7 +55,6 @@
>
>   #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */
>
> -#define RBD_MAX_MD_NAME_LEN	(RBD_MAX_OBJ_NAME_LEN + sizeof(RBD_SUFFIX))
>   #define RBD_MAX_SNAP_NAME_LEN	32
>   #define RBD_MAX_OPT_LEN		1024
>
> @@ -164,7 +163,7 @@ struct rbd_device {
>   	struct rbd_image_header	header;
>   	char			obj[RBD_MAX_OBJ_NAME_LEN]; /* rbd image name */
>   	int			obj_len;
> -	char			obj_md_name[RBD_MAX_MD_NAME_LEN]; /* hdr nm. */
> +	char			*obj_md_name; /* hdr nm. */
>   	int			pool_id;
>
>   	struct ceph_osd_event   *watch_event;
> @@ -2375,8 +2374,13 @@ static char *rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>
>   	rbd_dev->obj_len = len;
>
> -	BUILD_BUG_ON(RBD_MAX_MD_NAME_LEN
> -				<  RBD_MAX_OBJ_NAME_LEN + sizeof (RBD_SUFFIX));
> +	/* Create the name of the header object */
> +
> +	rbd_dev->obj_md_name = kmalloc(len + sizeof (RBD_SUFFIX), GFP_KERNEL);
> +	if (!rbd_dev->obj_md_name) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
>   	sprintf(rbd_dev->obj_md_name, "%s%s", rbd_dev->obj, RBD_SUFFIX);
>
>   	/*
> @@ -2393,6 +2397,7 @@ static char *rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   	return pool_name;
>
>   out_err:
> +	kfree(rbd_dev->obj_md_name);
>   	kfree(pool_name);
>
>   	return ERR_PTR(ret);
> @@ -2402,23 +2407,23 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		       const char *buf,
>   		       size_t count)
>   {
> -	struct rbd_device *rbd_dev;
> +	char *options;
> +	struct rbd_device *rbd_dev = NULL;
>   	const char *mon_addrs = NULL;
>   	size_t mon_addrs_size = 0;
> -	char *options = NULL;
> -	struct ceph_osd_client *osdc;
>   	char *pool_name;
> +	struct ceph_osd_client *osdc;
>   	int rc = -ENOMEM;
>
>   	if (!try_module_get(THIS_MODULE))
>   		return -ENODEV;
>
> -	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
> -	if (!rbd_dev)
> -		goto err_nomem;
>   	options = kmalloc(count, GFP_KERNEL);
>   	if (!options)
>   		goto err_nomem;
> +	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
> +	if (!rbd_dev)
> +		goto err_nomem;
>
>   	/* static rbd_device initialization */
>   	spin_lock_init(&rbd_dev->lock);
> @@ -2499,11 +2504,14 @@ err_out_blkdev:
>   err_out_client:
>   	rbd_put_client(rbd_dev);
>   err_put_id:
> -	kfree(pool_name);
> +	if (pool_name) {
> +		kfree(rbd_dev->obj_md_name);
> +		kfree(pool_name);
> +	}
>   	rbd_id_put(rbd_dev);
>   err_nomem:
> -	kfree(options);
>   	kfree(rbd_dev);
> +	kfree(options);
>
>   	dout("Error adding device %s\n", buf);
>   	module_put(THIS_MODULE);
> @@ -2548,6 +2556,7 @@ static void rbd_dev_release(struct device *dev)
>   	unregister_blkdev(rbd_dev->major, rbd_dev->name);
>
>   	/* done with the id, and with the rbd_dev */
> +	kfree(rbd_dev->obj_md_name);
>   	rbd_id_put(rbd_dev);
>   	kfree(rbd_dev);
>

