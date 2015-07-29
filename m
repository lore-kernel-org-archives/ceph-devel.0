From: mchristi@redhat.com
Subject: [PATCH 04/18] libceph: support bidirectional requests
Date: Wed, 29 Jul 2015 04:23:41 -0500
Message-ID: <1438161835-27960-4-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

The next patch will add support for SCSI's compare and write
command. This command sends N bytes, compares them to N bytes on disk,
then returns success or the offset in the buffer where a miscompare
occured. For Ceph support, I implemented this as a multiple op request:

1. a new CMPEXT (compare extent) operation that compare N bytes
and if a miscompare occured then returns the offset it miscompared
and also returns the buffer.
2. a write request. If the CMPEXT succeeds then this will be executed.

This patch modifies libceph so it can support both a request buffer
and response buffer for extent based IO, so the CMPEXT command can
send its comparision buffer and also receive the failed buffer if needed.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 fs/ceph/addr.c                  |   4 +-
 include/linux/ceph/osd_client.h |   3 +-
 net/ceph/osd_client.c           | 109 +++++++++++++++++++++++++++++++---------
 3 files changed, 89 insertions(+), 27 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 890c509..0360b44 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -269,7 +269,7 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
 	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);
 
 	/* unlock all pages, zeroing any data we didn't read */
-	osd_data = osd_req_op_extent_osd_data(req, 0);
+	osd_data = osd_req_op_extent_osd_response_data(req, 0);
 	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
 	num_pages = calc_pages_for((u64)osd_data->alignment,
 					(u64)osd_data->length);
@@ -618,7 +618,7 @@ static void writepages_finish(struct ceph_osd_request *req,
 	long writeback_stat;
 	unsigned issued = ceph_caps_issued(ci);
 
-	osd_data = osd_req_op_extent_osd_data(req, 0);
+	osd_data = osd_req_op_extent_osd_request_data(req, 0);
 	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
 	num_pages = calc_pages_for((u64)osd_data->alignment,
 					(u64)osd_data->length);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 2152f06..e737173 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -90,7 +90,8 @@ struct ceph_osd_req_op {
 			u64 offset, length;
 			u64 truncate_size;
 			u32 truncate_seq;
-			struct ceph_osd_data osd_data;
+			struct ceph_osd_data request_data;
+			struct ceph_osd_data response_data;
 		} extent;
 		struct {
 			u32 name_len;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index fd0a52e..3bf0849 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -153,12 +153,20 @@ osd_req_op_raw_data_in(struct ceph_osd_request *osd_req, unsigned int which)
 }
 
 struct ceph_osd_data *
-osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
-			unsigned int which)
+osd_req_op_extent_osd_request_data(struct ceph_osd_request *osd_req,
+				   unsigned int which)
 {
-	return osd_req_op_data(osd_req, which, extent, osd_data);
+	return osd_req_op_data(osd_req, which, extent, request_data);
 }
-EXPORT_SYMBOL(osd_req_op_extent_osd_data);
+EXPORT_SYMBOL(osd_req_op_extent_osd_request_data);
+
+struct ceph_osd_data *
+osd_req_op_extent_osd_response_data(struct ceph_osd_request *osd_req,
+				    unsigned int which)
+{
+	return osd_req_op_data(osd_req, which, extent, response_data);
+}
+EXPORT_SYMBOL(osd_req_op_extent_osd_response_data);
 
 struct ceph_osd_data *
 osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
@@ -186,21 +194,46 @@ void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
 			u64 length, u32 alignment,
 			bool pages_from_pool, bool own_pages)
 {
-	struct ceph_osd_data *osd_data;
+	struct ceph_osd_req_op *op = &osd_req->r_ops[which];
 
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
-				pages_from_pool, own_pages);
+	switch (op->op) {
+	case CEPH_OSD_OP_READ:
+	case CEPH_OSD_OP_ZERO:
+	case CEPH_OSD_OP_TRUNCATE:
+		ceph_osd_data_pages_init(&op->extent.response_data, pages,
+					 length, alignment, pages_from_pool,
+					 own_pages);
+		break;
+	case CEPH_OSD_OP_WRITE:
+		ceph_osd_data_pages_init(&op->extent.request_data, pages,
+					  length, alignment, pages_from_pool,
+					  own_pages);
+		break;
+	default:
+		BUG();
+	}
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pages);
 
 void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *osd_req,
 			unsigned int which, struct ceph_pagelist *pagelist)
 {
-	struct ceph_osd_data *osd_data;
+	struct ceph_osd_req_op *op = &osd_req->r_ops[which];
 
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_pagelist_init(osd_data, pagelist);
+	switch (op->op) {
+	case CEPH_OSD_OP_READ:
+	case CEPH_OSD_OP_ZERO:
+	case CEPH_OSD_OP_TRUNCATE:
+		ceph_osd_data_pagelist_init(&op->extent.response_data,
+					    pagelist);
+		break;
+	case CEPH_OSD_OP_WRITE:
+		ceph_osd_data_pagelist_init(&op->extent.request_data,
+					    pagelist);
+		break;
+	default:
+		BUG();
+	}
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);
 
@@ -208,10 +241,22 @@ EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);
 void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *osd_req,
 			unsigned int which, struct bio *bio, size_t bio_length)
 {
-	struct ceph_osd_data *osd_data;
+	struct ceph_osd_req_op *op = &osd_req->r_ops[which];
 
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_bio_init(osd_data, bio, bio_length);
+	switch (op->op) {
+	case CEPH_OSD_OP_READ:
+	case CEPH_OSD_OP_ZERO:
+	case CEPH_OSD_OP_TRUNCATE:
+		ceph_osd_data_bio_init(&op->extent.response_data, bio,
+				       bio_length);
+		break;
+	case CEPH_OSD_OP_WRITE:
+		ceph_osd_data_bio_init(&op->extent.request_data, bio,
+				       bio_length);
+		break;
+	default:
+		BUG();
+	}
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_bio);
 #endif /* CONFIG_BLOCK */
@@ -220,10 +265,22 @@ void osd_req_op_extent_osd_data_sg(struct ceph_osd_request *osd_req,
 			unsigned int which, struct scatterlist *sgl,
 			unsigned int init_sg_offset, u64 length)
 {
-	struct ceph_osd_data *osd_data;
+	struct ceph_osd_req_op *op = &osd_req->r_ops[which];
 
-	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
-	ceph_osd_data_sg_init(osd_data, sgl, init_sg_offset, length);
+	switch (op->op) {
+	case CEPH_OSD_OP_READ:
+	case CEPH_OSD_OP_ZERO:
+	case CEPH_OSD_OP_TRUNCATE:
+		ceph_osd_data_sg_init(&op->extent.response_data,
+				      sgl, init_sg_offset, length);
+		break;
+	case CEPH_OSD_OP_WRITE:
+		ceph_osd_data_sg_init(&op->extent.request_data,
+				      sgl, init_sg_offset, length);
+		break;
+	default:
+		BUG();
+	}
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_sg);
 
@@ -368,8 +425,10 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 
 	switch (op->op) {
 	case CEPH_OSD_OP_READ:
+		ceph_osd_data_release(&op->extent.response_data);
+		break;
 	case CEPH_OSD_OP_WRITE:
-		ceph_osd_data_release(&op->extent.osd_data);
+		ceph_osd_data_release(&op->extent.request_data);
 		break;
 	case CEPH_OSD_OP_CALL:
 		ceph_osd_data_release(&op->cls.request_info);
@@ -783,19 +842,21 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 	case CEPH_OSD_OP_WRITE:
 	case CEPH_OSD_OP_ZERO:
 	case CEPH_OSD_OP_TRUNCATE:
-		if (src->op == CEPH_OSD_OP_WRITE)
-			request_data_len = src->extent.length;
 		dst->extent.offset = cpu_to_le64(src->extent.offset);
 		dst->extent.length = cpu_to_le64(src->extent.length);
 		dst->extent.truncate_size =
 			cpu_to_le64(src->extent.truncate_size);
 		dst->extent.truncate_seq =
 			cpu_to_le32(src->extent.truncate_seq);
-		osd_data = &src->extent.osd_data;
-		if (src->op == CEPH_OSD_OP_WRITE)
+		if (src->op == CEPH_OSD_OP_WRITE) {
+			osd_data = &src->extent.request_data;
 			ceph_osdc_msg_data_add(req->r_request, osd_data);
-		else
+
+			request_data_len = src->extent.length;
+		} else {
+			osd_data = &src->extent.response_data;
 			ceph_osdc_msg_data_add(req->r_reply, osd_data);
+		}
 		break;
 	case CEPH_OSD_OP_CALL:
 		dst->cls.class_len = src->cls.class_len;
@@ -3326,7 +3387,7 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 		 * XXX page data.  Probably OK for reads, but this
 		 * XXX ought to be done more generally.
 		 */
-		osd_data = osd_req_op_extent_osd_data(req, 0);
+		osd_data = osd_req_op_extent_osd_response_data(req, 0);
 		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 			if (osd_data->pages &&
 				unlikely(osd_data->length < data_len)) {
-- 
1.8.3.1
