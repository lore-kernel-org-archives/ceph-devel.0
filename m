From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: don't zero-fill non-image object requests
Date: Wed, 27 Mar 2013 09:10:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303270909380.20593@cobra.newdream.net>
References: <5153020B.7050403@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51674 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3C0QKd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Mar 2013 12:10:33 -0400
In-Reply-To: <5153020B.7050403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Dan van der Ster <dan@vanderster.com>

On Wed, 27 Mar 2013, Alex Elder wrote:
> (This patch is available in the branch "review/wip-4559" in the
> ceph-client git repository.)
> 
> A result of ENOENT from a read request for an object that's part of
> an rbd image indicates that there is a hole in that portion of the
> image.  Similarly, a short read for such an object indicates that
> the remainder of the read should be interpreted a full read with
> zeros filling out the end of the request.
> 
> This behavior is not correct for objects that are not backing rbd
> image data.  Currently rbd_img_obj_request_callback() assumes it
> should be done for all objects.
> 
> Change rbd_img_obj_request_callback() so it only does this zeroing
> for image objects.  Encapsulate that special handling in its own
> function.  Add an assertion that the image object request is a bio
> request, since we assume that (and we currently don't support any
> other types).

Does this only affect the current -rc or is this problem older than that?

We should add some workunit tests that verify that mapping nonexistent 
images behaves.

sage

> 
> Reported-by: Dan van der Ster <dan@vanderster.com>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   47 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cc74b2c..d54a045 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1264,6 +1264,32 @@ static bool obj_request_done_test(struct
> rbd_obj_request *obj_request)
>  	return atomic_read(&obj_request->done) != 0;
>  }
> 
> +static void
> +rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
> +{
> +	dout("%s: obj %p img %p result %d %llu/%llu\n", __func__,
> +		obj_request, obj_request->img_request, obj_request->result,
> +		obj_request->xferred, obj_request->length);
> +	/*
> +	 * ENOENT means a hole in the image.  We zero-fill the
> +	 * entire length of the request.  A short read also implies
> +	 * zero-fill to the end of the request.  Either way we
> +	 * update the xferred count to indicate the whole request
> +	 * was satisfied.
> +	 */
> +	BUG_ON(obj_request->type != OBJ_REQUEST_BIO);
> +	if (obj_request->result == -ENOENT) {
> +		zero_bio_chain(obj_request->bio_list, 0);
> +		obj_request->result = 0;
> +		obj_request->xferred = obj_request->length;
> +	} else if (obj_request->xferred < obj_request->length &&
> +			!obj_request->result) {
> +		zero_bio_chain(obj_request->bio_list, obj_request->xferred);
> +		obj_request->xferred = obj_request->length;
> +	}
> +	obj_request_done_set(obj_request);
> +}
> +
>  static void rbd_obj_request_complete(struct rbd_obj_request *obj_request)
>  {
>  	dout("%s: obj %p cb %p\n", __func__, obj_request,
> @@ -1284,23 +1310,10 @@ static void rbd_osd_read_callback(struct
> rbd_obj_request *obj_request)
>  {
>  	dout("%s: obj %p result %d %llu/%llu\n", __func__, obj_request,
>  		obj_request->result, obj_request->xferred, obj_request->length);
> -	/*
> -	 * ENOENT means a hole in the object.  We zero-fill the
> -	 * entire length of the request.  A short read also implies
> -	 * zero-fill to the end of the request.  Either way we
> -	 * update the xferred count to indicate the whole request
> -	 * was satisfied.
> -	 */
> -	if (obj_request->result == -ENOENT) {
> -		zero_bio_chain(obj_request->bio_list, 0);
> -		obj_request->result = 0;
> -		obj_request->xferred = obj_request->length;
> -	} else if (obj_request->xferred < obj_request->length &&
> -			!obj_request->result) {
> -		zero_bio_chain(obj_request->bio_list, obj_request->xferred);
> -		obj_request->xferred = obj_request->length;
> -	}
> -	obj_request_done_set(obj_request);
> +	if (obj_request->img_request)
> +		rbd_img_obj_request_read_callback(obj_request);
> +	else
> +		obj_request_done_set(obj_request);
>  }
> 
>  static void rbd_osd_write_callback(struct rbd_obj_request *obj_request)
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
