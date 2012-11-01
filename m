From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/6] rbd: get additional info in parent spec
Date: Wed, 31 Oct 2012 18:49:00 -0700
Message-ID: <5091D50C.1030400@inktank.com>
References: <509081C4.3050402@inktank.com> <509083C4.409@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:45406 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab2KABtO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 21:49:14 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so915725dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 18:49:14 -0700 (PDT)
In-Reply-To: <509083C4.409@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I know you've got a queue of these already, but here's another:
rbd_dev_probe_update_spec() could definitely use some warnings
to distinguish its error cases.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/30/2012 06:49 PM, Alex Elder wrote:
> When a layered rbd image has a parent, that parent is identified
> only by its pool id, image id, and snapshot id.  Images that have
> been mapped also record *names* for those three id's.
>
> Add code to look up these names for parent images so they match
> mapped images more closely.  Skip doing this for an image if it
> already has its pool name defined (this will be the case for images
> mapped by the user).
>
> It is possible that an the name of a parent image can't be
> determined, even if the image id is valid.  If this occurs it
> does not preclude correct operation, so don't treat this as
> an error.
>
> On the other hand, defined pools will always have both an id and a
> name.   And any snapshot of an image identified as a parent for a
> clone image will exist, and will have a name (if not it indicates
> some other internal error).  So treat failure to get these bits
> of information as errors.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |  131
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 131 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bce1fcf..04062c1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -70,7 +70,10 @@
>
>   #define RBD_SNAP_HEAD_NAME	"-"
>
> +/* This allows a single page to hold an image name sent by OSD */
> +#define RBD_IMAGE_NAME_LEN_MAX	(PAGE_SIZE - sizeof (__le32) - 1)
>   #define RBD_IMAGE_ID_LEN_MAX	64
> +
>   #define RBD_OBJ_PREFIX_LEN_MAX	64
>
>   /* Feature bits */
> @@ -658,6 +661,20 @@ out_err:
>   	return -ENOMEM;
>   }
>
> +static const char *rbd_snap_name(struct rbd_device *rbd_dev, u64 snap_id)
> +{
> +	struct rbd_snap *snap;
> +
> +	if (snap_id == CEPH_NOSNAP)
> +		return RBD_SNAP_HEAD_NAME;
> +
> +	list_for_each_entry(snap, &rbd_dev->snaps, node)
> +		if (snap_id == snap->id)
> +			return snap->name;
> +
> +	return NULL;
> +}
> +
>   static int snap_by_name(struct rbd_device *rbd_dev, const char *snap_name)
>   {
>
> @@ -2499,6 +2516,7 @@ static int rbd_dev_v2_parent_info(struct
> rbd_device *rbd_dev)
>   		goto out_err;
>   	}
>   	parent_spec->image_id = image_id;
> +	parent_spec->image_id_len = len;
>   	ceph_decode_64_safe(&p, end, parent_spec->snap_id, out_err);
>   	ceph_decode_64_safe(&p, end, overlap, out_err);
>
> @@ -2514,6 +2532,115 @@ out_err:
>   	return ret;
>   }
>
> +static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
> +{
> +	size_t image_id_size;
> +	char *image_id;
> +	void *p;
> +	void *end;
> +	size_t size;
> +	void *reply_buf = NULL;
> +	size_t len = 0;
> +	char *image_name = NULL;
> +	int ret;
> +
> +	rbd_assert(!rbd_dev->spec->image_name);
> +
> +	image_id_size = sizeof (__le32) + rbd_dev->spec->image_id_len;
> +	image_id = kmalloc(image_id_size, GFP_KERNEL);
> +	if (!image_id)
> +		return NULL;
> +
> +	p = image_id;
> +	end = (char *) image_id + image_id_size;
> +	ceph_encode_string(&p, end, rbd_dev->spec->image_id,
> +				(u32) rbd_dev->spec->image_id_len);
> +
> +	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
> +	reply_buf = kmalloc(size, GFP_KERNEL);
> +	if (!reply_buf)
> +		goto out;
> +
> +	ret = rbd_req_sync_exec(rbd_dev, RBD_DIRECTORY,
> +				"rbd", "dir_get_name",
> +				image_id, image_id_size,
> +				(char *) reply_buf, size,
> +				CEPH_OSD_FLAG_READ, NULL);
> +	if (ret < 0)
> +		goto out;
> +	p = reply_buf;
> +	end = (char *) reply_buf + size;
> +	image_name = ceph_extract_encoded_string(&p, end, &len, GFP_KERNEL);
> +	if (image_name)
> +		dout("%s: name is %s len is %zd\n", __func__, image_name, len);
> +out:
> +	kfree(reply_buf);
> +	kfree(image_id);
> +
> +	return image_name;
> +}
> +
> +/*
> + * When a parent image gets probed, we only have the pool, image,
> + * and snapshot ids but not the names of any of them.  This call
> + * is made later to fill in those names.  It has to be done after
> + * rbd_dev_snaps_update() has completed because some of the
> + * information (in particular, snapshot name) is not available
> + * until then.
> + */
> +static int rbd_dev_probe_update_spec(struct rbd_device *rbd_dev)
> +{
> +	struct ceph_osd_client *osdc;
> +	const char *name;
> +	void *reply_buf = NULL;
> +	int ret;
> +
> +	if (rbd_dev->spec->pool_name)
> +		return 0;	/* Already have the names */
> +
> +	/* Look up the pool name */
> +
> +	osdc = &rbd_dev->rbd_client->client->osdc;
> +	name = ceph_pg_pool_name_by_id(osdc->osdmap, rbd_dev->spec->pool_id);
> +	if (!name)
> +		return -EIO;	/* pool id too large (>= 2^31) */
> +
> +	rbd_dev->spec->pool_name = kstrdup(name, GFP_KERNEL);
> +	if (!rbd_dev->spec->pool_name)
> +		return -ENOMEM;
> +
> +	/* Fetch the image name; tolerate failure here */
> +
> +	name = rbd_dev_image_name(rbd_dev);
> +	if (name) {
> +		rbd_dev->spec->image_name_len = strlen(name);
> +		rbd_dev->spec->image_name = (char *) name;
> +	} else {
> +		pr_warning(RBD_DRV_NAME "%d "
> +			"unable to get image name for image id %s\n",
> +			rbd_dev->major, rbd_dev->spec->image_id);
> +	}
> +
> +	/* Look up the snapshot name. */
> +
> +	name = rbd_snap_name(rbd_dev, rbd_dev->spec->snap_id);
> +	if (!name) {
> +		ret = -EIO;
> +		goto out_err;
> +	}
> +	rbd_dev->spec->snap_name = kstrdup(name, GFP_KERNEL);
> +	if(!rbd_dev->spec->snap_name)
> +		goto out_err;
> +
> +	return 0;
> +out_err:
> +	kfree(reply_buf);
> +	kfree(rbd_dev->spec->pool_name);
> +	rbd_dev->spec->pool_name = NULL;
> +
> +	return ret;
> +}
> +
>   static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev, u64 *ver)
>   {
>   	size_t size;
> @@ -3372,6 +3499,10 @@ static int rbd_dev_probe_finish(struct rbd_device
> *rbd_dev)
>   	if (ret)
>   		return ret;
>
> +	ret = rbd_dev_probe_update_spec(rbd_dev);
> +	if (ret)
> +		goto err_out_snaps;
> +
>   	ret = rbd_dev_set_mapping(rbd_dev);
>   	if (ret)
>   		goto err_out_snaps;
>

