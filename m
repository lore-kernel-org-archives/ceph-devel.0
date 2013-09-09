From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v3 3/5] rbd: fix use-after free of rbd_dev->disk
Date: Mon,  9 Sep 2013 00:17:00 -0700
Message-ID: <1378711022-20158-4-git-send-email-josh.durgin@inktank.com>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50659 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3IIH2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 03:28:19 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id F1A5626469
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:53 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id DBACA26474
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:53 -0700 (PDT)
In-Reply-To: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Removing a device deallocates the disk, unschedules the watch, and
finally cleans up the rbd_dev structure. rbd_dev_refresh(), called
from the watch callback, updates the disk size and rbd_dev
structure. With no locking between them, rbd_dev_refresh() may use the
device or rbd_dev after they've been freed.

To fix this, check whether RBD_DEV_FLAG_REMOVING is set before
updating the disk size in rbd_dev_refresh(). In order to prevent a
race where rbd_dev_refresh() is already revalidating the disk when
rbd_remove() is called, move the call to rbd_bus_del_dev() after the
watch is unregistered and all notifies are complete. It's safe to
defer deleting this structure because no new requests can be submitted
once the RBD_DEV_FLAG_REMOVING is set, since the device cannot be
opened.

Fixes: http://tracker.ceph.com/issues/5636
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9e5f07f..fe5767a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3325,6 +3325,31 @@ static void rbd_exists_validate(struct rbd_device *rbd_dev)
 		clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 }
 
+static void rbd_dev_update_size(struct rbd_device *rbd_dev)
+{
+	sector_t size;
+	bool removing;
+
+	/*
+	 * Don't hold the lock while doing disk operations,
+	 * or lock ordering will conflict with the bdev mutex via:
+	 * rbd_add() -> blkdev_get() -> rbd_open()
+	 */
+	spin_lock_irq(&rbd_dev->lock);
+	removing = test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
+	spin_unlock_irq(&rbd_dev->lock);
+	/*
+	 * If the device is being removed, rbd_dev->disk has
+	 * been destroyed, so don't try to update its size
+	 */
+	if (!removing) {
+		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
+		dout("setting size to %llu sectors", (unsigned long long)size);
+		set_capacity(rbd_dev->disk, size);
+		revalidate_disk(rbd_dev->disk);
+	}
+}
+
 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	u64 mapping_size;
@@ -3344,12 +3369,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	up_write(&rbd_dev->header_rwsem);
 
 	if (mapping_size != rbd_dev->mapping.size) {
-		sector_t size;
-
-		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
-		dout("setting size to %llu sectors", (unsigned long long)size);
-		set_capacity(rbd_dev->disk, size);
-		revalidate_disk(rbd_dev->disk);
+		rbd_dev_update_size(rbd_dev);
 	}
 
 	return ret;
@@ -5160,7 +5180,6 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	if (ret < 0 || already)
 		return ret;
 
-	rbd_bus_del_dev(rbd_dev);
 	ret = rbd_dev_header_watch_sync(rbd_dev, false);
 	if (ret)
 		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
@@ -5171,6 +5190,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	 */
 	dout("%s: flushing notifies", __func__);
 	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
+	rbd_bus_del_dev(rbd_dev);
 	rbd_dev_image_release(rbd_dev);
 	module_put(THIS_MODULE);
 
-- 
1.7.2.5

