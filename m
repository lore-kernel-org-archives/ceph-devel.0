From: mchristi@redhat.com
Subject: [PATCH 08/18] rbd: add support for COMPARE_AND_WRITE/CMPEXT
Date: Wed, 29 Jul 2015 04:23:45 -0500
Message-ID: <1438161835-27960-8-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47022 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbbG2JYC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:24:02 -0400
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch adds support to rbd for SCSI COMPARE_AND_WRITE commands. Higher
levels like LIO will work with IMG_REQ_CMP_AND_WRITE requests, but
rbd breaks it up into CMPEXT and WRITE Ceph requests.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 182 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 162 insertions(+), 20 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 425c3d8..b6d7f33 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -216,6 +216,7 @@ enum obj_operation_type {
 	OBJ_OP_WRITE,
 	OBJ_OP_READ,
 	OBJ_OP_DISCARD,
+	OBJ_OP_CMP_AND_WRITE,
 };
 
 enum obj_req_flags {
@@ -289,6 +290,7 @@ enum img_req_flags {
 	IMG_REQ_CHILD,		/* initiator: block = 0, child image = 1 */
 	IMG_REQ_LAYERED,	/* ENOENT handling: normal = 0, layered = 1 */
 	IMG_REQ_DISCARD,	/* discard: normal = 0, discard request = 1 */
+	IMG_REQ_CMP_AND_WRITE,	/* normal = 0, compare and write request = 1 */
 };
 
 struct rbd_img_request {
@@ -296,10 +298,9 @@ struct rbd_img_request {
 	u64			offset;	/* starting image byte offset */
 	u64			length;	/* byte count from offset */
 	unsigned long		flags;
-	union {
-		u64			snap_id;	/* for reads */
-		struct ceph_snap_context *snapc;	/* for writes */
-	};
+
+	u64			snap_id;	/* for reads */
+	struct ceph_snap_context *snapc;	/* for writes */
 
 	struct request		*rq;		/* block request */
 	struct rbd_obj_request	*obj_request;	/* obj req initiator */
@@ -818,6 +819,8 @@ static int obj_num_ops(enum obj_operation_type op_type)
 	switch (op_type) {
 	case OBJ_OP_WRITE:
 		return 2;
+	case OBJ_OP_CMP_AND_WRITE:
+		return 3;
 	default:
 		return 1;
 	}
@@ -832,6 +835,8 @@ static char* obj_op_name(enum obj_operation_type op_type)
 		return "write";
 	case OBJ_OP_DISCARD:
 		return "discard";
+	case OBJ_OP_CMP_AND_WRITE:
+		return "compare-and-write";
 	default:
 		return "???";
 	}
@@ -1749,10 +1754,23 @@ static bool img_request_layered_test(struct rbd_img_request *img_request)
 	return test_bit(IMG_REQ_LAYERED, &img_request->flags) != 0;
 }
 
+static void img_request_cmp_and_write_set(struct rbd_img_request *img_request)
+{
+	set_bit(IMG_REQ_CMP_AND_WRITE, &img_request->flags);
+	smp_mb();
+}
+
+static bool img_request_cmp_and_write_test(struct rbd_img_request *img_request)
+{
+	smp_mb();
+	return test_bit(IMG_REQ_CMP_AND_WRITE, &img_request->flags) != 0;
+}
+
 static bool img_request_is_write_type_test(struct rbd_img_request *img_request)
 {
 	return img_request_write_test(img_request) ||
-	       img_request_discard_test(img_request);
+	       img_request_discard_test(img_request) ||
+	       img_request_cmp_and_write_test(img_request);
 }
 
 static enum obj_operation_type
@@ -1762,6 +1780,8 @@ rbd_img_request_op_type(struct rbd_img_request *img_request)
 		return OBJ_OP_WRITE;
 	else if (img_request_discard_test(img_request))
 		return OBJ_OP_DISCARD;
+	else if (img_request_cmp_and_write_test(img_request))
+		return OBJ_OP_CMP_AND_WRITE;
 	else
 		return OBJ_OP_READ;
 }
@@ -1856,6 +1876,23 @@ static void rbd_osd_write_callback(struct rbd_obj_request *obj_request)
 	obj_request_done_set(obj_request);
 }
 
+static void rbd_osd_cmpext_callback(struct rbd_obj_request *obj_request,
+				    struct ceph_osd_request *osd_req)
+{
+	dout("%s: obj %p result %d %llu\n", __func__, obj_request,
+		obj_request->result, obj_request->length);
+
+	if (obj_request->result == -EILSEQ)
+		/*
+		 * on mismatch reply buf will contain offset and mismatched
+		 * data
+		 */
+		obj_request->xferred = osd_req->r_reply_op_len[1];
+	else
+		obj_request->xferred = obj_request->length;
+	obj_request_done_set(obj_request);
+}
+
 static void rbd_osd_discard_callback(struct rbd_obj_request *obj_request)
 {
 	dout("%s: obj %p result %d %llu\n", __func__, obj_request,
@@ -1915,11 +1952,19 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 		rbd_osd_read_callback(obj_request);
 		break;
 	case CEPH_OSD_OP_SETALLOCHINT:
-		rbd_assert(osd_req->r_ops[1].op == CEPH_OSD_OP_WRITE);
-		/* fall through */
+		if (osd_req->r_ops[1].op == CEPH_OSD_OP_WRITE)
+			rbd_osd_write_callback(obj_request);
+		else if (osd_req->r_ops[1].op == CEPH_OSD_OP_CMPEXT)
+			rbd_osd_cmpext_callback(obj_request, osd_req);
+		else
+			rbd_assert(0);
+		break;
 	case CEPH_OSD_OP_WRITE:
 		rbd_osd_write_callback(obj_request);
 		break;
+	case CEPH_OSD_OP_CMPEXT:
+		rbd_osd_cmpext_callback(obj_request, osd_req);
+		break;
 	case CEPH_OSD_OP_STAT:
 		rbd_osd_stat_callback(obj_request);
 		break;
@@ -1943,6 +1988,22 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 		rbd_obj_request_complete(obj_request);
 }
 
+static void rbd_osd_req_format_rw(struct rbd_obj_request *obj_request)
+{
+	struct rbd_img_request *img_request = obj_request->img_request;
+	struct ceph_osd_request *osd_req = obj_request->osd_req;
+	struct ceph_snap_context *snapc;
+	struct timespec mtime = CURRENT_TIME;
+	u64 snap_id;
+
+	rbd_assert(osd_req != NULL);
+
+	snapc = img_request ? img_request->snapc : NULL;
+	snap_id = img_request ? img_request->snap_id : CEPH_NOSNAP;
+	ceph_osdc_build_request(osd_req, obj_request->offset,
+				snapc, snap_id, &mtime);
+}
+
 static void rbd_osd_req_format_read(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request = obj_request->img_request;
@@ -1975,6 +2036,7 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
  * A write request has either one (watch) or two (hint+write) osd ops.
  * (All rbd data writes are prefixed with an allocation hint op, but
  * technically osd watch is a write request, hence this distinction.)
+ * A extent cmp has three (cmp+write+hint).
  */
 static struct ceph_osd_request *rbd_osd_req_create(
 					struct rbd_device *rbd_dev,
@@ -1987,12 +2049,15 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	struct ceph_osd_request *osd_req;
 
 	if (obj_request_img_data_test(obj_request) &&
-		(op_type == OBJ_OP_DISCARD || op_type == OBJ_OP_WRITE)) {
+		(op_type == OBJ_OP_DISCARD || op_type == OBJ_OP_WRITE ||
+		 op_type == OBJ_OP_CMP_AND_WRITE)) {
 		struct rbd_img_request *img_request = obj_request->img_request;
 		if (op_type == OBJ_OP_WRITE) {
 			rbd_assert(img_request_write_test(img_request));
-		} else {
+		} else if (op_type == OBJ_OP_DISCARD) {
 			rbd_assert(img_request_discard_test(img_request));
+		} else if (op_type == OBJ_OP_CMP_AND_WRITE) {
+			rbd_assert(img_request_cmp_and_write_test(img_request));
 		}
 		snapc = img_request->snapc;
 	}
@@ -2007,7 +2072,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
-	if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD)
+	if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD ||
+	    op_type == OBJ_OP_CMP_AND_WRITE)
 		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
 	else
 		osd_req->r_flags = CEPH_OSD_FLAG_READ;
@@ -2236,6 +2302,10 @@ static struct rbd_img_request *rbd_img_request_create(
 	} else if (op_type == OBJ_OP_WRITE) {
 		img_request_write_set(img_request);
 		img_request->snapc = snapc;
+	} else if (op_type == OBJ_OP_CMP_AND_WRITE) {
+		img_request_cmp_and_write_set(img_request);
+		img_request->snapc = snapc;
+		img_request->snap_id = rbd_dev->spec->snap_id;
 	} else {
 		img_request->snap_id = rbd_dev->spec->snap_id;
 	}
@@ -2332,18 +2402,11 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 	result = obj_request->result;
 	if (result) {
 		struct rbd_device *rbd_dev = img_request->rbd_dev;
-		enum obj_operation_type op_type;
-
-		if (img_request_discard_test(img_request))
-			op_type = OBJ_OP_DISCARD;
-		else if (img_request_write_test(img_request))
-			op_type = OBJ_OP_WRITE;
-		else
-			op_type = OBJ_OP_READ;
 
 		rbd_warn(rbd_dev, "%s %llx at %llx (%llx)",
-			obj_op_name(op_type), obj_request->length,
-			obj_request->img_offset, obj_request->offset);
+			obj_op_name(rbd_img_request_op_type(img_request)),
+			obj_request->length, obj_request->img_offset,
+			obj_request->offset);
 		rbd_warn(rbd_dev, "  result %d xferred %x",
 			result, xferred);
 		if (!img_request->result)
@@ -2624,6 +2687,85 @@ out_unwind:
 	return -ENOMEM;
 }
 
+int rbd_img_cmp_and_write_request_fill(struct rbd_img_request *img_request,
+				       struct scatterlist *cmp_sgl,
+				       u64 cmp_length,
+				       struct scatterlist *write_sgl,
+				       u64 write_length,
+				       struct page **response_pages,
+				       u64 response_length)
+{
+	struct rbd_device *rbd_dev = img_request->rbd_dev;
+	u64 object_size = rbd_obj_bytes(&rbd_dev->header);
+	struct rbd_obj_request *obj_request;
+	struct ceph_osd_request *osd_req;
+	const char *object_name;
+	int num_ops = 0;
+	u64 img_offset;
+	u64 offset;
+
+	img_offset = img_request->offset;
+	offset = rbd_segment_offset(rbd_dev, img_offset);
+
+	/*
+	 * LIO currently only supports 1 sector reqs and we assume the req
+	 * will not span segments.
+	 */
+	if (rbd_segment_length(rbd_dev, offset, cmp_length) != cmp_length)
+		return -EOPNOTSUPP;
+
+	object_name = rbd_segment_name(rbd_dev, img_offset);
+	if (!object_name)
+		return -EINVAL;
+
+	obj_request = rbd_obj_request_create(object_name, offset,
+					     cmp_length, OBJ_REQUEST_SG);
+	/* object request has its own copy of the object name */
+	rbd_segment_name_free(object_name);
+	if (!obj_request)
+		return -ENOMEM;
+
+	rbd_img_obj_request_add(img_request, obj_request);
+
+	obj_request->pages = response_pages;
+	obj_request->page_count = calc_pages_for(0, response_length);
+
+	osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_CMP_AND_WRITE, 3,
+				     obj_request);
+	if (!osd_req)
+		goto del_obj_req;
+
+	obj_request->osd_req = osd_req;
+	obj_request->callback = rbd_img_obj_callback;
+	obj_request->img_offset = img_offset;
+
+	osd_req_op_alloc_hint_init(osd_req, num_ops, object_size, object_size);
+
+	num_ops++;
+	osd_req_op_extent_init(osd_req, num_ops, CEPH_OSD_OP_CMPEXT, offset,
+			       cmp_length, 0, 0);
+	osd_req_op_extent_osd_data_sg(osd_req, num_ops, cmp_sgl, 0, cmp_length);
+	osd_req_op_extent_osd_data_pages(osd_req, num_ops, obj_request->pages,
+					 response_length, 0,
+					 obj_request->page_count, false);
+
+	num_ops++;
+	osd_req_op_extent_init(osd_req, num_ops, CEPH_OSD_OP_WRITE, offset,
+			       write_length, 0, 0);
+	osd_req_op_extent_osd_data_sg(osd_req, num_ops, write_sgl, 0,
+				      write_length);
+
+	rbd_osd_req_format_rw(obj_request);
+
+	rbd_img_request_get(img_request);
+	return 0;
+
+del_obj_req:
+	rbd_img_obj_request_del(img_request, obj_request);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(rbd_img_cmp_and_write_request_fill);
+
 static void
 rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request)
 {
-- 
1.8.3.1

