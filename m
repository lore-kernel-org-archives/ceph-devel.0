From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH] rbd: fix buffer size for writes to images with snapshots
Date: Thu, 29 Aug 2013 09:31:55 -0500
Message-ID: <521F5B5B.40205@linaro.org>
References: <1377641215-29459-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:63887 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab3H2Ob4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 10:31:56 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so656778oah.6
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 07:31:55 -0700 (PDT)
In-Reply-To: <1377641215-29459-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/27/2013 05:06 PM, Josh Durgin wrote:
> rbd_osd_req_create() needs to know the snapshot context size to create
> a buffer large enough to send it with the message front. It gets this
> from the img_request, which was not set for the obj_request yet. This
> resulted in trying to write past the end of the front payload, hitting
> this BUG:
> 
> libceph: BUG_ON(p > msg->front.iov_base + msg->front.iov_len);
> 
> Fix this by associating the obj_request with its img_request
> immediately after it's created, before the osd request is created.
> 
> Fixes: http://tracker.ceph.com/issues/5760
> Suggested-by: Alex Elder <alex.elder@linaro.org>

I must have suggested it in e-mail...  I guess I should have updated
the bug.

This looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f8fd7d3..80f787b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2203,6 +2203,11 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  		rbd_segment_name_free(object_name);
>  		if (!obj_request)
>  			goto out_unwind;
> +		/*
> +		 * set obj_request->img_request before creating the
> +		 * osd_request so that it gets the right snapc
> +		 */
> +		rbd_img_obj_request_add(img_request, obj_request);
>  
>  		if (type == OBJ_REQUEST_BIO) {
>  			unsigned int clone_size;
> @@ -2244,11 +2249,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  					obj_request->pages, length,
>  					offset & ~PAGE_MASK, false, false);
>  
> -		/*
> -		 * set obj_request->img_request before formatting
> -		 * the osd_request so that it gets the right snapc
> -		 */
> -		rbd_img_obj_request_add(img_request, obj_request);
>  		if (write_request)
>  			rbd_osd_req_format_write(obj_request);
>  		else
> 

