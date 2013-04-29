From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/6] rbd: rename __rbd_add_snap_dev()
Date: Mon, 29 Apr 2013 08:15:46 -0700
Message-ID: <517E8EA2.7090802@inktank.com>
References: <517A6D39.80000@inktank.com> <517A6DC0.7080005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43610 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3D2PP1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:15:27 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so1428469pdi.35
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:15:26 -0700 (PDT)
In-Reply-To: <517A6DC0.7080005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 05:06 AM, Alex Elder wrote:
> Rename __rbd_add_snap_dev() to be rbd_snap_create().  We no longer
> have devices for non-mapped snapshots, and we're not actually
> "adding" it to the list in this function, just creating it.
>
> Rename rbd_remove_snap_dev() to be rbd_snap_destroy() for reasons
> similar to the above.  Stop having this function delete the snapshot
> from its list (to be symmetrical with its create counterpart) and do
> that in the caller instead.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e7d10d3..916741b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -359,7 +359,7 @@ static int rbd_img_request_submit(struct
> rbd_img_request *img_request);
>   static int rbd_dev_snaps_update(struct rbd_device *rbd_dev);
>
>   static void rbd_dev_release(struct device *dev);
> -static void rbd_remove_snap_dev(struct rbd_snap *snap);
> +static void rbd_snap_destroy(struct rbd_snap *snap);
>
>   static ssize_t rbd_add(struct bus_type *bus, const char *buf,
>   		       size_t count);
> @@ -3010,8 +3010,10 @@ static void rbd_remove_all_snaps(struct
> rbd_device *rbd_dev)
>   	struct rbd_snap *snap;
>   	struct rbd_snap *next;
>
> -	list_for_each_entry_safe(snap, next, &rbd_dev->snaps, node)
> -		rbd_remove_snap_dev(snap);
> +	list_for_each_entry_safe(snap, next, &rbd_dev->snaps, node) {
> +		list_del(&snap->node);
> +		rbd_snap_destroy(snap);
> +	}
>   }
>
>   static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
> @@ -3413,14 +3415,13 @@ static void rbd_dev_destroy(struct rbd_device
> *rbd_dev)
>   	kfree(rbd_dev);
>   }
>
> -static void rbd_remove_snap_dev(struct rbd_snap *snap)
> +static void rbd_snap_destroy(struct rbd_snap *snap)
>   {
> -	list_del(&snap->node);
>   	kfree(snap->name);
>   	kfree(snap);
>   }
>
> -static struct rbd_snap *__rbd_add_snap_dev(struct rbd_device *rbd_dev,
> +static struct rbd_snap *rbd_snap_create(struct rbd_device *rbd_dev,
>   						const char *snap_name,
>   						u64 snap_id, u64 snap_size,
>   						u64 snap_features)
> @@ -4070,7 +4071,9 @@ static int rbd_dev_snaps_update(struct rbd_device
> *rbd_dev)
>   				rbd_dev->spec->snap_id == snap->id ?
>   							"mapped " : "",
>   				(unsigned long long)snap->id);
> -			rbd_remove_snap_dev(snap);
> +
> +			list_del(&snap->node);
> +			rbd_snap_destroy(snap);
>
>   			/* Done with this list entry; advance */
>
> @@ -4093,7 +4096,7 @@ static int rbd_dev_snaps_update(struct rbd_device
> *rbd_dev)
>
>   			/* We haven't seen this snapshot before */
>
> -			new_snap = __rbd_add_snap_dev(rbd_dev, snap_name,
> +			new_snap = rbd_snap_create(rbd_dev, snap_name,
>   					snap_id, snap_size, snap_features);
>   			if (IS_ERR(new_snap)) {
>   				ret = PTR_ERR(new_snap);
>

