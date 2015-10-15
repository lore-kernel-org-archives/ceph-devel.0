From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] libceph: add support for CEPH_OSD_OP_GETXATTR
Date: Thu, 15 Oct 2015 14:19:18 +0200
Message-ID: <1444911558-29419-1-git-send-email-ddiss@suse.de>
References: <20151015005150.6bd85b48@plati.site>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52944 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbbJOMTj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Oct 2015 08:19:39 -0400
In-Reply-To: <20151015005150.6bd85b48@plati.site>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: mchristi@redhat.com, idryomov@gmail.com, David Disseldorp <ddiss@suse.de>

Allows for xattr retrieval. Response data buffer allocation is the
responsibility of the osd_req_op_xattr_init() caller.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 include/linux/ceph/osd_client.h |  8 ++++++-
 net/ceph/osd_client.c           | 47 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 7506b48..062efc3 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -91,7 +91,8 @@ struct ceph_osd_req_op {
 			u32 value_len;
 			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
 			__u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
-			struct ceph_osd_data osd_data;
+			struct ceph_osd_data request_data;
+			struct ceph_osd_data response_data;
 		} xattr;
 		struct {
 			const char *class_name;
@@ -298,6 +299,11 @@ extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 					struct page **pages, u64 length,
 					u32 alignment, bool pages_from_pool,
 					bool own_pages);
+extern void osd_req_op_xattr_response_data_pages(struct ceph_osd_request *,
+					unsigned int which,
+					struct page **pages, u64 length,
+					u32 alignment, bool pages_from_pool,
+					bool own_pages);
 
 extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 80b94e3..5ad7ffe 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -243,6 +243,18 @@ void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data_pages);
 
+void osd_req_op_xattr_response_data_pages(struct ceph_osd_request *osd_req,
+			unsigned int which, struct page **pages, u64 length,
+			u32 alignment, bool pages_from_pool, bool own_pages)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, xattr, response_data);
+	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
+				pages_from_pool, own_pages);
+}
+EXPORT_SYMBOL(osd_req_op_xattr_response_data_pages);
+
 static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 {
 	switch (osd_data->type) {
@@ -294,7 +306,9 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 		break;
 	case CEPH_OSD_OP_SETXATTR:
 	case CEPH_OSD_OP_CMPXATTR:
-		ceph_osd_data_release(&op->xattr.osd_data);
+	case CEPH_OSD_OP_GETXATTR:
+		ceph_osd_data_release(&op->xattr.request_data);
+		ceph_osd_data_release(&op->xattr.response_data);
 		break;
 	case CEPH_OSD_OP_STAT:
 		ceph_osd_data_release(&op->raw_data_in);
@@ -562,8 +576,11 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 						      opcode, 0);
 	struct ceph_pagelist *pagelist;
 	size_t payload_len;
+	int ret;
 
-	BUG_ON(opcode != CEPH_OSD_OP_SETXATTR && opcode != CEPH_OSD_OP_CMPXATTR);
+	BUG_ON(opcode != CEPH_OSD_OP_SETXATTR
+		&& opcode != CEPH_OSD_OP_CMPXATTR
+		&& opcode != CEPH_OSD_OP_GETXATTR);
 
 	pagelist = kmalloc(sizeof(*pagelist), GFP_NOFS);
 	if (!pagelist)
@@ -573,18 +590,29 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 
 	payload_len = strlen(name);
 	op->xattr.name_len = payload_len;
-	ceph_pagelist_append(pagelist, name, payload_len);
+	ret = ceph_pagelist_append(pagelist, name, payload_len);
+	if (ret)
+		goto err_reqpl_free;
 
-	op->xattr.value_len = size;
-	ceph_pagelist_append(pagelist, value, size);
-	payload_len += size;
+	if (value) {
+		op->xattr.value_len = size;
+		ret = ceph_pagelist_append(pagelist, value, size);
+		if (ret)
+			goto err_reqpl_free;
+		payload_len += size;
+	}
 
 	op->xattr.cmp_op = cmp_op;
 	op->xattr.cmp_mode = cmp_mode;
 
-	ceph_osd_data_pagelist_init(&op->xattr.osd_data, pagelist);
+	ceph_osd_data_pagelist_init(&op->xattr.request_data, pagelist);
 	op->payload_len = payload_len;
+
 	return 0;
+
+err_reqpl_free:
+	ceph_pagelist_release(pagelist);
+	return ret;
 }
 EXPORT_SYMBOL(osd_req_op_xattr_init);
 
@@ -722,13 +750,16 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 		break;
 	case CEPH_OSD_OP_SETXATTR:
 	case CEPH_OSD_OP_CMPXATTR:
+	case CEPH_OSD_OP_GETXATTR:
 		dst->xattr.name_len = cpu_to_le32(src->xattr.name_len);
 		dst->xattr.value_len = cpu_to_le32(src->xattr.value_len);
 		dst->xattr.cmp_op = src->xattr.cmp_op;
 		dst->xattr.cmp_mode = src->xattr.cmp_mode;
-		osd_data = &src->xattr.osd_data;
+		osd_data = &src->xattr.request_data;
 		ceph_osdc_msg_data_add(req->r_request, osd_data);
 		request_data_len = osd_data->pagelist->length;
+		osd_data = &src->xattr.response_data;
+		ceph_osdc_msg_data_add(req->r_reply, osd_data);
 		break;
 	case CEPH_OSD_OP_CREATE:
 	case CEPH_OSD_OP_DELETE:
-- 
2.1.4

