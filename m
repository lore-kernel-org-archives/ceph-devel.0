From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/5] rbd: define rbd_dev_unprobe()
Date: Tue, 30 Apr 2013 18:11:16 -0700
Message-ID: <51806BB4.2060901@inktank.com>
References: <517EB4F0.1070607@inktank.com> <517EB54D.8090807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55115 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934079Ab3EABML (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 21:12:11 -0400
Received: by mail-pd0-f177.google.com with SMTP id p11so603171pdj.36
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 18:12:11 -0700 (PDT)
In-Reply-To: <517EB54D.8090807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

There are a couple calls that look unnecessary noted below.
Other than that:

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/29/2013 11:00 AM, Alex Elder wrote:
> Define a new function rbd_dev_unprobe() which undoes state changes
> that occur from calling rbd_dev_v1_probe() or rbd_dev_v2_probe().
> Note that this is a superset of rbd_header_free(), which is now
> getting removed (it seems to have been used improperly anyway).
>
> Flesh out rbd_dev_image_release() so it undoes exactly what
> rbd_dev_image_probe() does.
>
> This means that:
>      - rbd_dev_device_release() gets called when the last device
>        reference gets dropped;
>      - that undoes everything done by the rbd_dev_device_setup() call
>        at the end of rbd_dev_image_probe() (and nothing more), ending
>        by calling rbd_dev_image_release(); and
>      - rbd_dev_image_release() undoes everything else done by
>        rbd_dev_image_probe() (and this includes a call to
>        rbd_dev_unprobe().
>
> This means the image and device portions of an rbd device are fairly
> cleanly separated now, so error paths should be a little easier to
> verify than they used to be.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   78
> +++++++++++++++++++++++++--------------------------
>   1 file changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index feaa2e9..595d7b3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -900,18 +900,6 @@ static void rbd_dev_clear_mapping(struct rbd_device
> *rbd_dev)
>   	rbd_dev->mapping.read_only = true;
>   }
>
> -static void rbd_header_free(struct rbd_image_header *header)
> -{
> -	kfree(header->object_prefix);
> -	header->object_prefix = NULL;
> -	kfree(header->snap_sizes);
> -	header->snap_sizes = NULL;
> -	kfree(header->snap_names);
> -	header->snap_names = NULL;
> -	rbd_snap_context_put(header->snapc);
> -	header->snapc = NULL;
> -}
> -
>   static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
>   {
>   	char *name;
> @@ -4588,6 +4576,27 @@ out:
>   	return ret;
>   }
>
> +/* Undo whatever state changes are made by v1 or v2 image probe */
> +
> +static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
> +{
> +	struct rbd_image_header	*header;
> +
> +	rbd_dev_remove_parent(rbd_dev);
> +	rbd_spec_put(rbd_dev->parent_spec);
> +	rbd_dev->parent_spec = NULL;
> +	rbd_dev->parent_overlap = 0;
> +
> +	/* Free dynamic fields from the header, then zero it out */
> +
> +	header = &rbd_dev->header;
> +	rbd_snap_context_put(header->snapc);
> +	kfree(header->snap_sizes);
> +	kfree(header->snap_names);
> +	kfree(header->object_prefix);
> +	memset(header, 0, sizeof (*header));
> +}
> +
>   static int rbd_dev_v1_probe(struct rbd_device *rbd_dev)
>   {
>   	int ret;
> @@ -4809,10 +4818,20 @@ static int rbd_dev_header_name(struct rbd_device
> *rbd_dev)
>
>   static void rbd_dev_image_release(struct rbd_device *rbd_dev)
>   {
> -	rbd_header_free(&rbd_dev->header);
> -	rbd_assert(rbd_dev->rbd_client != NULL);
> -	rbd_spec_put(rbd_dev->parent_spec);
> +	int ret;
> +
> +	rbd_dev_remove_parent(rbd_dev);

This was just moved to rbd_dev_unprobe(), which is called in two lines.
It seems like this call should go away, since rbd_dev_unprobe() is also
used in an error path.

> +	rbd_remove_all_snaps(rbd_dev);
> +	rbd_dev_unprobe(rbd_dev);
> +	ret = rbd_dev_header_watch_sync(rbd_dev, 0);
> +	if (ret)
> +		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
>   	kfree(rbd_dev->header_name);
> +	rbd_dev->header_name = NULL;
> +	rbd_dev->image_format = 0;
> +	kfree(rbd_dev->spec->image_id);
> +	rbd_dev->spec->image_id = NULL;
> +
>   	rbd_dev_destroy(rbd_dev);
>   }
>
> @@ -4854,7 +4873,7 @@ static int rbd_dev_image_probe(struct rbd_device
> *rbd_dev)
>
>   	ret = rbd_dev_snaps_update(rbd_dev);
>   	if (ret)
> -		goto err_out_watch;
> +		goto err_out_probe;
>
>   	ret = rbd_dev_spec_update(rbd_dev);
>   	if (ret)
> @@ -4865,15 +4884,14 @@ static int rbd_dev_image_probe(struct rbd_device
> *rbd_dev)
>   		goto err_out_snaps;
>
>   	ret = rbd_dev_device_setup(rbd_dev);
> -	if (ret)
> -		goto err_out_parent;
> +	if (!ret)
> +		return 0;
>
> -	return ret;
> -err_out_parent:
>   	rbd_dev_remove_parent(rbd_dev);

This call is removed in the next patch, but should probably be removed
here, since rbd_dev_unprobe() calls it now.

> -	rbd_header_free(&rbd_dev->header);
>   err_out_snaps:
>   	rbd_remove_all_snaps(rbd_dev);
> +err_out_probe:
> +	rbd_dev_unprobe(rbd_dev);
>   err_out_watch:
>   	tmp = rbd_dev_header_watch_sync(rbd_dev, 0);
>   	if (tmp)
> @@ -5005,7 +5023,6 @@ static void rbd_dev_remove_parent(struct
> rbd_device *rbd_dev)
>   		struct rbd_device *first = rbd_dev;
>   		struct rbd_device *second = first->parent;
>   		struct rbd_device *third;
> -		int ret;
>
>   		/*
>   		 * Follow to the parent with no grandparent and
> @@ -5016,11 +5033,6 @@ static void rbd_dev_remove_parent(struct
> rbd_device *rbd_dev)
>   			second = third;
>   		}
>   		rbd_assert(second);
> -		ret = rbd_dev_header_watch_sync(rbd_dev, 0);
> -		if (ret)
> -			rbd_warn(rbd_dev,
> -				"failed to cancel watch event (%d)\n", ret);
> -		rbd_remove_all_snaps(second);
>   		rbd_bus_del_dev(second);
>   		first->parent = NULL;
>   		first->parent_overlap = 0;
> @@ -5065,19 +5077,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
>   	spin_unlock_irq(&rbd_dev->lock);
>   	if (ret < 0)
>   		goto done;
> -
> -	ret = rbd_dev_header_watch_sync(rbd_dev, 0);
> -	if (ret) {
> -		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
> -		clear_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
> -		smp_mb();
> -		return ret;
> -	}
>   	ret = count;
> -
> -	rbd_dev_remove_parent(rbd_dev);
> -
> -	rbd_remove_all_snaps(rbd_dev);
>   	rbd_bus_del_dev(rbd_dev);
>   	module_put(THIS_MODULE);
>   done:
>

