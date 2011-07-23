From: Sage Weil <sage@newdream.net>
Subject: [PATCH 13/23] rbd: cancel watch request when releasing the device
Date: Fri, 22 Jul 2011 17:02:52 -0700
Message-ID: <1311379382-9218-14-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44315 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1GWAFz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:55 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>

From: Yehuda Sadeh <yehuda@hq.newdream.net>

We were missing this cleanup, so when a device was released
the osd didn't clean up its watchers list, so following notifications
could be slow as osd needed to timeout on the client.

Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
---
 drivers/block/rbd.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1278098..7392d7a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1253,6 +1253,35 @@ fail:
 	return ret;
 }
 
+/*
+ * Request sync osd unwatch
+ */
+static int rbd_req_sync_unwatch(struct rbd_device *dev,
+				const char *obj)
+{
+	struct ceph_osd_req_op *ops;
+
+	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_WATCH, 0);
+	if (ret < 0)
+		return ret;
+
+	ops[0].watch.ver = 0;
+	ops[0].watch.cookie = cpu_to_le64(dev->watch_event->cookie);
+	ops[0].watch.flag = 0;
+
+	ret = rbd_req_sync_op(dev, NULL,
+			      CEPH_NOSNAP,
+			      0,
+			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
+			      ops,
+			      1, obj, 0, 0, NULL, NULL, NULL);
+
+	rbd_destroy_ops(ops);
+	ceph_osdc_cancel_event(dev->watch_event);
+	dev->watch_event = NULL;
+	return ret;
+}
+
 struct rbd_notify_info {
 	struct rbd_device *dev;
 };
@@ -2290,7 +2319,7 @@ static void rbd_dev_release(struct device *dev)
 		ceph_osdc_unregister_linger_request(&rbd_dev->client->osdc,
 						    rbd_dev->watch_request);
 	if (rbd_dev->watch_event)
-		ceph_osdc_cancel_event(rbd_dev->watch_event);
+		rbd_req_sync_unwatch(rbd_dev, rbd_dev->obj_md_name);
 
 	rbd_put_client(rbd_dev);
 
-- 
1.7.0

