From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/6] rbd: fix leak of format 2 snapshot names
Date: Mon, 29 Apr 2013 08:16:46 -0700
Message-ID: <517E8EDE.1020106@inktank.com>
References: <517A6D39.80000@inktank.com> <517A6DD1.2080102@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:59061 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3D2PQ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:16:27 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro2so2033786pbb.4
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:16:27 -0700 (PDT)
In-Reply-To: <517A6DD1.2080102@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 05:06 AM, Alex Elder wrote:
> When the snapshot context for an rbd device gets updated (or the
> initial one is recorded) a a list of snapshot structures is created
> to represent them, one entry per snapshot.  Each entry includes a
> dynamically-allocated copy of the snapshot name.
>
> Currently the name is allocated in rbd_snap_create(), as a duplicate
> of the passed-in name.
>
> For format 1 images, the snapshot name provided is just a pointer to
> an existing name.  But for format 2 images, the passed-in name is
> already dynamically allocated, and in the the process of duplicating
> it here we are leaking the passed-in name.
>
> Fix this by dynamically allocating the name for format 1 snapshots
> also, and then stop allocating a duplicate in rbd_snap_create().
>
> Change rbd_dev_v1_snap_info() so none of its parameters is
> side-effected unless it's going to return success.
>
> This is part of:
>      http://tracker.ceph.com/issues/4803
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 916741b..2b5ba50 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3427,30 +3427,23 @@ static struct rbd_snap *rbd_snap_create(struct
> rbd_device *rbd_dev,
>   						u64 snap_features)
>   {
>   	struct rbd_snap *snap;
> -	int ret;
>
>   	snap = kzalloc(sizeof (*snap), GFP_KERNEL);
>   	if (!snap)
>   		return ERR_PTR(-ENOMEM);
>
> -	ret = -ENOMEM;
> -	snap->name = kstrdup(snap_name, GFP_KERNEL);
> -	if (!snap->name)
> -		goto err;
> -
> +	snap->name = snap_name;
>   	snap->id = snap_id;
>   	snap->size = snap_size;
>   	snap->features = snap_features;
>
>   	return snap;
> -
> -err:
> -	kfree(snap->name);
> -	kfree(snap);
> -
> -	return ERR_PTR(ret);
>   }
>
> +/*
> + * Returns a dynamically-allocated snapshot name if successful, or a
> + * pointer-coded error otherwise.
> + */
>   static char *rbd_dev_v1_snap_info(struct rbd_device *rbd_dev, u32 which,
>   		u64 *snap_size, u64 *snap_features)
>   {
> @@ -3458,15 +3451,19 @@ static char *rbd_dev_v1_snap_info(struct
> rbd_device *rbd_dev, u32 which,
>
>   	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
>
> -	*snap_size = rbd_dev->header.snap_sizes[which];
> -	*snap_features = 0;	/* No features for v1 */
> -
>   	/* Skip over names until we find the one we are looking for */
>
>   	snap_name = rbd_dev->header.snap_names;
>   	while (which--)
>   		snap_name += strlen(snap_name) + 1;
>
> +	snap_name = kstrdup(snap_name, GFP_KERNEL);
> +	if (!snap_name);
> +		return ERR_PTR(-ENOMEM);
> +
> +	*snap_size = rbd_dev->header.snap_sizes[which];
> +	*snap_features = 0;	/* No features for v1 */
> +
>   	return snap_name;
>   }
>

