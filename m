From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: fix osd_request memory leak in __rbd_dev_header_watch_sync()
Date: Thu, 22 May 2014 20:35:15 +0400
Message-ID: <1400776515-6608-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:54573 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaEVQfU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 May 2014 12:35:20 -0400
Received: by mail-we0-f176.google.com with SMTP id q59so3607598wes.21
        for <ceph-devel@vger.kernel.org>; Thu, 22 May 2014 09:35:18 -0700 (PDT)
Received: from localhost ([109.110.67.203])
        by mx.google.com with ESMTPSA id lz11sm8806605wic.0.2014.05.22.09.35.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 09:35:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

osd_request, along with r_request and r_reply messages attached to it
are leaked in __rbd_dev_header_watch_sync() if the requested image
doesn't exist.  This is because lingering requests are special and get
an extra ref in the reply path.  Fix it by unregistering linger request
on the error path and split __rbd_dev_header_watch_sync() into two
functions to make it maintainable.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |  123 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 38 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 552a2edcaa74..55c34b70842a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2872,56 +2872,55 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
 }
 
 /*
- * Request sync osd watch/unwatch.  The value of "start" determines
- * whether a watch request is being initiated or torn down.
+ * Initiate a watch request, synchronously.
  */
-static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
+static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
 	int ret;
 
-	rbd_assert(start ^ !!rbd_dev->watch_event);
-	rbd_assert(start ^ !!rbd_dev->watch_request);
+	rbd_assert(!rbd_dev->watch_event);
+	rbd_assert(!rbd_dev->watch_request);
 
-	if (start) {
-		ret = ceph_osdc_create_event(osdc, rbd_watch_cb, rbd_dev,
-						&rbd_dev->watch_event);
-		if (ret < 0)
-			return ret;
-		rbd_assert(rbd_dev->watch_event != NULL);
-	}
+	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, rbd_dev,
+				     &rbd_dev->watch_event);
+	if (ret < 0)
+		return ret;
+
+	rbd_assert(rbd_dev->watch_event);
 
-	ret = -ENOMEM;
 	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
-							OBJ_REQUEST_NODATA);
-	if (!obj_request)
+					     OBJ_REQUEST_NODATA);
+	if (!obj_request) {
+		ret = -ENOMEM;
 		goto out_cancel;
+	}
 
 	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
 						  obj_request);
-	if (!obj_request->osd_req)
-		goto out_cancel;
+	if (!obj_request->osd_req) {
+		ret = -ENOMEM;
+		goto out_put;
+	}
 
-	if (start)
-		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
-	else
-		ceph_osdc_unregister_linger_request(osdc,
-					rbd_dev->watch_request->osd_req);
+	ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
 
 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-				rbd_dev->watch_event->cookie, 0, start ? 1 : 0);
+			      rbd_dev->watch_event->cookie, 0, 1);
 	rbd_osd_req_format_write(obj_request);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
-		goto out_cancel;
+		goto out_linger;
+
 	ret = rbd_obj_request_wait(obj_request);
 	if (ret)
-		goto out_cancel;
+		goto out_linger;
+
 	ret = obj_request->result;
 	if (ret)
-		goto out_cancel;
+		goto out_linger;
 
 	/*
 	 * A watch request is set to linger, so the underlying osd
@@ -2931,36 +2930,84 @@ static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
 	 * it.  We'll drop that reference (below) after we've
 	 * unregistered it.
 	 */
-	if (start) {
-		rbd_dev->watch_request = obj_request;
+	rbd_dev->watch_request = obj_request;
 
-		return 0;
+	return 0;
+
+out_linger:
+	ceph_osdc_unregister_linger_request(osdc, obj_request->osd_req);
+out_put:
+	rbd_obj_request_put(obj_request);
+out_cancel:
+	ceph_osdc_cancel_event(rbd_dev->watch_event);
+	rbd_dev->watch_event = NULL;
+
+	return ret;
+}
+
+/*
+ * Tear down a watch request, synchronously.
+ */
+static int __rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
+{
+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct rbd_obj_request *obj_request;
+	int ret;
+
+	rbd_assert(rbd_dev->watch_event);
+	rbd_assert(rbd_dev->watch_request);
+
+	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
+					     OBJ_REQUEST_NODATA);
+	if (!obj_request) {
+		ret = -ENOMEM;
+		goto out_cancel;
 	}
 
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
+						  obj_request);
+	if (!obj_request->osd_req) {
+		ret = -ENOMEM;
+		goto out_put;
+	}
+
+	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
+			      rbd_dev->watch_event->cookie, 0, 0);
+	rbd_osd_req_format_write(obj_request);
+
+	ret = rbd_obj_request_submit(osdc, obj_request);
+	if (ret)
+		goto out_put;
+
+	ret = rbd_obj_request_wait(obj_request);
+	if (ret)
+		goto out_put;
+
+	ret = obj_request->result;
+	if (ret)
+		goto out_put;
+
 	/* We have successfully torn down the watch request */
 
+	ceph_osdc_unregister_linger_request(osdc,
+					    rbd_dev->watch_request->osd_req);
 	rbd_obj_request_put(rbd_dev->watch_request);
 	rbd_dev->watch_request = NULL;
+
+out_put:
+	rbd_obj_request_put(obj_request);
 out_cancel:
-	/* Cancel the event if we're tearing down, or on error */
 	ceph_osdc_cancel_event(rbd_dev->watch_event);
 	rbd_dev->watch_event = NULL;
-	if (obj_request)
-		rbd_obj_request_put(obj_request);
 
 	return ret;
 }
 
-static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
-{
-	return __rbd_dev_header_watch_sync(rbd_dev, true);
-}
-
 static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
 {
 	int ret;
 
-	ret = __rbd_dev_header_watch_sync(rbd_dev, false);
+	ret = __rbd_dev_header_unwatch_sync(rbd_dev);
 	if (ret) {
 		rbd_warn(rbd_dev, "unable to tear down watch request: %d\n",
 			 ret);
-- 
1.7.10.4

