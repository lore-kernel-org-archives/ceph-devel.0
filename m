From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 02/12] libceph: add CREATE osd operation support
Date: Mon, 17 Nov 2014 15:56:56 +0800
Message-ID: <1416211026-11524-3-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32869 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKQH5k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:57:40 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 net/ceph/osd_client.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f8fb376..b991fb6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -476,8 +476,7 @@ void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 	size_t payload_len = 0;
 
 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE &&
-	       opcode != CEPH_OSD_OP_DELETE && opcode != CEPH_OSD_OP_ZERO &&
-	       opcode != CEPH_OSD_OP_TRUNCATE);
+	       opcode != CEPH_OSD_OP_ZERO && opcode != CEPH_OSD_OP_TRUNCATE);
 
 	op->extent.offset = offset;
 	op->extent.length = length;
@@ -654,7 +653,6 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 	case CEPH_OSD_OP_READ:
 	case CEPH_OSD_OP_WRITE:
 	case CEPH_OSD_OP_ZERO:
-	case CEPH_OSD_OP_DELETE:
 	case CEPH_OSD_OP_TRUNCATE:
 		if (src->op == CEPH_OSD_OP_WRITE)
 			request_data_len = src->extent.length;
@@ -714,6 +712,9 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 		ceph_osdc_msg_data_add(req->r_request, osd_data);
 		request_data_len = osd_data->pagelist->length;
 		break;
+	case CEPH_OSD_OP_CREATE:
+	case CEPH_OSD_OP_DELETE:
+		break;
 	default:
 		pr_err("unsupported osd opcode %s\n",
 			ceph_osd_op_name(src->op));
@@ -754,13 +755,11 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	u64 objnum = 0;
 	u64 objoff = 0;
 	u64 objlen = 0;
-	u32 object_size;
-	u64 object_base;
 	int r;
 
 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE &&
-	       opcode != CEPH_OSD_OP_DELETE && opcode != CEPH_OSD_OP_ZERO &&
-	       opcode != CEPH_OSD_OP_TRUNCATE);
+	       opcode != CEPH_OSD_OP_ZERO && opcode != CEPH_OSD_OP_TRUNCATE &&
+	       opcode != CEPH_OSD_OP_CREATE && opcode != CEPH_OSD_OP_DELETE);
 
 	req = ceph_osdc_alloc_request(osdc, snapc, num_ops, use_mempool,
 					GFP_NOFS);
@@ -776,21 +775,24 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 		return ERR_PTR(r);
 	}
 
-	object_size = le32_to_cpu(layout->fl_object_size);
-	object_base = off - objoff;
-	if (!(truncate_seq == 1 && truncate_size == -1ULL)) {
-		if (truncate_size <= object_base) {
-			truncate_size = 0;
-		} else {
-			truncate_size -= object_base;
-			if (truncate_size > object_size)
-				truncate_size = object_size;
+	if (opcode == CEPH_OSD_OP_CREATE || opcode == CEPH_OSD_OP_DELETE) {
+		osd_req_op_init(req, 0, opcode);
+	} else {
+		u32 object_size = le32_to_cpu(layout->fl_object_size);
+		u32 object_base = off - objoff;
+		if (!(truncate_seq == 1 && truncate_size == -1ULL)) {
+			if (truncate_size <= object_base) {
+				truncate_size = 0;
+			} else {
+				truncate_size -= object_base;
+				if (truncate_size > object_size)
+					truncate_size = object_size;
+			}
 		}
-	}
-
-	osd_req_op_extent_init(req, 0, opcode, objoff, objlen,
-				truncate_size, truncate_seq);
 
+		osd_req_op_extent_init(req, 0, opcode, objoff, objlen,
+				       truncate_size, truncate_seq);
+	}
 	/*
 	 * A second op in the ops array means the caller wants to
 	 * also issue a include a 'startsync' command so that the
-- 
1.9.3

