From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 6/6] rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT osd op
Date: Fri, 21 Feb 2014 20:55:46 +0200
Message-ID: <1393008946-7931-7-git-send-email-ilya.dryomov@inktank.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:60726 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbaBUS4J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 13:56:09 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so1778223eei.35
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 10:56:08 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id m8sm19594180eef.14.2014.02.21.10.56.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 10:56:07 -0800 (PST)
In-Reply-To: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In an effort to reduce fragmentation, prefix every rbd write with
a CEPH_OSD_OP_SETALLOCHINT osd op with an expected_write_size value set
to the object size (1 << order).  Backwards compatibility is taken care
of on the libceph/osd side.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   66 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6cf001ef00bc..14496f39c770 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1662,7 +1662,12 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	 */
 	obj_request->xferred = osd_req->r_reply_op_len[0];
 	rbd_assert(obj_request->xferred < (u64)UINT_MAX);
+
 	opcode = osd_req->r_ops[0].op;
+	if (opcode == CEPH_OSD_OP_SETALLOCHINT) {
+		BUG_ON(osd_req->r_ops[1].op != CEPH_OSD_OP_WRITE);
+		opcode = CEPH_OSD_OP_WRITE;
+	}
 	switch (opcode) {
 	case CEPH_OSD_OP_READ:
 		rbd_osd_read_callback(obj_request);
@@ -1715,6 +1720,12 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
 			snapc, CEPH_NOSNAP, &mtime);
 }
 
+/*
+ * Create an osd request.  A read request has one osd op (read).
+ * A write request has either one (watch) or two (hint+write) osd ops.
+ * (All rbd writes are prefixed with an allocation hint op, but
+ * technically osd watch is a write request, hence this distinction.)
+ */
 static struct ceph_osd_request *rbd_osd_req_create(
 					struct rbd_device *rbd_dev,
 					bool write_request,
@@ -1734,7 +1745,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
 			snapc = img_request->snapc;
 	}
 
-	rbd_assert(num_ops == 1);
+	rbd_assert((!write_request && num_ops == 1) ||
+		   (write_request && num_ops >= 1 && num_ops <= 2));
 
 	/* Allocate and initialize the request, for the num_ops ops */
 
@@ -1760,8 +1772,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
 
 /*
  * Create a copyup osd request based on the information in the
- * object request supplied.  A copyup request has two osd ops,
- * a copyup method call, and a "normal" write request.
+ * object request supplied.  A copyup request has three osd ops,
+ * a copyup method call, a hint op, and a write op.
  */
 static struct ceph_osd_request *
 rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
@@ -1777,12 +1789,12 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	rbd_assert(img_request);
 	rbd_assert(img_request_write_test(img_request));
 
-	/* Allocate and initialize the request, for the two ops */
+	/* Allocate and initialize the request, for the three ops */
 
 	snapc = img_request->snapc;
 	rbd_dev = img_request->rbd_dev;
 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, 2, false, GFP_ATOMIC);
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, 3, false, GFP_ATOMIC);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
@@ -2159,12 +2171,10 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 	struct page **pages = NULL;
 	u64 img_offset;
 	u64 resid;
-	u16 opcode;
 
 	dout("%s: img %p type %d data_desc %p\n", __func__, img_request,
 		(int)type, data_desc);
 
-	opcode = write_request ? CEPH_OSD_OP_WRITE : CEPH_OSD_OP_READ;
 	img_offset = img_request->offset;
 	resid = img_request->length;
 	rbd_assert(resid > 0);
@@ -2183,6 +2193,8 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		const char *object_name;
 		u64 offset;
 		u64 length;
+		unsigned int which;
+		u16 opcode;
 
 		object_name = rbd_segment_name(rbd_dev, img_offset);
 		if (!object_name)
@@ -2224,20 +2236,34 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 			pages += page_count;
 		}
 
-		osd_req = rbd_osd_req_create(rbd_dev, write_request, 1,
+		osd_req = rbd_osd_req_create(rbd_dev, write_request,
+					     (write_request ? 2 : 1),
 					     obj_request);
 		if (!osd_req)
 			goto out_partial;
 		obj_request->osd_req = osd_req;
 		obj_request->callback = rbd_img_obj_callback;
 
-		osd_req_op_extent_init(osd_req, 0, opcode, offset, length,
-						0, 0);
+		if (write_request) {
+			osd_req_op_hint_init(osd_req, 0,
+					     CEPH_OSD_OP_SETALLOCHINT,
+					     rbd_obj_bytes(&rbd_dev->header),
+					     rbd_obj_bytes(&rbd_dev->header),
+					     0);
+
+			which = 1;
+			opcode = CEPH_OSD_OP_WRITE;
+		} else {
+			which = 0;
+			opcode = CEPH_OSD_OP_READ;
+		}
+		osd_req_op_extent_init(osd_req, which, opcode, offset, length,
+				       0, 0);
 		if (type == OBJ_REQUEST_BIO)
-			osd_req_op_extent_osd_data_bio(osd_req, 0,
+			osd_req_op_extent_osd_data_bio(osd_req, which,
 					obj_request->bio_list, length);
 		else
-			osd_req_op_extent_osd_data_pages(osd_req, 0,
+			osd_req_op_extent_osd_data_pages(osd_req, which,
 					obj_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
 
@@ -2358,7 +2384,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 
 	/*
 	 * The original osd request is of no use to use any more.
-	 * We need a new one that can hold the two ops in a copyup
+	 * We need a new one that can hold the three ops in a copyup
 	 * request.  Allocate the new copyup osd request for the
 	 * original request, and release the old one.
 	 */
@@ -2377,17 +2403,23 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	osd_req_op_cls_request_data_pages(osd_req, 0, pages, parent_length, 0,
 						false, false);
 
-	/* Then the original write request op */
+	/* Then the hint op */
+
+	osd_req_op_hint_init(osd_req, 1, CEPH_OSD_OP_SETALLOCHINT,
+			     rbd_obj_bytes(&rbd_dev->header),
+			     rbd_obj_bytes(&rbd_dev->header), 0);
+
+	/* And the original write request op */
 
 	offset = orig_request->offset;
 	length = orig_request->length;
-	osd_req_op_extent_init(osd_req, 1, CEPH_OSD_OP_WRITE,
+	osd_req_op_extent_init(osd_req, 2, CEPH_OSD_OP_WRITE,
 					offset, length, 0, 0);
 	if (orig_request->type == OBJ_REQUEST_BIO)
-		osd_req_op_extent_osd_data_bio(osd_req, 1,
+		osd_req_op_extent_osd_data_bio(osd_req, 2,
 					orig_request->bio_list, length);
 	else
-		osd_req_op_extent_osd_data_pages(osd_req, 1,
+		osd_req_op_extent_osd_data_pages(osd_req, 2,
 					orig_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
 
-- 
1.7.10.4

