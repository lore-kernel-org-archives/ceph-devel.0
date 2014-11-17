From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 01/12] libceph: add SETXATTR/CMPXATTR osd operations support
Date: Mon, 17 Nov 2014 15:56:55 +0800
Message-ID: <1416211026-11524-2-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47699 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKQH5c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:57:32 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 include/linux/ceph/osd_client.h | 10 ++++++++++
 net/ceph/osd_client.c           | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 03aeb27..1ad217b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -87,6 +87,13 @@ struct ceph_osd_req_op {
 			struct ceph_osd_data osd_data;
 		} extent;
 		struct {
+			__le32 name_len;
+			__le32 value_len;
+			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
+			__u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
+			struct ceph_osd_data osd_data;
+		} xattr;
+		struct {
 			const char *class_name;
 			const char *method_name;
 			struct ceph_osd_data request_info;
@@ -295,6 +302,9 @@ extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					const char *class, const char *method);
+extern void osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
+				  u16 opcode, const char *name, const void *value,
+				  size_t size, u8 cmp_op, u8 cmp_mode);
 extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					u64 cookie, u64 version, int flag);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1f6c405..f8fb376 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -545,6 +545,34 @@ void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 }
 EXPORT_SYMBOL(osd_req_op_cls_init);
 
+void osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
+			  u16 opcode, const char *name, const void *value,
+			  size_t size, u8 cmp_op, u8 cmp_mode)
+{
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
+	struct ceph_pagelist *pagelist;
+	size_t payload_len;
+
+	pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
+	BUG_ON(!pagelist);
+	ceph_pagelist_init(pagelist);
+
+	payload_len = strlen(name);
+	op->xattr.name_len = payload_len;
+	ceph_pagelist_append(pagelist, name, payload_len);
+
+	op->xattr.value_len = size;
+	ceph_pagelist_append(pagelist, value, size);
+	payload_len += size;
+
+	op->xattr.cmp_op = cmp_op;
+	op->xattr.cmp_mode = cmp_mode;
+
+	ceph_osd_data_pagelist_init(&op->xattr.osd_data, pagelist);
+	op->payload_len = payload_len;
+}
+EXPORT_SYMBOL(osd_req_op_xattr_init);
+
 void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
 				unsigned int which, u16 opcode,
 				u64 cookie, u64 version, int flag)
@@ -676,6 +704,16 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 		dst->alloc_hint.expected_write_size =
 		    cpu_to_le64(src->alloc_hint.expected_write_size);
 		break;
+	case CEPH_OSD_OP_SETXATTR:
+	case CEPH_OSD_OP_CMPXATTR:
+		dst->xattr.name_len = cpu_to_le32(src->xattr.name_len);
+		dst->xattr.value_len = cpu_to_le32(src->xattr.value_len);
+		dst->xattr.cmp_op = src->xattr.cmp_op;
+		dst->xattr.cmp_mode = src->xattr.cmp_mode;
+		osd_data = &src->xattr.osd_data;
+		ceph_osdc_msg_data_add(req->r_request, osd_data);
+		request_data_len = osd_data->pagelist->length;
+		break;
 	default:
 		pr_err("unsupported osd opcode %s\n",
 			ceph_osd_op_name(src->op));
-- 
1.9.3

