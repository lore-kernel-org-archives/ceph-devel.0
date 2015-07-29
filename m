From: mchristi@redhat.com
Subject: [PATCH 09/18] libceph: add support for write same requests
Date: Wed, 29 Jul 2015 04:23:46 -0500
Message-ID: <1438161835-27960-9-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This adds a new ceph request writesame. Write a buffer of length
writesame.data_length bytes at writesame.offset over writesame.length
bytes.

This command maps to SCSI's WRITE SAME request. In the next patches
rbd and lio will hook in to this support.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/ceph/osd_client.h | 15 +++++++++++++++
 include/linux/ceph/rados.h      |  6 ++++++
 net/ceph/osd_client.c           | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index e737173..55c1442 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -128,6 +128,12 @@ struct ceph_osd_req_op {
 			u64 expected_object_size;
 			u64 expected_write_size;
 		} alloc_hint;
+		struct {
+			u64 offset;
+			u64 length;
+			u64 data_length;
+			struct ceph_osd_data request_data;
+		} writesame;
 	};
 };
 
@@ -293,6 +299,10 @@ extern void osd_req_op_raw_data_in_pages(struct ceph_osd_request *,
 					u32 alignment, bool pages_from_pool,
 					bool own_pages);
 
+extern void osd_req_op_writesame_init(struct ceph_osd_request *osd_req,
+					unsigned int which, u16 opcode,
+					u64 offset, u64 length,
+					u64 data_length);
 extern void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					u64 offset, u64 length,
@@ -325,6 +335,11 @@ extern void osd_req_op_extent_osd_data_sg(struct ceph_osd_request *,
 					struct scatterlist *sgl,
 					unsigned int init_sg_offset,
 					u64 length);
+extern void osd_req_op_writesame_osd_data_sg(struct ceph_osd_request *,
+					unsigned int which,
+					struct scatterlist *sgl,
+					unsigned int init_sg_offset,
+					u64 length);
 extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index a07da93..6f79f29 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -220,6 +220,7 @@ extern const char *ceph_osd_state_name(int s);
 	f(TRUNCATE,	__CEPH_OSD_OP(WR, DATA, 3),	"truncate")	    \
 	f(ZERO,		__CEPH_OSD_OP(WR, DATA, 4),	"zero")		    \
 	f(DELETE,	__CEPH_OSD_OP(WR, DATA, 5),	"delete")	    \
+	f(WRITESAME,	__CEPH_OSD_OP(WR, DATA, 36),	"write-same")	    \
 									    \
 	/* fancy write */						    \
 	f(APPEND,	__CEPH_OSD_OP(WR, DATA, 6),	"append")	    \
@@ -477,6 +478,11 @@ struct ceph_osd_op {
 			__le64 expected_object_size;
 			__le64 expected_write_size;
 		} __attribute__ ((packed)) alloc_hint;
+		struct {
+			__le64 offset;
+			__le64 length;
+			__le64 data_length;
+		} __attribute__ ((packed)) writesame;
 	};
 	__le32 payload_len;
 } __attribute__ ((packed));
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8b44b67..10d27d7 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -384,6 +384,17 @@ void osd_req_op_list_watchers_response_data_pages(
 }
 EXPORT_SYMBOL(osd_req_op_list_watchers_response_data_pages);
 
+void osd_req_op_writesame_osd_data_sg(struct ceph_osd_request *osd_req,
+			unsigned int which, struct scatterlist *sgl,
+			unsigned int init_sg_offset, u64 length)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, writesame, request_data);
+	ceph_osd_data_sg_init(osd_data, sgl, init_sg_offset, length);
+}
+EXPORT_SYMBOL(osd_req_op_writesame_osd_data_sg);
+
 static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 {
 	switch (osd_data->type) {
@@ -432,6 +443,9 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_WRITE:
 		ceph_osd_data_release(&op->extent.request_data);
 		break;
+	case CEPH_OSD_OP_WRITESAME:
+		ceph_osd_data_release(&op->writesame.request_data);
+		break;
 	case CEPH_OSD_OP_CMPEXT:
 		ceph_osd_data_release(&op->extent.response_data);
 		ceph_osd_data_release(&op->extent.request_data);
@@ -630,6 +644,22 @@ void osd_req_op_init(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_init);
 
+void osd_req_op_writesame_init(struct ceph_osd_request *osd_req,
+			       unsigned int which, u16 opcode,
+			       u64 offset, u64 length, u64 data_length)
+{
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode,
+						      0);
+
+	BUG_ON(opcode != CEPH_OSD_OP_WRITESAME);
+
+	op->writesame.offset = offset;
+	op->writesame.length = length;
+	op->writesame.data_length = data_length;
+	op->payload_len = data_length;
+}
+EXPORT_SYMBOL(osd_req_op_writesame_init);
+
 void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 				unsigned int which, u16 opcode,
 				u64 offset, u64 length,
@@ -946,6 +976,16 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 	case CEPH_OSD_OP_CREATE:
 	case CEPH_OSD_OP_DELETE:
 		break;
+	case CEPH_OSD_OP_WRITESAME:
+		osd_data = &src->writesame.request_data;
+		ceph_osdc_msg_data_add(req->r_request, osd_data);
+
+		dst->writesame.offset = cpu_to_le64(src->writesame.offset);
+		dst->writesame.length = cpu_to_le64(src->writesame.length);
+		dst->writesame.data_length =
+				cpu_to_le64(src->writesame.data_length);
+		request_data_len = src->writesame.data_length;;
+		break;
 	default:
 		pr_err("unsupported osd opcode %s\n",
 			ceph_osd_op_name(src->op));
-- 
1.8.3.1
