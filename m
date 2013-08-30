From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v2 1/3] rbd: fix use-after free of rbd_dev->disk
Date: Thu, 29 Aug 2013 17:57:06 -0700
Message-ID: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com>
References: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39827 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3H3BJd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 21:09:33 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 60A0626391
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 18:13:27 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 4C2CD26389
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 18:13:27 -0700 (PDT)
In-Reply-To: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Removing a device deallocates the disk, unschedules the watch, and
finally cleans up the rbd_dev structure. rbd_dev_refresh(), called
from the watch callback, updates the disk size and rbd_dev
structure. With no locking between them, rbd_dev_refresh() may use the
device or rbd_dev after they've been freed.

To fix this, add a shutting_down flag and a mutex protecting it to rbd_dev.
Take the mutex and check whether the flag is set before using rbd_dev->disk.
Move this disk-updating to a separate function as well.

Fixes: http://tracker.ceph.com/issues/5636
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fef3687..8ab3362b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -343,6 +343,9 @@ struct rbd_device {
 	struct ceph_osd_event   *watch_event;
 	struct rbd_obj_request	*watch_request;
 
+	bool			shutting_down;	/* rbd_remove() in progress */
+	struct mutex		shutdown_lock;	/* protects shutting_down */
+
 	struct rbd_spec		*parent_spec;
 	u64			parent_overlap;
 	atomic_t		parent_ref;
@@ -3324,6 +3327,24 @@ static void rbd_exists_validate(struct rbd_device *rbd_dev)
 		clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 }
 
+static void rbd_dev_update_size(struct rbd_device *rbd_dev)
+{
+	sector_t size;
+
+	mutex_lock(&rbd_dev->shutdown_lock);
+	/*
+	 * If the device is being removed, rbd_dev->disk has
+	 * been destroyed, so don't try to update its size
+	 */
+	if (!rbd_dev->shutting_down) {
+		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
+		dout("setting size to %llu sectors", (unsigned long long)size);
+		set_capacity(rbd_dev->disk, size);
+		revalidate_disk(rbd_dev->disk);
+	}
+	mutex_unlock(&rbd_dev->shutdown_lock);
+}
+
 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	u64 mapping_size;
@@ -3343,12 +3364,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
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
@@ -3656,6 +3672,8 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	atomic_set(&rbd_dev->parent_ref, 0);
 	INIT_LIST_HEAD(&rbd_dev->node);
 	init_rwsem(&rbd_dev->header_rwsem);
+	mutex_init(&rbd_dev->shutdown_lock);
+	rbd_dev->shutting_down = false;
 
 	rbd_dev->spec = spec;
 	rbd_dev->rbd_client = rbdc;
@@ -5159,7 +5177,16 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	if (ret < 0 || already)
 		return ret;
 
+	/*
+	 * hold shutdown_lock while destroying the device so that
+	 * device destruction will not race with device updates from
+	 * the watch callback
+	 */
+	mutex_lock(&rbd_dev->shutdown_lock);
+	rbd_dev->shutting_down = true;
 	rbd_bus_del_dev(rbd_dev);
+	mutex_unlock(&rbd_dev->shutdown_lock);
+
 	ret = rbd_dev_header_watch_sync(rbd_dev, false);
 	if (ret)
 		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
-- 
1.7.2.5

