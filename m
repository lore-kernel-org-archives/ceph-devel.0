From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: fix error paths in rbd_img_request_fill()
Date: Mon, 03 Mar 2014 15:59:52 -0600
Message-ID: <5314FB58.7030604@ieee.org>
References: <1393861102-5123-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:54372 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbaCCWAX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 17:00:23 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so4230278pdj.17
        for <ceph-devel@vger.kernel.org>; Mon, 03 Mar 2014 14:00:22 -0800 (PST)
In-Reply-To: <1393861102-5123-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/03/2014 09:38 AM, Ilya Dryomov wrote:
> Doing rbd_obj_request_put() in rbd_img_request_fill() error paths is
> not only insufficient, but also triggers an rbd_assert() in
> rbd_obj_request_destroy():
>
> Assertion failure in rbd_obj_request_destroy() at line 1867:
> rbd_assert(obj_request->img_request == NULL);

Does this have a tracker entry separate from 7327?  (I
didn't look, just curious.)

> rbd_img_obj_request_add() adds obj_requests to the img_request, the
> opposite is rbd_img_obj_request_del().  Use it.h

This is the main bug here, and this is the right fix.

> While at it, commit 03507db631c94 ("rbd: fix buffer size for writes to
> images with snapshots") moved the call to rbd_img_obj_request_add() up,
> making the out_partial label bogus.  Remove it.

Yes, this is also correct, and is a bug fix.  Since it's a distinct
bug *maybe* you could commit it separately, but I don't really think
it's that important.

Very nice.

Reviewed-by: Alex Elder <elder@linaro.org>

> Fixes: http://tracker.ceph.com/issues/7327
>
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>   drivers/block/rbd.c |    9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b365e0dfccb6..53d492e83586 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2191,6 +2191,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>   		rbd_segment_name_free(object_name);
>   		if (!obj_request)
>   			goto out_unwind;
> +
>   		/*
>   		 * set obj_request->img_request before creating the
>   		 * osd_request so that it gets the right snapc
> @@ -2208,7 +2209,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>   								clone_size,
>   								GFP_ATOMIC);
>   			if (!obj_request->bio_list)
> -				goto out_partial;
> +				goto out_unwind;
>   		} else {
>   			unsigned int page_count;
>
> @@ -2223,7 +2224,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>   		osd_req = rbd_osd_req_create(rbd_dev, write_request,
>   						obj_request);
>   		if (!osd_req)
> -			goto out_partial;
> +			goto out_unwind;
>   		obj_request->osd_req = osd_req;
>   		obj_request->callback = rbd_img_obj_callback;
>
> @@ -2250,11 +2251,9 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>
>   	return 0;
>
> -out_partial:
> -	rbd_obj_request_put(obj_request);
>   out_unwind:
>   	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
> -		rbd_obj_request_put(obj_request);
> +		rbd_img_obj_request_del(img_request, obj_request);
>
>   	return -ENOMEM;
>   }
>

