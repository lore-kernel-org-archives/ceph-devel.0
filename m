From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: remove snapshots on error in rbd_add()
Date: Mon, 29 Oct 2012 13:36:58 -0700
Message-ID: <508EE8EA.7040600@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B126C.8060200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55341 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2J2UhI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 16:37:08 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3691721pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 13:37:08 -0700 (PDT)
In-Reply-To: <508B126C.8060200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/26/2012 03:45 PM, Alex Elder wrote:
> If rbd_dev_snaps_update() has ever been called for an rbd device
> structure there could be snapshot structures on its snaps list.
> In rbd_add(), this function is called but a subsequent error
> path neglected to clean up any of these snapshots.
>
> Add a call to rbd_remove_all_snaps() in the appropriate spot to
> remedy this.  Change a couple of error labels to be a little
> clearer while there.
>
> And drop the leading underscorse from the function name; there's

underscores

> nothing special about that function that they might signify.

These could be removed for __rbd_remove_snap_dev() too.

> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |   12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cc06c55..147c8df 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1787,7 +1787,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
>   	return ret;
>   }
>
> -static void __rbd_remove_all_snaps(struct rbd_device *rbd_dev)
> +static void rbd_remove_all_snaps(struct rbd_device *rbd_dev)
>   {
>   	struct rbd_snap *snap;
>   	struct rbd_snap *next;
> @@ -3179,11 +3179,11 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	/* no need to lock here, as rbd_dev is not registered yet */
>   	rc = rbd_dev_snaps_update(rbd_dev);
>   	if (rc)
> -		goto err_out_header;
> +		goto err_out_probe;
>
>   	rc = rbd_dev_set_mapping(rbd_dev, snap_name);
>   	if (rc)
> -		goto err_out_header;
> +		goto err_out_snaps;
>
>   	/* generate unique id: find highest unique id, add one */
>   	rbd_dev_id_get(rbd_dev);
> @@ -3247,7 +3247,9 @@ err_out_blkdev:
>   	unregister_blkdev(rbd_dev->major, rbd_dev->name);
>   err_out_id:
>   	rbd_dev_id_put(rbd_dev);
> -err_out_header:
> +err_out_snaps:
> +	rbd_remove_all_snaps(rbd_dev);
> +err_out_probe:
>   	rbd_header_free(&rbd_dev->header);
>   err_out_client:
>   	kfree(rbd_dev->header_name);
> @@ -3345,7 +3347,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
>   		goto done;
>   	}
>
> -	__rbd_remove_all_snaps(rbd_dev);
> +	rbd_remove_all_snaps(rbd_dev);
>   	rbd_bus_del_dev(rbd_dev);
>
>   done:
>

