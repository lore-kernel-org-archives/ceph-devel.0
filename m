From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: plug rbd_dev->header.object_prefix memory leak
Date: Tue, 1 Sep 2015 07:43:43 -0500
Message-ID: <55E59D7F.6000505@ieee.org>
References: <1441040558-8977-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33545 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbbIAMnp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 08:43:45 -0400
Received: by iods203 with SMTP id s203so193756013iod.0
        for <ceph-devel@vger.kernel.org>; Tue, 01 Sep 2015 05:43:44 -0700 (PDT)
In-Reply-To: <1441040558-8977-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 08/31/2015 12:02 PM, Ilya Dryomov wrote:
> Need to free object_prefix when rbd_dev_v2_snap_context() fails, but
> only if this is the first time we are reading in the header.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Yes this makes sense.  It might be nice to encapsulate
some of this, something like rbd_dev_header_info_release().
As things stand, freeing of the object prefix appears
sort of random.  It wasn't easy to follow the life
cycle of that field doing a quick scan of the code for
when it's set and cleared.

Anyway, looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 324bf35ec4dd..69d03aa46d0d 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4720,7 +4720,10 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  	}
>  
>  	ret = rbd_dev_v2_snap_context(rbd_dev);
> -	dout("rbd_dev_v2_snap_context returned %d\n", ret);
> +	if (ret && first_time) {
> +		kfree(rbd_dev->header.object_prefix);
> +		rbd_dev->header.object_prefix = NULL;
> +	}
>  
>  	return ret;
>  }
> 

