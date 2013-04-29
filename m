From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/7] rbd: move stripe_unit and stripe_count into header
Date: Mon, 29 Apr 2013 08:35:42 -0700
Message-ID: <517E934E.80803@inktank.com>
References: <517AC047.6060000@inktank.com> <517AC0AB.9070308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49808 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621Ab3D2PfX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:35:23 -0400
Received: by mail-pa0-f48.google.com with SMTP id lb1so1812214pab.21
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:35:22 -0700 (PDT)
In-Reply-To: <517AC0AB.9070308@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 11:00 AM, Alex Elder wrote:
> This commit added fetching if fancy striping parameters:
>      09186ddb rbd: get and check striping parameters
>
> They are almost unused, but the two fields storing the information
> really belonged in the rbd_image_header structure.
>
> This patch moves them there.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d989914..fd4f678 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -108,6 +108,9 @@ struct rbd_image_header {
>   	char *snap_names;
>   	u64 *snap_sizes;
>
> +	u64 stripe_unit;
> +	u64 stripe_count;
> +
>   	u64 obj_version;
>   };
>
> @@ -316,9 +319,6 @@ struct rbd_device {
>   	u64			parent_overlap;
>   	struct rbd_device	*parent;
>
> -	u64			stripe_unit;
> -	u64			stripe_count;
> -
>   	/* protects updating the header */
>   	struct rw_semaphore     header_rwsem;
>
> @@ -3695,8 +3695,8 @@ static int rbd_dev_v2_striping_info(struct
> rbd_device *rbd_dev)
>   				"(got %llu want 1)", stripe_count);
>   		return -EINVAL;
>   	}
> -	rbd_dev->stripe_unit = stripe_unit;
> -	rbd_dev->stripe_count = stripe_count;
> +	rbd_dev->header.stripe_unit = stripe_unit;
> +	rbd_dev->header.stripe_count = stripe_count;
>
>   	return 0;
>   }
>

