From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/8] rbd: remove unnecessary asserts in rbd_dev_image_probe()
Date: Thu, 24 Jul 2014 07:40:00 -0500
Message-ID: <53D0FEA0.9020900@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com> <1406191369-6746-4-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:64160 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758526AbaGXMkB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 08:40:01 -0400
Received: by mail-ig0-f171.google.com with SMTP id l13so6398411iga.10
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 05:40:00 -0700 (PDT)
In-Reply-To: <1406191369-6746-4-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
> spec->image_id assert doesn't buy us much and image_format is asserted
> in rbd_dev_header_name() and rbd_dev_header_info() anyway.

Looks good.  Over time I'm sure there are more assertions
that can go away; they were most useful during rapid development
when confidence in certain things was lower.

Reviewed-by: Alex Elder <elder@linaro.org>


> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0d3be608f16f..4541f6027e4a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5143,8 +5143,6 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
>  	ret = rbd_dev_image_id(rbd_dev);
>  	if (ret)
>  		return ret;
> -	rbd_assert(rbd_dev->spec->image_id);
> -	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>  
>  	ret = rbd_dev_header_name(rbd_dev);
>  	if (ret)
> 

