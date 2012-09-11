From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/9] rbd: defer registering snapshot devices
Date: Tue, 11 Sep 2012 07:56:24 -0700
Message-ID: <504F5118.8030404@inktank.com>
References: <504A152E.4000905@inktank.com> <504A165F.1030406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40302 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2IKO41 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 10:56:27 -0400
Received: by pbbrr13 with SMTP id rr13so902053pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 07:56:27 -0700 (PDT)
In-Reply-To: <504A165F.1030406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/07/2012 08:44 AM, Alex Elder wrote:
> When a new snapshot is found in an rbd device's updated snapshot
> context, __rbd_add_snap_dev() is called to create and insert an
> entry in the rbd devices list of snapshots.  In addition, a Linux
> device is registered to represent the snapshot.
>
> For version 2 rbd images, it will be undesirable to initialize the
> device right away.  So in anticipation of that, this patch separates
> the insertion of a snapshot entry in the snaps list from the
> creation of devices for those snapshots.
>
> To do this, create a new function rbd_dev_snaps_register() which
> traverses the list of snapshots and calls rbd_register_snap_dev()
> on any that have not yet been registered.
>
> Rename rbd_dev_snap_devs_update() to be rbd_dev_snaps_update()
> to better reflect that only the entry in the snaps list and not
> the snapshot's device is affected by the function.
>
> For now, call rbd_dev_snaps_register() immediately after each
> call to rbd_dev_snaps_update().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   58
> ++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 14034e3..d03fb0f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -204,7 +204,9 @@ static DEFINE_SPINLOCK(rbd_dev_list_lock);
>   static LIST_HEAD(rbd_client_list);		/* clients */
>   static DEFINE_SPINLOCK(rbd_client_list_lock);
>
> -static int rbd_dev_snap_devs_update(struct rbd_device *rbd_dev);
> +static int rbd_dev_snaps_update(struct rbd_device *rbd_dev);
> +static int rbd_dev_snaps_register(struct rbd_device *rbd_dev);
> +
>   static void rbd_dev_release(struct device *dev);
>   static ssize_t rbd_snap_add(struct device *dev,
>   			    struct device_attribute *attr,
> @@ -648,6 +650,7 @@ static int rbd_header_set_snap(struct rbd_device
> *rbd_dev, char *snap_name)
>   		rbd_dev->mapping.size = rbd_dev->header.image_size;
>   		rbd_dev->mapping.snap_exists = false;
>   		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
> +		ret = 0;
>   	} else {
>   		ret = snap_by_name(rbd_dev, snap_name);
>   		if (ret < 0)
> @@ -656,8 +659,6 @@ static int rbd_header_set_snap(struct rbd_device
> *rbd_dev, char *snap_name)
>   		rbd_dev->mapping.read_only = true;
>   	}
>   	rbd_dev->mapping.snap_name = snap_name;
> -
> -	ret = 0;
>   done:
>   	return ret;
>   }

This hunk seems to be a separate clean up.

> @@ -1840,7 +1841,9 @@ static int __rbd_refresh_header(struct rbd_device
> *rbd_dev, u64 *hver)
>   	WARN_ON(strcmp(rbd_dev->header.object_prefix, h.object_prefix));
>   	kfree(h.object_prefix);
>
> -	ret = rbd_dev_snap_devs_update(rbd_dev);
> +	ret = rbd_dev_snaps_update(rbd_dev);
> +	if (!ret)
> +		ret = rbd_dev_snaps_register(rbd_dev);
>
>   	up_write(&rbd_dev->header_rwsem);
>
> @@ -2085,10 +2088,16 @@ static struct device_type rbd_snap_device_type = {
>   	.release	= rbd_snap_dev_release,
>   };
>
> +static bool rbd_snap_registered(struct rbd_snap *snap)
> +{
> +	return snap->dev.type == &rbd_snap_device_type;
> +}
> +
>   static void __rbd_remove_snap_dev(struct rbd_snap *snap)
>   {
>   	list_del(&snap->node);
> -	device_unregister(&snap->dev);
> +	if (rbd_snap_registered(snap))

Could this be device_is_registered(snap->dev)?

> +		device_unregister(&snap->dev);
>   }
>
>   static int rbd_register_snap_dev(struct rbd_snap *snap,
> @@ -2101,6 +2110,8 @@ static int rbd_register_snap_dev(struct rbd_snap
> *snap,
>   	dev->parent = parent;
>   	dev->release = rbd_snap_dev_release;
>   	dev_set_name(dev, "snap_%s", snap->name);
> +	dout("%s: registering device for snapshot %s\n", __func__, snap->name);
> +
>   	ret = device_register(dev);
>
>   	return ret;
> @@ -2123,11 +2134,6 @@ static struct rbd_snap *__rbd_add_snap_dev(struct
> rbd_device *rbd_dev,
>
>   	snap->size = rbd_dev->header.snap_sizes[i];
>   	snap->id = rbd_dev->header.snapc->snaps[i];
> -	if (device_is_registered(&rbd_dev->dev)) {
> -		ret = rbd_register_snap_dev(snap, &rbd_dev->dev);
> -		if (ret < 0)
> -			goto err;
> -	}
>
>   	return snap;
>
> @@ -2150,7 +2156,7 @@ err:
>    * snapshot id, highest id first.  (Snapshots in the rbd_dev's list
>    * are also maintained in that order.)
>    */
> -static int rbd_dev_snap_devs_update(struct rbd_device *rbd_dev)
> +static int rbd_dev_snaps_update(struct rbd_device *rbd_dev)
>   {
>   	struct ceph_snap_context *snapc = rbd_dev->header.snapc;
>   	const u32 snap_count = snapc->num_snaps;
> @@ -2237,6 +2243,31 @@ static int rbd_dev_snap_devs_update(struct
> rbd_device *rbd_dev)
>   	return 0;
>   }
>
> +/*
> + * Scan the list of snapshots and register the devices for any that
> + * have not already been registered.
> + */
> +static int rbd_dev_snaps_register(struct rbd_device *rbd_dev)
> +{
> +	struct rbd_snap *snap;
> +	int ret = 0;
> +
> +	dout("%s called\n", __func__);
> +	if (!device_is_registered(&rbd_dev->dev))
> +		return 0;
> +
> +	list_for_each_entry(snap, &rbd_dev->snaps, node) {
> +		if (!rbd_snap_registered(snap)) {
> +			ret = rbd_register_snap_dev(snap, &rbd_dev->dev);
> +			if (ret < 0)
> +				break;
> +		}
> +	}
> +	dout("%s: returning %d\n", __func__, ret);
> +
> +	return ret;
> +}
> +
>   static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
>   {
>   	struct device *dev;
> @@ -2587,7 +2618,10 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	if (rc)
>   		goto err_out_unlock;
>
> -	rc = rbd_dev_snap_devs_update(rbd_dev);
> +	rc = rbd_dev_snaps_update(rbd_dev);
> +	if (rc)
> +		goto err_out_unlock;
> +	rc = rbd_dev_snaps_register(rbd_dev);
>   	if (rc)
>   		goto err_out_unlock;
>

