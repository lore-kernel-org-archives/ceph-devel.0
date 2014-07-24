From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/8] rbd: introduce rbd_dev_header_info()
Date: Thu, 24 Jul 2014 07:34:43 -0500
Message-ID: <53D0FD63.8030905@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com> <1406191369-6746-3-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43803 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbaGXMeo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 08:34:44 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so2192344iec.36
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 05:34:43 -0700 (PDT)
In-Reply-To: <1406191369-6746-3-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
> A wrapper around rbd_dev_v{1,2}_header_info() to reduce duplication.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 7847fbb949ff..0d3be608f16f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -514,7 +514,7 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
>  
>  static int rbd_dev_refresh(struct rbd_device *rbd_dev);
>  static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
> -static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev);
> +static int rbd_dev_header_info(struct rbd_device *rbd_dev);
>  static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
>  					u64 snap_id);
>  static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
> @@ -3506,13 +3506,10 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>  	u64 mapping_size;
>  	int ret;
>  
> -	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>  	down_write(&rbd_dev->header_rwsem);
>  	mapping_size = rbd_dev->mapping.size;
> -	if (rbd_dev->image_format == 1)
> -		ret = rbd_dev_v1_header_info(rbd_dev);
> -	else
> -		ret = rbd_dev_v2_header_info(rbd_dev);
> +
> +	ret = rbd_dev_header_info(rbd_dev);
>  
>  	/* If it's a mapped snapshot, validate its EXISTS flag */
>  
> @@ -4501,6 +4498,16 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  	return ret;
>  }
>  
> +static int rbd_dev_header_info(struct rbd_device *rbd_dev)
> +{
> +	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
> +
> +	if (rbd_dev->image_format == 1)
> +		return rbd_dev_v1_header_info(rbd_dev);
> +
> +	return rbd_dev_v2_header_info(rbd_dev);
> +}
> +
>  static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
>  {
>  	struct device *dev;
> @@ -5149,10 +5156,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
>  			goto out_header_name;
>  	}
>  
> -	if (rbd_dev->image_format == 1)
> -		ret = rbd_dev_v1_header_info(rbd_dev);
> -	else
> -		ret = rbd_dev_v2_header_info(rbd_dev);
> +	ret = rbd_dev_header_info(rbd_dev);
>  	if (ret)
>  		goto err_out_watch;
>  
> 

