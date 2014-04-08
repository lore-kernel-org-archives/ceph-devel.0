From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 10/11] rbd: use helpers to handle discard for layered images correctly
Date: Tue,  8 Apr 2014 13:42:54 -0700
Message-ID: <d0ba691a26e050abe7284ab7859b1f481c380557.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56373 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756826AbaDHWCY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:24 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 05197267C6
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:32 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E9195267DA
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Only allocate two osd ops for discard requests, since the
preallocation hint is only added for regular writes.  Use
rbd_img_obj_request_fill() to recreate the original write or discard
osd operations, isolating that logic to one place, and change the
assert in rbd_osd_req_create_copyup() to accept discard requests as
well.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7bcdeda..c8fc8fc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1838,9 +1838,10 @@ static struct ceph_osd_request *rbd_osd_req_create(
 }
 
 /*
- * Create a copyup osd request based on the information in the
- * object request supplied.  A copyup request has three osd ops,
- * a copyup method call, a hint op, and a write op.
+ * Create a copyup osd request based on the information in the object
+ * request supplied.  A copyup request has two or three osd ops, a
+ * copyup method call, potentially a hint op, and a write or truncate
+ * or zero op.
  */
 static struct ceph_osd_request *
 rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
@@ -1850,18 +1851,24 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	struct rbd_device *rbd_dev;
 	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *osd_req;
+	int num_osd_ops = 3;
 
 	rbd_assert(obj_request_img_data_test(obj_request));
 	img_request = obj_request->img_request;
 	rbd_assert(img_request);
-	rbd_assert(img_request_write_test(img_request));
+	rbd_assert(img_request_write_test(img_request) ||
+			img_request_discard_test(img_request));
 
-	/* Allocate and initialize the request, for the three ops */
+	if (img_request_discard_test(img_request))
+		num_osd_ops = 2;
+
+	/* Allocate and initialize the request, for all the ops */
 
 	snapc = img_request->snapc;
 	rbd_dev = img_request->rbd_dev;
 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, 3, false, GFP_ATOMIC);
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_osd_ops,
+						false, GFP_ATOMIC);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
@@ -2401,7 +2408,8 @@ rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request)
 	struct page **pages;
 	u32 page_count;
 
-	rbd_assert(obj_request->type == OBJ_REQUEST_BIO);
+	rbd_assert(obj_request->type == OBJ_REQUEST_BIO ||
+		obj_request->type == OBJ_REQUEST_NODATA);
 	rbd_assert(obj_request_img_data_test(obj_request));
 	img_request = obj_request->img_request;
 	rbd_assert(img_request);
@@ -2439,11 +2447,10 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	struct ceph_osd_client *osdc;
 	struct rbd_device *rbd_dev;
 	struct page **pages;
+	enum obj_operation_type op_type;
 	u32 page_count;
 	int img_result;
 	u64 parent_length;
-	u64 offset;
-	u64 length;
 
 	rbd_assert(img_request_child_test(img_request));
 
@@ -2507,26 +2514,10 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	osd_req_op_cls_request_data_pages(osd_req, 0, pages, parent_length, 0,
 						false, false);
 
-	/* Then the hint op */
-
-	osd_req_op_alloc_hint_init(osd_req, 1, rbd_obj_bytes(&rbd_dev->header),
-				   rbd_obj_bytes(&rbd_dev->header));
-
-	/* And the original write request op */
-
-	offset = orig_request->offset;
-	length = orig_request->length;
-	osd_req_op_extent_init(osd_req, 2, CEPH_OSD_OP_WRITE,
-					offset, length, 0, 0);
-	if (orig_request->type == OBJ_REQUEST_BIO)
-		osd_req_op_extent_osd_data_bio(osd_req, 2,
-					orig_request->bio_list, length);
-	else
-		osd_req_op_extent_osd_data_pages(osd_req, 2,
-					orig_request->pages, length,
-					offset & ~PAGE_MASK, false, false);
+	/* Add the other op(s) */
 
-	rbd_osd_req_format_write(orig_request);
+	op_type = rbd_img_request_op_type(orig_request->img_request);
+	rbd_img_obj_request_fill(orig_request, osd_req, op_type, 1);
 
 	/* All set, send it off. */
 
-- 
1.7.10.4

