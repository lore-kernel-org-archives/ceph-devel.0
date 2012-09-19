From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/9]  rbd: add code to get the size of a v2 rbd image
Date: Wed, 19 Sep 2012 11:52:42 -0700
Message-ID: <505A147A.3050007@inktank.com>
References: <504A6273.7030807@inktank.com> <504A6379.7010308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53460 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab2ISSwp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 14:52:45 -0400
Received: by pbbrr13 with SMTP id rr13so3150892pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 11:52:45 -0700 (PDT)
In-Reply-To: <504A6379.7010308@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 02:13 PM, Alex Elder wrote:
> The size of an rbd format 2 image is fetched from the server using a
> "get_size" method.  The same method is used for getting the size of
> a snapshot, so structure this addition with a generic helper routine
> that we can get this information for either.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   53
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 019e695..24d12e3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2123,6 +2123,47 @@ static char *rbd_dev_v1_snap_info(struct
> rbd_device *rbd_dev, u32 which,
>   }
>
>   /*
> + * Get the size and object order for an image snapshot, or if
> + * snap_id is CEPH_NOSNAP, gets this information for the base
> + * image.
> + */
> +static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
> +				u8 *order, u64 *snap_size)
> +{
> +	__le64 snapid = cpu_to_le64(snap_id);
> +	int ret;
> +	struct {
> +		u8 order;
> +		__le64 size;
> +	} __attribute__ ((packed)) size_buf = { 0 };
> +
> +	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
> +				"rbd", "get_size",
> +				(char *) &snapid, sizeof (snapid),
> +				(char *) &size_buf, sizeof (size_buf),
> +				CEPH_OSD_FLAG_READ, NULL);
> +	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
> +	if (ret < 0)
> +		return ret;
> +
> +	*order = size_buf.order;
> +	*snap_size = le64_to_cpu(size_buf.size);
> +
> +	dout("  snap_id 0x%016llx order = %u, snap_size = %llu\n",
> +		(unsigned long long) snap_id, (unsigned int) *order,
> +		(unsigned long long) *snap_size);
> +
> +	return 0;
> +}
> +
> +static int rbd_dev_v2_image_size(struct rbd_device *rbd_dev)
> +{
> +	return _rbd_dev_v2_snap_size(rbd_dev, CEPH_NOSNAP,
> +					&rbd_dev->header.obj_order,
> +					&rbd_dev->header.image_size);
> +}
> +
> +/*
>    * Scan the rbd device's current snapshot list and compare it to the
>    * newly-received snapshot context.  Remove any existing snapshots
>    * not present in the new snapshot context.  Add a new snapshot for
> @@ -2631,6 +2672,7 @@ out_err:
>   static int rbd_dev_v2_probe(struct rbd_device *rbd_dev)
>   {
>   	size_t size;
> +	int ret;
>
>   	/*
>   	 * Image id was filled in by the caller.  Record the header
> @@ -2642,12 +2684,23 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>   		return -ENOMEM;
>   	sprintf(rbd_dev->header_name, "%s%s",
>   			RBD_HEADER_PREFIX, rbd_dev->image_id);
> +
> +	/* Get the size and object order for the image */
> +
> +	ret = rbd_dev_v2_image_size(rbd_dev);
> +	if (ret < 0)
> +		goto out_err;
>   	rbd_dev->image_format = 2;
>
>   	dout("discovered version 2 image, header name is %s\n",
>   		rbd_dev->header_name);
>
>   	return -ENOTSUPP;
> +out_err:
> +	kfree(rbd_dev->header_name);
> +	rbd_dev->header_name = NULL;
> +
> +	return ret;
>   }
>
>   /*
>

