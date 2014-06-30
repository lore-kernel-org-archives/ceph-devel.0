From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: handle parent_overlap on writes correctly
Date: Mon, 30 Jun 2014 07:14:38 -0500
Message-ID: <53B154AE.5050705@ieee.org>
References: <1402504849-9958-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:42416 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635AbaF3MOc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 08:14:32 -0400
Received: by mail-ig0-f172.google.com with SMTP id hn18so4221624igb.11
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 05:14:31 -0700 (PDT)
In-Reply-To: <1402504849-9958-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/11/2014 11:40 AM, Ilya Dryomov wrote:
> The following check in rbd_img_obj_request_submit()
> 
>     rbd_dev->parent_overlap <= obj_request->img_offset
> 
> allows the fall through to the non-layered write case even if both
> parent_overlap and obj_request->img_offset belong to the same RADOS
> object.  This leads to data corruption, because the area to the left of
> parent_overlap ends up unconditionally zero-filled instead of being
> populated with parent data.  Suppose we want to write 1M to offset 6M
> of image bar, which is a clone of foo@snap; object_size is 4M,
> parent_overlap is 5M:
> 
>     rbd_data.<id>.0000000000000001
>      ---------------------|----------------------|------------
>     | should be copyup'ed | should be zeroed out | write ...
>      ---------------------|----------------------|------------
>    4M                    5M                     6M
>                     parent_overlap    obj_request->img_offset
> 
> 4..5M should be copyup'ed from foo, yet it is zero-filled, just like
> 5..6M is.
> 
> Given that the only striping mode kernel client currently supports is
> chunking (i.e. stripe_unit == object_size, stripe_count == 1), round
> parent_overlap up to the next object boundary for the purposes of the
> overlap check.

I know Josh already reviewed this, but I wanted to make sure
I understood it.  Now I do.

Previously the first layered write request starting at the
"should be zeroed out" region would be treated as a normal
write.  Consequently the child object would get created, but
only the affected portion would get written, meaning the
"should be copyup'ed" region in the child object would be
zero filled.  Later reads to the "should be copyup'ed" would
see that child object existed, so the parent data will never
get filled into the "should be copyup'ed" area as it must be.

Rounding up like you did for this test makes sense--it makes
the granularity of this overlap test match the granularity
of the "exists" test.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8295b3afa8e0..813e673d49df 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1366,6 +1366,14 @@ static bool obj_request_exists_test(struct rbd_obj_request *obj_request)
>  	return test_bit(OBJ_REQ_EXISTS, &obj_request->flags) != 0;
>  }
>  
> +static bool obj_request_overlaps_parent(struct rbd_obj_request *obj_request)
> +{
> +	struct rbd_device *rbd_dev = obj_request->img_request->rbd_dev;
> +
> +	return obj_request->img_offset <
> +	    round_up(rbd_dev->parent_overlap, rbd_obj_bytes(&rbd_dev->header));
> +}
> +
>  static void rbd_obj_request_get(struct rbd_obj_request *obj_request)
>  {
>  	dout("%s: obj %p (was %d)\n", __func__, obj_request,
> @@ -2683,7 +2691,7 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
>  	 */
>  	if (!img_request_write_test(img_request) ||
>  		!img_request_layered_test(img_request) ||
> -		rbd_dev->parent_overlap <= obj_request->img_offset ||
> +		!obj_request_overlaps_parent(obj_request) ||
>  		((known = obj_request_known_test(obj_request)) &&
>  			obj_request_exists_test(obj_request))) {
>  
> 

