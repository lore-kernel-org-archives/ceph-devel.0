From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 4/6] rbd: define generalized osd request op routines
Date: Fri, 04 Jan 2013 09:06:45 -0600
Message-ID: <50E6F005.10909@inktank.com>
References: <50E6EF5F.9080200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:37364 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab3ADPGr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 10:06:47 -0500
Received: by mail-ia0-f180.google.com with SMTP id t4so14092396iag.11
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 07:06:47 -0800 (PST)
In-Reply-To: <50E6EF5F.9080200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Create a baseline function to encapsulate the creation of osd
requests, along with a matching function to destroy them.  For now
this just duplicates what rbd_create_rw_op() does for read and write
operations, but the next patches will expand on this.

Since rbd_create_rw_op() is no longer used for read or write
requests, the special handling in that function for those types can
be removed.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   52
+++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 685d049..6fa6ba7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1034,14 +1034,6 @@ static struct ceph_osd_req_op
*rbd_create_rw_op(int opcode, u64 ofs, u64 len)
 		return NULL;

 	op->op = opcode;
-	if (opcode == CEPH_OSD_OP_READ || opcode == CEPH_OSD_OP_WRITE) {
-		op->extent.offset = ofs;
-		op->extent.length = len;
-		if (opcode == CEPH_OSD_OP_WRITE) {
-			rbd_assert(len <= (u64) U32_MAX);
-			op->payload_len = len;
-		}
-	}

 	return op;
 }
@@ -1051,6 +1043,42 @@ static void rbd_destroy_op(struct ceph_osd_req_op
*op)
 	kfree(op);
 }

+struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
+{
+	struct ceph_osd_req_op *op;
+	va_list args;
+
+	op = kzalloc(sizeof (*op), GFP_NOIO);
+	if (!op)
+		return NULL;
+	op->op = opcode;
+	va_start(args, opcode);
+	switch (opcode) {
+	case CEPH_OSD_OP_READ:
+	case CEPH_OSD_OP_WRITE:
+		/* rbd_osd_req_op_create(READ, offset, length) */
+		/* rbd_osd_req_op_create(WRITE, offset, length) */
+		op->extent.offset = va_arg(args, u64);
+		op->extent.length = va_arg(args, u64);
+		if (opcode == CEPH_OSD_OP_WRITE)
+			op->payload_len = op->extent.length;
+		break;
+	default:
+		rbd_warn(NULL, "unsupported opcode %hu\n", opcode);
+		kfree(op);
+		op = NULL;
+		break;
+	}
+	va_end(args);
+
+	return op;
+}
+
+static void rbd_osd_req_op_destroy(struct ceph_osd_req_op *op)
+{
+	kfree(op);
+}
+
 static void rbd_coll_end_req_index(struct request *rq,
 				   struct rbd_req_coll *coll,
 				   int index,
@@ -1323,7 +1351,7 @@ static int rbd_do_op(struct request *rq,
 	}

 	ret = -ENOMEM;
-	op = rbd_create_rw_op(opcode, seg_ofs, seg_len);
+	op = rbd_osd_req_op_create(opcode, seg_ofs, seg_len);
 	if (!op)
 		goto done;

@@ -1343,7 +1371,7 @@ static int rbd_do_op(struct request *rq,
 	if (ret < 0)
 		rbd_coll_end_req_index(rq, coll, coll_index,
 					(s32) ret, seg_len);
-	rbd_destroy_op(op);
+	rbd_osd_req_op_destroy(op);
 done:
 	kfree(seg_name);
 	return ret;
@@ -1361,13 +1389,13 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 	struct ceph_osd_req_op *op;
 	int ret;

-	op = rbd_create_rw_op(CEPH_OSD_OP_READ, ofs, len);
+	op = rbd_osd_req_op_create(CEPH_OSD_OP_READ, ofs, len);
 	if (!op)
 		return -ENOMEM;

 	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
 			       op, object_name, ofs, len, buf, NULL, ver);
-	rbd_destroy_op(op);
+	rbd_osd_req_op_destroy(op);

 	return ret;
 }
-- 
1.7.9.5

