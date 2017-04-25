From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/9] rbd: fix error handling around rbd_init_disk()
Date: Tue, 25 Apr 2017 11:33:39 +0200
Message-ID: <1493112825-16403-4-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34089 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428698AbdDYJeP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:15 -0400
Received: by mail-qt0-f194.google.com with SMTP id y33so24142250qta.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:15 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.13
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:13 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

add_disk() takes an extra reference on disk->queue, which is put in
put_disk() -> disk_release().  Avoiding blk_cleanup_queue() (which also
puts the queue) until add_disk() sets GENHD_FL_UP works for the queue
itself, but leaks various queue internals.  Conditioning tag_set freeing
on GENHD_FL_UP is wrong too: all error paths after rbd_init_disk() leak
the tag_set.

Move the final "announce" steps out of rbd_dev_device_setup() so that
it can be unwound like any other function.  Leave "announce" steps to
do_rbd_add/remove().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 87 +++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a21587732749..aadf35451be7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4114,19 +4114,10 @@ static int rbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void rbd_free_disk(struct rbd_device *rbd_dev)
 {
-	struct gendisk *disk = rbd_dev->disk;
-
-	if (!disk)
-		return;
-
+	blk_cleanup_queue(rbd_dev->disk->queue);
+	blk_mq_free_tag_set(&rbd_dev->tag_set);
+	put_disk(rbd_dev->disk);
 	rbd_dev->disk = NULL;
-	if (disk->flags & GENHD_FL_UP) {
-		del_gendisk(disk);
-		if (disk->queue)
-			blk_cleanup_queue(disk->queue);
-		blk_mq_free_tag_set(&rbd_dev->tag_set);
-	}
-	put_disk(disk);
 }
 
 static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
@@ -4385,8 +4376,12 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
 		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
 
+	/*
+	 * disk_release() expects a queue ref from add_disk() and will
+	 * put it.  Hold an extra ref until add_disk() is called.
+	 */
+	WARN_ON(!blk_get_queue(q));
 	disk->queue = q;
-
 	q->queuedata = rbd_dev;
 
 	rbd_dev->disk = disk;
@@ -5875,6 +5870,15 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 	return ret;
 }
 
+static void rbd_dev_device_release(struct rbd_device *rbd_dev)
+{
+	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
+	rbd_dev_mapping_clear(rbd_dev);
+	rbd_free_disk(rbd_dev);
+	if (!single_major)
+		unregister_blkdev(rbd_dev->major, rbd_dev->name);
+}
+
 /*
  * rbd_dev->header_rwsem must be locked for write and will be unlocked
  * upon return.
@@ -5910,26 +5914,13 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
 
-	dev_set_name(&rbd_dev->dev, "%d", rbd_dev->dev_id);
-	ret = device_add(&rbd_dev->dev);
+	ret = dev_set_name(&rbd_dev->dev, "%d", rbd_dev->dev_id);
 	if (ret)
 		goto err_out_mapping;
 
-	/* Everything's ready.  Announce the disk to the world. */
-
 	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	up_write(&rbd_dev->header_rwsem);
-
-	spin_lock(&rbd_dev_list_lock);
-	list_add_tail(&rbd_dev->node, &rbd_dev_list);
-	spin_unlock(&rbd_dev_list_lock);
-
-	add_disk(rbd_dev->disk);
-	pr_info("%s: capacity %llu features 0x%llx\n", rbd_dev->disk->disk_name,
-		(unsigned long long)get_capacity(rbd_dev->disk) << SECTOR_SHIFT,
-		rbd_dev->header.features);
-
-	return ret;
+	return 0;
 
 err_out_mapping:
 	rbd_dev_mapping_clear(rbd_dev);
@@ -6131,11 +6122,30 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	if (rc)
 		goto err_out_image_probe;
 
+	/* Everything's ready.  Announce the disk to the world. */
+
+	rc = device_add(&rbd_dev->dev);
+	if (rc)
+		goto err_out_device_setup;
+
+	add_disk(rbd_dev->disk);
+	/* see rbd_init_disk() */
+	blk_put_queue(rbd_dev->disk->queue);
+
+	spin_lock(&rbd_dev_list_lock);
+	list_add_tail(&rbd_dev->node, &rbd_dev_list);
+	spin_unlock(&rbd_dev_list_lock);
+
+	pr_info("%s: capacity %llu features 0x%llx\n", rbd_dev->disk->disk_name,
+		(unsigned long long)get_capacity(rbd_dev->disk) << SECTOR_SHIFT,
+		rbd_dev->header.features);
 	rc = count;
 out:
 	module_put(THIS_MODULE);
 	return rc;
 
+err_out_device_setup:
+	rbd_dev_device_release(rbd_dev);
 err_out_image_probe:
 	rbd_dev_image_release(rbd_dev);
 err_out_rbd_dev:
@@ -6165,21 +6175,6 @@ static ssize_t rbd_add_single_major(struct bus_type *bus,
 	return do_rbd_add(bus, buf, count);
 }
 
-static void rbd_dev_device_release(struct rbd_device *rbd_dev)
-{
-	rbd_free_disk(rbd_dev);
-
-	spin_lock(&rbd_dev_list_lock);
-	list_del_init(&rbd_dev->node);
-	spin_unlock(&rbd_dev_list_lock);
-
-	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
-	device_del(&rbd_dev->dev);
-	rbd_dev_mapping_clear(rbd_dev);
-	if (!single_major)
-		unregister_blkdev(rbd_dev->major, rbd_dev->name);
-}
-
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
 {
 	while (rbd_dev->parent) {
@@ -6266,6 +6261,12 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 		blk_set_queue_dying(rbd_dev->disk->queue);
 	}
 
+	del_gendisk(rbd_dev->disk);
+	spin_lock(&rbd_dev_list_lock);
+	list_del_init(&rbd_dev->node);
+	spin_unlock(&rbd_dev_list_lock);
+	device_del(&rbd_dev->dev);
+
 	down_write(&rbd_dev->lock_rwsem);
 	if (__rbd_is_lock_owner(rbd_dev))
 		rbd_unlock(rbd_dev);
-- 
2.4.3

