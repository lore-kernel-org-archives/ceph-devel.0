From: mchristi@redhat.com
Subject: [PATCH 10/18] rbd: add support for writesame requests
Date: Wed, 29 Jul 2015 04:23:47 -0500
Message-ID: <1438161835-27960-10-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbbG2JYD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:24:03 -0400
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This adds support for ceph writesame requests.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b6d7f33..931d2d7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -217,6 +217,7 @@ enum obj_operation_type {
 	OBJ_OP_READ,
 	OBJ_OP_DISCARD,
 	OBJ_OP_CMP_AND_WRITE,
+	OBJ_OP_WRITESAME,
 };
 
 enum obj_req_flags {
@@ -291,6 +292,7 @@ enum img_req_flags {
 	IMG_REQ_LAYERED,	/* ENOENT handling: normal = 0, layered = 1 */
 	IMG_REQ_DISCARD,	/* discard: normal = 0, discard request = 1 */
 	IMG_REQ_CMP_AND_WRITE,	/* normal = 0, compare and write request = 1 */
+	IMG_REQ_WRITESAME,	/* normal = 0, write same = 1 */
 };
 
 struct rbd_img_request {
@@ -818,6 +820,7 @@ static int obj_num_ops(enum obj_operation_type op_type)
 {
 	switch (op_type) {
 	case OBJ_OP_WRITE:
+	case OBJ_OP_WRITESAME:
 		return 2;
 	case OBJ_OP_CMP_AND_WRITE:
 		return 3;
@@ -1703,6 +1706,17 @@ static bool img_request_write_test(struct rbd_img_request *img_request)
 	return test_bit(IMG_REQ_WRITE, &img_request->flags) != 0;
 }
 
+static void img_request_writesame_set(struct rbd_img_request *img_request)
+{
+	set_bit(IMG_REQ_WRITESAME, &img_request->flags);
+	smp_mb();
+}
+
+static bool img_request_writesame_test(struct rbd_img_request *img_request)
+{
+	smp_mb();
+	return test_bit(IMG_REQ_WRITESAME, &img_request->flags) != 0;
+}
 /*
  * Set the discard flag when the img_request is an discard request
  */
@@ -1769,6 +1783,7 @@ static bool img_request_cmp_and_write_test(struct rbd_img_request *img_request)
 static bool img_request_is_write_type_test(struct rbd_img_request *img_request)
 {
 	return img_request_write_test(img_request) ||
+	       img_request_writesame_test(img_request) ||
 	       img_request_discard_test(img_request) ||
 	       img_request_cmp_and_write_test(img_request);
 }
@@ -1782,6 +1797,8 @@ rbd_img_request_op_type(struct rbd_img_request *img_request)
 		return OBJ_OP_DISCARD;
 	else if (img_request_cmp_and_write_test(img_request))
 		return OBJ_OP_CMP_AND_WRITE;
+	else if (img_request_writesame_test(img_request))
+		return OBJ_OP_WRITESAME;
 	else
 		return OBJ_OP_READ;
 }
@@ -1952,7 +1969,8 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 		rbd_osd_read_callback(obj_request);
 		break;
 	case CEPH_OSD_OP_SETALLOCHINT:
-		if (osd_req->r_ops[1].op == CEPH_OSD_OP_WRITE)
+		if (osd_req->r_ops[1].op == CEPH_OSD_OP_WRITE ||
+		    osd_req->r_ops[1].op == CEPH_OSD_OP_WRITESAME)
 			rbd_osd_write_callback(obj_request);
 		else if (osd_req->r_ops[1].op == CEPH_OSD_OP_CMPEXT)
 			rbd_osd_cmpext_callback(obj_request, osd_req);
@@ -1960,6 +1978,7 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 			rbd_assert(0);
 		break;
 	case CEPH_OSD_OP_WRITE:
+	case CEPH_OSD_OP_WRITESAME:
 		rbd_osd_write_callback(obj_request);
 		break;
 	case CEPH_OSD_OP_CMPEXT:
@@ -2050,7 +2069,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
 
 	if (obj_request_img_data_test(obj_request) &&
 		(op_type == OBJ_OP_DISCARD || op_type == OBJ_OP_WRITE ||
-		 op_type == OBJ_OP_CMP_AND_WRITE)) {
+		 op_type == OBJ_OP_CMP_AND_WRITE ||
+		 op_type == OBJ_OP_WRITESAME)) {
 		struct rbd_img_request *img_request = obj_request->img_request;
 		if (op_type == OBJ_OP_WRITE) {
 			rbd_assert(img_request_write_test(img_request));
@@ -2058,6 +2078,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
 			rbd_assert(img_request_discard_test(img_request));
 		} else if (op_type == OBJ_OP_CMP_AND_WRITE) {
 			rbd_assert(img_request_cmp_and_write_test(img_request));
+		} else if (op_type == OBJ_OP_WRITESAME) {
+			rbd_assert(img_request_writesame_test(img_request));
 		}
 		snapc = img_request->snapc;
 	}
@@ -2073,7 +2095,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 		return NULL;	/* ENOMEM */
 
 	if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD ||
-	    op_type == OBJ_OP_CMP_AND_WRITE)
+	    op_type == OBJ_OP_CMP_AND_WRITE || op_type == OBJ_OP_WRITESAME)
 		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
 	else
 		osd_req->r_flags = CEPH_OSD_FLAG_READ;
@@ -2302,6 +2324,9 @@ static struct rbd_img_request *rbd_img_request_create(
 	} else if (op_type == OBJ_OP_WRITE) {
 		img_request_write_set(img_request);
 		img_request->snapc = snapc;
+	} else if (op_type == OBJ_OP_WRITESAME) {
+		img_request_writesame_set(img_request);
+		img_request->snapc = snapc;
 	} else if (op_type == OBJ_OP_CMP_AND_WRITE) {
 		img_request_cmp_and_write_set(img_request);
 		img_request->snapc = snapc;
@@ -2522,12 +2547,21 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
 		osd_req_op_alloc_hint_init(osd_request, num_ops,
 					object_size, object_size);
 		num_ops++;
+	} else if (op_type == OBJ_OP_WRITESAME) {
+		opcode = CEPH_OSD_OP_WRITESAME;
+		osd_req_op_alloc_hint_init(osd_request, num_ops,
+					   object_size, object_size);
+		num_ops++;
 	} else {
 		opcode = CEPH_OSD_OP_READ;
 	}
 
 	if (opcode == CEPH_OSD_OP_DELETE)
 		osd_req_op_init(osd_request, num_ops, opcode, 0);
+	else if (opcode == CEPH_OSD_OP_WRITESAME)
+		osd_req_op_writesame_init(osd_request, num_ops, opcode,
+					  offset, length, min_t(u64, length,
+					  obj_request->sg->length));
 	else
 		osd_req_op_extent_init(osd_request, num_ops, opcode,
 				       offset, length, 0, 0);
@@ -2539,13 +2573,22 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
 		osd_req_op_extent_osd_data_pages(osd_request, num_ops,
 					obj_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
-	else if (obj_request->type == OBJ_REQUEST_SG)
-		osd_req_op_extent_osd_data_sg(osd_request, num_ops,
-					obj_request->sg,
-					obj_request->init_sg_offset, length);
+	else if (obj_request->type == OBJ_REQUEST_SG) {
+		if (op_type == OBJ_OP_WRITESAME)
+			osd_req_op_writesame_osd_data_sg(osd_request, num_ops,
+						obj_request->sg,
+						obj_request->init_sg_offset,
+						min_t(u64, length,
+						obj_request->sg->length));
+		else
+			osd_req_op_extent_osd_data_sg(osd_request, num_ops,
+						obj_request->sg,
+						obj_request->init_sg_offset,
+						length);
+	}
 
 	/* Discards are also writes */
-	if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD)
+	if (img_request_is_write_type_test(img_request))
 		rbd_osd_req_format_write(obj_request);
 	else
 		rbd_osd_req_format_read(obj_request);
-- 
1.8.3.1

