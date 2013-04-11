From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: update feature bits
Date: Thu, 11 Apr 2013 13:04:37 -0700
Message-ID: <51671755.6040205@inktank.com>
References: <516715E1.5090708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55795 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab3DKUFH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 16:05:07 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so1072819pab.21
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 13:05:07 -0700 (PDT)
In-Reply-To: <516715E1.5090708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/11/2013 12:58 PM, Alex Elder wrote:
> There is a new rbd feature bit defined for "fancy striping." Add
> it to the ones defined in the kernel client.
>
> Change RBD_FEATURES_ALL so it represents the set of all feature
> bits (rather than just the ones we support).  Define a new symbol
> RBD_FEATURES_SUPPORTED to indicate the supported ones.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 11b7987..503e64f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -73,11 +73,14 @@
>
>   /* Feature bits */
>
> -#define RBD_FEATURE_LAYERING      1
> +#define RBD_FEATURE_LAYERING	(1<<0)
> +#define RBD_FEATURE_STRIPINGV2	(1<<1)
> +#define RBD_FEATURES_ALL \
> +	    (RBD_FEATURE_LAYERING | RBD_FEATURE_STRIPINGV2)
>
>   /* Features supported by this (client software) implementation. */
>
> -#define RBD_FEATURES_ALL          (0)
> +#define RBD_FEATURES_SUPPORTED	(0)
>
>   /*
>    * An RBD device name will be "rbd#", where the "rbd" comes from
> @@ -2843,7 +2846,7 @@ static int _rbd_dev_v2_snap_features(struct
> rbd_device *rbd_dev, u64 snap_id,
>   		return ret;
>
>   	incompat = le64_to_cpu(features_buf.incompat);
> -	if (incompat & ~RBD_FEATURES_ALL)
> +	if (incompat & ~RBD_FEATURES_SUPPORTED)
>   		return -ENXIO;
>
>   	*snap_features = le64_to_cpu(features_buf.features);
>

