From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: fix image request leak on parent read
Date: Thu, 02 May 2013 10:06:58 -0700
Message-ID: <51829D32.1050102@inktank.com>
References: <5182532C.80400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63566 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913Ab3EBRGi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 13:06:38 -0400
Received: by mail-pd0-f169.google.com with SMTP id 14so465309pdc.14
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 10:06:38 -0700 (PDT)
In-Reply-To: <5182532C.80400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/02/2013 04:51 AM, Alex Elder wrote:
> When a read for a layered image object finds the target object
> doesn't exist, a read image request for the parent image is created
> and submitted.  When that completes, the callback routine was
> not releasing that parent image request.  Fix that.
>
> The slab allocation stuff just added has greatly simplified the
> search for the source of this memory leak.
>
> This resolves:
>      http://tracker.ceph.com/issues/4803
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8d9aeef..d669f71 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2547,6 +2547,7 @@ static void rbd_img_parent_read_callback(struct
> rbd_img_request *img_request)
>   		obj_request->xferred = img_request->xferred;
>   	}
>   out:
> +	rbd_img_request_put(img_request);
>   	rbd_img_obj_request_read_callback(obj_request);
>   	rbd_obj_request_complete(obj_request);
>   }
>

