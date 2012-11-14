From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: there is really only one op
Date: Wed, 14 Nov 2012 10:34:58 -0600
Message-ID: <50A3C832.7060508@inktank.com>
References: <50A3C7D0.2050809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54151 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671Ab2KNQfA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:35:00 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so882810iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:35:00 -0800 (PST)
In-Reply-To: <50A3C7D0.2050809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Throughout the rbd code there are spots where it appears we can
handle an osd request containing more than one osd request op.

But that is only the way it appears.  In fact, currently only one
operation at a time can be supported, and supporting more than
one will require much more than fleshing out the support that's
there now.

This patch changes names to make it perfectly clear that anywhere
we're dealing with a block of ops, we're in fact dealing with
exactly one of them.  We'll be able to simplify some things as
a result.

When multiple op support is implemented, we can update things again
accordingly.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |  118
++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 62 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5a69a74..0922fbb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1025,32 +1025,26 @@ out_err:
 	return NULL;
 }

-/*
- * helpers for osd request op vectors.
- */
-static struct ceph_osd_req_op *rbd_create_rw_ops(int num_op,
-					int opcode, u32 payload_len)
+static struct ceph_osd_req_op *rbd_create_rw_op(int opcode, u32
payload_len)
 {
-	struct ceph_osd_req_op *ops;
+	struct ceph_osd_req_op *op;

-	ops = kzalloc(num_op * sizeof (*ops), GFP_NOIO);
-	if (!ops)
+	op = kzalloc(sizeof (*op), GFP_NOIO);
+	if (!op)
 		return NULL;
-
-	ops[0].op = opcode;
-
 	/*
 	 * op extent offset and length will be set later on
 	 * in calc_raw_layout()
 	 */
-	ops[0].payload_len = payload_len;
+	op->op = opcode;
+	op->payload_len = payload_len;

-	return ops;
+	return op;
 }

-static void rbd_destroy_ops(struct ceph_osd_req_op *ops)
+static void rbd_destroy_op(struct ceph_osd_req_op *op)
 {
-	kfree(ops);
+	kfree(op);
 }

 static void rbd_coll_end_req_index(struct request *rq,
@@ -1316,7 +1310,7 @@ static int rbd_do_op(struct request *rq,
 	u64 seg_ofs;
 	u64 seg_len;
 	int ret;
-	struct ceph_osd_req_op *ops;
+	struct ceph_osd_req_op *op;
 	u32 payload_len;
 	int opcode;
 	int flags;
@@ -1342,8 +1336,8 @@ static int rbd_do_op(struct request *rq,
 	}

 	ret = -ENOMEM;
-	ops = rbd_create_rw_ops(1, opcode, payload_len);
-	if (!ops)
+	op = rbd_create_rw_op(opcode, payload_len);
+	if (!op)
 		goto done;

 	/* we've taken care of segment sizes earlier when we
@@ -1356,13 +1350,13 @@ static int rbd_do_op(struct request *rq,
 			     bio,
 			     NULL, 0,
 			     flags,
-			     1, ops,
+			     1, op,
 			     coll, coll_index,
 			     rbd_req_cb, 0, NULL);
 	if (ret < 0)
 		rbd_coll_end_req_index(rq, coll, coll_index,
 					(s32) ret, seg_len);
-	rbd_destroy_ops(ops);
+	rbd_destroy_op(op);
 done:
 	kfree(seg_name);
 	return ret;
@@ -1377,16 +1371,16 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 			  char *buf,
 			  u64 *ver)
 {
-	struct ceph_osd_req_op *ops;
+	struct ceph_osd_req_op *op;
 	int ret;

-	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_READ, 0);
-	if (!ops)
+	op = rbd_create_rw_op(CEPH_OSD_OP_READ, 0);
+	if (!op)
 		return -ENOMEM;

 	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
-			       1, ops, object_name, ofs, len, buf, NULL, ver);
-	rbd_destroy_ops(ops);
+			       1, op, object_name, ofs, len, buf, NULL, ver);
+	rbd_destroy_op(op);

 	return ret;
 }
@@ -1398,26 +1392,26 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 				   u64 ver,
 				   u64 notify_id)
 {
-	struct ceph_osd_req_op *ops;
+	struct ceph_osd_req_op *op;
 	int ret;

-	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_NOTIFY_ACK, 0);
-	if (!ops)
+	op = rbd_create_rw_op(CEPH_OSD_OP_NOTIFY_ACK, 0);
+	if (!op)
 		return -ENOMEM;

-	ops[0].watch.ver = cpu_to_le64(ver);
-	ops[0].watch.cookie = notify_id;
-	ops[0].watch.flag = 0;
+	op->watch.ver = cpu_to_le64(ver);
+	op->watch.cookie = notify_id;
+	op->watch.flag = 0;

 	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
 			  rbd_dev->header_name, 0, 0, NULL,
 			  NULL, 0,
 			  CEPH_OSD_FLAG_READ,
-			  1, ops,
+			  1, op,
 			  NULL, 0,
 			  rbd_simple_req_cb, 0, NULL);

-	rbd_destroy_ops(ops);
+	rbd_destroy_op(op);
 	return ret;
 }

@@ -1446,12 +1440,12 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
  */
 static int rbd_req_sync_watch(struct rbd_device *rbd_dev)
 {
-	struct ceph_osd_req_op *ops;
+	struct ceph_osd_req_op *op;
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	int ret;

-	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_WATCH, 0);
-	if (!ops)
+	op = rbd_create_rw_op(CEPH_OSD_OP_WATCH, 0);
+	if (!op)
 		return -ENOMEM;

 	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0,
@@ -1459,13 +1453,13 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev)
 	if (ret < 0)
 		goto fail;

-	ops[0].watch.ver = cpu_to_le64(rbd_dev->header.obj_version);
-	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
-	ops[0].watch.flag = 1;
+	op->watch.ver = cpu_to_le64(rbd_dev->header.obj_version);
+	op->watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
+	op->watch.flag = 1;

 	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      1, ops,
+			      1, op,
 			      rbd_dev->header_name,
 			      0, 0, NULL,
 			      &rbd_dev->watch_request, NULL);
@@ -1473,14 +1467,14 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev)
 	if (ret < 0)
 		goto fail_event;

-	rbd_destroy_ops(ops);
+	rbd_destroy_op(op);
 	return 0;

 fail_event:
 	ceph_osdc_cancel_event(rbd_dev->watch_event);
 	rbd_dev->watch_event = NULL;
 fail:
-	rbd_destroy_ops(ops);
+	rbd_destroy_op(op);
 	return ret;
 }

@@ -1489,25 +1483,25 @@ fail:
  */
 static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev)
 {
-	struct ceph_osd_req_op *ops;
+	struct ceph_osd_req_op *op;
 	int ret;

-	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_WATCH, 0);
-	if (!ops)
+	op = rbd_create_rw_op(CEPH_OSD_OP_WATCH, 0);
+	if (!op)
 		return -ENOMEM;

-	ops[0].watch.ver = 0;
-	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
-	ops[0].watch.flag = 0;
+	op->watch.ver = 0;
+	op->watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
+	op->watch.flag = 0;

 	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      1, ops,
+			      1, op,
 			      rbd_dev->header_name,
 			      0, 0, NULL, NULL, NULL);


-	rbd_destroy_ops(ops);
+	rbd_destroy_op(op);
 	ceph_osdc_cancel_event(rbd_dev->watch_event);
 	rbd_dev->watch_event = NULL;
 	return ret;
@@ -1526,7 +1520,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 			     size_t inbound_size,
 			     u64 *ver)
 {
-	struct ceph_osd_req_op *ops;
+	struct ceph_osd_req_op *op;
 	int class_name_len = strlen(class_name);
 	int method_name_len = strlen(method_name);
 	int payload_size;
@@ -1541,23 +1535,23 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	 * operation.
 	 */
 	payload_size = class_name_len + method_name_len + outbound_size;
-	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_CALL, payload_size);
-	if (!ops)
+	op = rbd_create_rw_op(CEPH_OSD_OP_CALL, payload_size);
+	if (!op)
 		return -ENOMEM;

-	ops[0].cls.class_name = class_name;
-	ops[0].cls.class_len = (__u8) class_name_len;
-	ops[0].cls.method_name = method_name;
-	ops[0].cls.method_len = (__u8) method_name_len;
-	ops[0].cls.argc = 0;
-	ops[0].cls.indata = outbound;
-	ops[0].cls.indata_len = outbound_size;
+	op->cls.class_name = class_name;
+	op->cls.class_len = (__u8) class_name_len;
+	op->cls.method_name = method_name;
+	op->cls.method_len = (__u8) method_name_len;
+	op->cls.argc = 0;
+	op->cls.indata = outbound;
+	op->cls.indata_len = outbound_size;

-	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, 1, ops,
+	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, 1, op,
 			       object_name, 0, inbound_size, inbound,
 			       NULL, ver);

-	rbd_destroy_ops(ops);
+	rbd_destroy_op(op);

 	dout("cls_exec returned %d\n", ret);
 	return ret;
-- 
1.7.9.5

