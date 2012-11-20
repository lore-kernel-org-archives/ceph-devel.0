From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] rbd: move call osd op setup into rbd_osd_req_op_create()
Date: Tue, 20 Nov 2012 13:58:39 -0600
Message-ID: <50ABE0EF.6080303@inktank.com>
References: <50ABDF8A.4080206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54396 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2KTT65 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 14:58:57 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so9204818iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 11:58:57 -0800 (PST)
In-Reply-To: <50ABDF8A.4080206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Move the initialization of the CEPH_OSD_OP_CALL operation into
rbd_osd_req_op_create().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 17a7781..97f356f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -52,10 +52,12 @@
 #define	SECTOR_SHIFT	9
 #define	SECTOR_SIZE	(1ULL << SECTOR_SHIFT)

-/* It might be useful to have this defined elsewhere too */
+/* It might be useful to have these defined elsewhere */

-#define	U32_MAX	((u32) (~0U))
-#define	U64_MAX	((u64) (~0ULL))
+#define	U8_MAX	((u8)	(~0U))
+#define	U16_MAX	((u16)	(~0U))
+#define	U32_MAX	((u32)	(~0U))
+#define	U64_MAX	((u64)	(~0ULL))

 #define RBD_DRV_NAME "rbd"
 #define RBD_DRV_NAME_LONG "rbd (rados block device)"
@@ -1047,6 +1049,7 @@ struct ceph_osd_req_op *rbd_osd_req_op_create(u16
opcode, ...)
 {
 	struct ceph_osd_req_op *op;
 	va_list args;
+	size_t size;

 	op = kzalloc(sizeof (*op), GFP_NOIO);
 	if (!op)
@@ -1063,6 +1066,27 @@ struct ceph_osd_req_op *rbd_osd_req_op_create(u16
opcode, ...)
 		if (opcode == CEPH_OSD_OP_WRITE)
 			op->payload_len = op->extent.length;
 		break;
+	case CEPH_OSD_OP_CALL:
+		/* rbd_osd_req_op_create(CALL, class, method, data, datalen) */
+		op->cls.class_name = va_arg(args, char *);
+		size = strlen(op->cls.class_name);
+		rbd_assert(size <= (size_t) U8_MAX);
+		op->cls.class_len = size;
+		op->payload_len = size;
+
+		op->cls.method_name = va_arg(args, char *);
+		size = strlen(op->cls.method_name);
+		rbd_assert(size <= (size_t) U8_MAX);
+		op->cls.method_len = size;
+		op->payload_len += size;
+
+		op->cls.argc = 0;
+		op->cls.indata = va_arg(args, void *);
+		size = va_arg(args, size_t);
+		rbd_assert(size <= (size_t) U32_MAX);
+		op->cls.indata_len = (u32) size;
+		op->payload_len += size;
+		break;
 	default:
 		rbd_warn(NULL, "unsupported opcode %hu\n", opcode);
 		kfree(op);
@@ -1510,9 +1534,6 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 			     u64 *ver)
 {
 	struct ceph_osd_req_op *op;
-	int class_name_len = strlen(class_name);
-	int method_name_len = strlen(method_name);
-	int payload_size;
 	int ret;

 	/*
@@ -1523,25 +1544,16 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	 * the perspective of the server side) in the OSD request
 	 * operation.
 	 */
-	payload_size = class_name_len + method_name_len + outbound_size;
-	op = rbd_create_rw_op(CEPH_OSD_OP_CALL, 0, 0);
+	op = rbd_osd_req_op_create(CEPH_OSD_OP_CALL, class_name,
+					method_name, outbound, outbound_size);
 	if (!op)
 		return -ENOMEM;
-	op->payload_len = payload_size;
-
-	op->cls.class_name = class_name;
-	op->cls.class_len = (__u8) class_name_len;
-	op->cls.method_name = method_name;
-	op->cls.method_len = (__u8) method_name_len;
-	op->cls.argc = 0;
-	op->cls.indata = outbound;
-	op->cls.indata_len = outbound_size;

 	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, op,
 			       object_name, 0, inbound_size, inbound,
 			       NULL, ver);

-	rbd_destroy_op(op);
+	rbd_osd_req_op_destroy(op);

 	dout("cls_exec returned %d\n", ret);
 	return ret;
-- 
1.7.9.5

