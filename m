From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v2 5/5] rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT osd op
Date: Tue, 25 Feb 2014 17:36:47 +0200
Message-ID: <1393342607-23653-6-git-send-email-ilya.dryomov@inktank.com>
References: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:41604 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaBYPhG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 10:37:06 -0500
Received: by mail-lb0-f178.google.com with SMTP id s7so513576lbd.9
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 07:37:03 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id mo3sm22639897lbb.17.2014.02.25.07.37.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Feb 2014 07:37:03 -0800 (PST)
In-Reply-To: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In an effort to reduce fragmentation, prefix every rbd write with
a CEPH_OSD_OP_SETALLOCHINT osd op with an expected_write_size value set
to the object size (1 << order).  Backwards compatibility is taken care
of on the libceph/osd side.

"The CEPH_OSD_OP_SETALLOCHINT hint is durable, in that it's enough to
do it once.  The reason every rbd write is prefixed is that rbd doesn't
explicitly create objects and relies on writes creating them
implicitly, so there is no place to stick a single hint op into.  To
get around that we decided to prefix every rbd write with a hint (just
like write and setattr ops, hint op will create an object implicitly if
it doesn't exist)."

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 drivers/block/rbd.c |   55 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1d6d5f69271b..6534a47009b4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1662,11 +1662,15 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	 */
 	obj_request->xferred = osd_req->r_reply_op_len[0];
 	rbd_assert(obj_request->xferred < (u64)UINT_MAX);
+
 	opcode = osd_req->r_ops[0].op;
 	switch (opcode) {
 	case CEPH_OSD_OP_READ:
 		rbd_osd_read_callback(obj_request);
 		break;
+	case CEPH_OSD_OP_SETALLOCHINT:
+		rbd_assert(osd_req->r_ops[1].op == CEPH_OSD_OP_WRITE);
+		/* fall through */
 	case CEPH_OSD_OP_WRITE:
 		rbd_osd_write_callback(obj_request);
 		break;
@@ -1715,6 +1719,12 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
 			snapc, CEPH_NOSNAP, &mtime);
 }
 
+/*
+ * Create an osd request.  A read request has one osd op (read).
+ * A write request has either one (watch) or two (hint+write) osd ops.
+ * (All rbd data writes are prefixed with an allocation hint op, but
+ * technically osd watch is a write request, hence this distinction.)
+ */
 static struct ceph_osd_request *rbd_osd_req_create(
 					struct rbd_device *rbd_dev,
 					bool write_request,
@@ -1734,7 +1744,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 			snapc = img_request->snapc;
 	}
 
-	rbd_assert(num_ops == 1);
+	rbd_assert(num_ops == 1 || (write_request && num_ops == 2));
 
 	/* Allocate and initialize the request, for the num_ops ops */
 
@@ -1760,8 +1770,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
 
 /*
  * Create a copyup osd request based on the information in the
- * object request supplied.  A copyup request has two osd ops,
- * a copyup method call, and a "normal" write request.
+ * object request supplied.  A copyup request has three osd ops,
+ * a copyup method call, a hint op, and a write op.
  */
 static struct ceph_osd_request *
 rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
@@ -1777,12 +1787,12 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
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
 
@@ -2183,6 +2193,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		const char *object_name;
 		u64 offset;
 		u64 length;
+		unsigned int which = 0;
 
 		object_name = rbd_segment_name(rbd_dev, img_offset);
 		if (!object_name)
@@ -2224,20 +2235,29 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
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
+			osd_req_op_alloc_hint_init(osd_req, which,
+					     rbd_obj_bytes(&rbd_dev->header),
+					     rbd_obj_bytes(&rbd_dev->header),
+					     0);
+			which++;
+		}
+
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
 
@@ -2358,7 +2378,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 
 	/*
 	 * The original osd request is of no use to use any more.
-	 * We need a new one that can hold the two ops in a copyup
+	 * We need a new one that can hold the three ops in a copyup
 	 * request.  Allocate the new copyup osd request for the
 	 * original request, and release the old one.
 	 */
@@ -2377,17 +2397,22 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	osd_req_op_cls_request_data_pages(osd_req, 0, pages, parent_length, 0,
 						false, false);
 
-	/* Then the original write request op */
+	/* Then the hint op */
+
+	osd_req_op_alloc_hint_init(osd_req, 1, rbd_obj_bytes(&rbd_dev->header),
+				   rbd_obj_bytes(&rbd_dev->header), 0);
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

