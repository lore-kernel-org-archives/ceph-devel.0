From: Alex Elder <elder@inktank.com>
Subject: [PATCH 20/20] libceph: kill off osd request r_data_in and r_data_out
Date: Fri, 05 Apr 2013 09:06:17 -0500
Message-ID: <515EDA59.1080109@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46991 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161475Ab3DEOGT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:06:19 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so4214252ieb.8
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:06:18 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Finally!  Convert the osd op data pointers into real structures, and
make the switch over to using them instead of having all ops share
the in and/or out data structures in the osd request.

Set up a new function to traverse the set of ops and release any
data associated with them (pages).

This and the patches leading up to it resolve:
    http://tracker.ceph.com/issues/4657

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    9 ++---
 net/ceph/osd_client.c           |   79
+++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 46 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index dd4ca4ba..4ec46c0 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -87,14 +87,14 @@ struct ceph_osd_req_op {
 			u64 offset, length;
 			u64 truncate_size;
 			u32 truncate_seq;
-			struct ceph_osd_data *osd_data;
+			struct ceph_osd_data osd_data;
 		} extent;
 		struct {
 			const char *class_name;
 			const char *method_name;
 			const void *request_data;
-			struct ceph_osd_data *request_info;
-			struct ceph_osd_data *response_data;
+			struct ceph_osd_data request_info;
+			struct ceph_osd_data response_data;
 			u32 request_data_len;
 			__u8 class_len;
 			__u8 method_len;
@@ -164,9 +164,6 @@ struct ceph_osd_request {

 	struct ceph_file_layout r_file_layout;
 	struct ceph_snap_context *r_snapc;    /* snap context for writes */
-
-	struct ceph_osd_data r_data_in;
-	struct ceph_osd_data r_data_out;
 };

 struct ceph_osd_event {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cc4003f..2562e4e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -121,8 +121,7 @@ osd_req_op_extent_osd_data(struct ceph_osd_request
*osd_req,
 {
 	BUG_ON(which >= osd_req->r_num_ops);

-	/* return &osd_req->r_ops[which].extent.osd_data; */
-	return write_request ? &osd_req->r_data_out : &osd_req->r_data_in;
+	return &osd_req->r_ops[which].extent.osd_data;
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data);

@@ -132,8 +131,7 @@ osd_req_op_cls_request_info(struct ceph_osd_request
*osd_req,
 {
 	BUG_ON(which >= osd_req->r_num_ops);

-	/* return &osd_req->r_ops[which].cls.request_info; */
-	return &osd_req->r_data_out;	/* Request data is outgoing */
+	return &osd_req->r_ops[which].cls.request_info;
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_info);	/* ??? */

@@ -143,8 +141,7 @@ osd_req_op_cls_response_data(struct ceph_osd_request
*osd_req,
 {
 	BUG_ON(which >= osd_req->r_num_ops);

-	/* return &osd_req->r_ops[which].cls.response_data; */
-	return &osd_req->r_data_in;	/* Response data is incoming */
+	return &osd_req->r_ops[which].cls.response_data;
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data);	/* ??? */

@@ -158,9 +155,6 @@ void osd_req_op_extent_osd_data_pages(struct
ceph_osd_request *osd_req,
 	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
 	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
 				pages_from_pool, own_pages);
-
-	osd_req->r_ops[which].extent.osd_data =
-		osd_req_op_extent_osd_data(osd_req, which, write_request);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pages);

@@ -172,9 +166,6 @@ void osd_req_op_extent_osd_data_pagelist(struct
ceph_osd_request *osd_req,

 	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
-
-	osd_req->r_ops[which].extent.osd_data =
-		osd_req_op_extent_osd_data(osd_req, which, write_request);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);

@@ -187,9 +178,6 @@ void osd_req_op_extent_osd_data_bio(struct
ceph_osd_request *osd_req,

 	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
 	ceph_osd_data_bio_init(osd_data, bio, bio_length);
-
-	osd_req->r_ops[which].extent.osd_data =
-		osd_req_op_extent_osd_data(osd_req, which, write_request);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_bio);
 #endif /* CONFIG_BLOCK */
@@ -202,9 +190,6 @@ static void osd_req_op_cls_request_info_pagelist(

 	osd_data = osd_req_op_cls_request_info(osd_req, which);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
-
-	osd_req->r_ops[which].cls.request_info =
-		osd_req_op_cls_request_info(osd_req, which);
 }

 void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
@@ -216,9 +201,6 @@ void osd_req_op_cls_response_data_pages(struct
ceph_osd_request *osd_req,
 	osd_data = osd_req_op_cls_response_data(osd_req, which);
 	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
 				pages_from_pool, own_pages);
-
-	osd_req->r_ops[which].cls.response_data =
-		osd_req_op_cls_response_data(osd_req, which);
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data_pages);

@@ -241,18 +223,39 @@ static u64 ceph_osd_data_length(struct
ceph_osd_data *osd_data)
 	}
 }

+
 static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 {
-	if (osd_data->type != CEPH_OSD_DATA_TYPE_PAGES)
-		return;
-
-	if (osd_data->own_pages) {
+	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES && osd_data->own_pages) {
 		int num_pages;

 		num_pages = calc_pages_for((u64)osd_data->alignment,
 						(u64)osd_data->length);
 		ceph_release_page_vector(osd_data->pages, num_pages);
 	}
+	ceph_osd_data_init(osd_data);
+}
+
+static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
+			unsigned int which)
+{
+	struct ceph_osd_req_op *op;
+
+	BUG_ON(which >= osd_req->r_num_ops);
+	op = &osd_req->r_ops[which];
+
+	switch (op->op) {
+	case CEPH_OSD_OP_READ:
+	case CEPH_OSD_OP_WRITE:
+		ceph_osd_data_release(&op->extent.osd_data);
+		break;
+	case CEPH_OSD_OP_CALL:
+		ceph_osd_data_release(&op->cls.request_info);
+		ceph_osd_data_release(&op->cls.response_data);
+		break;
+	default:
+		break;
+	}
 }

 /*
@@ -261,6 +264,7 @@ static void ceph_osd_data_release(struct
ceph_osd_data *osd_data)
 void ceph_osdc_release_request(struct kref *kref)
 {
 	struct ceph_osd_request *req;
+	unsigned int which;

 	req = container_of(kref, struct ceph_osd_request, r_kref);
 	if (req->r_request)
@@ -270,8 +274,8 @@ void ceph_osdc_release_request(struct kref *kref)
 		ceph_msg_put(req->r_reply);
 	}

-	ceph_osd_data_release(&req->r_data_in);
-	ceph_osd_data_release(&req->r_data_out);
+	for (which = 0; which < req->r_num_ops; which++)
+		osd_req_op_data_release(req, which);

 	ceph_put_snap_context(req->r_snapc);
 	if (req->r_mempool)
@@ -595,27 +599,22 @@ static u64 osd_req_encode_op(struct
ceph_osd_request *req,
 			cpu_to_le64(src->extent.truncate_size);
 		dst->extent.truncate_seq =
 			cpu_to_le32(src->extent.truncate_seq);
-		if (src->op == CEPH_OSD_OP_WRITE) {
-			WARN_ON(src->extent.osd_data != &req->r_data_out);
+		if (src->op == CEPH_OSD_OP_WRITE)
 			ceph_osdc_msg_data_set(req->r_request,
-						src->extent.osd_data);
-		} else {
-			WARN_ON(src->extent.osd_data != &req->r_data_in);
+						&src->extent.osd_data);
+		else
 			ceph_osdc_msg_data_set(req->r_reply,
-						src->extent.osd_data);
-		}
+						&src->extent.osd_data);
 		break;
 	case CEPH_OSD_OP_CALL:
 		dst->cls.class_len = src->cls.class_len;
 		dst->cls.method_len = src->cls.method_len;
 		dst->cls.indata_len = cpu_to_le32(src->cls.request_data_len);
-		WARN_ON(src->cls.response_data != &req->r_data_in);
-		ceph_osdc_msg_data_set(req->r_reply, src->cls.response_data);
-		WARN_ON(src->cls.request_info != &req->r_data_out);
-		ceph_osdc_msg_data_set(req->r_request, src->cls.request_info);
-		BUG_ON(src->cls.request_info->type !=
+		ceph_osdc_msg_data_set(req->r_reply, &src->cls.response_data);
+		ceph_osdc_msg_data_set(req->r_request, &src->cls.request_info);
+		BUG_ON(src->cls.request_info.type !=
 					CEPH_OSD_DATA_TYPE_PAGELIST);
-		request_data_len = src->cls.request_info->pagelist->length;
+		request_data_len = src->cls.request_info.pagelist->length;
 		break;
 	case CEPH_OSD_OP_STARTSYNC:
 		break;
-- 
1.7.9.5

