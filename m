From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH V2 5/6] libceph: add helper that duplicates last extent operation
Date: Tue, 19 Jan 2016 16:08:10 +0800
Message-ID: <1453190891-40937-6-git-send-email-zyan@redhat.com>
References: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58186 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbcASII4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 03:08:56 -0500
In-Reply-To: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

This helper duplicates last extent operation in OSD request, then
adjusts the new extent operation's offset and length. The helper
is for scatterd page writeback, which adds nonconsecutive dirty
pages to single OSD request.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 include/linux/ceph/osd_client.h |  2 ++
 net/ceph/osd_client.c           | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 6430766..aa07591 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -267,6 +267,8 @@ extern void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 					u64 truncate_size, u32 truncate_seq);
 extern void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
 					unsigned int which, u64 length);
+extern void osd_req_op_extent_dup_last(struct ceph_osd_request *osd_req,
+				       u64 offset_inc);
 
 extern struct ceph_osd_data *osd_req_op_extent_osd_data(
 					struct ceph_osd_request *osd_req,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index c9df912..c0a5665 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -600,6 +600,27 @@ void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_update);
 
+void osd_req_op_extent_dup_last(struct ceph_osd_request *osd_req,
+				u64 offset_inc)
+{
+	struct ceph_osd_req_op *op, *prev_op;
+	int which;
+
+	BUG_ON(osd_req->r_num_ops == 0);
+	which = osd_req->r_num_ops;
+
+	prev_op = &osd_req->r_ops[which - 1];
+	op = _osd_req_op_init(osd_req, which, prev_op->op, prev_op->flags);
+	/* dup previous one */
+	op->payload_len = prev_op->payload_len;
+	op->extent = prev_op->extent;
+	/* adjust offset */
+	op->extent.offset += offset_inc;
+	op->extent.length -= offset_inc;
+	op->payload_len -= offset_inc;
+}
+EXPORT_SYMBOL(osd_req_op_extent_dup_last);
+
 void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			u16 opcode, const char *class, const char *method)
 {
-- 
2.5.0

