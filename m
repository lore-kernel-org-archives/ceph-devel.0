From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/2] rbd: introduce rbd_dev_header_unwatch_sync() and switch to it
Date: Mon, 16 Dec 2013 22:05:34 +0200
Message-ID: <1387224335-902-2-git-send-email-ilya.dryomov@inktank.com>
References: <1387224335-902-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:61593 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3LPUGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 15:06:25 -0500
Received: by mail-ea0-f178.google.com with SMTP id d10so2432619eaj.37
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 12:06:24 -0800 (PST)
In-Reply-To: <1387224335-902-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Rename rbd_dev_header_watch_sync() to __rbd_dev_header_watch_sync() and
introduce two helpers: rbd_dev_header_{,un}watch_sync() to make it more
clear what is going on.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cb1db2979d3d..c91108b760cf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2866,7 +2866,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
  * Request sync osd watch/unwatch.  The value of "start" determines
  * whether a watch request is being initiated or torn down.
  */
-static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
+static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
@@ -2941,6 +2941,22 @@ out_cancel:
 	return ret;
 }
 
+static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
+{
+	return __rbd_dev_header_watch_sync(rbd_dev, true);
+}
+
+static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
+{
+	int ret;
+
+	ret = __rbd_dev_header_watch_sync(rbd_dev, false);
+	if (ret) {
+		rbd_warn(rbd_dev, "unable to tear down watch request: %d\n",
+			 ret);
+	}
+}
+
 /*
  * Synchronous osd object method call.  Returns the number of bytes
  * returned in the outbound buffer, or a negative error code.
@@ -4961,7 +4977,6 @@ static void rbd_dev_image_release(struct rbd_device *rbd_dev)
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 {
 	int ret;
-	int tmp;
 
 	/*
 	 * Get the id from the image id object.  Unless there's an
@@ -4980,7 +4995,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 		goto err_out_format;
 
 	if (mapping) {
-		ret = rbd_dev_header_watch_sync(rbd_dev, true);
+		ret = rbd_dev_header_watch_sync(rbd_dev);
 		if (ret)
 			goto out_header_name;
 	}
@@ -5007,12 +5022,8 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 err_out_probe:
 	rbd_dev_unprobe(rbd_dev);
 err_out_watch:
-	if (mapping) {
-		tmp = rbd_dev_header_watch_sync(rbd_dev, false);
-		if (tmp)
-			rbd_warn(rbd_dev, "unable to tear down "
-					"watch request (%d)\n", tmp);
-	}
+	if (mapping)
+		rbd_dev_header_unwatch_sync(rbd_dev);
 out_header_name:
 	kfree(rbd_dev->header_name);
 	rbd_dev->header_name = NULL;
@@ -5191,16 +5202,14 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	if (ret < 0 || already)
 		return ret;
 
-	ret = rbd_dev_header_watch_sync(rbd_dev, false);
-	if (ret)
-		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
-
+	rbd_dev_header_unwatch_sync(rbd_dev);
 	/*
 	 * flush remaining watch callbacks - these must be complete
 	 * before the osd_client is shutdown
 	 */
 	dout("%s: flushing notifies", __func__);
 	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
+
 	/*
 	 * Don't free anything from rbd_dev->disk until after all
 	 * notifies are completely processed. Otherwise
-- 
1.7.10.4

