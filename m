From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 6/8] rbd: rework rbd_img_obj_exists_submit() error paths
Date: Sun, 25 Sep 2016 11:30:30 -0500
Message-ID: <d47671df-6f9d-ea62-fe44-31d41e7c0986@linaro.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-7-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37081 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034564AbcIYQac (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Sep 2016 12:30:32 -0400
Received: by mail-it0-f51.google.com with SMTP id j69so25759976itb.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Sep 2016 09:30:32 -0700 (PDT)
In-Reply-To: <1474304608-17958-7-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> - don't put obj_request if rbd_obj_request_create() fails

Not only that, don't leak the page vector in that case either.

> - don't leak stat_request if rbd_osd_req_create() fails

I believe the reference that was being dropped at the end of
the function was intended to match the one taken for the
assignment of stat_request->obj_request.  But clearly the
error path wasn't right.  Your new code no longer has an
error path that requires dropping that reference.  It is
dropped near the top of rbd_img_obj_exists_callback().

In your new code you drop a reference to the stat request,
but that's to match the one taken when that request was
created.

> Reported-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

This looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b9a4e79a663f..03f171067e08 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2886,11 +2886,23 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  {
>  	struct rbd_device *rbd_dev = obj_request->img_request->rbd_dev;
>  	struct rbd_obj_request *stat_request;
> -	struct page **pages = NULL;
> +	struct page **pages;
>  	u32 page_count;
>  	size_t size;
>  	int ret;
>  
> +	stat_request = rbd_obj_request_create(obj_request->object_name, 0, 0,
> +					      OBJ_REQUEST_PAGES);
> +	if (!stat_request)
> +		return -ENOMEM;
> +
> +	stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
> +						   stat_request);
> +	if (!stat_request->osd_req) {
> +		ret = -ENOMEM;
> +		goto fail_stat_request;
> +	}
> +
>  	/*
>  	 * The response data for a STAT call consists of:
>  	 *     le64 length;
> @@ -2902,38 +2914,28 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  	size = sizeof (__le64) + sizeof (__le32) + sizeof (__le32);
>  	page_count = (u32)calc_pages_for(0, size);
>  	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
> -	if (IS_ERR(pages))
> -		return PTR_ERR(pages);
> +	if (IS_ERR(pages)) {
> +		ret = PTR_ERR(pages);
> +		goto fail_stat_request;
> +	}
>  
> -	ret = -ENOMEM;
> -	stat_request = rbd_obj_request_create(obj_request->object_name, 0, 0,
> -							OBJ_REQUEST_PAGES);
> -	if (!stat_request)
> -		goto out;
> +	osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT, 0);
> +	osd_req_op_raw_data_in_pages(stat_request->osd_req, 0, pages, size, 0,
> +				     false, false);
>  
>  	rbd_obj_request_get(obj_request);
>  	stat_request->obj_request = obj_request;
>  	stat_request->pages = pages;
>  	stat_request->page_count = page_count;
> -
> -	stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
> -						   stat_request);
> -	if (!stat_request->osd_req)
> -		goto out;
>  	stat_request->callback = rbd_img_obj_exists_callback;
>  
> -	osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT, 0);
> -	osd_req_op_raw_data_in_pages(stat_request->osd_req, 0, pages, size, 0,
> -					false, false);
>  	rbd_osd_req_format_read(stat_request);
>  
>  	rbd_obj_request_submit(stat_request);
>  	return 0;
>  
> -out:
> -	if (ret)
> -		rbd_obj_request_put(obj_request);
> -
> +fail_stat_request:
> +	rbd_obj_request_put(stat_request);
>  	return ret;
>  }
>  
> 

