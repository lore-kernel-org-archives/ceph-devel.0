From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: allocate img_request with GFP_NOIO instead GFP_ATOMIC
Date: Thu, 07 Aug 2014 06:51:48 -0500
Message-ID: <53E36854.8020501@ieee.org>
References: <1407404411-4928-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55157 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbaHGLvt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Aug 2014 07:51:49 -0400
Received: by mail-ie0-f179.google.com with SMTP id rl12so4508143iec.10
        for <ceph-devel@vger.kernel.org>; Thu, 07 Aug 2014 04:51:48 -0700 (PDT)
In-Reply-To: <1407404411-4928-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 08/07/2014 04:40 AM, Ilya Dryomov wrote:
> Now that rbd_img_request_create() is called from work functions, no
> need to use GFP_ATOMIC.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4515b128d0b4..a5ebcf28e041 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2061,7 +2061,7 @@ static struct rbd_img_request *rbd_img_request_create(
>  {
>  	struct rbd_img_request *img_request;
>  
> -	img_request = kmem_cache_alloc(rbd_img_request_cache, GFP_ATOMIC);
> +	img_request = kmem_cache_alloc(rbd_img_request_cache, GFP_NOIO);
>  	if (!img_request)
>  		return NULL;
>  
> 

