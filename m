From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 1/3] rbd: fix null dereference in dout
Date: Thu, 29 Aug 2013 09:26:24 -0500
Message-ID: <521F5A10.90608@linaro.org>
References: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com> <1377757447-23515-2-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:58840 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3H2O0Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 10:26:25 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so647682oag.10
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 07:26:24 -0700 (PDT)
In-Reply-To: <1377757447-23515-2-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/29/2013 01:24 AM, Josh Durgin wrote:
> The order parameter is sometimes NULL in _rbd_dev_v2_snap_size(), but
> the dout() always derefences it. Move this to another dout() protected
> by a check that order is non-NULL.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

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
> 

