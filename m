From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 8/8] rbd: img_data requests don't own their page array
Date: Sun, 25 Sep 2016 12:06:34 -0500
Message-ID: <3fe273f8-7f12-26d4-885a-972e63c0b48e@linaro.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-9-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35661 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965935AbcIYRGh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Sep 2016 13:06:37 -0400
Received: by mail-io0-f171.google.com with SMTP id m186so161684205ioa.2
        for <ceph-devel@vger.kernel.org>; Sun, 25 Sep 2016 10:06:36 -0700 (PDT)
In-Reply-To: <1474304608-17958-9-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> Move the check into rbd_obj_request_destroy(), to avoid use-after-free
> on errors in rbd_img_request_fill().
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Is this because an error occurring in rbd_img_request_fill()
causes rbd_img_obj_request_del() to be called, which leads to
rbd_obj_request_destroy(), which (by this time) has not yet
had its obj_request->pages pointer set to NULL because the
object request is still outstanding?  (Your explanation was
a little brief...)

The change in rbd_obj_request_destroy() looks good for that
case.

The code deleted in rbd_img_obj_end_request() could still stay,
however.  Almost everywhere, pointers are reassigned to NULL
when it's known the thing referred to is no longer needed.
It's useful in post-mortem understanding of what's occurred.

I guess it's fine with me either way.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8907ee6342ac..d305b9ebe2cf 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2139,7 +2139,9 @@ static void rbd_obj_request_destroy(struct kref *kref)
>  			bio_chain_put(obj_request->bio_list);
>  		break;
>  	case OBJ_REQUEST_PAGES:
> -		if (obj_request->pages)
> +		/* img_data requests don't own their page array */
> +		if (obj_request->pages &&
> +		    !obj_request_img_data_test(obj_request))
>  			ceph_release_page_vector(obj_request->pages,
>  						obj_request->page_count);
>  		break;
> @@ -2360,13 +2362,6 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
>  		xferred = obj_request->length;
>  	}
>  
> -	/* Image object requests don't own their page array */
> -
> -	if (obj_request->type == OBJ_REQUEST_PAGES) {
> -		obj_request->pages = NULL;
> -		obj_request->page_count = 0;
> -	}
> -
>  	if (img_request_child_test(img_request)) {
>  		rbd_assert(img_request->obj_request != NULL);
>  		more = obj_request->which < img_request->obj_request_count - 1;
> 

