From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 10/14] rbd: rbd_obj_request_wait() should cancel the request if interrupted
Date: Wed, 25 Jun 2014 21:16:43 +0400
Message-ID: <1403716607-13535-11-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:52152 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757668AbaFYRRR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:17 -0400
Received: by mail-la0-f41.google.com with SMTP id hz20so1007735lab.28
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:15 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id ui5sm4216270lbb.32.2014.06.25.10.17.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:14 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_obj_request_wait() should cancel the underlying OSD request if
interrupted.  Otherwise libceph will hold onto it indefinitely, causing
assert failures or leaking the original object request.

This also adds an rbd wrapper around ceph_osdc_cancel_request() to
match rbd_obj_request_submit() and rbd_obj_request_wait().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b2c98c1bc037..20147aec86f3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1527,11 +1527,37 @@ static bool obj_request_type_valid(enum obj_request_type type)
 static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
 				struct rbd_obj_request *obj_request)
 {
-	dout("%s: osdc %p obj %p\n", __func__, osdc, obj_request);
-
+	dout("%s %p\n", __func__, obj_request);
 	return ceph_osdc_start_request(osdc, obj_request->osd_req, false);
 }
 
+static void rbd_obj_request_end(struct rbd_obj_request *obj_request)
+{
+	dout("%s %p\n", __func__, obj_request);
+	ceph_osdc_cancel_request(obj_request->osd_req);
+}
+
+/*
+ * Wait for an object request to complete.  If interrupted, cancel the
+ * underlying osd request.
+ */
+static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
+{
+	int ret;
+
+	dout("%s %p\n", __func__, obj_request);
+
+	ret = wait_for_completion_interruptible(&obj_request->completion);
+	if (ret < 0) {
+		dout("%s %p interrupted\n", __func__, obj_request);
+		rbd_obj_request_end(obj_request);
+		return ret;
+	}
+
+	dout("%s %p done\n", __func__, obj_request);
+	return 0;
+}
+
 static void rbd_img_request_complete(struct rbd_img_request *img_request)
 {
 
@@ -1558,15 +1584,6 @@ static void rbd_img_request_complete(struct rbd_img_request *img_request)
 		rbd_img_request_put(img_request);
 }
 
-/* Caller is responsible for rbd_obj_request_destroy(obj_request) */
-
-static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
-{
-	dout("%s: obj %p\n", __func__, obj_request);
-
-	return wait_for_completion_interruptible(&obj_request->completion);
-}
-
 /*
  * The default/initial value for all image request flags is 0.  Each
  * is conditionally set to 1 at image request initialization time
-- 
1.7.10.4

