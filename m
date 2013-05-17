From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH, v2] rbd: drop original request earlier for existence
 check
Date: Thu, 16 May 2013 18:42:50 -0700
Message-ID: <51958B1A.2090407@inktank.com>
References: <519195DC.1060609@inktank.com> <51954FB1.9060902@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:36489 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3EQBoI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 21:44:08 -0400
Received: by mail-da0-f49.google.com with SMTP id p5so2032656dak.36
        for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 18:44:07 -0700 (PDT)
In-Reply-To: <51954FB1.9060902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/16/2013 02:29 PM, Alex Elder wrote:
> The reference to the original request dropped at the end of
> rbd_img_obj_exists_callback() corresponds to the reference taken
> in rbd_img_obj_exists_submit() to account for the stat request
> referring to it.  Move the put of that reference up right after
> clearing that pointer to make its purpose more obvious.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v2: rebased to reflect changes in earlier patches
>
>   drivers/block/rbd.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fdbcf04..b4c5e47 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2529,6 +2529,7 @@ static void rbd_img_obj_exists_callback(struct
> rbd_obj_request *obj_request)
>   	 */
>   	orig_request = obj_request->obj_request;
>   	obj_request->obj_request = NULL;
> +	rbd_obj_request_put(orig_request);
>   	rbd_assert(orig_request);
>   	rbd_assert(orig_request->img_request);
>
> @@ -2549,7 +2550,6 @@ static void rbd_img_obj_exists_callback(struct
> rbd_obj_request *obj_request)
>   	if (!rbd_dev->parent_overlap) {
>   		struct ceph_osd_client *osdc;
>
> -		rbd_obj_request_put(orig_request);
>   		osdc = &rbd_dev->rbd_client->client->osdc;
>   		result = rbd_obj_request_submit(osdc, orig_request);
>   		if (!result)
> @@ -2579,7 +2579,6 @@ static void rbd_img_obj_exists_callback(struct
> rbd_obj_request *obj_request)
>   out:
>   	if (orig_request->result)
>   		rbd_obj_request_complete(orig_request);
> -	rbd_obj_request_put(orig_request);
>   }
>
>   static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>

