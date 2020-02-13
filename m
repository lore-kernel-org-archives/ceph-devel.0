From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/5] rbd: kill img_request kref
Date: Thu, 13 Feb 2020 20:26:02 +0100
Message-ID: <20200213192606.31194-2-idryomov@gmail.com>
References: <20200213192606.31194-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42103 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgBMTZo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 14:25:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so8095257wrd.9
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 11:25:43 -0800 (PST)
In-Reply-To: <20200213192606.31194-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>

From: Hannes Reinecke <hare@suse.de>

The reference counter is never increased, so we can as well call
rbd_img_request_destroy() directly and drop the kref.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/rbd.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f206edbbc5d3..22d524a0e98b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -349,7 +349,6 @@ struct rbd_img_request {
 	struct pending_result	pending;
 	struct work_struct	work;
 	int			work_result;
-	struct kref		kref;
 };
 
 #define for_each_obj_request(ireq, oreq) \
@@ -1320,15 +1319,6 @@ static void rbd_obj_request_put(struct rbd_obj_request *obj_request)
 	kref_put(&obj_request->kref, rbd_obj_request_destroy);
 }
 
-static void rbd_img_request_destroy(struct kref *kref);
-static void rbd_img_request_put(struct rbd_img_request *img_request)
-{
-	rbd_assert(img_request != NULL);
-	dout("%s: img %p (was %d)\n", __func__, img_request,
-		kref_read(&img_request->kref));
-	kref_put(&img_request->kref, rbd_img_request_destroy);
-}
-
 static inline void rbd_img_obj_request_add(struct rbd_img_request *img_request,
 					struct rbd_obj_request *obj_request)
 {
@@ -1656,19 +1646,15 @@ static struct rbd_img_request *rbd_img_request_create(
 	INIT_LIST_HEAD(&img_request->lock_item);
 	INIT_LIST_HEAD(&img_request->object_extents);
 	mutex_init(&img_request->state_mutex);
-	kref_init(&img_request->kref);
 
 	return img_request;
 }
 
-static void rbd_img_request_destroy(struct kref *kref)
+static void rbd_img_request_destroy(struct rbd_img_request *img_request)
 {
-	struct rbd_img_request *img_request;
 	struct rbd_obj_request *obj_request;
 	struct rbd_obj_request *next_obj_request;
 
-	img_request = container_of(kref, struct rbd_img_request, kref);
-
 	dout("%s: img %p\n", __func__, img_request);
 
 	WARN_ON(!list_empty(&img_request->lock_item));
@@ -2885,7 +2871,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
 					      obj_req->copyup_bvecs);
 	}
 	if (ret) {
-		rbd_img_request_put(child_img_req);
+		rbd_img_request_destroy(child_img_req);
 		return ret;
 	}
 
@@ -3644,7 +3630,7 @@ static void rbd_img_handle_request(struct rbd_img_request *img_req, int result)
 	if (test_bit(IMG_REQ_CHILD, &img_req->flags)) {
 		struct rbd_obj_request *obj_req = img_req->obj_request;
 
-		rbd_img_request_put(img_req);
+		rbd_img_request_destroy(img_req);
 		if (__rbd_obj_handle_request(obj_req, &result)) {
 			img_req = obj_req->img_request;
 			goto again;
@@ -3652,7 +3638,7 @@ static void rbd_img_handle_request(struct rbd_img_request *img_req, int result)
 	} else {
 		struct request *rq = img_req->rq;
 
-		rbd_img_request_put(img_req);
+		rbd_img_request_destroy(img_req);
 		blk_mq_end_request(rq, errno_to_blk_status(result));
 	}
 }
@@ -4798,7 +4784,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 	return;
 
 err_img_request:
-	rbd_img_request_put(img_request);
+	rbd_img_request_destroy(img_request);
 err_rq:
 	if (result)
 		rbd_warn(rbd_dev, "%s %llx at %llx result %d",
-- 
2.19.2
