From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 08/16] rbd: don't store pool name in struct rbd_dev
Date: Wed, 11 Jul 2012 12:36:25 -0700
Message-ID: <4FFDD5B9.9090101@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD875B.3060608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:36353 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab2GKTg3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 15:36:29 -0400
Received: by gglu4 with SMTP id u4so1634777ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 12:36:28 -0700 (PDT)
In-Reply-To: <4FFD875B.3060608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 07:02 AM, Alex Elder wrote:
> An rbd device's pool name is used to specify the pool to use for an
> rbd image when it gets mapped (via rbd_add()).  However, only the
> pool id can be relied on to be invariant--the name of a pool can
> change at any time.
>
> This means that the name of the pool is potentially stale as soon as
> the image is mapped, so it's a bad idea to record this information.
> So only store the pool id, not its name, in an rbd_dev.
>
> Here are a few specific notes about this change:
>      - The "pool" name device attribute (/sys/bus/rbd/devices/<N>/pool)
>        goes away.  In its place is a "pool_id" attribute that provide
>        the numeric pool id for the rbd image.

We're using the pool name for udev to provide a predictable device name
(/dev/rbd/poolname/imagename[@snapname]), so we probably want to keep
the sysfs attribute. I don't think there's a good way for us to detect
pool renames right now though, so we should document that the pool
name reported does not reflect any potential renames.

>      - rbd_add_parse_args() now returns a pointer to a dynamically-
>        allocated copy of the pool name taken from the arguments.
>      - rbd_add() has been changed to handle freeing the pool name,
>        both in error cases and in the normal case after the pool id
>        has been recorded.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |   74
> +++++++++++++++++++++++++++++++-------------------
>   1 files changed, 46 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3aa0ca0..76e978c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -56,7 +56,6 @@
>   #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */
>
>   #define RBD_MAX_MD_NAME_LEN	(RBD_MAX_OBJ_NAME_LEN + sizeof(RBD_SUFFIX))
> -#define RBD_MAX_POOL_NAME_LEN	64
>   #define RBD_MAX_SNAP_NAME_LEN	32
>   #define RBD_MAX_OPT_LEN		1024
>
> @@ -166,8 +165,7 @@ struct rbd_device {
>   	char			obj[RBD_MAX_OBJ_NAME_LEN]; /* rbd image name */
>   	int			obj_len;
>   	char			obj_md_name[RBD_MAX_MD_NAME_LEN]; /* hdr nm. */
> -	char			pool_name[RBD_MAX_POOL_NAME_LEN];
> -	int			poolid;
> +	int			pool_id;
>
>   	struct ceph_osd_event   *watch_event;
>   	struct ceph_osd_request *watch_request;
> @@ -930,7 +928,7 @@ static int rbd_do_request(struct request *rq,
>   	layout->fl_stripe_unit = cpu_to_le32(1<<  RBD_MAX_OBJ_ORDER);
>   	layout->fl_stripe_count = cpu_to_le32(1);
>   	layout->fl_object_size = cpu_to_le32(1<<  RBD_MAX_OBJ_ORDER);
> -	layout->fl_pg_pool = cpu_to_le32(dev->poolid);
> +	layout->fl_pg_pool = cpu_to_le32(dev->pool_id);
>   	ceph_calc_raw_layout(osdc, layout, snapid, ofs,&len,&bno,
>   				req, ops);
>
> @@ -1653,7 +1651,7 @@ static int rbd_header_add_snap(struct rbd_device *dev,
>   		return -EINVAL;
>
>   	monc =&dev->rbd_client->client->monc;
> -	ret = ceph_monc_create_snapid(monc, dev->poolid,&new_snapid);
> +	ret = ceph_monc_create_snapid(monc, dev->pool_id,&new_snapid);
>   	dout("created snapid=%lld\n", new_snapid);
>   	if (ret<  0)
>   		return ret;
> @@ -1851,12 +1849,12 @@ static ssize_t rbd_client_id_show(struct device
> *dev,
>   			ceph_client_id(rbd_dev->rbd_client->client));
>   }
>
> -static ssize_t rbd_pool_show(struct device *dev,
> +static ssize_t rbd_pool_id_show(struct device *dev,
>   			     struct device_attribute *attr, char *buf)
>   {
>   	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
>
> -	return sprintf(buf, "%s\n", rbd_dev->pool_name);
> +	return sprintf(buf, "%d\n", rbd_dev->pool_id);
>   }
>
>   static ssize_t rbd_name_show(struct device *dev,
> @@ -1898,7 +1896,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
>   static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
>   static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
>   static DEVICE_ATTR(client_id, S_IRUGO, rbd_client_id_show, NULL);
> -static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
> +static DEVICE_ATTR(pool_id, S_IRUGO, rbd_pool_id_show, NULL);
>   static DEVICE_ATTR(name, S_IRUGO, rbd_name_show, NULL);
>   static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
>   static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
> @@ -1908,7 +1906,7 @@ static struct attribute *rbd_attrs[] = {
>   	&dev_attr_size.attr,
>   	&dev_attr_major.attr,
>   	&dev_attr_client_id.attr,
> -	&dev_attr_pool.attr,
> +	&dev_attr_pool_id.attr,
>   	&dev_attr_name.attr,
>   	&dev_attr_current_snap.attr,
>   	&dev_attr_refresh.attr,
> @@ -2329,25 +2327,31 @@ static inline char *dup_token(const char **buf,
> size_t *lenp)
>   }
>
>   /*
> - * This fills in the pool_name, obj, obj_len, snap_name, obj_len,
> - * rbd_dev, rbd_md_name, and name fields of the given rbd_dev, based
> - * on the list of monitor addresses and other options provided via
> - * /sys/bus/rbd/add.
> + * This fills in the obj, obj_len, snap_name, rbd_dev, rbd_md_name,
> + * and name fields of the given rbd_dev, based on the list of
> + * monitor addresses and other options provided via /sys/bus/rbd/add.
> + *
> + * Returns a pointer to a dynamically-allocated buffer containing
> + * the pool name provided, or a pointer-coded errno if an error
> + * occurs.
>    */
> -static int rbd_add_parse_args(struct rbd_device *rbd_dev,
> +static char *rbd_add_parse_args(struct rbd_device *rbd_dev,
>   			      const char *buf,
>   			      const char **mon_addrs,
>   			      size_t *mon_addrs_size,
>   			      char *options,
>   			      size_t options_size)
>   {
> -	size_t	len;
> +	size_t len;
> +	int ret = -EINVAL;
> +	char *pool_name = NULL;
>
>   	/* The first four tokens are required */
>
>   	len = next_token(&buf);
>   	if (!len)
> -		return -EINVAL;
> +		goto out_err;
> +
>   	*mon_addrs_size = len + 1;
>   	*mon_addrs = buf;
>
> @@ -2355,15 +2359,17 @@ static int rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>
>   	len = copy_token(&buf, options, options_size);
>   	if (!len || len>= options_size)
> -		return -EINVAL;
> +		goto out_err;
>
> -	len = copy_token(&buf, rbd_dev->pool_name, sizeof (rbd_dev->pool_name));
> -	if (!len || len>= sizeof (rbd_dev->pool_name))
> -		return -EINVAL;
> +	pool_name = dup_token(&buf, NULL);
> +	if (!pool_name) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
>
>   	len = copy_token(&buf, rbd_dev->obj, sizeof (rbd_dev->obj));
>   	if (!len || len>= sizeof (rbd_dev->obj))
> -		return -EINVAL;
> +		goto out_err;
>
>   	/* We have the object length in hand, save it. */
>
> @@ -2382,9 +2388,14 @@ static int rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>   			sizeof (RBD_SNAP_HEAD_NAME));
>   	else if (len>= sizeof (rbd_dev->snap_name))
> -		return -EINVAL;
> +		goto out_err;
>
> -	return 0;
> +	return pool_name;
> +
> +out_err:
> +	kfree(pool_name);
> +
> +	return ERR_PTR(ret);
>   }
>
>   static ssize_t rbd_add(struct bus_type *bus,
> @@ -2396,6 +2407,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	size_t mon_addrs_size = 0;
>   	char *options = NULL;
>   	struct ceph_osd_client *osdc;
> +	char *pool_name;
>   	int rc = -ENOMEM;
>
>   	if (!try_module_get(THIS_MODULE))
> @@ -2425,10 +2437,14 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->id);
>
>   	/* parse add command */
> -	rc = rbd_add_parse_args(rbd_dev, buf,&mon_addrs,&mon_addrs_size,
> -				options, count);
> -	if (rc)
> +	pool_name = rbd_add_parse_args(rbd_dev, buf,
> +					&mon_addrs,&mon_addrs_size,
> +					options, count);
> +	if (IS_ERR(pool_name)) {
> +		rc = PTR_ERR(pool_name);
> +		pool_name = NULL;
>   		goto err_put_id;
> +	}
>
>   	rbd_dev->rbd_client = rbd_get_client(mon_addrs, mon_addrs_size - 1,
>   						options);
> @@ -2439,10 +2455,10 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	/* pick the pool */
>   	osdc =&rbd_dev->rbd_client->client->osdc;
> -	rc = ceph_pg_poolid_by_name(osdc->osdmap, rbd_dev->pool_name);
> +	rc = ceph_pg_poolid_by_name(osdc->osdmap, pool_name);
>   	if (rc<  0)
>   		goto err_out_client;
> -	rbd_dev->poolid = rc;
> +	rbd_dev->pool_id = rc;
>
>   	/* register our block device */
>   	rc = register_blkdev(0, rbd_dev->name);
> @@ -2453,6 +2469,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	rc = rbd_bus_add_dev(rbd_dev);
>   	if (rc)
>   		goto err_out_blkdev;
> +	kfree(pool_name);
>
>   	/*
>   	 * At this point cleanup in the event of an error is the job
> @@ -2482,6 +2499,7 @@ err_out_blkdev:
>   err_out_client:
>   	rbd_put_client(rbd_dev);
>   err_put_id:
> +	kfree(pool_name);
>   	rbd_id_put(rbd_dev);
>   err_nomem:
>   	kfree(options);

