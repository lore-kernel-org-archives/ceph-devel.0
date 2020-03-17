From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/3] rbd: avoid a deadlock on header_rwsem when flushing notifies
Date: Tue, 17 Mar 2020 13:04:20 +0100
Message-ID: <20200317120422.3406-2-idryomov@gmail.com>
References: <20200317120422.3406-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54799 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQMEz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2020 08:04:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so21141297wmc.4
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2020 05:04:53 -0700 (PDT)
Received: from kwango.local (ip-94-112-129-237.net.upcbroadband.cz. [94.112.129.237])
        by smtp.gmail.com with ESMTPSA id p8sm4416706wrw.19.2020.03.17.05.04.48
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 05:04:49 -0700 (PDT)
In-Reply-To: <20200317120422.3406-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_unregister_watch() flushes notifies and therefore cannot be called
under header_rwsem because a header update notify takes header_rwsem to
synchronize with "rbd map".  If mapping an image fails after the watch
is established and a header update notify sneaks in, we deadlock when
erroring out from rbd_dev_image_probe().

Move watch registration and unregistration out of the critical section.
The only reason they were put there was to make header_rwsem management
slightly more obvious.

Fixes: 811c66887746 ("rbd: fix rbd map vs notify races")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a4e7b494344c..f0ce30a6fc69 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4527,6 +4527,10 @@ static void cancel_tasks_sync(struct rbd_device *rbd_dev)
 	cancel_work_sync(&rbd_dev->unlock_work);
 }
 
+/*
+ * header_rwsem must not be held to avoid a deadlock with
+ * rbd_dev_refresh() when flushing notifies.
+ */
 static void rbd_unregister_watch(struct rbd_device *rbd_dev)
 {
 	cancel_tasks_sync(rbd_dev);
@@ -6907,6 +6911,8 @@ static void rbd_dev_image_release(struct rbd_device *rbd_dev)
  * device.  If this image is the one being mapped (i.e., not a
  * parent), initiate a watch on its header object before using that
  * object to get detailed information about the rbd image.
+ *
+ * On success, returns with header_rwsem held for write.
  */
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 {
@@ -6936,6 +6942,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 		}
 	}
 
+	down_write(&rbd_dev->header_rwsem);
 	ret = rbd_dev_header_info(rbd_dev);
 	if (ret) {
 		if (ret == -ENOENT && !need_watch)
@@ -6987,6 +6994,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 err_out_probe:
 	rbd_dev_unprobe(rbd_dev);
 err_out_watch:
+	up_write(&rbd_dev->header_rwsem);
 	if (need_watch)
 		rbd_unregister_watch(rbd_dev);
 err_out_format:
@@ -7050,12 +7058,9 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		goto err_out_rbd_dev;
 	}
 
-	down_write(&rbd_dev->header_rwsem);
 	rc = rbd_dev_image_probe(rbd_dev, 0);
-	if (rc < 0) {
-		up_write(&rbd_dev->header_rwsem);
+	if (rc < 0)
 		goto err_out_rbd_dev;
-	}
 
 	if (rbd_dev->opts->alloc_size > rbd_dev->layout.object_size) {
 		rbd_warn(rbd_dev, "alloc_size adjusted to %u",
-- 
2.19.2
