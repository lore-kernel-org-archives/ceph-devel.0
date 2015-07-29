From: mchristi@redhat.com
Subject: [PATCH 06/18] rbd: add write test helper
Date: Wed, 29 Jul 2015 04:23:43 -0500
Message-ID: <1438161835-27960-6-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbbG2JYA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:24:00 -0400
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

The next patches add a couple new commands that have write data.
This patch adds a helper to combine all the IMG_REQ write tests.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1df7bdd..8d0b30a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1739,6 +1739,12 @@ static bool img_request_layered_test(struct rbd_img_request *img_request)
 	return test_bit(IMG_REQ_LAYERED, &img_request->flags) != 0;
 }
 
+static bool img_request_is_write_type_test(struct rbd_img_request *img_request)
+{
+	return img_request_write_test(img_request) ||
+	       img_request_discard_test(img_request);
+}
+
 static enum obj_operation_type
 rbd_img_request_op_type(struct rbd_img_request *img_request)
 {
@@ -2024,8 +2030,7 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	rbd_assert(obj_request_img_data_test(obj_request));
 	img_request = obj_request->img_request;
 	rbd_assert(img_request);
-	rbd_assert(img_request_write_test(img_request) ||
-			img_request_discard_test(img_request));
+	rbd_assert(img_request_is_write_type_test(img_request));
 
 	if (img_request_discard_test(img_request))
 		num_osd_ops = 2;
@@ -2259,8 +2264,7 @@ static void rbd_img_request_destroy(struct kref *kref)
 		rbd_dev_parent_put(img_request->rbd_dev);
 	}
 
-	if (img_request_write_test(img_request) ||
-		img_request_discard_test(img_request))
+	if (img_request_is_write_type_test(img_request))
 		ceph_put_snap_context(img_request->snapc);
 
 	kmem_cache_free(rbd_img_request_cache, img_request);
@@ -2977,8 +2981,7 @@ static bool img_obj_request_simple(struct rbd_obj_request *obj_request)
 	rbd_dev = img_request->rbd_dev;
 
 	/* Reads */
-	if (!img_request_write_test(img_request) &&
-	    !img_request_discard_test(img_request))
+	if (!img_request_is_write_type_test(img_request))
 		return true;
 
 	/* Non-layered writes */
-- 
1.8.3.1

