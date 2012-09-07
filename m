From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/5] rbd: rename __rbd_init_snaps_header()
Date: Fri, 07 Sep 2012 11:16:23 -0700
Message-ID: <504A39F7.9040708@inktank.com>
References: <5049F7F5.1070609@inktank.com> <5049F914.1050306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39478 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab2IGSQ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 14:16:26 -0400
Received: by dady13 with SMTP id y13so1949676dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 11:16:25 -0700 (PDT)
In-Reply-To: <5049F914.1050306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 06:39 AM, Alex Elder wrote:
> The name __rbd_init_snaps_header() doesn't really convey what that
> function does very well.  Its purpose is to scan a new snapshot
> context and either create or destroy snapshot device entries so
> that local host's view is consistent with the reality maintained
> on the OSDs.  This patch just changes the name of this function,
> to be rbd_dev_snap_devs_update().  Still not perfect, but I think
> better.
>
> Also add some dynamic debug statements to this function.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8cb8e0a..7726368 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -201,7 +201,7 @@ static DEFINE_SPINLOCK(rbd_dev_list_lock);
>   static LIST_HEAD(rbd_client_list);		/* clients */
>   static DEFINE_SPINLOCK(rbd_client_list_lock);
>
> -static int __rbd_init_snaps_header(struct rbd_device *rbd_dev);
> +static int rbd_dev_snap_devs_update(struct rbd_device *rbd_dev);
>   static void rbd_dev_release(struct device *dev);
>   static ssize_t rbd_snap_add(struct device *dev
>   			    struct device_attribute *attr,
> @@ -1848,7 +1848,7 @@ static int __rbd_refresh_header(struct rbd_device
> *rbd_dev, u64 *hver)
>   	WARN_ON(strcmp(rbd_dev->header.object_prefix, h.object_prefix));
>   	kfree(h.object_prefix);
>
> -	ret = __rbd_init_snaps_header(rbd_dev);
> +	ret = rbd_dev_snap_devs_update(rbd_dev);
>
>   	up_write(&rbd_dev->header_rwsem);
>
> @@ -1880,7 +1880,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   		return rc;
>
>   	/* no need to lock here, as rbd_dev is not registered yet */
> -	rc = __rbd_init_snaps_header(rbd_dev);
> +	rc = rbd_dev_snap_devs_update(rbd_dev);
>   	if (rc)
>   		return rc;
>
> @@ -2184,7 +2184,7 @@ err:
>    * snapshot id, highest id first.  (Snapshots in the rbd_dev's list
>    * are also maintained in that order.)
>    */
> -static int __rbd_init_snaps_header(struct rbd_device *rbd_dev)
> +static int rbd_dev_snap_devs_update(struct rbd_device *rbd_dev)
>   {
>   	struct ceph_snap_context *snapc = rbd_dev->header.snapc;
>   	const u32 snap_count = snapc->num_snaps;
> @@ -2193,6 +2193,7 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   	struct list_head *links = head->next;
>   	u32 index = 0;
>
> +	dout("%s: snap count is %u\n", __func__, (unsigned int) snap_count);
>   	while (index < snap_count || links != head) {
>   		u64 snap_id;
>   		struct rbd_snap *snap;
> @@ -2211,6 +2212,9 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   			if (rbd_dev->snap_id == snap->id)
>   				rbd_dev->snap_exists = false;
>   			__rbd_remove_snap_dev(snap);
> +			dout("%ssnap id %llu has been removed\n",
> +				rbd_dev->snap_id == snap->id ? "mapped " : "",
> +				(unsigned long long) snap->id);
>
>   			/* Done with this list entry; advance */
>
> @@ -2218,6 +2222,8 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   			continue;
>   		}
>
> +		dout("entry %u: snap_id = %llu\n", (unsigned int) snap_count,
> +			(unsigned long long) snap_id);
>   		if (!snap || (snap_id != CEPH_NOSNAP && snap->id < snap_id)) {
>   			struct rbd_snap *new_snap;
>
> @@ -2225,11 +2231,17 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>
>   			new_snap = __rbd_add_snap_dev(rbd_dev, index,
>   							snap_name);
> -			if (IS_ERR(new_snap))
> -				return PTR_ERR(new_snap);
> +			if (IS_ERR(new_snap)) {
> +				int err = PTR_ERR(new_snap);
> +
> +				dout("  failed to add dev, error %d\n", err);
> +
> +				return err;
> +			}
>
>   			/* New goes before existing, or at end of list */
>
> +			dout("  added dev%s\n", snap ? "" : " at end\n");
>   			if (snap)
>   				list_add_tail(&new_snap->node, &snap->node);
>   			else
> @@ -2237,6 +2249,8 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   		} else {
>   			/* Already have this one */
>
> +			dout("  already present\n");
> +
>   			rbd_assert(snap->size ==
>   					rbd_dev->header.snap_sizes[index]);
>   			rbd_assert(!strcmp(snap->name, snap_name));
> @@ -2251,6 +2265,7 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   		index++;
>   		snap_name += strlen(snap_name) + 1;
>   	}
> +	dout("%s: done\n", __func__);
>
>   	return 0;
>   }
>

