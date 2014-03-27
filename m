From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/3 v2] rbd: skip the copyup when an entire object writing
Date: Thu, 27 Mar 2014 14:48:26 -0700
Message-ID: <53349CAA.3020809@inktank.com>
References: <1394680896-8554-1-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:43092 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbaC0VvJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 17:51:09 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so3941020pdi.30
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 14:51:08 -0700 (PDT)
In-Reply-To: <1394680896-8554-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: elder@ieee.org

On 03/12/2014 08:21 PM, Guangliang Zhao wrote:
> It need to copyup the parent's content when layered writing,
> but an entire object write would overwrite it, so skip it.
>
> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> ---

This looks good to me. This situation is unlikely with normal I/O, but
discards done e.g. by mkfs are more likely to benefit from this
optimization. Nice refactoring of that conditional too (thanks for
suggesting that Alex)!

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |   49 ++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 34 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b365e0d..2d48858 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2624,34 +2624,53 @@ out:
>   	return ret;
>   }
>
> -static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
> +static bool rbd_obj_request_simple(struct rbd_obj_request *obj_request)
>   {
>   	struct rbd_img_request *img_request;
>   	struct rbd_device *rbd_dev;
> -	bool known;
> +	u64 obj_size;
>
>   	rbd_assert(obj_request_img_data_test(obj_request));
>
>   	img_request = obj_request->img_request;
>   	rbd_assert(img_request);
>   	rbd_dev = img_request->rbd_dev;
> +	obj_size = (u64) 1 << rbd_dev->header.obj_order;
>
> +	/* Read requests didn't need special handling */
> +	if (!img_request_write_test(img_request))
> +		return true;
> +	/* No-layered writes are simple requests*/
> +	if (!img_request_layered_test(img_request))
> +		return true;
>   	/*
> -	 * Only writes to layered images need special handling.
> -	 * Reads and non-layered writes are simple object requests.
>   	 * Layered writes that start beyond the end of the overlap
> -	 * with the parent have no parent data, so they too are
> -	 * simple object requests.  Finally, if the target object is
> -	 * known to already exist, its parent data has already been
> -	 * copied, so a write to the object can also be handled as a
> -	 * simple object request.
> +	 * with the parent have no parent data, so they are simple
> +	 * object requests.
>   	 */
> -	if (!img_request_write_test(img_request) ||
> -		!img_request_layered_test(img_request) ||
> -		rbd_dev->parent_overlap <= obj_request->img_offset ||
> -		((known = obj_request_known_test(obj_request)) &&
> -			obj_request_exists_test(obj_request))) {
> +	if (rbd_dev->parent_overlap <= obj_request->img_offset)
> +		return true;
> +	/*
> +	 * If the obj_request aligns with the boundary and equals
> +	 * to the size of an object, it doesn't need copyup, because
> +	 * the obj_request will overwrite it finally.
> +	 */
> +	if ((!obj_request->offset) && (obj_request->length == obj_size))
> +		return true;
> +	/*
> +	 * If the target object is known to already exist, its parent
> +	 * data has already been copied, so a write to the object can
> +	 * also be handled as a simple object request
> +	 */
> +	if (obj_request_known_test(obj_request) &&
> +			obj_request_exists_test(obj_request))
> +		return true;
> +	return false;
> +}
>
> +static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
> +{
> +	if (rbd_obj_request_simple(obj_request)) {
>   		struct rbd_device *rbd_dev;
>   		struct ceph_osd_client *osdc;
>
> @@ -2667,7 +2686,7 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
>   	 * start by reading the data for the full target object from
>   	 * the parent so we can use it for a copyup to the target.
>   	 */
> -	if (known)
> +	if (obj_request_known_test(obj_request))
>   		return rbd_img_obj_parent_read_full(obj_request);
>
>   	/* We don't know whether the target exists.  Go find out. */
>

