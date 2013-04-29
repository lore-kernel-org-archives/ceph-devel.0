From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/6] rbd: only update values on snap_info success
Date: Mon, 29 Apr 2013 08:15:21 -0700
Message-ID: <517E8E89.7060804@inktank.com>
References: <517A6D39.80000@inktank.com> <517A6DAE.7010604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44893 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3D2PPE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:15:04 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so1696815pad.20
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:15:03 -0700 (PDT)
In-Reply-To: <517A6DAE.7010604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 05:06 AM, Alex Elder wrote:
> Change rbd_dev_v2_snap_info() so it only ever sets values of the
> size and features parameters if looking up the snapshot name was
> successful.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 1e01f0d..e7d10d3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3908,6 +3908,7 @@ static char *rbd_dev_v2_snap_name(struct
> rbd_device *rbd_dev, u32 which)
>   	if (!reply_buf)
>   		return ERR_PTR(-ENOMEM);
>
> +	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
>   	snap_id = cpu_to_le64(rbd_dev->header.snapc->snaps[which]);
>   	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
>   				"rbd", "get_snapshot_name",
> @@ -3940,17 +3941,30 @@ static char *rbd_dev_v2_snap_info(struct
> rbd_device *rbd_dev, u32 which,
>   		u64 *snap_size, u64 *snap_features)
>   {
>   	u64 snap_id;
> +	u64 size;
> +	u64 features;
> +	char *snap_name;
>   	int ret;
>
> +	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
>   	snap_id = rbd_dev->header.snapc->snaps[which];
> -	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, NULL, snap_size);
> +	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, NULL, &size);
>   	if (ret)
> -		return ERR_PTR(ret);
> -	ret = _rbd_dev_v2_snap_features(rbd_dev, snap_id, snap_features);
> +		goto out_err;
> +
> +	ret = _rbd_dev_v2_snap_features(rbd_dev, snap_id, &features);
>   	if (ret)
> -		return ERR_PTR(ret);
> +		goto out_err;
> +
> +	snap_name = rbd_dev_v2_snap_name(rbd_dev, which);
> +	if (!IS_ERR(snap_name)) {
> +		*snap_size = size;
> +		*snap_features = features;
> +	}
>
> -	return rbd_dev_v2_snap_name(rbd_dev, which);
> +	return snap_name;
> +out_err:
> +	return ERR_PTR(ret);
>   }
>
>   static char *rbd_dev_snap_info(struct rbd_device *rbd_dev, u32 which,
>

