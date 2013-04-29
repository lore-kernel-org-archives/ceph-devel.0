From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/4] rbd: have snap_by_name() return a snapshot
Date: Mon, 29 Apr 2013 08:28:28 -0700
Message-ID: <517E919C.70009@inktank.com>
References: <517A945B.9040304@inktank.com> <517A94C0.3000006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34520 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3D2P2I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:28:08 -0400
Received: by mail-pa0-f46.google.com with SMTP id ld11so1445610pab.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:28:08 -0700 (PDT)
In-Reply-To: <517A94C0.3000006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 07:52 AM, Alex Elder wrote:
> A function called snap_by_name() ought to just look up a snapshot by
> name.  It does that, but then it assigns some stuff to the rbd
> device structure as well.
>
> Change the function to do just the lookup, and have the caller do
> the assignments that follow.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e79dfe2..5f97137 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -830,44 +830,39 @@ static const char *rbd_snap_name(struct rbd_device
> *rbd_dev, u64 snap_id)
>   	return NULL;
>   }
>
> -static int snap_by_name(struct rbd_device *rbd_dev, const char *snap_name)
> +static struct rbd_snap *snap_by_name(struct rbd_device *rbd_dev,
> +					const char *snap_name)
>   {
> -
>   	struct rbd_snap *snap;
>
> -	list_for_each_entry(snap, &rbd_dev->snaps, node) {
> -		if (!strcmp(snap_name, snap->name)) {
> -			rbd_dev->spec->snap_id = snap->id;
> -			rbd_dev->mapping.size = snap->size;
> -			rbd_dev->mapping.features = snap->features;
> -
> -			return 0;
> -		}
> -	}
> +	list_for_each_entry(snap, &rbd_dev->snaps, node)
> +		if (!strcmp(snap_name, snap->name))
> +			return snap;
>
> -	return -ENOENT;
> +	return NULL;
>   }
>
>   static int rbd_dev_set_mapping(struct rbd_device *rbd_dev)
>   {
> -	int ret;
> -
>   	if (!memcmp(rbd_dev->spec->snap_name, RBD_SNAP_HEAD_NAME,
>   		    sizeof (RBD_SNAP_HEAD_NAME))) {
>   		rbd_dev->spec->snap_id = CEPH_NOSNAP;
>   		rbd_dev->mapping.size = rbd_dev->header.image_size;
>   		rbd_dev->mapping.features = rbd_dev->header.features;
> -		ret = 0;
>   	} else {
> -		ret = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
> -		if (ret < 0)
> -			goto done;
> +		struct rbd_snap *snap;
> +
> +		snap = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
> +		if (!snap)
> +			return -ENOENT;
> +		rbd_dev->spec->snap_id = snap->id;
> +		rbd_dev->mapping.size = snap->size;
> +		rbd_dev->mapping.features = snap->features;
>   		rbd_dev->mapping.read_only = true;
>   	}
>   	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
>
> -done:
> -	return ret;
> +	return 0;
>   }
>
>   static void rbd_header_free(struct rbd_image_header *header)
>

