From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: handle parent_overlap on writes correctly
Date: Thu, 12 Jun 2014 18:26:40 -0700
Message-ID: <539A5350.1070706@inktank.com>
References: <1402504849-9958-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45733 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaFMB1D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jun 2014 21:27:03 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so2601060qae.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jun 2014 18:27:02 -0700 (PDT)
In-Reply-To: <1402504849-9958-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/11/2014 09:40 AM, Ilya Dryomov wrote:
> The following check in rbd_img_obj_request_submit()
>
>      rbd_dev->parent_overlap <= obj_request->img_offset
>
> allows the fall through to the non-layered write case even if both
> parent_overlap and obj_request->img_offset belong to the same RADOS
> object.  This leads to data corruption, because the area to the left of
> parent_overlap ends up unconditionally zero-filled instead of being
> populated with parent data.  Suppose we want to write 1M to offset 6M
> of image bar, which is a clone of foo@snap; object_size is 4M,
> parent_overlap is 5M:
>
>      rbd_data.<id>.0000000000000001
>       ---------------------|----------------------|------------
>      | should be copyup'ed | should be zeroed out | write ...
>       ---------------------|----------------------|------------
>     4M                    5M                     6M
>                      parent_overlap    obj_request->img_offset
>
> 4..5M should be copyup'ed from foo, yet it is zero-filled, just like
> 5..6M is.
>
> Given that the only striping mode kernel client currently supports is
> chunking (i.e. stripe_unit == object_size, stripe_count == 1), round
> parent_overlap up to the next object boundary for the purposes of the
> overlap check.
>
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---

Good catch! This should be included in any stable kernels 3.10 or later
too.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |   10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8295b3afa8e0..813e673d49df 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1366,6 +1366,14 @@ static bool obj_request_exists_test(struct rbd_obj_request *obj_request)
>   	return test_bit(OBJ_REQ_EXISTS, &obj_request->flags) != 0;
>   }
>
> +static bool obj_request_overlaps_parent(struct rbd_obj_request *obj_request)
> +{
> +	struct rbd_device *rbd_dev = obj_request->img_request->rbd_dev;
> +
> +	return obj_request->img_offset <
> +	    round_up(rbd_dev->parent_overlap, rbd_obj_bytes(&rbd_dev->header));
> +}
> +
>   static void rbd_obj_request_get(struct rbd_obj_request *obj_request)
>   {
>   	dout("%s: obj %p (was %d)\n", __func__, obj_request,
> @@ -2683,7 +2691,7 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
>   	 */
>   	if (!img_request_write_test(img_request) ||
>   		!img_request_layered_test(img_request) ||
> -		rbd_dev->parent_overlap <= obj_request->img_offset ||
> +		!obj_request_overlaps_parent(obj_request) ||
>   		((known = obj_request_known_test(obj_request)) &&
>   			obj_request_exists_test(obj_request))) {
>
>

