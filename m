From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 5/8] rbd: don't crash or leak on errors in
 rbd_img_obj_parent_read_full_callback()
Date: Sun, 25 Sep 2016 11:02:02 -0500
Message-ID: <49200893-649c-d85f-19bc-b328361c3127@linaro.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-6-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36157 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbcIYQCG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Sep 2016 12:02:06 -0400
Received: by mail-it0-f45.google.com with SMTP id o3so54473751ita.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Sep 2016 09:02:05 -0700 (PDT)
In-Reply-To: <1474304608-17958-6-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> - fix parent_length == img_request->xferred assert to not fire on
>   copyup read failures
> - don't leak pages if copyup read fails or we can't allocate a new osd
>   request
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d8070bd29fd1..b9a4e79a663f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2666,7 +2666,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  	rbd_assert(obj_request_type_valid(orig_request->type));
>  	img_result = img_request->result;
>  	parent_length = img_request->length;
> -	rbd_assert(parent_length == img_request->xferred);
> +	rbd_assert(img_result || parent_length == img_request->xferred);
>  	rbd_img_request_put(img_request);
>  
>  	rbd_assert(orig_request->img_request);
> @@ -2719,6 +2719,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  	return;
>  
>  out_err:
> +	ceph_release_page_vector(pages, page_count);
>  	orig_request->result = img_result;
>  	orig_request->xferred = 0;
>  	rbd_img_request_get(orig_request->img_request);
> 

