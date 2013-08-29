From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/3] rbd: fix null dereference in dout
Date: Thu, 29 Aug 2013 07:46:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308290746230.10144@cobra.newdream.net>
References: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com> <1377757447-23515-2-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44286 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3H2Oq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 10:46:29 -0400
In-Reply-To: <1377757447-23515-2-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Wed, 28 Aug 2013, Josh Durgin wrote:

> The order parameter is sometimes NULL in _rbd_dev_v2_snap_size(), but
> the dout() always derefences it. Move this to another dout() protected
> by a check that order is non-NULL.
> 
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 80f787b..fef3687 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3702,12 +3702,14 @@ static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
>  	if (ret < sizeof (size_buf))
>  		return -ERANGE;
>  
> -	if (order)
> +	if (order) {
>  		*order = size_buf.order;
> +		dout("  order %u", (unsigned int)*order);
> +	}
>  	*snap_size = le64_to_cpu(size_buf.size);
>  
> -	dout("  snap_id 0x%016llx order = %u, snap_size = %llu\n",
> -		(unsigned long long)snap_id, (unsigned int)*order,
> +	dout("  snap_id 0x%016llx snap_size = %llu\n",
> +		(unsigned long long)snap_id,
>  		(unsigned long long)*snap_size);
>  
>  	return 0;
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
