From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: do not return -ERANGE on auth failure
Date: Thu, 11 Sep 2014 10:23:27 -0500
Message-ID: <5411BE6F.1040202@ieee.org>
References: <1410448246-6635-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:45552 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaIKPXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 11:23:30 -0400
Received: by mail-ig0-f170.google.com with SMTP id l13so62269iga.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 08:23:29 -0700 (PDT)
In-Reply-To: <1410448246-6635-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 09/11/2014 10:10 AM, Ilya Dryomov wrote:
> Trying to map an image out of a pool for which we don't have an 'x'
> permission bit fails with -ERANGE from ceph_extract_encoded_string()
> due to an unsigned vs signed bug.  Fix it and get rid of the -ENIVAL
> sink, thus exposing rbd::get_id cls method return value.  (I've seen
> a bunch of unexplained -ERANGE reports, I bet this is it).
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

I often think people are annoyed by my explicit type casts
all over the place.  This (missed) one matters a lot.

I think the -EINVAL was to ensure an error code that was
expected by a write() call would be returned.

In any case, this looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4b97baf8afa3..fe3726c62a37 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4924,7 +4924,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>  		ret = image_id ? 0 : -ENOMEM;
>  		if (!ret)
>  			rbd_dev->image_format = 1;
> -	} else if (ret > sizeof (__le32)) {
> +	} else if (ret > (int)sizeof(u32)) {
>  		void *p = response;
>  
>  		image_id = ceph_extract_encoded_string(&p, p + ret,
> @@ -4932,8 +4932,6 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>  		ret = PTR_ERR_OR_ZERO(image_id);
>  		if (!ret)
>  			rbd_dev->image_format = 2;
> -	} else {
> -		ret = -EINVAL;
>  	}
>  
>  	if (!ret) {
> 

