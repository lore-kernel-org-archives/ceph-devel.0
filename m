From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 12/14] rbd: use rbd_obj_watch_request_helper() helper
Date: Wed, 25 Jun 2014 21:16:45 +0400
Message-ID: <1403716607-13535-13-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36690 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700AbaFYRRW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:22 -0400
Received: by mail-la0-f44.google.com with SMTP id ty20so991243lab.17
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:21 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id ul4sm4215647lbb.33.2014.06.25.10.17.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:20 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Switch rbd_dev_header_{un,}watch_sync() to use the new helper and fix
rbd_dev_header_unwatch_sync() to destroy watch_request structures
before queuing watch-remove message while at it.  This mistake slipped
into commit b30a01f2a307 ("rbd: fix osd_request memory leak in
__rbd_dev_header_watch_sync()") and could lead to "image still in use"
errors on image removal.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |  115 ++++++++-------------------------------------------
 1 file changed, 17 insertions(+), 98 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 02cf7aba7679..d99aa81774f8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3040,130 +3040,49 @@ static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 	if (ret < 0)
 		return ret;
 
-	rbd_assert(rbd_dev->watch_event);
-
-	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
-					     OBJ_REQUEST_NODATA);
-	if (!obj_request) {
-		ret = -ENOMEM;
-		goto out_cancel;
+	obj_request = rbd_obj_watch_request_helper(rbd_dev, true);
+	if (IS_ERR(obj_request)) {
+		ceph_osdc_cancel_event(rbd_dev->watch_event);
+		rbd_dev->watch_event = NULL;
+		return PTR_ERR(obj_request);
 	}
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
-						  obj_request);
-	if (!obj_request->osd_req) {
-		ret = -ENOMEM;
-		goto out_put;
-	}
-
-	ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
-
-	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-			      rbd_dev->watch_event->cookie, 0, 1);
-	rbd_osd_req_format_write(obj_request);
-
-	ret = rbd_obj_request_submit(osdc, obj_request);
-	if (ret)
-		goto out_linger;
-
-	ret = rbd_obj_request_wait(obj_request);
-	if (ret)
-		goto out_linger;
-
-	ret = obj_request->result;
-	if (ret)
-		goto out_linger;
-
 	/*
 	 * A watch request is set to linger, so the underlying osd
 	 * request won't go away until we unregister it.  We retain
 	 * a pointer to the object request during that time (in
-	 * rbd_dev->watch_request), so we'll keep a reference to
-	 * it.  We'll drop that reference (below) after we've
-	 * unregistered it.
+	 * rbd_dev->watch_request), so we'll keep a reference to it.
+	 * We'll drop that reference after we've unregistered it in
+	 * rbd_dev_header_unwatch_sync().
 	 */
 	rbd_dev->watch_request = obj_request;
 
 	return 0;
-
-out_linger:
-	ceph_osdc_unregister_linger_request(osdc, obj_request->osd_req);
-out_put:
-	rbd_obj_request_put(obj_request);
-out_cancel:
-	ceph_osdc_cancel_event(rbd_dev->watch_event);
-	rbd_dev->watch_event = NULL;
-
-	return ret;
 }
 
 /*
  * Tear down a watch request, synchronously.
  */
-static int __rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
+static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
 {
-	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
-	int ret;
 
 	rbd_assert(rbd_dev->watch_event);
 	rbd_assert(rbd_dev->watch_request);
 
-	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
-					     OBJ_REQUEST_NODATA);
-	if (!obj_request) {
-		ret = -ENOMEM;
-		goto out_cancel;
-	}
-
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
-						  obj_request);
-	if (!obj_request->osd_req) {
-		ret = -ENOMEM;
-		goto out_put;
-	}
-
-	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-			      rbd_dev->watch_event->cookie, 0, 0);
-	rbd_osd_req_format_write(obj_request);
-
-	ret = rbd_obj_request_submit(osdc, obj_request);
-	if (ret)
-		goto out_put;
-
-	ret = rbd_obj_request_wait(obj_request);
-	if (ret)
-		goto out_put;
-
-	ret = obj_request->result;
-	if (ret)
-		goto out_put;
-
-	/* We have successfully torn down the watch request */
-
-	ceph_osdc_unregister_linger_request(osdc,
-					    rbd_dev->watch_request->osd_req);
+	rbd_obj_request_end(rbd_dev->watch_request);
 	rbd_obj_request_put(rbd_dev->watch_request);
 	rbd_dev->watch_request = NULL;
 
-out_put:
-	rbd_obj_request_put(obj_request);
-out_cancel:
+	obj_request = rbd_obj_watch_request_helper(rbd_dev, false);
+	if (!IS_ERR(obj_request))
+		rbd_obj_request_put(obj_request);
+	else
+		rbd_warn(rbd_dev, "unable to tear down watch request (%ld)",
+			 PTR_ERR(obj_request));
+
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

