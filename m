From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/3] rbd: skip the copyup when an entire object writing
Date: Tue, 11 Mar 2014 23:39:31 -0500
Message-ID: <531FE503.7030000@ieee.org>
References: <1394598285-17225-1-git-send-email-lucienchao@gmail.com> <1394598285-17225-2-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55691 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaCLEjb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 00:39:31 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so10145461iec.30
        for <ceph-devel@vger.kernel.org>; Tue, 11 Mar 2014 21:39:31 -0700 (PDT)
In-Reply-To: <1394598285-17225-2-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 03/11/2014 11:24 PM, Guangliang Zhao wrote:
> It need to copyup the parent's content when layered writing,
> but an entire object write would overwrite it, so skip it.

This is a pretty reasonable optimization.  Has anyone
found how often this case is hit?  Is it a big win?

I think the patch looks good but I have something for
you to consider, below.  Either way:

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> ---
>  drivers/block/rbd.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b365e0d..965b9b9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2629,12 +2629,14 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
>  	struct rbd_img_request *img_request;
>  	struct rbd_device *rbd_dev;
>  	bool known;
> +	u64 obj_size;
>  
>  	rbd_assert(obj_request_img_data_test(obj_request));
>  
>  	img_request = obj_request->img_request;
>  	rbd_assert(img_request);
>  	rbd_dev = img_request->rbd_dev;
> +	obj_size = (u64) 1 << rbd_dev->header.obj_order;
>  
>  	/*
>  	 * Only writes to layered images need special handling.
> @@ -2644,11 +2646,15 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
>  	 * simple object requests.  Finally, if the target object is
>  	 * known to already exist, its parent data has already been
>  	 * copied, so a write to the object can also be handled as a
> -	 * simple object request.
> +	 * simple object request. Another type: if the obj_request
> +	 * aligns with the boundary and equals to the size of an object,
> +	 * it doesn't need copyup, because the obj_request will overwrite
> +	 * it finally.
>  	 */

This test is awfully big, and it's now even bigger.  I think it
would be good to encapsulate it into a helper function.  Something
like rbd_obj_request_simple() (or figure out a better name).  So
it might then look like:

	/*
	 * If it's a simple image object request, no special
	 * handling is required.
	 */
	if (rbd_img_obj_request_simple(obj_request)) {
                struct rbd_device *rbd_dev;
                struct ceph_osd_client *osdc;

                return rbd_obj_request_submit(osdc, obj_request);
        }

The called function could probably be made a little easier
to understand by splitting up the conditions and returning
more than once.  E.g.:

	/* Only layered writes need special handling. */

	img_request = obj_request->img_request;
        rbd_dev = img_request->rbd_dev;

	if (!img_request_write_test(obj_request))
		return true;
	if (!img_request_layered_test(img_request))
		return true;

	/*
	 * Layered writes that start beyond the end of the overlap
         * with the parent have no parent data, so they too are
         * simple object requests.
	 */
	if (rbd_dev->parent_overlap <= obj_request->img_offset)
		return true;

And so on.


>  	if (!img_request_write_test(img_request) ||
>  		!img_request_layered_test(img_request) ||
>  		rbd_dev->parent_overlap <= obj_request->img_offset ||
> +		((!obj_request->offset) && (obj_request->length == obj_size)) ||
>  		((known = obj_request_known_test(obj_request)) &&
>  			obj_request_exists_test(obj_request))) {
>  
> 

