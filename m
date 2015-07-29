From: mchristi@redhat.com
Subject: [PATCH 05/18] libceph: add support for CMPEXT compare extent requests
Date: Wed, 29 Jul 2015 04:23:42 -0500
Message-ID: <1438161835-27960-5-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This adds support for the CMPEXT request. The request will compare
extent.length bytes and compare them to extent.length bytes at
extent.offset on disk. If there is a miscompare the osd will return
-EILSEQ, the offset in the buffer where it occurred, and the buffer.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/ceph/rados.h |  2 ++
 net/ceph/osd_client.c      | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index bcaabf3..a07da93 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -212,6 +212,8 @@ extern const char *ceph_osd_state_name(int s);
 	/* sync */							    \
 	f(SYNC_READ,	__CEPH_OSD_OP(RD, DATA, 11),	"sync_read")	    \
 									    \
+	f(CMPEXT,	__CEPH_OSD_OP(RD, DATA, 31),	"cmpext")	    \
+									    \
 	/* write */							    \
 	f(WRITE,	__CEPH_OSD_OP(WR, DATA, 1),	"write")	    \
 	f(WRITEFULL,	__CEPH_OSD_OP(WR, DATA, 2),	"writefull")	    \
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 3bf0849..8b44b67 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -200,6 +200,7 @@ void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_READ:
 	case CEPH_OSD_OP_ZERO:
 	case CEPH_OSD_OP_TRUNCATE:
+	case CEPH_OSD_OP_CMPEXT:
 		ceph_osd_data_pages_init(&op->extent.response_data, pages,
 					 length, alignment, pages_from_pool,
 					 own_pages);
@@ -275,6 +276,7 @@ void osd_req_op_extent_osd_data_sg(struct ceph_osd_request *osd_req,
 				      sgl, init_sg_offset, length);
 		break;
 	case CEPH_OSD_OP_WRITE:
+	case CEPH_OSD_OP_CMPEXT:
 		ceph_osd_data_sg_init(&op->extent.request_data,
 				      sgl, init_sg_offset, length);
 		break;
@@ -430,6 +432,10 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_WRITE:
 		ceph_osd_data_release(&op->extent.request_data);
 		break;
+	case CEPH_OSD_OP_CMPEXT:
+		ceph_osd_data_release(&op->extent.response_data);
+		ceph_osd_data_release(&op->extent.request_data);
+		break;
 	case CEPH_OSD_OP_CALL:
 		ceph_osd_data_release(&op->cls.request_info);
 		ceph_osd_data_release(&op->cls.request_data);
@@ -634,13 +640,14 @@ void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 	size_t payload_len = 0;
 
 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE &&
-	       opcode != CEPH_OSD_OP_ZERO && opcode != CEPH_OSD_OP_TRUNCATE);
+	       opcode != CEPH_OSD_OP_ZERO && opcode != CEPH_OSD_OP_TRUNCATE &&
+	       opcode != CEPH_OSD_OP_CMPEXT);
 
 	op->extent.offset = offset;
 	op->extent.length = length;
 	op->extent.truncate_size = truncate_size;
 	op->extent.truncate_seq = truncate_seq;
-	if (opcode == CEPH_OSD_OP_WRITE)
+	if (opcode == CEPH_OSD_OP_WRITE || opcode == CEPH_OSD_OP_CMPEXT)
 		payload_len += length;
 
 	op->payload_len = payload_len;
@@ -842,6 +849,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 	case CEPH_OSD_OP_WRITE:
 	case CEPH_OSD_OP_ZERO:
 	case CEPH_OSD_OP_TRUNCATE:
+	case CEPH_OSD_OP_CMPEXT:
 		dst->extent.offset = cpu_to_le64(src->extent.offset);
 		dst->extent.length = cpu_to_le64(src->extent.length);
 		dst->extent.truncate_size =
@@ -853,6 +861,14 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 			ceph_osdc_msg_data_add(req->r_request, osd_data);
 
 			request_data_len = src->extent.length;
+		} else if (src->op == CEPH_OSD_OP_CMPEXT) {
+			osd_data = &src->extent.request_data;
+			ceph_osdc_msg_data_add(req->r_request, osd_data);
+
+			osd_data = &src->extent.response_data;
+			ceph_osdc_msg_data_add(req->r_reply, osd_data);
+
+			request_data_len = src->extent.length;
 		} else {
 			osd_data = &src->extent.response_data;
 			ceph_osdc_msg_data_add(req->r_reply, osd_data);
@@ -1092,7 +1108,8 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 
 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE &&
 	       opcode != CEPH_OSD_OP_ZERO && opcode != CEPH_OSD_OP_TRUNCATE &&
-	       opcode != CEPH_OSD_OP_CREATE && opcode != CEPH_OSD_OP_DELETE);
+	       opcode != CEPH_OSD_OP_CREATE && opcode != CEPH_OSD_OP_DELETE &&
+	       opcode != CEPH_OSD_OP_CMPEXT);
 
 	req = ceph_osdc_alloc_request(osdc, snapc, num_ops, use_mempool,
 					GFP_NOFS);
-- 
1.8.3.1
