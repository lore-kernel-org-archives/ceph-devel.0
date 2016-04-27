From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH] rbd: fix rbd map vs notify races
Date: Wed, 27 Apr 2016 14:11:24 -0700
Message-ID: <57212AFC.90601@redhat.com>
References: <1460741164-22850-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbcD0VL0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Apr 2016 17:11:26 -0400
In-Reply-To: <1460741164-22850-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 04/15/2016 10:26 AM, Ilya Dryomov wrote:
> A while ago, commit 9875201e1049 ("rbd: fix use-after free of
> rbd_dev->disk") fixed rbd unmap vs notify race by introducing
> an exported wrapper for flushing notifies and sticking it into
> do_rbd_remove().
>
> A similar problem exists on the rbd map path, though: the watch is
> registered in rbd_dev_image_probe(), while the disk is set up quite
> a few steps later, in rbd_dev_device_setup().  Nothing prevents
> a notify from coming in and crashing on a NULL rbd_dev->disk:
>
>      BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
>      Call Trace:
>       [<ffffffffa0508344>] rbd_watch_cb+0x34/0x180 [rbd]
>       [<ffffffffa04bd290>] do_event_work+0x40/0xb0 [libceph]
>       [<ffffffff8109d5db>] process_one_work+0x17b/0x470
>       [<ffffffff8109e3ab>] worker_thread+0x11b/0x400
>       [<ffffffff8109e290>] ? rescuer_thread+0x400/0x400
>       [<ffffffff810a5acf>] kthread+0xcf/0xe0
>       [<ffffffff810b41b3>] ? finish_task_switch+0x53/0x170
>       [<ffffffff810a5a00>] ? kthread_create_on_node+0x140/0x140
>       [<ffffffff81645dd8>] ret_from_fork+0x58/0x90
>       [<ffffffff810a5a00>] ? kthread_create_on_node+0x140/0x140
>      RIP  [<ffffffffa050828a>] rbd_dev_refresh+0xfa/0x180 [rbd]
>
> If an error occurs during rbd map, we have to error out, potentially
> tearing down a watch.  Just like on rbd unmap, notifies have to be
> flushed, otherwise rbd_watch_cb() may end up trying to read in the
> image header after rbd_dev_image_release() has run:
>
>      Assertion failure in rbd_dev_header_info() at line 4722:
>
>       rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>
>      Call Trace:
>       [<ffffffff81cccee0>] ? rbd_parent_request_create+0x150/0x150
>       [<ffffffff81cd4e59>] rbd_dev_refresh+0x59/0x390
>       [<ffffffff81cd5229>] rbd_watch_cb+0x69/0x290
>       [<ffffffff81fde9bf>] do_event_work+0x10f/0x1c0
>       [<ffffffff81107799>] process_one_work+0x689/0x1a80
>       [<ffffffff811076f7>] ? process_one_work+0x5e7/0x1a80
>       [<ffffffff81132065>] ? finish_task_switch+0x225/0x640
>       [<ffffffff81107110>] ? pwq_dec_nr_in_flight+0x2b0/0x2b0
>       [<ffffffff81108c69>] worker_thread+0xd9/0x1320
>       [<ffffffff81108b90>] ? process_one_work+0x1a80/0x1a80
>       [<ffffffff8111b02d>] kthread+0x21d/0x2e0
>       [<ffffffff8111ae10>] ? kthread_stop+0x550/0x550
>       [<ffffffff82022802>] ret_from_fork+0x22/0x40
>       [<ffffffff8111ae10>] ? kthread_stop+0x550/0x550
>      RIP  [<ffffffff81ccd8f9>] rbd_dev_header_info+0xa19/0x1e30
>
> To fix this, a) check if RBD_DEV_FLAG_EXISTS is set before calling
> revalidate_disk(), b) move ceph_osdc_flush_notifies() call into
> rbd_dev_header_unwatch_sync() to cover rbd map error paths and c) turn
> header read-in into a critical section.  The latter also happens to
> take care of rbd map foo@bar vs rbd snap rm foo@bar race.
>
> Fixes: http://tracker.ceph.com/issues/15490
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good to me.

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

> ---
>   drivers/block/rbd.c | 43 +++++++++++++++++++------------------------
>   1 file changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 644940377954..9f1eb00b5e64 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -538,7 +538,6 @@ static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
>   				u8 *order, u64 *snap_size);
>   static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
>   		u64 *snap_features);
> -static u64 rbd_snap_id_by_name(struct rbd_device *rbd_dev, const char *name);
>
>   static int rbd_open(struct block_device *bdev, fmode_t mode)
>   {
> @@ -3127,9 +3126,6 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
>   	struct rbd_device *rbd_dev = (struct rbd_device *)data;
>   	int ret;
>
> -	if (!rbd_dev)
> -		return;
> -
>   	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
>   		rbd_dev->header_name, (unsigned long long)notify_id,
>   		(unsigned int)opcode);
> @@ -3263,6 +3259,9 @@ static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
>
>   	ceph_osdc_cancel_event(rbd_dev->watch_event);
>   	rbd_dev->watch_event = NULL;
> +
> +	dout("%s flushing notifies\n", __func__);
> +	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
>   }
>
>   /*
> @@ -3642,21 +3641,14 @@ static void rbd_exists_validate(struct rbd_device *rbd_dev)
>   static void rbd_dev_update_size(struct rbd_device *rbd_dev)
>   {
>   	sector_t size;
> -	bool removing;
>
>   	/*
> -	 * Don't hold the lock while doing disk operations,
> -	 * or lock ordering will conflict with the bdev mutex via:
> -	 * rbd_add() -> blkdev_get() -> rbd_open()
> +	 * If EXISTS is not set, rbd_dev->disk may be NULL, so don't
> +	 * try to update its size.  If REMOVING is set, updating size
> +	 * is just useless work since the device can't be opened.
>   	 */
> -	spin_lock_irq(&rbd_dev->lock);
> -	removing = test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
> -	spin_unlock_irq(&rbd_dev->lock);
> -	/*
> -	 * If the device is being removed, rbd_dev->disk has
> -	 * been destroyed, so don't try to update its size
> -	 */
> -	if (!removing) {
> +	if (test_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags) &&
> +	    !test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags)) {
>   		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>   		dout("setting size to %llu sectors", (unsigned long long)size);
>   		set_capacity(rbd_dev->disk, size);
> @@ -5188,6 +5180,10 @@ out_err:
>   	return ret;
>   }
>
> +/*
> + * rbd_dev->header_rwsem must be locked for write and will be unlocked
> + * upon return.
> + */
>   static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
>   {
>   	int ret;
> @@ -5196,7 +5192,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
>
>   	ret = rbd_dev_id_get(rbd_dev);
>   	if (ret)
> -		return ret;
> +		goto err_out_unlock;
>
>   	BUILD_BUG_ON(DEV_NAME_LEN
>   			< sizeof (RBD_DRV_NAME) + MAX_INT_FORMAT_WIDTH);
> @@ -5237,8 +5233,9 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
>   	/* Everything's ready.  Announce the disk to the world. */
>
>   	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
> -	add_disk(rbd_dev->disk);
> +	up_write(&rbd_dev->header_rwsem);
>
> +	add_disk(rbd_dev->disk);
>   	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
>   		(unsigned long long) rbd_dev->mapping.size);
>
> @@ -5253,6 +5250,8 @@ err_out_blkdev:
>   		unregister_blkdev(rbd_dev->major, rbd_dev->name);
>   err_out_id:
>   	rbd_dev_id_put(rbd_dev);
> +err_out_unlock:
> +	up_write(&rbd_dev->header_rwsem);
>   	return ret;
>   }
>
> @@ -5443,6 +5442,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>   	spec = NULL;		/* rbd_dev now owns this */
>   	rbd_opts = NULL;	/* rbd_dev now owns this */
>
> +	down_write(&rbd_dev->header_rwsem);
>   	rc = rbd_dev_image_probe(rbd_dev, 0);
>   	if (rc < 0)
>   		goto err_out_rbd_dev;
> @@ -5472,6 +5472,7 @@ out:
>   	return rc;
>
>   err_out_rbd_dev:
> +	up_write(&rbd_dev->header_rwsem);
>   	rbd_dev_destroy(rbd_dev);
>   err_out_client:
>   	rbd_put_client(rbdc);
> @@ -5578,12 +5579,6 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
>   		return ret;
>
>   	rbd_dev_header_unwatch_sync(rbd_dev);
> -	/*
> -	 * flush remaining watch callbacks - these must be complete
> -	 * before the osd_client is shutdown
> -	 */
> -	dout("%s: flushing notifies", __func__);
> -	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
>
>   	/*
>   	 * Don't free anything from rbd_dev->disk until after all
>

