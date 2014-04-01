From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 3/3 v3] rbd: add discard support for rbd
Date: Tue,  1 Apr 2014 22:22:16 +0800
Message-ID: <1396362136-8722-2-git-send-email-lucienchao@gmail.com>
References: <1396362136-8722-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:50847 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaDAOfV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Apr 2014 10:35:21 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so9905818pbc.23
        for <ceph-devel@vger.kernel.org>; Tue, 01 Apr 2014 07:35:20 -0700 (PDT)
In-Reply-To: <1396362136-8722-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: josh.durgin@inktank.com, elder@ieee.org

This patch add the discard support for rbd driver.

There are three types operation in the driver:
1. The objects would be removed if they completely contained
   within the discard range.
2. The objects would be truncated if they partly contained within
   the discard range, and align with their boundary.
3. Others would be zeroed.

A discard request from blkdev_issue_discard() is defined which
REQ_WRITE and REQ_DISCARD both marked and no data, so we must
check the REQ_DISCARD first when getting the request type.

This resolve:
	http://tracker.ceph.com/issues/190

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
---
 drivers/block/rbd.c |  110 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ed83fd1..f12c325 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -212,6 +212,7 @@ enum obj_request_type {
 enum obj_operation_type {
 	OBJ_OP_WRITE,
 	OBJ_OP_READ,
+	OBJ_OP_DISCARD,
 };
 
 enum obj_req_flags {
@@ -280,6 +281,7 @@ enum img_req_flags {
 	IMG_REQ_WRITE,		/* I/O direction: read = 0, write = 1 */
 	IMG_REQ_CHILD,		/* initiator: block = 0, child image = 1 */
 	IMG_REQ_LAYERED,	/* ENOENT handling: normal = 0, layered = 1 */
+	IMG_REQ_DISCARD,	/* discard: normal = 0, discard request = 1 */
 };
 
 struct rbd_img_request {
@@ -727,6 +729,8 @@ static char* obj_op_name(enum obj_operation_type op_type)
 		return "read";
 	case OBJ_OP_WRITE:
 		return "write";
+	case OBJ_OP_DISCARD:
+		return "discard";
 	default:
 		return "invalid op code";
 	}
@@ -1521,6 +1525,21 @@ static bool img_request_write_test(struct rbd_img_request *img_request)
 	return test_bit(IMG_REQ_WRITE, &img_request->flags) != 0;
 }
 
+/*
+ * Set the discard flag when the img_request is an discard request
+ */
+static void img_request_discard_set(struct rbd_img_request *img_request)
+{
+	set_bit(IMG_REQ_DISCARD, &img_request->flags);
+	smp_mb();
+}
+
+static bool img_request_discard_test(struct rbd_img_request *img_request)
+{
+	smp_mb();
+	return test_bit(IMG_REQ_DISCARD, &img_request->flags) != 0;
+}
+
 static void img_request_child_set(struct rbd_img_request *img_request)
 {
 	set_bit(IMG_REQ_CHILD, &img_request->flags);
@@ -1643,6 +1662,18 @@ static void rbd_osd_write_callback(struct rbd_obj_request *obj_request)
 	obj_request_done_set(obj_request);
 }
 
+static void rbd_osd_discard_callback(struct rbd_obj_request *obj_request)
+{
+	dout("%s: obj %p result %d %llu\n", __func__, obj_request,
+		obj_request->result, obj_request->length);
+	/*
+	 * There is no such thing as a successful short discard.  Set
+	 * it to our originally-requested length.
+	 */
+	obj_request->xferred = obj_request->length;
+	obj_request_done_set(obj_request);
+}
+
 /*
  * For a simple stat call there's nothing to do.  We'll do more if
  * this is part of a write sequence for a layered image.
@@ -1690,6 +1721,11 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_STAT:
 		rbd_osd_stat_callback(obj_request);
 		break;
+	case CEPH_OSD_OP_DELETE:
+	case CEPH_OSD_OP_TRUNCATE:
+	case CEPH_OSD_OP_ZERO:
+		rbd_osd_discard_callback(obj_request);
+		break;
 	case CEPH_OSD_OP_CALL:
 	case CEPH_OSD_OP_NOTIFY_ACK:
 	case CEPH_OSD_OP_WATCH:
@@ -1741,11 +1777,16 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *osd_req;
 
-	if (obj_request_img_data_test(obj_request) && op_type == OBJ_OP_WRITE) {
+	if (obj_request_img_data_test(obj_request)
+		&& (op_type == OBJ_OP_DISCARD || op_type == OBJ_OP_WRITE)) {
 		struct rbd_img_request *img_request = obj_request->img_request;
-
-		rbd_assert(img_request_write_test(img_request));
 		snapc = img_request->snapc;
+
+		if (op_type == OBJ_OP_WRITE) {
+			rbd_assert(img_request_write_test(img_request));
+		} else {
+			rbd_assert(img_request_discard_test(img_request));
+		}
 	}
 
 	/* Allocate and initialize the request, for the single op */
@@ -1755,7 +1796,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
-	if (op_type == OBJ_OP_WRITE)
+	if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD)
 		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
 	else
 		osd_req->r_flags = CEPH_OSD_FLAG_READ;
@@ -1981,7 +2022,11 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->offset = offset;
 	img_request->length = length;
 	img_request->flags = 0;
-	if (op_type == OBJ_OP_WRITE) {
+
+	if (op_type == OBJ_OP_DISCARD) {
+		img_request_discard_set(img_request);
+		img_request->snapc = rbd_dev->header.snapc;
+	} else if (op_type == OBJ_OP_WRITE) {
 		img_request_write_set(img_request);
 		img_request->snapc = rbd_dev->header.snapc;
 	} else {
@@ -2082,8 +2127,13 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 		struct rbd_device *rbd_dev = img_request->rbd_dev;
 		enum obj_operation_type op_type;
 
-		op_type = img_request_write_test(img_request) ? OBJ_OP_WRITE :
-								OBJ_OP_READ;
+		if (img_request_discard_test(img_request))
+			op_type = OBJ_OP_DISCARD;
+		else if (img_request_write_test(img_request))
+			op_type = OBJ_OP_WRITE;
+		else
+			op_type = OBJ_OP_READ;
+
 		rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
 			obj_op_name(op_type), obj_request->length,
 			obj_request->img_offset, obj_request->offset);
@@ -2168,8 +2218,10 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 	struct bio *bio_list = NULL;
 	unsigned int bio_offset = 0;
 	struct page **pages = NULL;
-	enum obj_operation_type  op_type;
+	enum obj_operation_type op_type;
+	u64 object_size = rbd_obj_bytes(&rbd_dev->header);
 	u64 img_offset;
+	u64 img_end;
 	u64 resid;
 	u16 opcode;
 
@@ -2178,14 +2230,14 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 
 	img_offset = img_request->offset;
 	resid = img_request->length;
+	img_end = rbd_dev->header.image_size;
 	rbd_assert(resid > 0);
 
 	if (type == OBJ_REQUEST_BIO) {
 		bio_list = data_desc;
 		rbd_assert(img_offset ==
 			   bio_list->bi_iter.bi_sector << SECTOR_SHIFT);
-	} else {
-		rbd_assert(type == OBJ_REQUEST_PAGES);
+	} else if (type == OBJ_REQUEST_PAGES) {
 		pages = data_desc;
 	}
 
@@ -2224,7 +2276,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 								GFP_ATOMIC);
 			if (!obj_request->bio_list)
 				goto out_partial;
-		} else {
+		} else if (type == OBJ_REQUEST_PAGES) {
 			unsigned int page_count;
 
 			obj_request->pages = pages;
@@ -2235,7 +2287,19 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 			pages += page_count;
 		}
 
-		if (img_request_write_test(img_request)) {
+		if (img_request_discard_test(img_request)) {
+			op_type = OBJ_OP_DISCARD;
+			if (!offset && (length == object_size)
+				&& (!img_request_layered_test(img_request) ||
+				(rbd_dev->parent_overlap <=
+						obj_request->img_offset)))
+				opcode = CEPH_OSD_OP_DELETE;
+			else if ((offset + length == object_size) ||
+				(obj_request->img_offset + length == img_end))
+				opcode = CEPH_OSD_OP_TRUNCATE;
+			else
+				opcode = CEPH_OSD_OP_ZERO;
+		} else if (img_request_write_test(img_request)) {
 			op_type = OBJ_OP_WRITE;
 			opcode = CEPH_OSD_OP_WRITE;
 		} else {
@@ -2254,12 +2318,13 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		if (type == OBJ_REQUEST_BIO)
 			osd_req_op_extent_osd_data_bio(osd_req, 0,
 					obj_request->bio_list, length);
-		else
+		else if (type == OBJ_REQUEST_PAGES)
 			osd_req_op_extent_osd_data_pages(osd_req, 0,
 					obj_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
 
-		if (op_type == OBJ_OP_WRITE)
+		/* Discards are also writes */
+		if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD)
 			rbd_osd_req_format_write(obj_request);
 		else
 			rbd_osd_req_format_read(obj_request);
@@ -3105,7 +3170,9 @@ static void rbd_request_fn(struct request_queue *q)
 
 		spin_unlock_irq(q->queue_lock);
 
-		if (rq->cmd_flags & REQ_WRITE)
+		if (rq->cmd_flags & REQ_DISCARD)
+			op_type = OBJ_OP_DISCARD;
+		else if (rq->cmd_flags & REQ_WRITE)
 			op_type = OBJ_OP_WRITE;
 		else
 			op_type = OBJ_OP_READ;
@@ -3155,8 +3222,12 @@ static void rbd_request_fn(struct request_queue *q)
 
 		img_request->rq = rq;
 
-		result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
-						rq->bio);
+		if (op_type == OBJ_OP_DISCARD)
+			result = rbd_img_request_fill(img_request,
+						OBJ_REQUEST_NODATA, NULL);
+		else
+			result = rbd_img_request_fill(img_request,
+						OBJ_REQUEST_BIO, rq->bio);
 		if (!result)
 			result = rbd_img_request_submit(img_request);
 		if (result)
@@ -3464,6 +3535,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	blk_queue_io_min(q, segment_size);
 	blk_queue_io_opt(q, segment_size);
 
+	/* enable the discard support */
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
+	q->limits.discard_granularity = segment_size;
+	q->limits.discard_alignment = segment_size;
+
 	blk_queue_merge_bvec(q, rbd_merge_bvec);
 	disk->queue = q;
 
-- 
1.7.9.5

