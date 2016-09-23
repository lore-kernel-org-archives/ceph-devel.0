From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 1/8] rbd: change rbd_obj_request_submit() signature
Date: Fri, 23 Sep 2016 10:38:20 -0500
Message-ID: <8a64ea11-c6c2-83be-f49f-31a0ac371384@linaro.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33742 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965902AbcIWPiY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2016 11:38:24 -0400
Received: by mail-io0-f181.google.com with SMTP id r145so122060662ior.0
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2016 08:38:23 -0700 (PDT)
In-Reply-To: <1474304608-17958-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> - osdc parameter is useless
> - starting with commit 5aea3dcd5021 ("libceph: a major OSD client
>   update"), ceph_osdc_start_request() always returns success

Then ceph_osdc_start_request() should probably be made a
void function as well.  I know it's called all over the
place.

But this is a nice cleanup.

Reviewed-by: Alex Elder <elder@linaro.org>


> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 70 ++++++++++++++++++-----------------------------------
>  1 file changed, 23 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 82569e65d61b..d8b702e3c4d9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1610,11 +1610,12 @@ static bool obj_request_type_valid(enum obj_request_type type)
>  	}
>  }
>  
> -static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
> -				struct rbd_obj_request *obj_request)
> +static void rbd_obj_request_submit(struct rbd_obj_request *obj_request)
>  {
> -	dout("%s %p\n", __func__, obj_request);
> -	return ceph_osdc_start_request(osdc, obj_request->osd_req, false);
> +	struct ceph_osd_request *osd_req = obj_request->osd_req;
> +
> +	dout("%s %p osd_req %p\n", __func__, obj_request, osd_req);
> +	ceph_osdc_start_request(osd_req->r_osdc, osd_req, false);
>  }
>  
>  static void rbd_obj_request_end(struct rbd_obj_request *obj_request)
> @@ -2638,7 +2639,6 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  {
>  	struct rbd_obj_request *orig_request;
>  	struct ceph_osd_request *osd_req;
> -	struct ceph_osd_client *osdc;
>  	struct rbd_device *rbd_dev;
>  	struct page **pages;
>  	enum obj_operation_type op_type;
> @@ -2675,13 +2675,9 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  	 * and re-submit the original write request.
>  	 */
>  	if (!rbd_dev->parent_overlap) {
> -		struct ceph_osd_client *osdc;
> -
>  		ceph_release_page_vector(pages, page_count);
> -		osdc = &rbd_dev->rbd_client->client->osdc;
> -		img_result = rbd_obj_request_submit(osdc, orig_request);
> -		if (!img_result)
> -			return;
> +		rbd_obj_request_submit(orig_request);
> +		return;
>  	}
>  
>  	if (img_result)
> @@ -2715,10 +2711,9 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  
>  	/* All set, send it off. */
>  
> -	osdc = &rbd_dev->rbd_client->client->osdc;
> -	img_result = rbd_obj_request_submit(osdc, orig_request);
> -	if (!img_result)
> -		return;
> +	rbd_obj_request_submit(orig_request);
> +	return;
> +
>  out_err:
>  	/* Record the error code and complete the request */
>  
> @@ -2852,17 +2847,13 @@ static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
>  
>  	/*
>  	 * If the overlap has become 0 (most likely because the
> -	 * image has been flattened) we need to free the pages
> -	 * and re-submit the original write request.
> +	 * image has been flattened) we need to re-submit the
> +	 * original request.
>  	 */
>  	rbd_dev = orig_request->img_request->rbd_dev;
>  	if (!rbd_dev->parent_overlap) {
> -		struct ceph_osd_client *osdc;
> -
> -		osdc = &rbd_dev->rbd_client->client->osdc;
> -		result = rbd_obj_request_submit(osdc, orig_request);
> -		if (!result)
> -			return;
> +		rbd_obj_request_submit(orig_request);
> +		return;
>  	}
>  
>  	/*
> @@ -2894,7 +2885,6 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  {
>  	struct rbd_obj_request *stat_request;
>  	struct rbd_device *rbd_dev;
> -	struct ceph_osd_client *osdc;
>  	struct page **pages = NULL;
>  	u32 page_count;
>  	size_t size;
> @@ -2938,8 +2928,9 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  					false, false);
>  	rbd_osd_req_format_read(stat_request);
>  
> -	osdc = &rbd_dev->rbd_client->client->osdc;
> -	ret = rbd_obj_request_submit(osdc, stat_request);
> +	rbd_obj_request_submit(stat_request);
> +	return 0;
> +
>  out:
>  	if (ret)
>  		rbd_obj_request_put(obj_request);
> @@ -2996,13 +2987,8 @@ static bool img_obj_request_simple(struct rbd_obj_request *obj_request)
>  static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
>  {
>  	if (img_obj_request_simple(obj_request)) {
> -		struct rbd_device *rbd_dev;
> -		struct ceph_osd_client *osdc;
> -
> -		rbd_dev = obj_request->img_request->rbd_dev;
> -		osdc = &rbd_dev->rbd_client->client->osdc;
> -
> -		return rbd_obj_request_submit(osdc, obj_request);
> +		rbd_obj_request_submit(obj_request);
> +		return 0;
>  	}
>  
>  	/*
> @@ -3065,12 +3051,8 @@ static void rbd_img_parent_read_callback(struct rbd_img_request *img_request)
>  	rbd_assert(obj_request->img_request);
>  	rbd_dev = obj_request->img_request->rbd_dev;
>  	if (!rbd_dev->parent_overlap) {
> -		struct ceph_osd_client *osdc;
> -
> -		osdc = &rbd_dev->rbd_client->client->osdc;
> -		img_result = rbd_obj_request_submit(osdc, obj_request);
> -		if (!img_result)
> -			return;
> +		rbd_obj_request_submit(obj_request);
> +		return;
>  	}
>  
>  	obj_request->result = img_result;
> @@ -3997,7 +3979,6 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
>  			     void *inbound,
>  			     size_t inbound_size)
>  {
> -	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>  	struct rbd_obj_request *obj_request;
>  	struct page **pages;
>  	u32 page_count;
> @@ -4048,9 +4029,7 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
>  					0, false, false);
>  	rbd_osd_req_format_read(obj_request);
>  
> -	ret = rbd_obj_request_submit(osdc, obj_request);
> -	if (ret)
> -		goto out;
> +	rbd_obj_request_submit(obj_request);
>  	ret = rbd_obj_request_wait(obj_request);
>  	if (ret)
>  		goto out;
> @@ -4255,7 +4234,6 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
>  				u64 offset, u64 length, void *buf)
>  
>  {
> -	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>  	struct rbd_obj_request *obj_request;
>  	struct page **pages = NULL;
>  	u32 page_count;
> @@ -4290,9 +4268,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
>  					false, false);
>  	rbd_osd_req_format_read(obj_request);
>  
> -	ret = rbd_obj_request_submit(osdc, obj_request);
> -	if (ret)
> -		goto out;
> +	rbd_obj_request_submit(obj_request);
>  	ret = rbd_obj_request_wait(obj_request);
>  	if (ret)
>  		goto out;
> 

