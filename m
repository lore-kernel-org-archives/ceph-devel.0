From: mchristi@redhat.com
Subject: [PATCH 15/18] rbd: export some functions used by lio rbd backend
Date: Wed, 29 Jul 2015 04:23:52 -0500
Message-ID: <1438161835-27960-15-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47506 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbbG2JYH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:24:07 -0400
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

The lio rbd backend will make img_request rbd calls, so this
patch exports the functions it uses.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 931d2d7..d89749c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1552,7 +1552,8 @@ static void rbd_img_request_get(struct rbd_img_request *img_request)
 static bool img_request_child_test(struct rbd_img_request *img_request);
 static void rbd_parent_request_destroy(struct kref *kref);
 static void rbd_img_request_destroy(struct kref *kref);
-static void rbd_img_request_put(struct rbd_img_request *img_request)
+
+void rbd_img_request_put(struct rbd_img_request *img_request)
 {
 	rbd_assert(img_request != NULL);
 	dout("%s: img %p (was %d)\n", __func__, img_request,
@@ -1562,6 +1563,7 @@ static void rbd_img_request_put(struct rbd_img_request *img_request)
 	else
 		kref_put(&img_request->kref, rbd_img_request_destroy);
 }
+EXPORT_SYMBOL(rbd_img_request_put);
 
 static inline void rbd_img_obj_request_add(struct rbd_img_request *img_request,
 					struct rbd_obj_request *obj_request)
@@ -2300,11 +2302,10 @@ static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
  * that comprises the image request, and the Linux request pointer
  * (if there is one).
  */
-static struct rbd_img_request *rbd_img_request_create(
-					struct rbd_device *rbd_dev,
-					u64 offset, u64 length,
-					enum obj_operation_type op_type,
-					struct ceph_snap_context *snapc)
+struct rbd_img_request *rbd_img_request_create(struct rbd_device *rbd_dev,
+					       u64 offset, u64 length,
+					       enum obj_operation_type op_type,
+					       struct ceph_snap_context *snapc)
 {
 	struct rbd_img_request *img_request;
 
@@ -2349,6 +2350,7 @@ static struct rbd_img_request *rbd_img_request_create(
 
 	return img_request;
 }
+EXPORT_SYMBOL(rbd_img_request_create);
 
 static void rbd_img_request_destroy(struct kref *kref)
 {
@@ -2602,9 +2604,8 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
  * function assumes data_desc describes memory sufficient to hold
  * all data described by the image request.
  */
-static int rbd_img_request_fill(struct rbd_img_request *img_request,
-					enum obj_request_type type,
-					void *data_desc)
+int rbd_img_request_fill(struct rbd_img_request *img_request,
+			 enum obj_request_type type, void *data_desc)
 {
 	struct rbd_device *rbd_dev = img_request->rbd_dev;
 	struct rbd_obj_request *obj_request = NULL;
@@ -2729,6 +2730,7 @@ out_unwind:
 
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(rbd_img_request_fill);
 
 int rbd_img_cmp_and_write_request_fill(struct rbd_img_request *img_request,
 				       struct scatterlist *cmp_sgl,
@@ -3234,7 +3236,7 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
 	return rbd_img_obj_exists_submit(obj_request);
 }
 
-static int rbd_img_request_submit(struct rbd_img_request *img_request)
+int rbd_img_request_submit(struct rbd_img_request *img_request)
 {
 	struct rbd_obj_request *obj_request;
 	struct rbd_obj_request *next_obj_request;
@@ -3250,6 +3252,7 @@ static int rbd_img_request_submit(struct rbd_img_request *img_request)
 
 	return 0;
 }
+EXPORT_SYMBOL(rbd_img_request_submit);
 
 static void rbd_img_parent_read_callback(struct rbd_img_request *img_request)
 {
-- 
1.8.3.1

