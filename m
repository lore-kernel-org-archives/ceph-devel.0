From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: define osd_req_opcode_valid()
Date: Fri, 29 Mar 2013 16:24:20 -0500
Message-ID: <51560684.5060509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:44513 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab3C2VYX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 17:24:23 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so699515iaa.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 14:24:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Define a separate function to determine the validity of an opcode,
and use it inside osd_req_encode_op() in order to unclutter that
function.

Don't update the destination op at all--and return zero--if an
unsupported or unrecognized opcode is seen in osd_req_encode_op().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |  126
++++++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 54 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 015bf9f..4e5c043 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -220,70 +220,24 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 }
 EXPORT_SYMBOL(ceph_osdc_alloc_request);

-static u64 osd_req_encode_op(struct ceph_osd_request *req,
-			      struct ceph_osd_op *dst,
-			      struct ceph_osd_req_op *src)
+static bool osd_req_opcode_valid(u16 opcode)
 {
-	u64 out_data_len = 0;
-	struct ceph_pagelist *pagelist;
-
-	dst->op = cpu_to_le16(src->op);
-
-	switch (src->op) {
-	case CEPH_OSD_OP_STAT:
-		break;
+	switch (opcode) {
 	case CEPH_OSD_OP_READ:
-	case CEPH_OSD_OP_WRITE:
-		if (src->op == CEPH_OSD_OP_WRITE)
-			out_data_len = src->extent.length;
-		dst->extent.offset = cpu_to_le64(src->extent.offset);
-		dst->extent.length = cpu_to_le64(src->extent.length);
-		dst->extent.truncate_size =
-			cpu_to_le64(src->extent.truncate_size);
-		dst->extent.truncate_seq =
-			cpu_to_le32(src->extent.truncate_seq);
-		break;
-	case CEPH_OSD_OP_CALL:
-		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
-		BUG_ON(!pagelist);
-		ceph_pagelist_init(pagelist);
-
-		dst->cls.class_len = src->cls.class_len;
-		dst->cls.method_len = src->cls.method_len;
-		dst->cls.indata_len = cpu_to_le32(src->cls.indata_len);
-		ceph_pagelist_append(pagelist, src->cls.class_name,
-				     src->cls.class_len);
-		ceph_pagelist_append(pagelist, src->cls.method_name,
-				     src->cls.method_len);
-		ceph_pagelist_append(pagelist, src->cls.indata,
-				     src->cls.indata_len);
-
-		req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGELIST;
-		req->r_data_out.pagelist = pagelist;
-		out_data_len = pagelist->length;
-		break;
-	case CEPH_OSD_OP_STARTSYNC:
-		break;
-	case CEPH_OSD_OP_NOTIFY_ACK:
-	case CEPH_OSD_OP_WATCH:
-		dst->watch.cookie = cpu_to_le64(src->watch.cookie);
-		dst->watch.ver = cpu_to_le64(src->watch.ver);
-		dst->watch.flag = src->watch.flag;
-		break;
-	default:
-		pr_err("unrecognized osd opcode %d\n", src->op);
-		WARN_ON(1);
-		break;
+	case CEPH_OSD_OP_STAT:
 	case CEPH_OSD_OP_MAPEXT:
 	case CEPH_OSD_OP_MASKTRUNC:
 	case CEPH_OSD_OP_SPARSE_READ:
 	case CEPH_OSD_OP_NOTIFY:
+	case CEPH_OSD_OP_NOTIFY_ACK:
 	case CEPH_OSD_OP_ASSERT_VER:
+	case CEPH_OSD_OP_WRITE:
 	case CEPH_OSD_OP_WRITEFULL:
 	case CEPH_OSD_OP_TRUNCATE:
 	case CEPH_OSD_OP_ZERO:
 	case CEPH_OSD_OP_DELETE:
 	case CEPH_OSD_OP_APPEND:
+	case CEPH_OSD_OP_STARTSYNC:
 	case CEPH_OSD_OP_SETTRUNC:
 	case CEPH_OSD_OP_TRIMTRUNC:
 	case CEPH_OSD_OP_TMAPUP:
@@ -291,11 +245,11 @@ static u64 osd_req_encode_op(struct
ceph_osd_request *req,
 	case CEPH_OSD_OP_TMAPGET:
 	case CEPH_OSD_OP_CREATE:
 	case CEPH_OSD_OP_ROLLBACK:
+	case CEPH_OSD_OP_WATCH:
 	case CEPH_OSD_OP_OMAPGETKEYS:
 	case CEPH_OSD_OP_OMAPGETVALS:
 	case CEPH_OSD_OP_OMAPGETHEADER:
 	case CEPH_OSD_OP_OMAPGETVALSBYKEYS:
-	case CEPH_OSD_OP_MODE_RD:
 	case CEPH_OSD_OP_OMAPSETVALS:
 	case CEPH_OSD_OP_OMAPSETHEADER:
 	case CEPH_OSD_OP_OMAPCLEAR:
@@ -326,13 +280,77 @@ static u64 osd_req_encode_op(struct
ceph_osd_request *req,
 	case CEPH_OSD_OP_RDUNLOCK:
 	case CEPH_OSD_OP_UPLOCK:
 	case CEPH_OSD_OP_DNLOCK:
+	case CEPH_OSD_OP_CALL:
 	case CEPH_OSD_OP_PGLS:
 	case CEPH_OSD_OP_PGLS_FILTER:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static u64 osd_req_encode_op(struct ceph_osd_request *req,
+			      struct ceph_osd_op *dst,
+			      struct ceph_osd_req_op *src)
+{
+	u64 out_data_len = 0;
+	struct ceph_pagelist *pagelist;
+
+	if (WARN_ON(!osd_req_opcode_valid(src->op))) {
+		pr_err("unrecognized osd opcode %d\n", src->op);
+
+		return 0;
+	}
+
+	switch (src->op) {
+	case CEPH_OSD_OP_STAT:
+		break;
+	case CEPH_OSD_OP_READ:
+	case CEPH_OSD_OP_WRITE:
+		if (src->op == CEPH_OSD_OP_WRITE)
+			out_data_len = src->extent.length;
+		dst->extent.offset = cpu_to_le64(src->extent.offset);
+		dst->extent.length = cpu_to_le64(src->extent.length);
+		dst->extent.truncate_size =
+			cpu_to_le64(src->extent.truncate_size);
+		dst->extent.truncate_seq =
+			cpu_to_le32(src->extent.truncate_seq);
+		break;
+	case CEPH_OSD_OP_CALL:
+		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
+		BUG_ON(!pagelist);
+		ceph_pagelist_init(pagelist);
+
+		dst->cls.class_len = src->cls.class_len;
+		dst->cls.method_len = src->cls.method_len;
+		dst->cls.indata_len = cpu_to_le32(src->cls.indata_len);
+		ceph_pagelist_append(pagelist, src->cls.class_name,
+				     src->cls.class_len);
+		ceph_pagelist_append(pagelist, src->cls.method_name,
+				     src->cls.method_len);
+		ceph_pagelist_append(pagelist, src->cls.indata,
+				     src->cls.indata_len);
+
+		req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGELIST;
+		req->r_data_out.pagelist = pagelist;
+		out_data_len = pagelist->length;
+		break;
+	case CEPH_OSD_OP_STARTSYNC:
+		break;
+	case CEPH_OSD_OP_NOTIFY_ACK:
+	case CEPH_OSD_OP_WATCH:
+		dst->watch.cookie = cpu_to_le64(src->watch.cookie);
+		dst->watch.ver = cpu_to_le64(src->watch.ver);
+		dst->watch.flag = src->watch.flag;
+		break;
+	default:
 		pr_err("unsupported osd opcode %s\n",
 			ceph_osd_op_name(src->op));
 		WARN_ON(1);
-		break;
+
+		return 0;
 	}
+	dst->op = cpu_to_le16(src->op);
 	dst->payload_len = cpu_to_le32(src->payload_len);

 	return out_data_len;
-- 
1.7.9.5

