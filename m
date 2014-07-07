From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: do not leak image_id in rbd_dev_v2_parent_info()
Date: Mon, 07 Jul 2014 17:40:30 -0500
Message-ID: <53BB21DE.6090902@ieee.org>
References: <1404121556-4854-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:63147 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaGGWka (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 18:40:30 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so10132igq.13
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 15:40:29 -0700 (PDT)
In-Reply-To: <1404121556-4854-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/30/2014 04:45 AM, Ilya Dryomov wrote:
> image_id is leaked if the parent happens to have been recorded already.
> Fix it.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d99aa81774f8..adedb393b374 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4072,6 +4072,8 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
>  		parent_spec->snap_id = snap_id;
>  		rbd_dev->parent_spec = parent_spec;
>  		parent_spec = NULL;	/* rbd_dev now owns this */
> +	} else {
> +		kfree(image_id);
>  	}
>  
>  	/*
> 

