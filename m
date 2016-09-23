From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/8] rbd: clean up asserts in rbd_img_obj_request_submit()
 helpers
Date: Fri, 23 Sep 2016 10:57:15 -0500
Message-ID: <a04e660b-ae90-78ba-63d8-c388ad29be8e@ieee.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35895 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965954AbcIWP5R (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2016 11:57:17 -0400
Received: by mail-it0-f43.google.com with SMTP id o3so18840778ita.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2016 08:57:16 -0700 (PDT)
In-Reply-To: <1474304608-17958-3-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> Assert once in rbd_img_obj_request_submit().

Generally I prefer validating things as early as possible.

But I also value the simplicity of doing it all in one place.
These are assertions, so the conditions checked should never
really happen anyway.  And...  now that we're well past doing
huge and rapid changes, the code is showing its maturity, so
the number of assertions is kind of excessive anyway.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d8b702e3c4d9..027e0817a118 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2739,21 +2739,14 @@ out_err:
>   */
>  static int rbd_img_obj_parent_read_full(struct rbd_obj_request *obj_request)
>  {
> -	struct rbd_img_request *img_request = NULL;
> +	struct rbd_device *rbd_dev = obj_request->img_request->rbd_dev;
>  	struct rbd_img_request *parent_request = NULL;
> -	struct rbd_device *rbd_dev;
>  	u64 img_offset;
>  	u64 length;
>  	struct page **pages = NULL;
>  	u32 page_count;
>  	int result;
>  
> -	rbd_assert(obj_request_img_data_test(obj_request));
> -	rbd_assert(obj_request_type_valid(obj_request->type));
> -
> -	img_request = obj_request->img_request;
> -	rbd_assert(img_request != NULL);
> -	rbd_dev = img_request->rbd_dev;
>  	rbd_assert(rbd_dev->parent != NULL);
>  
>  	/*
> @@ -2794,10 +2787,11 @@ static int rbd_img_obj_parent_read_full(struct rbd_obj_request *obj_request)
>  	result = rbd_img_request_fill(parent_request, OBJ_REQUEST_PAGES, pages);
>  	if (result)
>  		goto out_err;
> +
>  	parent_request->copyup_pages = pages;
>  	parent_request->copyup_page_count = page_count;
> -
>  	parent_request->callback = rbd_img_obj_parent_read_full_callback;
> +
>  	result = rbd_img_request_submit(parent_request);
>  	if (!result)
>  		return 0;
> @@ -2883,8 +2877,8 @@ out:
>  
>  static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  {
> +	struct rbd_device *rbd_dev = obj_request->img_request->rbd_dev;
>  	struct rbd_obj_request *stat_request;
> -	struct rbd_device *rbd_dev;
>  	struct page **pages = NULL;
>  	u32 page_count;
>  	size_t size;
> @@ -2915,8 +2909,6 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  	stat_request->pages = pages;
>  	stat_request->page_count = page_count;
>  
> -	rbd_assert(obj_request->img_request);
> -	rbd_dev = obj_request->img_request->rbd_dev;
>  	stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
>  						   stat_request);
>  	if (!stat_request->osd_req)
> @@ -2940,14 +2932,8 @@ out:
>  
>  static bool img_obj_request_simple(struct rbd_obj_request *obj_request)
>  {
> -	struct rbd_img_request *img_request;
> -	struct rbd_device *rbd_dev;
> -
> -	rbd_assert(obj_request_img_data_test(obj_request));
> -
> -	img_request = obj_request->img_request;
> -	rbd_assert(img_request);
> -	rbd_dev = img_request->rbd_dev;
> +	struct rbd_img_request *img_request = obj_request->img_request;
> +	struct rbd_device *rbd_dev = img_request->rbd_dev;
>  
>  	/* Reads */
>  	if (!img_request_write_test(img_request) &&
> @@ -2986,6 +2972,10 @@ static bool img_obj_request_simple(struct rbd_obj_request *obj_request)
>  
>  static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
>  {
> +	rbd_assert(obj_request_img_data_test(obj_request));
> +	rbd_assert(obj_request_type_valid(obj_request->type));
> +	rbd_assert(obj_request->img_request);
> +
>  	if (img_obj_request_simple(obj_request)) {
>  		rbd_obj_request_submit(obj_request);
>  		return 0;
> 

