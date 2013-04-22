From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: get and check striping parameters
Date: Mon, 22 Apr 2013 15:19:40 -0700
Message-ID: <5175B77C.8040600@inktank.com>
References: <51745788.5060109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:44743 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab3DVWU0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 18:20:26 -0400
Received: by mail-pa0-f53.google.com with SMTP id bh4so44993pad.12
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 15:20:25 -0700 (PDT)
In-Reply-To: <51745788.5060109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/21/2013 02:18 PM, Alex Elder wrote:
> If an rbd format 2 image indicates it supports the STRIPINGV2
> feature we need to find out its stripe unit and stripe count in
> order to know whether we can use it.  We don't yet support fancy
> striping fully, but if the default parameters are used the behavior
> is indistinguishible from non-fancy striping.
>
> This is necessary because some images require the STRIPINGV2 feature
> even if they use the default parameters.  (Which is to say the feature
> bit was erroneously set even if the feature was not used.)
>
> This resolves:
>      http://tracker.ceph.com/issues/4709
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   61
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3013cdb0..d23cc8f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -317,6 +317,9 @@ struct rbd_device {
>   	u64			parent_overlap;
>   	struct rbd_device	*parent;
>
> +	u64			stripe_unit;
> +	u64			stripe_count;
> +
>   	/* protects updating the header */
>   	struct rw_semaphore     header_rwsem;
>
> @@ -3748,6 +3751,56 @@ out_err:
>   	return ret;
>   }
>
> +static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev)
> +{
> +	struct {
> +		__le64 stripe_unit;
> +		__le64 stripe_count;
> +	} __attribute__ ((packed)) striping_info_buf = { 0 };
> +	size_t size = sizeof (striping_info_buf);
> +	void *p;
> +	u64 obj_size;
> +	u64 stripe_unit;
> +	u64 stripe_count;
> +	int ret;
> +
> +	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
> +				"rbd", "get_stripe_unit_count", NULL, 0,
> +				(char *)&striping_info_buf, size, NULL);
> +	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
> +	if (ret < 0)
> +		return ret;
> +	if (ret < size)
> +		return -ERANGE;
> +
> +	/*
> +	 * We don't actually support the "fancy striping" feature
> +	 * (STRIPINGV2) yet, but if the striping sizes are the
> +	 * defaults the behavior is the same as before.  So find
> +	 * out, and only fail if the image has non-default values.
> +	 */
> +	ret = -EINVAL;
> +	obj_size = (u64)1 << rbd_dev->header.obj_order;
> +	p = &striping_info_buf;
> +	stripe_unit = ceph_decode_64(&p);
> +	if (stripe_unit != obj_size) {
> +		rbd_warn(rbd_dev, "unsupported stripe unit "
> +				"(got %llu want %llu)",
> +				stripe_unit, obj_size);
> +		return -EINVAL;
> +	}
> +	stripe_count = ceph_decode_64(&p);
> +	if (stripe_count != 1) {
> +		rbd_warn(rbd_dev, "unsupported stripe count "
> +				"(got %llu want 1)", stripe_count);
> +		return -EINVAL;
> +	}
> +	rbd_dev->stripe_unit = stripe_unit;
> +	rbd_dev->stripe_count = stripe_count;
> +
> +	return 0;
> +}
> +
>   static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
>   {
>   	size_t image_id_size;
> @@ -4672,6 +4725,14 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>   			goto out_err;
>   	}
>
> +	/* If the image supports fancy striping, get its parameters */
> +
> +	if (rbd_dev->header.features & RBD_FEATURE_STRIPINGV2) {
> +		ret = rbd_dev_v2_striping_info(rbd_dev);
> +		if (ret < 0)
> +			goto out_err;
> +	}
> +
>   	/* crypto and compression type aren't (yet) supported for v2 images */
>
>   	rbd_dev->header.crypt_type = 0;
>

