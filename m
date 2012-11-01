From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/6] rbd: get parent spec for version 2 images
Date: Wed, 31 Oct 2012 18:33:16 -0700
Message-ID: <5091D15C.9000804@inktank.com>
References: <509081C4.3050402@inktank.com> <509083A3.5030003@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39813 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab2KABda (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 21:33:30 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1360244pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 18:33:29 -0700 (PDT)
In-Reply-To: <509083A3.5030003@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/30/2012 06:49 PM, Alex Elder wrote:
> Add support for getting the the information identifying the parent
> image for rbd images that have them.  The child image holds a
> reference to its parent image specification structure.  Create a new
> entry "parent" in /sys/bus/rbd/image/N/ to report the identifying
> information for the parent image, if any.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-rbd |    4 +
>   drivers/block/rbd.c                     |  131
> +++++++++++++++++++++++++++++++
>   include/linux/ceph/rados.h              |    2 +
>   3 files changed, 137 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-rbd
> b/Documentation/ABI/testing/sysfs-bus-rbd
> index 1cf2adf..cd9213c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-rbd
> +++ b/Documentation/ABI/testing/sysfs-bus-rbd
> @@ -70,6 +70,10 @@ snap_*
>
>   	A directory per each snapshot
>
> +parent
> +
> +	Information identifying the pool, image, and snapshot id for
> +	the parent image in a layered rbd image (format 2 only).
>
>   Entries under /sys/bus/rbd/devices/<dev-id>/snap_<snap-name>
>   -------------------------------------------------------------
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 28052ff..bce1fcf 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -217,6 +217,9 @@ struct rbd_device {
>   	struct ceph_osd_event   *watch_event;
>   	struct ceph_osd_request *watch_request;
>
> +	struct rbd_spec		*parent_spec;
> +	u64			parent_overlap;
> +
>   	/* protects updating the header */
>   	struct rw_semaphore     header_rwsem;
>
> @@ -2009,6 +2012,49 @@ static ssize_t rbd_snap_show(struct device *dev,
>   	return sprintf(buf, "%s\n", rbd_dev->spec->snap_name);
>   }
>
> +/*
> + * For an rbd v2 image, shows the pool id, image id, and snapshot id
> + * for the parent image.  If there is no parent, simply shows
> + * "(no parent image)".
> + */
> +static ssize_t rbd_parent_show(struct device *dev,
> +			     struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
> +	struct rbd_spec *spec = rbd_dev->parent_spec;
> +	int count;
> +	char *bufp = buf;
> +
> +	if (!spec)
> +		return sprintf(buf, "(no parent image)\n");
> +
> +	count = sprintf(bufp, "pool_id %llu\npool_name %s\n",
> +			(unsigned long long) spec->pool_id, spec->pool_name);
> +	if (count < 0)
> +		return count;
> +	bufp += count;
> +
> +	count = sprintf(bufp, "image_id %s\nimage_name %s\n", spec->image_id,
> +			spec->image_name ? spec->image_name : "(unknown)");
> +	if (count < 0)
> +		return count;
> +	bufp += count;
> +
> +	count = sprintf(bufp, "snap_id %llu\nsnap_name %s\n",
> +			(unsigned long long) spec->snap_id, spec->snap_name);
> +	if (count < 0)
> +		return count;
> +	bufp += count;
> +
> +	count = sprintf(bufp, "overlap %llu\n", rbd_dev->parent_overlap);
> +	if (count < 0)
> +		return count;
> +	bufp += count;
> +
> +	return (ssize_t) (bufp - buf);
> +}
> +
>   static ssize_t rbd_image_refresh(struct device *dev,
>   				 struct device_attribute *attr,
>   				 const char *buf,
> @@ -2032,6 +2078,7 @@ static DEVICE_ATTR(name, S_IRUGO, rbd_name_show,
> NULL);
>   static DEVICE_ATTR(image_id, S_IRUGO, rbd_image_id_show, NULL);
>   static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
>   static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
> +static DEVICE_ATTR(parent, S_IRUGO, rbd_parent_show, NULL);
>
>   static struct attribute *rbd_attrs[] = {
>   	&dev_attr_size.attr,
> @@ -2043,6 +2090,7 @@ static struct attribute *rbd_attrs[] = {
>   	&dev_attr_name.attr,
>   	&dev_attr_image_id.attr,
>   	&dev_attr_current_snap.attr,
> +	&dev_attr_parent.attr,
>   	&dev_attr_refresh.attr,
>   	NULL
>   };
> @@ -2192,6 +2240,7 @@ struct rbd_device *rbd_dev_create(struct
> rbd_client *rbdc,
>
>   static void rbd_dev_destroy(struct rbd_device *rbd_dev)
>   {
> +	rbd_spec_put(rbd_dev->parent_spec);
>   	kfree(rbd_dev->header_name);
>   	rbd_put_client(rbd_dev->rbd_client);
>   	rbd_spec_put(rbd_dev->spec);
> @@ -2400,6 +2449,71 @@ static int rbd_dev_v2_features(struct rbd_device
> *rbd_dev)
>   						&rbd_dev->header.features);
>   }
>
> +static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
> +{
> +	struct rbd_spec *parent_spec;
> +	size_t size;
> +	void *reply_buf = NULL;
> +	__le64 snapid;
> +	void *p;
> +	void *end;
> +	char *image_id;
> +	u64 overlap;
> +	size_t len = 0;
> +	int ret;
> +
> +	parent_spec = rbd_spec_alloc();
> +	if (!parent_spec)
> +		return -ENOMEM;
> +
> +	size = sizeof (__le64) +				/* pool_id */
> +		sizeof (__le32) + RBD_IMAGE_ID_LEN_MAX +	/* image_id */
> +		sizeof (__le64) +				/* snap_id */
> +		sizeof (__le64);				/* overlap */
> +	reply_buf = kmalloc(size, GFP_KERNEL);
> +	if (!reply_buf) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	snapid = cpu_to_le64(CEPH_NOSNAP);
> +	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
> +				"rbd", "get_parent",
> +				(char *) &snapid, sizeof (snapid),
> +				(char *) reply_buf, size,
> +				CEPH_OSD_FLAG_READ, NULL);
> +	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	ret = -ERANGE;
> +	p = reply_buf;
> +	end = (char *) reply_buf + size;
> +	ceph_decode_64_safe(&p, end, parent_spec->pool_id, out_err);
> +	if (parent_spec->pool_id == CEPH_NOPOOL)
> +		goto out;	/* No parent?  No problem. */
> +
> +	image_id = ceph_extract_encoded_string(&p, end, &len, GFP_KERNEL);
> +	if (IS_ERR(image_id)) {
> +		ret = PTR_ERR(image_id);
> +		goto out_err;
> +	}
> +	parent_spec->image_id = image_id;
> +	ceph_decode_64_safe(&p, end, parent_spec->snap_id, out_err);
> +	ceph_decode_64_safe(&p, end, overlap, out_err);
> +
> +	rbd_dev->parent_overlap = overlap;
> +	rbd_dev->parent_spec = parent_spec;
> +	parent_spec = NULL;	/* rbd_dev now owns this */
> +out:
> +	ret = 0;
> +out_err:
> +	kfree(reply_buf);
> +	rbd_spec_put(parent_spec);
> +
> +	return ret;
> +}
> +
>   static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev, u64 *ver)
>   {
>   	size_t size;
> @@ -3154,6 +3268,12 @@ static int rbd_dev_v1_probe(struct rbd_device
> *rbd_dev)
>   	ret = rbd_read_header(rbd_dev, &rbd_dev->header);
>   	if (ret < 0)
>   		goto out_err;
> +
> +	/* Version 1 images have no parent (no layering) */
> +
> +	rbd_dev->parent_spec = NULL;
> +	rbd_dev->parent_overlap = 0;
> +
>   	rbd_dev->image_format = 1;
>
>   	dout("discovered version 1 image, header name is %s\n",
> @@ -3205,6 +3325,14 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>   	if (ret < 0)
>   		goto out_err;
>
> +	/* If the image supports layering, get the parent info */
> +
> +	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
> +		ret = rbd_dev_v2_parent_info(rbd_dev);
> +		if (ret < 0)
> +			goto out_err;
> +	}
> +
>   	/* crypto and compression type aren't (yet) supported for v2 images */
>
>   	rbd_dev->header.crypt_type = 0;
> @@ -3224,6 +3352,9 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>
>   	return 0;
>   out_err:
> +	rbd_dev->parent_overlap = 0;
> +	rbd_spec_put(rbd_dev->parent_spec);
> +	rbd_dev->parent_spec = NULL;
>   	kfree(rbd_dev->header_name);
>   	rbd_dev->header_name = NULL;
>   	kfree(rbd_dev->header.object_prefix);
> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> index 0a99099..15077db 100644
> --- a/include/linux/ceph/rados.h
> +++ b/include/linux/ceph/rados.h
> @@ -87,6 +87,8 @@ struct ceph_pg {
>    *
>    *  lpgp_num -- as above.
>    */
> +#define CEPH_NOPOOL  ((__u64) (-1))  /* pool id not defined */
> +
>   #define CEPH_PG_TYPE_REP     1
>   #define CEPH_PG_TYPE_RAID4   2
>   #define CEPH_PG_POOL_VERSION 2
>

