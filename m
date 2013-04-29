From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/6] rbd: make snap_size order parameter optional
Date: Mon, 29 Apr 2013 08:14:46 -0700
Message-ID: <517E8E66.8030504@inktank.com>
References: <517A6D39.80000@inktank.com> <517A6DA1.90809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58538 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3D2PO1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:14:27 -0400
Received: by mail-pa0-f46.google.com with SMTP id ld11so1438323pab.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:14:26 -0700 (PDT)
In-Reply-To: <517A6DA1.90809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 05:05 AM, Alex Elder wrote:
> Only one of the two callers of _rbd_dev_v2_snap_size() needs the
> order value returned.  So make that an optional argument--a null
> pointer if the caller doesn't need it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 28b652c..1e01f0d 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3494,7 +3494,8 @@ static int _rbd_dev_v2_snap_size(struct rbd_device
> *rbd_dev, u64 snap_id,
>   	if (ret < sizeof (size_buf))
>   		return -ERANGE;
>
> -	*order = size_buf.order;
> +	if (order)
> +		*order = size_buf.order;
>   	*snap_size = le64_to_cpu(size_buf.size);
>
>   	dout("  snap_id 0x%016llx order = %u, snap_size = %llu\n",
> @@ -3939,11 +3940,10 @@ static char *rbd_dev_v2_snap_info(struct
> rbd_device *rbd_dev, u32 which,
>   		u64 *snap_size, u64 *snap_features)
>   {
>   	u64 snap_id;
> -	u8 order;
>   	int ret;
>
>   	snap_id = rbd_dev->header.snapc->snaps[which];
> -	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, &order, snap_size);
> +	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, NULL, snap_size);
>   	if (ret)
>   		return ERR_PTR(ret);
>   	ret = _rbd_dev_v2_snap_features(rbd_dev, snap_id, snap_features);
>

