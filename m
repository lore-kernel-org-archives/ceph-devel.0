From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 01/15] rbd: use kstrndup() in rbd_header_from_disk()
Date: Wed, 15 Feb 2017 09:52:14 -0600
Message-ID: <f23ab023-cb4e-f605-ada5-0480a174c9d7@ieee.org>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
 <1487103124-2974-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35503 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdBOPwR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 10:52:17 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so67080516ith.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 07:52:16 -0800 (PST)
In-Reply-To: <1487103124-2974-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 02/14/2017 02:11 PM, Ilya Dryomov wrote:
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>


> ---
>  drivers/block/rbd.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 40a15ae354ce..76e538c3378e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -992,15 +992,11 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
>  	/* Allocate this now to avoid having to handle failure below */
>  
>  	if (first_time) {
> -		size_t len;
> -
> -		len = strnlen(ondisk->object_prefix,
> -				sizeof (ondisk->object_prefix));
> -		object_prefix = kmalloc(len + 1, GFP_KERNEL);
> +		object_prefix = kstrndup(ondisk->object_prefix,
> +					 sizeof(ondisk->object_prefix),
> +					 GFP_KERNEL);
>  		if (!object_prefix)
>  			return -ENOMEM;
> -		memcpy(object_prefix, ondisk->object_prefix, len);
> -		object_prefix[len] = '\0';
>  	}
>  
>  	/* Allocate the snapshot context and fill it in */
> 

