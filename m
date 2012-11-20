From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] rbd: initialize off and len in rbd_create_rw_op()
Date: Tue, 20 Nov 2012 13:57:22 -0600
Message-ID: <50ABE0A2.8080205@inktank.com>
References: <50ABDF8A.4080206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58830 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2KTT5a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 14:57:30 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4506049iay.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 11:57:29 -0800 (PST)
In-Reply-To: <50ABDF8A.4080206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Move the initialization of a read or write operation's offset,
length, and payload length fields into rbd_create_rw_op().

This will actually get removed in the next patch, but it finishes
the consolidation of setting these fields at osd op creation time.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b2e819c..54d11c9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1025,19 +1025,23 @@ out_err:
 	return NULL;
 }

-static struct ceph_osd_req_op *rbd_create_rw_op(int opcode, u32
payload_len)
+static struct ceph_osd_req_op *rbd_create_rw_op(int opcode, u64 ofs,
u64 len)
 {
 	struct ceph_osd_req_op *op;

 	op = kzalloc(sizeof (*op), GFP_NOIO);
 	if (!op)
 		return NULL;
-	/*
-	 * op extent offset and length will be set later on
-	 * after ceph_calc_file_object_mapping().
-	 */
+
 	op->op = opcode;
-	op->payload_len = payload_len;
+	if (opcode == CEPH_OSD_OP_READ || opcode == CEPH_OSD_OP_WRITE) {
+		op->extent.offset = ofs;
+		op->extent.length = len;
+		if (opcode == CEPH_OSD_OP_WRITE) {
+			rbd_assert(len <= (u64) U32_MAX);
+			op->payload_len = len;
+		}
+	}

 	return op;
 }
@@ -1297,7 +1301,6 @@ static int rbd_do_op(struct request *rq,
 	u64 seg_len;
 	int ret;
 	struct ceph_osd_req_op *op;
-	u32 payload_len;
 	int opcode;
 	int flags;
 	u64 snapid;
@@ -1312,22 +1315,17 @@ static int rbd_do_op(struct request *rq,
 		opcode = CEPH_OSD_OP_WRITE;
 		flags = CEPH_OSD_FLAG_WRITE|CEPH_OSD_FLAG_ONDISK;
 		snapid = CEPH_NOSNAP;
-		payload_len = seg_len;
 	} else {
 		opcode = CEPH_OSD_OP_READ;
 		flags = CEPH_OSD_FLAG_READ;
 		rbd_assert(!snapc);
 		snapid = rbd_dev->spec->snap_id;
-		payload_len = 0;
 	}

 	ret = -ENOMEM;
-	op = rbd_create_rw_op(opcode, payload_len);
+	op = rbd_create_rw_op(opcode, seg_ofs, seg_len);
 	if (!op)
 		goto done;
-	op->extent.offset = seg_ofs;
-	op->extent.length = seg_len;
-	op->payload_len = payload_len;

 	/* we've taken care of segment sizes earlier when we
 	   cloned the bios. We should never have a segment
@@ -1363,12 +1361,9 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 	struct ceph_osd_req_op *op;
 	int ret;

-	op = rbd_create_rw_op(CEPH_OSD_OP_READ, 0);
+	op = rbd_create_rw_op(CEPH_OSD_OP_READ, ofs, len);
 	if (!op)
 		return -ENOMEM;
-	op->extent.offset = ofs;
-	op->extent.length = len;
-	op->payload_len = 0;

 	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
 			       op, object_name, ofs, len, buf, NULL, ver);
@@ -1387,7 +1382,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 	struct ceph_osd_req_op *op;
 	int ret;

-	op = rbd_create_rw_op(CEPH_OSD_OP_NOTIFY_ACK, 0);
+	op = rbd_create_rw_op(CEPH_OSD_OP_NOTIFY_ACK, 0, 0);
 	if (!op)
 		return -ENOMEM;

@@ -1438,7 +1433,7 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev, int start)
 	__le64 version = 0;
 	int ret;

-	op = rbd_create_rw_op(CEPH_OSD_OP_WATCH, 0);
+	op = rbd_create_rw_op(CEPH_OSD_OP_WATCH, 0, 0);
 	if (!op)
 		return -ENOMEM;

@@ -1501,9 +1496,10 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	 * operation.
 	 */
 	payload_size = class_name_len + method_name_len + outbound_size;
-	op = rbd_create_rw_op(CEPH_OSD_OP_CALL, payload_size);
+	op = rbd_create_rw_op(CEPH_OSD_OP_CALL, 0, 0);
 	if (!op)
 		return -ENOMEM;
+	op->payload_len = payload_size;

 	op->cls.class_name = class_name;
 	op->cls.class_len = (__u8) class_name_len;
-- 
1.7.9.5

