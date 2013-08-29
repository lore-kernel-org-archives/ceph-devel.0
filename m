From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 3/3] rbd: close remove vs. notify race leading to use-after-free
Date: Wed, 28 Aug 2013 23:24:07 -0700
Message-ID: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com>
References: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35218 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab3H2Ggh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 02:36:37 -0400
In-Reply-To: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>

Removing a device deallocates the disk, unschedules the watch, and
finally cleans up the rbd_dev structure. rbd_dev_refresh(), called
from the watch callback, updates the disk size and rbd_dev
structure. With no locking between them, rbd_dev_refresh() may use the
device or rbd_dev after they've been freed.

To fix this, use the header_rwsem to protect all the work
rbd_dev_refresh() does, and take it exclusively in rbd_remove() where
the block device is released and the watch is canceled.
rbd_bus_del_dev() ends up releasing the block device, so no requests
to the device remain after this. This makes all the work in
rbd_dev_refresh() unnecessary, as well as race-prone, so skip it if
the watch has been canceled.

Finally, flush the osd client's notify queue before deallocating the
rbd dev, so that any callbacks remaining can read rbd_dev->watch_event
safely. No more notifies can enter the queue at this point since the
watch has been canceled.

Fixes: http://tracker.ceph.com/issues/5636
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fef3687..63e1590 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3327,10 +3327,13 @@ static void rbd_exists_validate(struct rbd_device *rbd_dev)
 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	u64 mapping_size;
-	int ret;
+	int ret = 0;
 
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
 	down_write(&rbd_dev->header_rwsem);
+	if (!rbd_dev->watch_event)
+		goto out;
+
 	mapping_size = rbd_dev->mapping.size;
 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_header_info(rbd_dev);
@@ -3340,7 +3343,6 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	/* If it's a mapped snapshot, validate its EXISTS flag */
 
 	rbd_exists_validate(rbd_dev);
-	up_write(&rbd_dev->header_rwsem);
 
 	if (mapping_size != rbd_dev->mapping.size) {
 		sector_t size;
@@ -3350,7 +3352,8 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 		set_capacity(rbd_dev->disk, size);
 		revalidate_disk(rbd_dev->disk);
 	}
-
+out:
+	up_write(&rbd_dev->header_rwsem);
 	return ret;
 }
 
@@ -5159,10 +5162,26 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	if (ret < 0 || already)
 		return ret;
 
+	/*
+	 * take header semaphore while destroying the device and
+	 * canceling the watch so that device destruction will
+	 * not race with device updates from the watch callback
+	 */
+	down_write(&rbd_dev->header_rwsem);
 	rbd_bus_del_dev(rbd_dev);
 	ret = rbd_dev_header_watch_sync(rbd_dev, false);
+	up_write(&rbd_dev->header_rwsem);
+
 	if (ret)
 		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
+
+	/*
+	 * flush remaing watch callbacks - these don't update anything
+	 * anymore since rbd_dev->watch_event is NULL, but it avoids
+	 * the watch callback using a freed rbd_dev
+	 */
+	dout("%s: flushing notifies", __func__);
+	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
 	rbd_dev_image_release(rbd_dev);
 	module_put(THIS_MODULE);
 
-- 
1.7.2.5

