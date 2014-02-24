From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 5/6] rbd: num_ops parameter for rbd_osd_req_create()
Date: Mon, 24 Feb 2014 08:59:15 -0600
Message-ID: <530B5E43.9090007@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <1393008946-7931-6-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:61522 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXO7N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 09:59:13 -0500
Received: by mail-ie0-f171.google.com with SMTP id to1so3554481ieb.2
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 06:59:13 -0800 (PST)
In-Reply-To: <1393008946-7931-6-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
> In preparation for prefixing rbd writes with an allocation hint
> introduce a num_ops parameter for rbd_osd_req_create().  The rationale
> is that not every write request is a write op that needs to be prefixed
> (e.g. watch op), so the num_ops logic needs to be in the callers.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c |   28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 48a889866824..6cf001ef00bc 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1718,6 +1718,7 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
>  static struct ceph_osd_request *rbd_osd_req_create(
>  					struct rbd_device *rbd_dev,
>  					bool write_request,
> +					unsigned int num_ops,
>  					struct rbd_obj_request *obj_request)
>  {
>  	struct ceph_snap_context *snapc = NULL;
> @@ -1733,10 +1734,13 @@ static struct ceph_osd_request *rbd_osd_req_create(
>  			snapc = img_request->snapc;
>  	}
>  
> -	/* Allocate and initialize the request, for the single op */
> +	rbd_assert(num_ops == 1);
> +
> +	/* Allocate and initialize the request, for the num_ops ops */
>  
>  	osdc = &rbd_dev->rbd_client->client->osdc;
> -	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
> +	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_ops, false,
> +					  GFP_ATOMIC);
>  	if (!osd_req)
>  		return NULL;	/* ENOMEM */
>  
> @@ -2220,8 +2224,8 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  			pages += page_count;
>  		}
>  
> -		osd_req = rbd_osd_req_create(rbd_dev, write_request,
> -						obj_request);
> +		osd_req = rbd_osd_req_create(rbd_dev, write_request, 1,
> +					     obj_request);
>  		if (!osd_req)
>  			goto out_partial;
>  		obj_request->osd_req = osd_req;
> @@ -2604,8 +2608,8 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  
>  	rbd_assert(obj_request->img_request);
>  	rbd_dev = obj_request->img_request->rbd_dev;
> -	stat_request->osd_req = rbd_osd_req_create(rbd_dev, false,
> -						stat_request);
> +	stat_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
> +						   stat_request);
>  	if (!stat_request->osd_req)
>  		goto out;
>  	stat_request->callback = rbd_img_obj_exists_callback;
> @@ -2808,7 +2812,8 @@ static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
>  		return -ENOMEM;
>  
>  	ret = -ENOMEM;
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
> +						  obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
>  
> @@ -2871,7 +2876,8 @@ static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
>  	if (!obj_request)
>  		goto out_cancel;
>  
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
> +						  obj_request);
>  	if (!obj_request->osd_req)
>  		goto out_cancel;
>  
> @@ -2979,7 +2985,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
>  	obj_request->pages = pages;
>  	obj_request->page_count = page_count;
>  
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
> +						  obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
>  
> @@ -3212,7 +3219,8 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
>  	obj_request->pages = pages;
>  	obj_request->page_count = page_count;
>  
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
> +						  obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
>  
> 

