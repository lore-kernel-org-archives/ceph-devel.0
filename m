From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST] rbd: combine rbd sync watch/unwatch functions
Date: Fri, 04 Jan 2013 08:55:08 -0600
Message-ID: <50E6ED4C.7080009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41110 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab3ADOzJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:55:09 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so13607001iay.5
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:55:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The rbd_req_sync_watch() and rbd_req_sync_unwatch() functions are
nearly identical.  Combine them into a single function with a flag
indicating whether a watch is to be initiated or torn down.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   81
+++++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7c35608..c1e5f24 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1429,74 +1429,48 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 }

 /*
- * Request sync osd watch
+ * Request sync osd watch/unwatch.  The value of "start" determines
+ * whether a watch request is being initiated or torn down.
  */
-static int rbd_req_sync_watch(struct rbd_device *rbd_dev)
+static int rbd_req_sync_watch(struct rbd_device *rbd_dev, int start)
 {
 	struct ceph_osd_req_op *op;
-	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_osd_request **linger_req = NULL;
+	__le64 version = 0;
 	int ret;

 	op = rbd_create_rw_op(CEPH_OSD_OP_WATCH, 0);
 	if (!op)
 		return -ENOMEM;

-	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0,
-				     (void *)rbd_dev, &rbd_dev->watch_event);
-	if (ret < 0)
-		goto fail;
-
-	op->watch.ver = cpu_to_le64(rbd_dev->header.obj_version);
-	op->watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
-	op->watch.flag = 1;
-
-	ret = rbd_req_sync_op(rbd_dev,
-			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      op,
-			      rbd_dev->header_name,
-			      0, 0, NULL,
-			      &rbd_dev->watch_request, NULL);
-
-	if (ret < 0)
-		goto fail_event;
-
-	rbd_destroy_op(op);
-	return 0;
-
-fail_event:
-	ceph_osdc_cancel_event(rbd_dev->watch_event);
-	rbd_dev->watch_event = NULL;
-fail:
-	rbd_destroy_op(op);
-	return ret;
-}
-
-/*
- * Request sync osd unwatch
- */
-static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev)
-{
-	struct ceph_osd_req_op *op;
-	int ret;
+	if (start) {
+		struct ceph_osd_client *osdc;

-	op = rbd_create_rw_op(CEPH_OSD_OP_WATCH, 0);
-	if (!op)
-		return -ENOMEM;
+		osdc = &rbd_dev->rbd_client->client->osdc;
+		ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0, rbd_dev,
+						&rbd_dev->watch_event);
+		if (ret < 0)
+			goto done;
+		version = cpu_to_le64(rbd_dev->header.obj_version);
+		linger_req = &rbd_dev->watch_request;
+	}

-	op->watch.ver = 0;
+	op->watch.ver = version;
 	op->watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
-	op->watch.flag = 0;
+	op->watch.flag = (u8) start ? 1 : 0;

 	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      op,
-			      rbd_dev->header_name,
-			      0, 0, NULL, NULL, NULL);
-
+			      op, rbd_dev->header_name,
+			      0, 0, NULL, linger_req, NULL);

+	if (!start || ret < 0) {
+		ceph_osdc_cancel_event(rbd_dev->watch_event);
+		rbd_dev->watch_event = NULL;
+	}
+done:
 	rbd_destroy_op(op);
-	ceph_osdc_cancel_event(rbd_dev->watch_event);
-	rbd_dev->watch_event = NULL;
+
 	return ret;
 }

@@ -3031,7 +3005,7 @@ static int rbd_init_watch_dev(struct rbd_device
*rbd_dev)
 	int ret, rc;

 	do {
-		ret = rbd_req_sync_watch(rbd_dev);
+		ret = rbd_req_sync_watch(rbd_dev, 1);
 		if (ret == -ERANGE) {
 			rc = rbd_dev_refresh(rbd_dev, NULL);
 			if (rc < 0)
@@ -3750,8 +3724,7 @@ static void rbd_dev_release(struct device *dev)
 						    rbd_dev->watch_request);
 	}
 	if (rbd_dev->watch_event)
-		rbd_req_sync_unwatch(rbd_dev);
-
+		rbd_req_sync_watch(rbd_dev, 0);

 	/* clean up and free blkdev */
 	rbd_free_disk(rbd_dev);
-- 
1.7.9.5

