From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 03/11] rbd: extend the operation type
Date: Tue,  8 Apr 2014 13:42:47 -0700
Message-ID: <84df60d1748ca561d2c984e02ef551bdb2d2f38b.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56376 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133AbaDHWCZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:25 -0400
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Guangliang Zhao <lucienchao@gmail.com>

From: Guangliang Zhao <lucienchao@gmail.com>

It could only handle the read and write operations now,
extend it for the coming discard support.

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 drivers/block/rbd.c |   94 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 282bfcd..c90a60a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -209,6 +209,11 @@ enum obj_request_type {
 	OBJ_REQUEST_NODATA, OBJ_REQUEST_BIO, OBJ_REQUEST_PAGES
 };
 
+enum obj_operation_type {
+	OBJ_OP_WRITE,
+	OBJ_OP_READ,
+};
+
 enum obj_req_flags {
 	OBJ_REQ_DONE,		/* completion flag: not done = 0, done = 1 */
 	OBJ_REQ_IMG_DATA,	/* object usage: standalone = 0, image = 1 */
@@ -715,6 +720,18 @@ static int parse_rbd_opts_token(char *c, void *private)
 	return 0;
 }
 
+static char* obj_op_name(enum obj_operation_type op_type)
+{
+	switch (op_type) {
+	case OBJ_OP_READ:
+		return "read";
+	case OBJ_OP_WRITE:
+		return "write";
+	default:
+		return "invalid op code";
+	}
+}
+
 /*
  * Get a ceph client with specific addr and configuration, if one does
  * not exist create it.  Either way, ceph_opts is consumed by this
@@ -1727,7 +1744,7 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
  */
 static struct ceph_osd_request *rbd_osd_req_create(
 					struct rbd_device *rbd_dev,
-					bool write_request,
+					enum obj_operation_type op_type,
 					unsigned int num_ops,
 					struct rbd_obj_request *obj_request)
 {
@@ -1735,16 +1752,14 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *osd_req;
 
-	if (obj_request_img_data_test(obj_request)) {
+	if (obj_request_img_data_test(obj_request) && op_type == OBJ_OP_WRITE) {
 		struct rbd_img_request *img_request = obj_request->img_request;
 
-		rbd_assert(write_request ==
-				img_request_write_test(img_request));
-		if (write_request)
-			snapc = img_request->snapc;
+		rbd_assert(img_request_write_test(img_request));
+		snapc = img_request->snapc;
 	}
 
-	rbd_assert(num_ops == 1 || (write_request && num_ops == 2));
+	rbd_assert(num_ops == 1 || ((op_type == OBJ_OP_WRITE) && num_ops == 2));
 
 	/* Allocate and initialize the request, for the num_ops ops */
 
@@ -1754,7 +1769,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
-	if (write_request)
+	if (op_type == OBJ_OP_WRITE)
 		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
 	else
 		osd_req->r_flags = CEPH_OSD_FLAG_READ;
@@ -1961,7 +1976,7 @@ static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
 static struct rbd_img_request *rbd_img_request_create(
 					struct rbd_device *rbd_dev,
 					u64 offset, u64 length,
-					bool write_request,
+					enum obj_operation_type op_type,
 					struct ceph_snap_context *snapc)
 {
 	struct rbd_img_request *img_request;
@@ -1975,7 +1990,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->offset = offset;
 	img_request->length = length;
 	img_request->flags = 0;
-	if (write_request) {
+	if (op_type == OBJ_OP_WRITE) {
 		img_request_write_set(img_request);
 		img_request->snapc = snapc;
 	} else {
@@ -1992,8 +2007,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	kref_init(&img_request->kref);
 
 	dout("%s: rbd_dev %p %s %llu/%llu -> img %p\n", __func__, rbd_dev,
-		write_request ? "write" : "read", offset, length,
-		img_request);
+		obj_op_name(op_type), offset, length, img_request);
 
 	return img_request;
 }
@@ -2034,7 +2048,7 @@ static struct rbd_img_request *rbd_parent_request_create(
 	rbd_dev = obj_request->img_request->rbd_dev;
 
 	parent_request = rbd_img_request_create(rbd_dev->parent, img_offset,
-						length, false, NULL);
+						length, OBJ_OP_READ, NULL);
 	if (!parent_request)
 		return NULL;
 
@@ -2075,11 +2089,14 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 	result = obj_request->result;
 	if (result) {
 		struct rbd_device *rbd_dev = img_request->rbd_dev;
+		enum obj_operation_type op_type;
+
+		op_type = img_request_write_test(img_request) ? OBJ_OP_WRITE :
+								OBJ_OP_READ;
 
 		rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
-			img_request_write_test(img_request) ? "write" : "read",
-			obj_request->length, obj_request->img_offset,
-			obj_request->offset);
+			obj_op_name(op_type), obj_request->length,
+			obj_request->img_offset, obj_request->offset);
 		rbd_warn(rbd_dev, "  result %d xferred %x\n",
 			result, xferred);
 		if (!img_request->result)
@@ -2157,10 +2174,10 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 	struct rbd_device *rbd_dev = img_request->rbd_dev;
 	struct rbd_obj_request *obj_request = NULL;
 	struct rbd_obj_request *next_obj_request;
-	bool write_request = img_request_write_test(img_request);
 	struct bio *bio_list = NULL;
 	unsigned int bio_offset = 0;
 	struct page **pages = NULL;
+	enum obj_operation_type op_type;
 	u64 img_offset;
 	u64 resid;
 	u16 opcode;
@@ -2168,7 +2185,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 	dout("%s: img %p type %d data_desc %p\n", __func__, img_request,
 		(int)type, data_desc);
 
-	opcode = write_request ? CEPH_OSD_OP_WRITE : CEPH_OSD_OP_READ;
 	img_offset = img_request->offset;
 	resid = img_request->length;
 	rbd_assert(resid > 0);
@@ -2230,15 +2246,21 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 			pages += page_count;
 		}
 
-		osd_req = rbd_osd_req_create(rbd_dev, write_request,
-					     (write_request ? 2 : 1),
-					     obj_request);
+		if (img_request_write_test(img_request)) {
+			op_type = OBJ_OP_WRITE;
+			opcode = CEPH_OSD_OP_WRITE;
+		} else {
+			op_type = OBJ_OP_READ;
+			opcode = CEPH_OSD_OP_READ;
+		}
+
+		osd_req = rbd_osd_req_create(rbd_dev, op_type, obj_request);
 		if (!osd_req)
 			goto out_unwind;
 		obj_request->osd_req = osd_req;
 		obj_request->callback = rbd_img_obj_callback;
 
-		if (write_request) {
+		if (op_type == OBJ_OP_WRITE) {
 			osd_req_op_alloc_hint_init(osd_req, which,
 					     rbd_obj_bytes(&rbd_dev->header),
 					     rbd_obj_bytes(&rbd_dev->header));
@@ -2255,7 +2277,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 					obj_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
 
-		if (write_request)
+		if (op_type == OBJ_OP_WRITE)
 			rbd_osd_req_format_write(obj_request);
 		else
 			rbd_osd_req_format_read(obj_request);
@@ -2625,7 +2647,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 
 	rbd_assert(obj_request->img_request);
 	rbd_dev = obj_request->img_request->rbd_dev;
-	stat_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+	stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
 						   stat_request);
 	if (!stat_request->osd_req)
 		goto out;
@@ -2848,7 +2870,7 @@ static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
 		return -ENOMEM;
 
 	ret = -ENOMEM;
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
 						  obj_request);
 	if (!obj_request->osd_req)
 		goto out;
@@ -2912,7 +2934,7 @@ static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
 	if (!obj_request)
 		goto out_cancel;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_WRITE, 1,
 						  obj_request);
 	if (!obj_request->osd_req)
 		goto out_cancel;
@@ -3021,7 +3043,7 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 	obj_request->pages = pages;
 	obj_request->page_count = page_count;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
 						  obj_request);
 	if (!obj_request->osd_req)
 		goto out;
@@ -3077,7 +3099,7 @@ static void rbd_request_fn(struct request_queue *q)
 	int result;
 
 	while ((rq = blk_fetch_request(q))) {
-		bool write_request = rq_data_dir(rq) == WRITE;
+		enum obj_operation_type op_type;
 		struct rbd_img_request *img_request;
 		struct ceph_snap_context *snapc = NULL;
 		u64 offset;
@@ -3106,9 +3128,14 @@ static void rbd_request_fn(struct request_queue *q)
 
 		spin_unlock_irq(q->queue_lock);
 
-		/* Disallow writes to a read-only device */
+		if (rq->cmd_flags & REQ_WRITE)
+			op_type = OBJ_OP_WRITE;
+		else
+			op_type = OBJ_OP_READ;
+
+		/* Only allow reads to a read-only device */
 
-		if (write_request) {
+		if (op_type != OBJ_OP_READ) {
 			result = -EROFS;
 			if (read_only)
 				goto end_request;
@@ -3153,7 +3180,7 @@ static void rbd_request_fn(struct request_queue *q)
 
 		result = -ENOMEM;
 		img_request = rbd_img_request_create(rbd_dev, offset, length,
-							write_request, snapc);
+							op_type, snapc);
 		if (!img_request)
 			goto end_request;
 
@@ -3169,8 +3196,7 @@ end_request:
 		spin_lock_irq(q->queue_lock);
 		if (result < 0) {
 			rbd_warn(rbd_dev, "%s %llx at %llx result %d\n",
-				write_request ? "write" : "read",
-				length, offset, result);
+				obj_op_name(op_type), length, offset, result);
 			if (snapc)
 				ceph_put_snap_context(snapc);
 
@@ -3267,7 +3293,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	obj_request->pages = pages;
 	obj_request->page_count = page_count;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
 						  obj_request);
 	if (!obj_request->osd_req)
 		goto out;
-- 
1.7.10.4

