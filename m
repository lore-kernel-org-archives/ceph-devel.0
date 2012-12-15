From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 7/9] rbd: don't use ENOTSUPP
Date: Fri, 14 Dec 2012 21:12:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212142112440.23307@cobra.newdream.net>
References: <50CA0915.1090801@inktank.com> <50CA0A2E.1030003@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42287 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2LOFMu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 00:12:50 -0500
In-Reply-To: <50CA0A2E.1030003@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Thu, 13 Dec 2012, Alex Elder wrote:

> ENOTSUPP is not a standard errno (it shows up as "Unknown error 524"
> in an error message).  This is what was getting produced when the
> the local rbd code does not implement features required by a
> discovered rbd image.
> 
> Change the error code returned in this case to ENXIO.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ce26b749..4daa400 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2456,7 +2456,7 @@ static int _rbd_dev_v2_snap_features(struct
> rbd_device *rbd_dev, u64 snap_id,
> 
>  	incompat = le64_to_cpu(features_buf.incompat);
>  	if (incompat & ~RBD_FEATURES_ALL)
> -		return -ENOTSUPP;
> +		return -ENXIO;
> 
>  	*snap_features = le64_to_cpu(features_buf.features);
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
