From: Alex Elder <elder@inktank.com>
Subject: [PATCH 11/20] libceph: specify osd op by index in request
Date: Fri, 05 Apr 2013 09:04:10 -0500
Message-ID: <515ED9DA.6090009@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:46328 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161833Ab3DEOEN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:04:13 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so4395855ieb.31
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:04:12 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

An osd request now holds all of its source op structures, and every
place that initializes one of these is in fact initializing one
of the entries in the the osd request's array.

So rather than supplying the address of the op to initialize, have
caller specify the osd request and an indication of which op it
would like to initialize.  This better hides the details the
op structure (and faciltates moving the data pointers they use).

Since osd_req_op_init() is a common routine, and it's not used
outside the osd client code, give it static scope.  Also make
it return the address of the specified op (so all the other
init routines don't have to repeat that code).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |   35 +++++++++------------
 fs/ceph/addr.c                  |    2 +-
 include/linux/ceph/osd_client.h |   19 +++++++-----
 net/ceph/osd_client.c           |   64
++++++++++++++++++++++++---------------
 4 files changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 59f9db1..7a62327 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1336,16 +1336,17 @@ static void rbd_osd_req_format_op(struct
rbd_obj_request *obj_request,
 			snap_id = img_request->snap_id;
 	}
 	if (obj_request->type != OBJ_REQUEST_NODATA) {
-		struct ceph_osd_req_op *op = &obj_request->osd_req->r_ops[0];
-
 		/*
 		 * If it has data, it's either a object class method
 		 * call (cls) or it's an extent operation.
 		 */
-		if (op->op == CEPH_OSD_OP_CALL)
-			osd_req_op_cls_response_data(op, osd_data);
+		/* XXX This use of the ops array goes away in the next patch */
+		if (obj_request->osd_req->r_ops[0].op == CEPH_OSD_OP_CALL)
+			osd_req_op_cls_response_data(obj_request->osd_req, 0,
+						osd_data);
 		else
-			osd_req_op_extent_osd_data(op, osd_data);
+			osd_req_op_extent_osd_data(obj_request->osd_req, 0,
+						osd_data);
 	}
 	ceph_osdc_build_request(osd_req, obj_request->offset,
 			snapc, snap_id, mtime);
@@ -1577,7 +1578,6 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 	while (resid) {
 		const char *object_name;
 		unsigned int clone_size;
-		struct ceph_osd_req_op *op;
 		u64 offset;
 		u64 length;

@@ -1606,8 +1606,8 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 		if (!obj_request->osd_req)
 			goto out_partial;

-		op = &obj_request->osd_req->r_ops[0];
-		osd_req_op_extent_init(op, opcode, offset, length, 0, 0);
+		osd_req_op_extent_init(obj_request->osd_req, 0,
+					opcode, offset, length, 0, 0);
 		rbd_osd_req_format_op(obj_request, write_request);

 		/* status and version are initially zero-filled */
@@ -1709,7 +1709,6 @@ static int rbd_obj_notify_ack(struct rbd_device
*rbd_dev,
 				   u64 ver, u64 notify_id)
 {
 	struct rbd_obj_request *obj_request;
-	struct ceph_osd_req_op *op;
 	struct ceph_osd_client *osdc;
 	int ret;

@@ -1723,8 +1722,8 @@ static int rbd_obj_notify_ack(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

-	op = &obj_request->osd_req->r_ops[0];
-	osd_req_op_watch_init(op, CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver, 0);
+	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
+					notify_id, ver, 0);
 	rbd_osd_req_format_op(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
@@ -1765,7 +1764,6 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
-	struct ceph_osd_req_op *op;
 	int ret;

 	rbd_assert(start ^ !!rbd_dev->watch_event);
@@ -1789,8 +1787,7 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 	if (!obj_request->osd_req)
 		goto out_cancel;

-	op = &obj_request->osd_req->r_ops[0];
-	osd_req_op_watch_init(op, CEPH_OSD_OP_WATCH,
+	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
 				rbd_dev->watch_event->cookie,
 				rbd_dev->header.obj_version, start);
 	rbd_osd_req_format_op(obj_request, true);
@@ -1853,7 +1850,6 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 {
 	struct rbd_obj_request *obj_request;
 	struct ceph_osd_client *osdc;
-	struct ceph_osd_req_op *op;
 	struct page **pages;
 	u32 page_count;
 	int ret;
@@ -1883,8 +1879,8 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

-	op = &obj_request->osd_req->r_ops[0];
-	osd_req_op_cls_init(op, CEPH_OSD_OP_CALL, class_name, method_name,
+	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
+					class_name, method_name,
 					outbound, outbound_size);
 	rbd_osd_req_format_op(obj_request, false);

@@ -2065,7 +2061,6 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,

 {
 	struct rbd_obj_request *obj_request;
-	struct ceph_osd_req_op *op;
 	struct ceph_osd_client *osdc;
 	struct page **pages = NULL;
 	u32 page_count;
@@ -2090,8 +2085,8 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

-	op = &obj_request->osd_req->r_ops[0];
-	osd_req_op_extent_init(op, CEPH_OSD_OP_READ, offset, length, 0, 0);
+	osd_req_op_extent_init(obj_request->osd_req, 0, CEPH_OSD_OP_READ,
+					offset, length, 0, 0);
 	rbd_osd_req_format_op(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3caadb0..dd5d263 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -926,7 +926,7 @@ get_more_pages:

 		/* Update the write op length in case we changed it */

-		osd_req_op_extent_update(&req->r_ops[0], len);
+		osd_req_op_extent_update(req, 0, len);

 		vino = ceph_vino(inode);
 		ceph_osdc_build_request(req, offset, snapc, vino.snap,
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index ae51935..144d57c 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -233,20 +233,25 @@ extern void ceph_osdc_handle_reply(struct
ceph_osd_client *osdc,
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);

-extern void osd_req_op_init(struct ceph_osd_req_op *op, u16 opcode);
-extern void osd_req_op_extent_init(struct ceph_osd_req_op *op, u16 opcode,
+extern void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
+					unsigned int which, u16 opcode,
 					u64 offset, u64 length,
 					u64 truncate_size, u32 truncate_seq);
-extern void osd_req_op_extent_update(struct ceph_osd_req_op *op, u64
length);
-extern void osd_req_op_extent_osd_data(struct ceph_osd_req_op *op,
+extern void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
+					unsigned int which, u64 length);
+extern void osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
+					unsigned int which,
 					struct ceph_osd_data *osd_data);
-extern void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
+extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
+					unsigned int which, u16 opcode,
 					const char *class, const char *method,
 					const void *request_data,
 					size_t request_data_size);
-extern void osd_req_op_cls_response_data(struct ceph_osd_req_op *op,
+extern void osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
+					unsigned int which,
 					struct ceph_osd_data *response_data);
-extern void osd_req_op_watch_init(struct ceph_osd_req_op *op, u16 opcode,
+extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
+					unsigned int which, u16 opcode,
 					u64 cookie, u64 version, int flag);

 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct
ceph_osd_client *osdc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2a14187..e698ccf 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -329,25 +329,32 @@ static bool osd_req_opcode_valid(u16 opcode)
  * other information associated with them.  It also serves as a
  * common init routine for all the other init functions, below.
  */
-void osd_req_op_init(struct ceph_osd_req_op *op, u16 opcode)
+static struct ceph_osd_req_op *
+osd_req_op_init(struct ceph_osd_request *osd_req, unsigned int which,
+				u16 opcode)
 {
+	struct ceph_osd_req_op *op;
+
+	BUG_ON(which >= osd_req->r_num_ops);
 	BUG_ON(!osd_req_opcode_valid(opcode));

+	op = &osd_req->r_ops[which];
 	memset(op, 0, sizeof (*op));
-
 	op->op = opcode;
+
+	return op;
 }

-void osd_req_op_extent_init(struct ceph_osd_req_op *op, u16 opcode,
+void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
+				unsigned int which, u16 opcode,
 				u64 offset, u64 length,
 				u64 truncate_size, u32 truncate_seq)
 {
+	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);
 	size_t payload_len = 0;

 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE);

-	osd_req_op_init(op, opcode);
-
 	op->extent.offset = offset;
 	op->extent.length = length;
 	op->extent.truncate_size = truncate_size;
@@ -359,9 +366,15 @@ void osd_req_op_extent_init(struct ceph_osd_req_op
*op, u16 opcode,
 }
 EXPORT_SYMBOL(osd_req_op_extent_init);

-void osd_req_op_extent_update(struct ceph_osd_req_op *op, u64 length)
+void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
+				unsigned int which, u64 length)
 {
-	u64 previous = op->extent.length;
+	struct ceph_osd_req_op *op;
+	u64 previous;
+
+	BUG_ON(which >= osd_req->r_num_ops);
+	op = &osd_req->r_ops[which];
+	previous = op->extent.length;

 	if (length == previous)
 		return;		/* Nothing to do */
@@ -372,24 +385,25 @@ void osd_req_op_extent_update(struct
ceph_osd_req_op *op, u64 length)
 }
 EXPORT_SYMBOL(osd_req_op_extent_update);

-void osd_req_op_extent_osd_data(struct ceph_osd_req_op *op,
+void osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
+				unsigned int which,
 				struct ceph_osd_data *osd_data)
 {
-	op->extent.osd_data = osd_data;
+	BUG_ON(which >= osd_req->r_num_ops);
+	osd_req->r_ops[which].extent.osd_data = osd_data;
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data);

-void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
-			const char *class, const char *method,
+void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int
which,
+			u16 opcode, const char *class, const char *method,
 			const void *request_data, size_t request_data_size)
 {
+	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);
 	size_t payload_len = 0;
 	size_t size;

 	BUG_ON(opcode != CEPH_OSD_OP_CALL);

-	osd_req_op_init(op, opcode);
-
 	op->cls.class_name = class;
 	size = strlen(class);
 	BUG_ON(size > (size_t) U8_MAX);
@@ -412,26 +426,28 @@ void osd_req_op_cls_init(struct ceph_osd_req_op
*op, u16 opcode,
 	op->payload_len = payload_len;
 }
 EXPORT_SYMBOL(osd_req_op_cls_init);
-
-void osd_req_op_cls_response_data(struct ceph_osd_req_op *op,
+void osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
+				unsigned int which,
 				struct ceph_osd_data *response_data)
 {
-	op->cls.response_data = response_data;
+	BUG_ON(which >= osd_req->r_num_ops);
+	osd_req->r_ops[which].cls.response_data = response_data;
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data);

-void osd_req_op_watch_init(struct ceph_osd_req_op *op, u16 opcode,
+void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
+				unsigned int which, u16 opcode,
 				u64 cookie, u64 version, int flag)
 {
-	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);
+	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);

-	osd_req_op_init(op, opcode);
+	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);

 	op->watch.cookie = cookie;
 	/* op->watch.ver = version; */	/* XXX 3847 */
 	op->watch.ver = cpu_to_le64(version);
 	if (opcode == CEPH_OSD_OP_WATCH && flag)
-		op->watch.flag = (u8) 1;
+		op->watch.flag = (u8)1;
 }
 EXPORT_SYMBOL(osd_req_op_watch_init);

@@ -629,7 +645,6 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 {
 	struct ceph_osd_request *req;
 	struct ceph_osd_data *osd_data;
-	struct ceph_osd_req_op *op;
 	u64 objnum = 0;
 	u64 objoff = 0;
 	u64 objlen = 0;
@@ -665,10 +680,9 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 			truncate_size = object_size;
 	}

-	op = &req->r_ops[0];
-	osd_req_op_extent_init(op, opcode, objoff, objlen,
+	osd_req_op_extent_init(req, 0, opcode, objoff, objlen,
 				truncate_size, truncate_seq);
-	osd_req_op_extent_osd_data(op, osd_data);
+	osd_req_op_extent_osd_data(req, 0, osd_data);

 	/*
 	 * A second op in the ops array means the caller wants to
@@ -676,7 +690,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	 * osd will flush data quickly.
 	 */
 	if (num_ops > 1)
-		osd_req_op_init(++op, CEPH_OSD_OP_STARTSYNC);
+		osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC);

 	req->r_file_layout = *layout;  /* keep a copy */

-- 
1.7.9.5

