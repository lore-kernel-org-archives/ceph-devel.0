From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/5, v2] rbd: get parent info on refresh
Date: Mon, 13 May 2013 12:34:32 -0700
Message-ID: <51914048.1080007@inktank.com>
References: <518E831E.6000206@inktank.com> <518E8357.7010506@inktank.com> <518EB11D.9050600@inktank.com> <519129D4.30109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56606 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab3EMTfp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 15:35:45 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so4887089pab.31
        for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 12:35:44 -0700 (PDT)
In-Reply-To: <519129D4.30109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/13/2013 10:58 AM, Alex Elder wrote:
> Get parent info for format 2 images on every refresh (rather than
> just during the initial probe).  This will be needed to detect the
> disappearance of the parent image in the event a mapped image
> becomes unlayered (i.e., flattened).  Avoid leaking the previous
> parent spec on the second and subsequent times this information is
> requested by dropping the previous one (if any) before updating it.
> (Also, extract the pool id into a local variable before assigning
> it into the parent spec.)
>
> Switch to using a non-zero parent overlap value rather than the
> existence of a parent (a non-null parent_spec pointer) to determine
> whether to mark a request layered.  It will soon be possible for
> a layered image to become unlayered while a request is in flight.
>
> This means that the layered flag for an image request indicates that
> there was a non-zero parent overlap at the time the image request
> was created.  The parent overlap can change thereafter, which may
> lead to special handling at request submission or completion time.
>
> This and the next several patches are related to:
>      http://tracker.ceph.com/issues/3763
>
> NOTE:
> If an error occurs while refreshing the parent info (i.e.,
> requesting it after initial probe), the old parent info will
> persist.  This is not really correct, and is a scenario that needs
> to be addressed.  For now we'll assert that the failure mode is
> unlikely, but the issue has been documented in tracker issue 5040.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v2: no longer clean up rbd_dev and header on error in refresh
>
>   drivers/block/rbd.c |   67
> ++++++++++++++++++++++++++++-----------------------
>   1 file changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b67ecda..fcef63c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1873,7 +1873,7 @@ static struct rbd_img_request *rbd_img_request_create(
>   	}
>   	if (child_request)
>   		img_request_child_set(img_request);
> -	if (rbd_dev->parent_spec)
> +	if (rbd_dev->parent_overlap)
>   		img_request_layered_set(img_request);
>   	spin_lock_init(&img_request->completion_lock);
>   	img_request->next_completion = 0;
> @@ -3613,6 +3613,7 @@ static int rbd_dev_v2_parent_info(struct
> rbd_device *rbd_dev)
>   	__le64 snapid;
>   	void *p;
>   	void *end;
> +	u64 pool_id;
>   	char *image_id;
>   	u64 overlap;
>   	int ret;
> @@ -3643,18 +3644,19 @@ static int rbd_dev_v2_parent_info(struct
> rbd_device *rbd_dev)
>   	p = reply_buf;
>   	end = reply_buf + ret;
>   	ret = -ERANGE;
> -	ceph_decode_64_safe(&p, end, parent_spec->pool_id, out_err);
> -	if (parent_spec->pool_id == CEPH_NOPOOL)
> +	ceph_decode_64_safe(&p, end, pool_id, out_err);
> +	if (pool_id == CEPH_NOPOOL)
>   		goto out;	/* No parent?  No problem. */
>
>   	/* The ceph file layout needs to fit pool id in 32 bits */
>
>   	ret = -EIO;
> -	if (parent_spec->pool_id > (u64)U32_MAX) {
> +	if (pool_id > (u64)U32_MAX) {
>   		rbd_warn(NULL, "parent pool id too large (%llu > %u)\n",
> -			(unsigned long long)parent_spec->pool_id, U32_MAX);
> +			(unsigned long long)pool_id, U32_MAX);
>   		goto out_err;
>   	}
> +	parent_spec->pool_id = pool_id;
>
>   	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
>   	if (IS_ERR(image_id)) {
> @@ -3666,6 +3668,7 @@ static int rbd_dev_v2_parent_info(struct
> rbd_device *rbd_dev)
>   	ceph_decode_64_safe(&p, end, overlap, out_err);
>
>   	if (overlap) {
> +		rbd_spec_put(rbd_dev->parent_spec);
>   		rbd_dev->parent_spec = parent_spec;
>   		parent_spec = NULL;	/* rbd_dev now owns this */
>   		rbd_dev->parent_overlap = overlap;
> @@ -4034,17 +4037,43 @@ static int rbd_dev_v2_header_info(struct
> rbd_device *rbd_dev)
>   			goto out;
>   	}
>
> +	/*
> +	 * If the image supports layering, get the parent info.  We
> +	 * need to probe the first time regardless.  Thereafter we
> +	 * only need to if there's a parent, to see if it has
> +	 * disappeared due to the mapped image getting flattened.
> +	 */
> +	if (rbd_dev->header.features & RBD_FEATURE_LAYERING &&
> +			(first_time || rbd_dev->parent_spec)) {
> +		bool warn;
> +
> +		ret = rbd_dev_v2_parent_info(rbd_dev);
> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * Print a warning if this is the initial probe and
> +		 * the image has a parent.  Don't print it if the
> +		 * image now being probed is itself a parent.  We
> +		 * can tell at this point because we won't know its
> +		 * pool name yet (just its pool id).
> +		 */
> +		warn = rbd_dev->parent_spec && rbd_dev->spec->pool_name;
> +		if (first_time && warn)
> +			rbd_warn(rbd_dev, "WARNING: kernel layering "
> +					"is EXPERIMENTAL!");
> +	}
> +
>   	ret = rbd_dev_v2_image_size(rbd_dev);
>   	if (ret)
>   		goto out;
> +
>   	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
>   		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
>   			rbd_dev->mapping.size = rbd_dev->header.image_size;
>
>   	ret = rbd_dev_v2_snap_context(rbd_dev);
>   	dout("rbd_dev_v2_snap_context returned %d\n", ret);
> -	if (ret)
> -		goto out;
>   out:
>   	up_write(&rbd_dev->header_rwsem);
>
> @@ -4498,24 +4527,6 @@ static int rbd_dev_v2_header_onetime(struct
> rbd_device *rbd_dev)
>   	if (ret)
>   		goto out_err;
>
> -	/* If the image supports layering, get the parent info */
> -
> -	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
> -		ret = rbd_dev_v2_parent_info(rbd_dev);
> -		if (ret)
> -			goto out_err;
> -		/*
> -		 * Print a warning if this image has a parent.
> -		 * Don't print it if the image now being probed
> -		 * is itself a parent.  We can tell at this point
> -		 * because we won't know its pool name yet (just its
> -		 * pool id).
> -		 */
> -		if (rbd_dev->parent_spec && rbd_dev->spec->pool_name)
> -			rbd_warn(rbd_dev, "WARNING: kernel layering "
> -					"is EXPERIMENTAL!");
> -	}
> -
>   	/* If the image supports fancy striping, get its parameters */
>
>   	if (rbd_dev->header.features & RBD_FEATURE_STRIPINGV2) {
> @@ -4527,11 +4538,7 @@ static int rbd_dev_v2_header_onetime(struct
> rbd_device *rbd_dev)
>
>   	return 0;
>   out_err:
> -	rbd_dev->parent_overlap = 0;
> -	rbd_spec_put(rbd_dev->parent_spec);
> -	rbd_dev->parent_spec = NULL;
> -	kfree(rbd_dev->header_name);
> -	rbd_dev->header_name = NULL;
> +	rbd_dev->header.features = 0;
>   	kfree(rbd_dev->header.object_prefix);
>   	rbd_dev->header.object_prefix = NULL;
>

