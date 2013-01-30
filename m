From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/4] rbd: decrement obj request count when deleting
Date: Wed, 30 Jan 2013 11:30:54 -0800
Message-ID: <510974EE.1040305@inktank.com>
References: <51043EF2.4070305@inktank.com> <51043F64.6020800@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40698 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738Ab3A3TbI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 14:31:08 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so1266915pad.9
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 11:31:07 -0800 (PST)
In-Reply-To: <51043F64.6020800@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/26/2013 12:41 PM, Alex Elder wrote:
> Decrement the obj_request_count value when deleting an object
> request from its image request's list.  Rearrange a few lines
> in the surrounding code.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4e78402..340773f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1071,22 +1071,29 @@ static void rbd_img_request_put(struct
> rbd_img_request *img_request)
>   static inline void rbd_img_obj_request_add(struct rbd_img_request
> *img_request,
>   					struct rbd_obj_request *obj_request)
>   {
> +	rbd_assert(obj_request->img_request == NULL);
> +
>   	rbd_obj_request_get(obj_request);
>   	obj_request->img_request = img_request;
> -	list_add_tail(&obj_request->links, &img_request->obj_requests);
> -	obj_request->which = img_request->obj_request_count++;
> +	obj_request->which = img_request->obj_request_count;
>   	rbd_assert(obj_request->which != BAD_WHICH);
> +	img_request->obj_request_count++;
> +	list_add_tail(&obj_request->links, &img_request->obj_requests);
>   }
>
>   static inline void rbd_img_obj_request_del(struct rbd_img_request
> *img_request,
>   					struct rbd_obj_request *obj_request)
>   {
>   	rbd_assert(obj_request->which != BAD_WHICH);
> -	obj_request->which = BAD_WHICH;
> +
>   	list_del(&obj_request->links);
> +	rbd_assert(img_request->obj_request_count > 0);
> +	img_request->obj_request_count--;
> +	rbd_assert(obj_request->which == img_request->obj_request_count);
> +	obj_request->which = BAD_WHICH;
>   	rbd_assert(obj_request->img_request == img_request);
> -	obj_request->callback = NULL;
>   	obj_request->img_request = NULL;
> +	obj_request->callback = NULL;
>   	rbd_obj_request_put(obj_request);
>   }
>
> @@ -1482,6 +1489,7 @@ static void rbd_img_request_destroy(struct kref *kref)
>
>   	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
>   		rbd_img_obj_request_del(img_request, obj_request);
> +	rbd_assert(img_request->obj_request_count == 0);
>
>   	if (img_request->write_request)
>   		ceph_put_snap_context(img_request->snapc);
>

