From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 4/4] rbd: add rbd_obj_watch_request_helper() helper
Date: Fri, 20 Jun 2014 13:09:43 +0400
Message-ID: <1403255383-5729-5-git-send-email-ilya.dryomov@inktank.com>
References: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:63842 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965886AbaFTJJ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 05:09:58 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so2165615lab.23
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jun 2014 02:09:56 -0700 (PDT)
Received: from localhost ([109.110.66.173])
        by mx.google.com with ESMTPSA id ut18sm6142214lbb.38.2014.06.20.02.09.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 02:09:55 -0700 (PDT)
In-Reply-To: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_dev_header_watch_sync() used to handle both watch and unwatch and
was entangled and leaky.  Commit b30a01f2a307 ("rbd: fix osd_request
memory leak in __rbd_dev_header_watch_sync()") split it into two
separate functions.  This commit cleanly abstracts the common bits,
relying on the fixed rbd_obj_request_wait().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |  134 +++++++++++++++++++++------------------------------
 1 file changed, 54 insertions(+), 80 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1701595648ce..deab91b2d967 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2966,30 +2966,21 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
 }
 
 /*
- * Initiate a watch request, synchronously.
+ * Send a (un)watch request and wait for the ack.  Return a request
+ * with a ref held on success or error.
  */
-static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
+static struct rbd_obj_request *rbd_obj_watch_request_helper(
+						struct rbd_device *rbd_dev,
+						bool watch)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
 	int ret;
 
-	rbd_assert(!rbd_dev->watch_event);
-	rbd_assert(!rbd_dev->watch_request);
-
-	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, rbd_dev,
-				     &rbd_dev->watch_event);
-	if (ret < 0)
-		return ret;
-
-	rbd_assert(rbd_dev->watch_event);
-
 	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
 					     OBJ_REQUEST_NODATA);
-	if (!obj_request) {
-		ret = -ENOMEM;
-		goto out_cancel;
-	}
+	if (!obj_request)
+		return ERR_PTR(-ENOMEM);
 
 	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
 						  obj_request);
@@ -2998,12 +2989,13 @@ static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 		goto out_put;
 	}
 
-	ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
-
 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-			      rbd_dev->watch_event->cookie, 0, 1);
+			      rbd_dev->watch_event->cookie, 0, watch);
 	rbd_osd_req_format_write(obj_request);
 
+	if (watch)
+		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
+
 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
 		goto out_linger;
@@ -3016,96 +3008,78 @@ static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 	if (ret)
 		goto out_linger;
 
-	/*
-	 * A watch request is set to linger, so the underlying osd
-	 * request won't go away until we unregister it.  We retain
-	 * a pointer to the object request during that time (in
-	 * rbd_dev->watch_request), so we'll keep a reference to
-	 * it.  We'll drop that reference (below) after we've
-	 * unregistered it.
-	 */
-	rbd_dev->watch_request = obj_request;
-
-	return 0;
+	return obj_request;
 
 out_linger:
-	ceph_osdc_unregister_linger_request(osdc, obj_request->osd_req);
+	if (watch)
+		ceph_osdc_unregister_linger_request(osdc, obj_request->osd_req);
 out_put:
 	rbd_obj_request_put(obj_request);
-out_cancel:
-	ceph_osdc_cancel_event(rbd_dev->watch_event);
-	rbd_dev->watch_event = NULL;
-
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
- * Tear down a watch request, synchronously.
+ * Initiate a watch request, synchronously.
  */
-static int __rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
+static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
 	int ret;
 
-	rbd_assert(rbd_dev->watch_event);
-	rbd_assert(rbd_dev->watch_request);
+	rbd_assert(!rbd_dev->watch_event);
+	rbd_assert(!rbd_dev->watch_request);
 
-	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
-					     OBJ_REQUEST_NODATA);
-	if (!obj_request) {
-		ret = -ENOMEM;
-		goto out_cancel;
-	}
+	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, rbd_dev,
+				     &rbd_dev->watch_event);
+	if (ret < 0)
+		return ret;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
-						  obj_request);
-	if (!obj_request->osd_req) {
-		ret = -ENOMEM;
-		goto out_put;
+	obj_request = rbd_obj_watch_request_helper(rbd_dev, true);
+	if (IS_ERR(obj_request)) {
+		ceph_osdc_cancel_event(rbd_dev->watch_event);
+		rbd_dev->watch_event = NULL;
+		return PTR_ERR(obj_request);
 	}
 
-	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-			      rbd_dev->watch_event->cookie, 0, 0);
-	rbd_osd_req_format_write(obj_request);
+	/*
+	 * A watch request is set to linger, so the underlying osd
+	 * request won't go away until we unregister it.  We retain
+	 * a pointer to the object request during that time (in
+	 * rbd_dev->watch_request), so we'll keep a reference to it.
+	 * We'll drop that reference after we've unregistered it in
+	 * rbd_dev_header_unwatch_sync().
+	 */
+	rbd_dev->watch_request = obj_request;
 
-	ret = rbd_obj_request_submit(osdc, obj_request);
-	if (ret)
-		goto out_put;
+	return 0;
+}
 
-	ret = rbd_obj_request_wait(obj_request);
-	if (ret)
-		goto out_put;
+/*
+ * Tear down a watch request, synchronously.
+ */
+static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
+{
+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct rbd_obj_request *obj_request;
 
-	ret = obj_request->result;
-	if (ret)
-		goto out_put;
+	rbd_assert(rbd_dev->watch_event);
+	rbd_assert(rbd_dev->watch_request);
 
-	/* We have successfully torn down the watch request */
+	obj_request = rbd_obj_watch_request_helper(rbd_dev, false);
+	if (!IS_ERR(obj_request))
+		rbd_obj_request_put(obj_request);
+	else
+		rbd_warn(rbd_dev, "unable to tear down watch request (%ld)",
+			 PTR_ERR(obj_request));
 
 	ceph_osdc_unregister_linger_request(osdc,
 					    rbd_dev->watch_request->osd_req);
 	rbd_obj_request_put(rbd_dev->watch_request);
 	rbd_dev->watch_request = NULL;
 
-out_put:
-	rbd_obj_request_put(obj_request);
-out_cancel:
 	ceph_osdc_cancel_event(rbd_dev->watch_event);
 	rbd_dev->watch_event = NULL;
-
-	return ret;
-}
-
-static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
-{
-	int ret;
-
-	ret = __rbd_dev_header_unwatch_sync(rbd_dev);
-	if (ret) {
-		rbd_warn(rbd_dev, "unable to tear down watch request: %d\n",
-			 ret);
-	}
 }
 
 /*
-- 
1.7.10.4

