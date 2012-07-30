From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/7] rbd: have __rbd_add_snap_dev() return a pointer
Date: Mon, 30 Jul 2012 13:42:18 -0700
Message-ID: <5016F1AA.4040605@inktank.com>
References: <50119421.1090702@inktank.com> <501195AD.8080405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45932 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab2G3UmV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 16:42:21 -0400
Received: by pbbrp8 with SMTP id rp8so10394353pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 13:42:21 -0700 (PDT)
In-Reply-To: <501195AD.8080405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 12:08 PM, Alex Elder wrote:
> It's not obvious whether the snapshot pointer whose address is
> provided to __rbd_add_snap_dev() will be assigned by that function.
> Change it to return the snapshot, or a pointer-coded errno in the
> event of a failure.
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |   37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fd5f3038..fd91964 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2025,15 +2025,21 @@ static int rbd_register_snap_dev(struct rbd_snap
> *snap,
>   	return ret;
>   }
>
> -static int __rbd_add_snap_dev(struct rbd_device *rbd_dev,
> -			      int i, const char *name,
> -			      struct rbd_snap **snapp)
> +static struct rbd_snap *__rbd_add_snap_dev(struct rbd_device *rbd_dev,
> +					      int i, const char *name)
>   {
> +	struct rbd_snap *snap;
>   	int ret;
> -	struct rbd_snap *snap = kzalloc(sizeof(*snap), GFP_KERNEL);
> +
> +	snap = kzalloc(sizeof (*snap), GFP_KERNEL);
>   	if (!snap)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = -ENOMEM;
>   	snap->name = kstrdup(name, GFP_KERNEL);
> +	if (!snap->name)
> +		goto err;
> +
>   	snap->size = rbd_dev->header.snap_sizes[i];
>   	snap->id = rbd_dev->header.snapc->snaps[i];
>   	if (device_is_registered(&rbd_dev->dev)) {
> @@ -2041,12 +2047,14 @@ static int __rbd_add_snap_dev(struct rbd_device
> *rbd_dev,
>   		if (ret < 0)
>   			goto err;
>   	}
> -	*snapp = snap;
> -	return 0;
> +
> +	return snap;
> +
>   err:
>   	kfree(snap->name);
>   	kfree(snap);
> -	return ret;
> +
> +	return ERR_PTR(ret);
>   }
>
>   /*
> @@ -2079,7 +2087,6 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   	const char *name, *first_name;
>   	int i = rbd_dev->header.total_snaps;
>   	struct rbd_snap *snap, *old_snap = NULL;
> -	int ret;
>   	struct list_head *p, *n;
>
>   	first_name = rbd_dev->header.snap_names;
> @@ -2122,9 +2129,9 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   			if (cur_id >= old_snap->id)
>   				break;
>   			/* a new snapshot */
> -			ret = __rbd_add_snap_dev(rbd_dev, i - 1, name, &snap);
> -			if (ret < 0)
> -				return ret;
> +			snap = __rbd_add_snap_dev(rbd_dev, i - 1, name);
> +			if (IS_ERR(snap))
> +				return PTR_ERR(snap);
>
>   			/* note that we add it backward so using n and not p */
>   			list_add(&snap->node, n);
> @@ -2138,9 +2145,9 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   			WARN_ON(1);
>   			return -EINVAL;
>   		}
> -		ret = __rbd_add_snap_dev(rbd_dev, i - 1, name, &snap);
> -		if (ret < 0)
> -			return ret;
> +		snap = __rbd_add_snap_dev(rbd_dev, i - 1, name);
> +		if (IS_ERR(snap))
> +			return PTR_ERR(snap);
>   		list_add(&snap->node, &rbd_dev->snaps);
>   	}
>

