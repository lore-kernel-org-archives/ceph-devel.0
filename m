From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/3] rbd: use a single workqueue for all devices
Date: Fri, 10 Oct 2014 22:27:06 +0400
Message-ID: <1412965626-11165-4-git-send-email-idryomov@redhat.com>
References: <1412965626-11165-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:35328 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaJJS10 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 14:27:26 -0400
Received: by mail-la0-f42.google.com with SMTP id mk6so3818028lab.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 11:27:24 -0700 (PDT)
In-Reply-To: <1412965626-11165-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Micha Krause <micha@krausam.de>

Using one queue per device doesn't make much sense given that our
workfn processes "devices" and not "requests".  Switch to a single
workqueue for all devices.

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 drivers/block/rbd.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0a54c588e433..be8d44af6ae1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -342,7 +342,6 @@ struct rbd_device {
 
 	struct list_head	rq_queue;	/* incoming rq queue */
 	spinlock_t		lock;		/* queue, flags, open_count */
-	struct workqueue_struct	*rq_wq;
 	struct work_struct	rq_work;
 
 	struct rbd_image_header	header;
@@ -402,6 +401,8 @@ static struct kmem_cache	*rbd_segment_name_cache;
 static int rbd_major;
 static DEFINE_IDA(rbd_dev_id_ida);
 
+static struct workqueue_struct *rbd_wq;
+
 /*
  * Default to false for now, as single-major requires >= 0.75 version of
  * userspace rbd utility.
@@ -3452,7 +3453,7 @@ static void rbd_request_fn(struct request_queue *q)
 	}
 
 	if (queued)
-		queue_work(rbd_dev->rq_wq, &rbd_dev->rq_work);
+		queue_work(rbd_wq, &rbd_dev->rq_work);
 }
 
 /*
@@ -5242,16 +5243,9 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
 
-	rbd_dev->rq_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
-					 rbd_dev->disk->disk_name);
-	if (!rbd_dev->rq_wq) {
-		ret = -ENOMEM;
-		goto err_out_mapping;
-	}
-
 	ret = rbd_bus_add_dev(rbd_dev);
 	if (ret)
-		goto err_out_workqueue;
+		goto err_out_mapping;
 
 	/* Everything's ready.  Announce the disk to the world. */
 
@@ -5263,9 +5257,6 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 
 	return ret;
 
-err_out_workqueue:
-	destroy_workqueue(rbd_dev->rq_wq);
-	rbd_dev->rq_wq = NULL;
 err_out_mapping:
 	rbd_dev_mapping_clear(rbd_dev);
 err_out_disk:
@@ -5512,7 +5503,6 @@ static void rbd_dev_device_release(struct device *dev)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
 
-	destroy_workqueue(rbd_dev->rq_wq);
 	rbd_free_disk(rbd_dev);
 	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	rbd_dev_mapping_clear(rbd_dev);
@@ -5716,11 +5706,21 @@ static int __init rbd_init(void)
 	if (rc)
 		return rc;
 
+	/*
+	 * The number of active work items is limited by the number of
+	 * rbd devices, so leave @max_active at default.
+	 */
+	rbd_wq = alloc_workqueue(RBD_DRV_NAME, WQ_MEM_RECLAIM, 0);
+	if (!rbd_wq) {
+		rc = -ENOMEM;
+		goto err_out_slab;
+	}
+
 	if (single_major) {
 		rbd_major = register_blkdev(0, RBD_DRV_NAME);
 		if (rbd_major < 0) {
 			rc = rbd_major;
-			goto err_out_slab;
+			goto err_out_wq;
 		}
 	}
 
@@ -5738,6 +5738,8 @@ static int __init rbd_init(void)
 err_out_blkdev:
 	if (single_major)
 		unregister_blkdev(rbd_major, RBD_DRV_NAME);
+err_out_wq:
+	destroy_workqueue(rbd_wq);
 err_out_slab:
 	rbd_slab_exit();
 	return rc;
@@ -5749,6 +5751,7 @@ static void __exit rbd_exit(void)
 	rbd_sysfs_cleanup();
 	if (single_major)
 		unregister_blkdev(rbd_major, RBD_DRV_NAME);
+	destroy_workqueue(rbd_wq);
 	rbd_slab_exit();
 }
 
-- 
1.7.10.4

