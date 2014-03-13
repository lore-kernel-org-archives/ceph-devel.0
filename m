From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 2/3 v2] rbd: extend the operation type
Date: Thu, 13 Mar 2014 11:21:35 +0800
Message-ID: <1394680896-8554-2-git-send-email-lucienchao@gmail.com>
References: <1394680896-8554-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63184 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaCMDV4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 23:21:56 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so451867pdb.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 20:21:56 -0700 (PDT)
In-Reply-To: <1394680896-8554-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org

It could only handle the read and write operations now,
extend it for the coming discard support.

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
---
 drivers/block/rbd.c |   96 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2d48858..fc5bf37 100644
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
@@ -1717,20 +1734,18 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
 
 static struct ceph_osd_request *rbd_osd_req_create(
 					struct rbd_device *rbd_dev,
-					bool write_request,
+					enum obj_operation_type op_type,
 					struct rbd_obj_request *obj_request)
 {
 	struct ceph_snap_context *snapc = NULL;
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
 
 	/* Allocate and initialize the request, for the single op */
@@ -1740,7 +1755,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
-	if (write_request)
+	if (op_type == OBJ_OP_WRITE)
 		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
 	else
 		osd_req->r_flags = CEPH_OSD_FLAG_READ;
@@ -1947,7 +1962,7 @@ static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
 static struct rbd_img_request *rbd_img_request_create(
 					struct rbd_device *rbd_dev,
 					u64 offset, u64 length,
-					bool write_request)
+					enum obj_operation_type op_type)
 {
 	struct rbd_img_request *img_request;
 
@@ -1955,7 +1970,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	if (!img_request)
 		return NULL;
 
-	if (write_request) {
+	if (op_type == OBJ_OP_WRITE) {
 		down_read(&rbd_dev->header_rwsem);
 		ceph_get_snap_context(rbd_dev->header.snapc);
 		up_read(&rbd_dev->header_rwsem);
@@ -1966,7 +1981,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->offset = offset;
 	img_request->length = length;
 	img_request->flags = 0;
-	if (write_request) {
+	if (op_type == OBJ_OP_WRITE) {
 		img_request_write_set(img_request);
 		img_request->snapc = rbd_dev->header.snapc;
 	} else {
@@ -1983,8 +1998,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	kref_init(&img_request->kref);
 
 	dout("%s: rbd_dev %p %s %llu/%llu -> img %p\n", __func__, rbd_dev,
-		write_request ? "write" : "read", offset, length,
-		img_request);
+		 obj_op_name(op_type), offset, length, img_request);
 
 	return img_request;
 }
@@ -2024,8 +2038,8 @@ static struct rbd_img_request *rbd_parent_request_create(
 	rbd_assert(obj_request->img_request);
 	rbd_dev = obj_request->img_request->rbd_dev;
 
-	parent_request = rbd_img_request_create(rbd_dev->parent,
-						img_offset, length, false);
+	parent_request = rbd_img_request_create(rbd_dev->parent, img_offset,
+						length, OBJ_OP_READ);
 	if (!parent_request)
 		return NULL;
 
@@ -2066,11 +2080,13 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 	result = obj_request->result;
 	if (result) {
 		struct rbd_device *rbd_dev = img_request->rbd_dev;
+		enum obj_operation_type op_type;
 
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
@@ -2149,10 +2165,10 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 	struct rbd_device *rbd_dev = img_request->rbd_dev;
 	struct rbd_obj_request *obj_request = NULL;
 	struct rbd_obj_request *next_obj_request;
-	bool write_request = img_request_write_test(img_request);
 	struct bio *bio_list = NULL;
 	unsigned int bio_offset = 0;
 	struct page **pages = NULL;
+	enum obj_operation_type  op_type;
 	u64 img_offset;
 	u64 resid;
 	u16 opcode;
@@ -2160,7 +2176,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 	dout("%s: img %p type %d data_desc %p\n", __func__, img_request,
 		(int)type, data_desc);
 
-	opcode = write_request ? CEPH_OSD_OP_WRITE : CEPH_OSD_OP_READ;
 	img_offset = img_request->offset;
 	resid = img_request->length;
 	rbd_assert(resid > 0);
@@ -2220,8 +2235,15 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 			pages += page_count;
 		}
 
-		osd_req = rbd_osd_req_create(rbd_dev, write_request,
-						obj_request);
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
 			goto out_partial;
 		obj_request->osd_req = osd_req;
@@ -2237,7 +2259,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 					obj_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
 
-		if (write_request)
+		if (op_type == OBJ_OP_WRITE)
 			rbd_osd_req_format_write(obj_request);
 		else
 			rbd_osd_req_format_read(obj_request);
@@ -2604,7 +2626,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 
 	rbd_assert(obj_request->img_request);
 	rbd_dev = obj_request->img_request->rbd_dev;
-	stat_request->osd_req = rbd_osd_req_create(rbd_dev, false,
+	stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ,
 						stat_request);
 	if (!stat_request->osd_req)
 		goto out;
@@ -2827,7 +2849,8 @@ static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
 		return -ENOMEM;
 
 	ret = -ENOMEM;
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ,
+							obj_request);
 	if (!obj_request->osd_req)
 		goto out;
 
@@ -2890,7 +2913,8 @@ static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
 	if (!obj_request)
 		goto out_cancel;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_WRITE,
+							obj_request);
 	if (!obj_request->osd_req)
 		goto out_cancel;
 
@@ -2998,7 +3022,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 	obj_request->pages = pages;
 	obj_request->page_count = page_count;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ,
+							obj_request);
 	if (!obj_request->osd_req)
 		goto out;
 
@@ -3053,7 +3078,7 @@ static void rbd_request_fn(struct request_queue *q)
 	int result;
 
 	while ((rq = blk_fetch_request(q))) {
-		bool write_request = rq_data_dir(rq) == WRITE;
+		enum obj_operation_type op_type;
 		struct rbd_img_request *img_request;
 		u64 offset;
 		u64 length;
@@ -3080,9 +3105,14 @@ static void rbd_request_fn(struct request_queue *q)
 
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
@@ -3119,7 +3149,7 @@ static void rbd_request_fn(struct request_queue *q)
 
 		result = -ENOMEM;
 		img_request = rbd_img_request_create(rbd_dev, offset, length,
-							write_request);
+							op_type);
 		if (!img_request)
 			goto end_request;
 
@@ -3135,8 +3165,7 @@ end_request:
 		spin_lock_irq(q->queue_lock);
 		if (result < 0) {
 			rbd_warn(rbd_dev, "%s %llx at %llx result %d\n",
-				write_request ? "write" : "read",
-				length, offset, result);
+				obj_op_name(op_type), length, offset, result);
 
 			__blk_end_request_all(rq, result);
 		}
@@ -3231,7 +3260,8 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	obj_request->pages = pages;
 	obj_request->page_count = page_count;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ,
+							obj_request);
 	if (!obj_request->osd_req)
 		goto out;
 
-- 
1.7.9.5

