From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/2] rbd: fetch object order before using it
Date: Thu, 13 Jun 2013 08:52:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306130851250.24708@cobra.newdream.net>
References: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36008 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758375Ab3FMPwD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jun 2013 11:52:03 -0400
In-Reply-To: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Both of these look good; pushing to testing branch shortly.  The name 
length one I also tagged for 3.9 stable (this one didn't apply cleanly).

Thanks!
sage


On Wed, 12 Jun 2013, Josh Durgin wrote:

> rbd_dev_v2_header_onetime() fetches striping information, and
> checks whether the image can be read by compariing the stripe unit
> to the object size. It determines the object size by shifting
> the object order, which is 0 at this point since it has not been
> read yet. Move the call to get the image size and object order
> before rbd_dev_v2_header_onetime() so it is set before use.
> 
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cecf5c6..9f72125 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4286,6 +4286,10 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  	bool first_time = rbd_dev->header.object_prefix == NULL;
>  	int ret;
>  
> +	ret = rbd_dev_v2_image_size(rbd_dev);
> +	if (ret)
> +		return ret;
> +
>  	if (first_time) {
>  		ret = rbd_dev_v2_header_onetime(rbd_dev);
>  		if (ret)
> @@ -4319,10 +4323,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  					"is EXPERIMENTAL!");
>  	}
>  
> -	ret = rbd_dev_v2_image_size(rbd_dev);
> -	if (ret)
> -		return ret;
> -
>  	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
>  		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
>  			rbd_dev->mapping.size = rbd_dev->header.image_size;
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
