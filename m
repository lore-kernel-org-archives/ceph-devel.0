From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/7] rbd: use rbd_warn(), not WARN_ON()
Date: Mon, 29 Apr 2013 08:36:54 -0700
Message-ID: <517E9396.9060008@inktank.com>
References: <517AC047.6060000@inktank.com> <517AC0B7.9010006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:49823 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab3D2Pgf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:36:35 -0400
Received: by mail-da0-f50.google.com with SMTP id a4so2943489dad.23
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:36:34 -0700 (PDT)
In-Reply-To: <517AC0B7.9010006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 11:00 AM, Alex Elder wrote:
> Change some calls to WARN_ON() so they use rbd_warn() instead, so we
> get consistent messaging.  A few remain but they can probably just
> go away eventually.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fd4f678..fe84975 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -777,7 +777,6 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>   			header->snap_sizes[i] =
>   				le64_to_cpu(ondisk->snaps[i].image_size);
>   	} else {
> -		WARN_ON(ondisk->snap_names_len);
>   		header->snap_names = NULL;
>   		header->snap_sizes = NULL;
>   	}
> @@ -2755,8 +2754,11 @@ static void rbd_request_fn(struct request_queue *q)
>   		}
>
>   		result = -EINVAL;
> -		if (WARN_ON(offset && length > U64_MAX - offset + 1))
> +		if (offset && length > U64_MAX - offset + 1) {
> +			rbd_warn(rbd_dev, "bad request range (%llu~%llu)\n",
> +				offset, length);
>   			goto end_request;	/* Shouldn't happen */
> +		}
>
>   		result = -ENOMEM;
>   		img_request = rbd_img_request_create(rbd_dev, offset, length,
> @@ -2955,7 +2957,7 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
> u64 *version)
>   				       0, size, ondisk, version);
>   		if (ret < 0)
>   			goto out_err;
> -		if (WARN_ON((size_t) ret < size)) {
> +		if ((size_t)ret < size) {
>   			ret = -ENXIO;
>   			rbd_warn(rbd_dev, "short header read (want %zd got %d)",
>   				size, ret);
> @@ -3057,7 +3059,8 @@ static int rbd_dev_v1_refresh(struct rbd_device
> *rbd_dev, u64 *hver)
>   	rbd_dev->header.snap_names = h.snap_names;
>   	rbd_dev->header.snap_sizes = h.snap_sizes;
>   	/* Free the extra copy of the object prefix */
> -	WARN_ON(strcmp(rbd_dev->header.object_prefix, h.object_prefix));
> +	if (strcmp(rbd_dev->header.object_prefix, h.object_prefix))
> +		rbd_warn(rbd_dev, "object prefix changed (ignoring)");
>   	kfree(h.object_prefix);
>
>   	ret = rbd_dev_snaps_update(rbd_dev);
> @@ -3627,8 +3630,11 @@ static int rbd_dev_v2_parent_info(struct
> rbd_device *rbd_dev)
>   	/* The ceph file layout needs to fit pool id in 32 bits */
>
>   	ret = -EIO;
> -	if (WARN_ON(parent_spec->pool_id > (u64)U32_MAX))
> +	if (parent_spec->pool_id > (u64)U32_MAX) {
> +		rbd_warn(NULL, "parent pool id too large (%llu > %u)\n",
> +			(unsigned long long)parent_spec->pool_id, U32_MAX);
>   		goto out_err;
> +	}
>
>   	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
>   	if (IS_ERR(image_id)) {
> @@ -4859,11 +4865,13 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	rc = ceph_pg_poolid_by_name(osdc->osdmap, spec->pool_name);
>   	if (rc < 0)
>   		goto err_out_client;
> -	spec->pool_id = (u64) rc;
> +	spec->pool_id = (u64)rc;
>
>   	/* The ceph file layout needs to fit pool id in 32 bits */
>
> -	if (WARN_ON(spec->pool_id > (u64) U32_MAX)) {
> +	if (spec->pool_id > (u64)U32_MAX) {
> +		rbd_warn(NULL, "pool id too large (%llu > %u)\n",
> +				(unsigned long long)spec->pool_id, U32_MAX);
>   		rc = -EIO;
>   		goto err_out_client;
>   	}
> @@ -4897,7 +4905,7 @@ err_out_module:
>
>   	dout("Error adding device %s\n", buf);
>
> -	return (ssize_t) rc;
> +	return (ssize_t)rc;
>   }
>
>   static struct rbd_device *__rbd_get_dev(unsigned long dev_id)
>

