From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/3] libceph: allow setting osd_req_op's flags
Date: Mon, 27 Apr 2015 16:24:55 +0800
Message-ID: <1430123096-11516-2-git-send-email-zyan@redhat.com>
References: <1430123096-11516-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbbD0IZO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Apr 2015 04:25:14 -0400
In-Reply-To: <1430123096-11516-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 drivers/block/rbd.c             |  4 ++--
 fs/ceph/addr.c                  |  3 ++-
 fs/ceph/file.c                  |  2 +-
 include/linux/ceph/osd_client.h |  2 +-
 net/ceph/osd_client.c           | 24 +++++++++++++++---------
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8125233..15ddc5e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2371,7 +2371,7 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
 	}
 
 	if (opcode == CEPH_OSD_OP_DELETE)
-		osd_req_op_init(osd_request, num_ops, opcode);
+		osd_req_op_init(osd_request, num_ops, opcode, 0);
 	else
 		osd_req_op_extent_init(osd_request, num_ops, opcode,
 				       offset, length, 0, 0);
@@ -2843,7 +2843,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 		goto out;
 	stat_request->callback = rbd_img_obj_exists_callback;
 
-	osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT);
+	osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT, 0);
 	osd_req_op_raw_data_in_pages(stat_request->osd_req, 0, pages, size, 0,
 					false, false);
 	rbd_osd_req_format_read(stat_request);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cab1cf5..bdeea57 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -884,7 +884,8 @@ get_more_pages:
 				}
 
 				if (do_sync)
-					osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC);
+					osd_req_op_init(req, 1,
+							CEPH_OSD_OP_STARTSYNC, 0);
 
 				req->r_callback = writepages_finish;
 				req->r_inode = inode;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d533075..a972019 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -615,7 +615,7 @@ ceph_sync_direct_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos)
 			break;
 		}
 
-		osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC);
+		osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC, 0);
 
 		n = iov_iter_get_pages_alloc(from, &pages, len, &start);
 		if (unlikely(n < 0)) {
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 61b19c4..7506b48 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -249,7 +249,7 @@ extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);
 
 extern void osd_req_op_init(struct ceph_osd_request *osd_req,
-					unsigned int which, u16 opcode);
+			    unsigned int which, u16 opcode, u32 flags);
 
 extern void osd_req_op_raw_data_in_pages(struct ceph_osd_request *,
 					unsigned int which,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b93531f..e3c2e8b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -453,7 +453,7 @@ __CEPH_FORALL_OSD_OPS(GENERATE_CASE)
  */
 static struct ceph_osd_req_op *
 _osd_req_op_init(struct ceph_osd_request *osd_req, unsigned int which,
-				u16 opcode)
+		 u16 opcode, u32 flags)
 {
 	struct ceph_osd_req_op *op;
 
@@ -463,14 +463,15 @@ _osd_req_op_init(struct ceph_osd_request *osd_req, unsigned int which,
 	op = &osd_req->r_ops[which];
 	memset(op, 0, sizeof (*op));
 	op->op = opcode;
+	op->flags = flags;
 
 	return op;
 }
 
 void osd_req_op_init(struct ceph_osd_request *osd_req,
-				unsigned int which, u16 opcode)
+		     unsigned int which, u16 opcode, u32 flags)
 {
-	(void)_osd_req_op_init(osd_req, which, opcode);
+	(void)_osd_req_op_init(osd_req, which, opcode, flags);
 }
 EXPORT_SYMBOL(osd_req_op_init);
 
@@ -479,7 +480,8 @@ void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 				u64 offset, u64 length,
 				u64 truncate_size, u32 truncate_seq)
 {
-	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
+						      opcode, 0);
 	size_t payload_len = 0;
 
 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE &&
@@ -518,7 +520,8 @@ EXPORT_SYMBOL(osd_req_op_extent_update);
 void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			u16 opcode, const char *class, const char *method)
 {
-	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
+						      opcode, 0);
 	struct ceph_pagelist *pagelist;
 	size_t payload_len = 0;
 	size_t size;
@@ -555,7 +558,8 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 			  u16 opcode, const char *name, const void *value,
 			  size_t size, u8 cmp_op, u8 cmp_mode)
 {
-	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
+						      opcode, 0);
 	struct ceph_pagelist *pagelist;
 	size_t payload_len;
 
@@ -588,7 +592,8 @@ void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
 				unsigned int which, u16 opcode,
 				u64 cookie, u64 version, int flag)
 {
-	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
+						      opcode, 0);
 
 	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);
 
@@ -605,7 +610,8 @@ void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
 				u64 expected_write_size)
 {
 	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
-						      CEPH_OSD_OP_SETALLOCHINT);
+						      CEPH_OSD_OP_SETALLOCHINT,
+						      0);
 
 	op->alloc_hint.expected_object_size = expected_object_size;
 	op->alloc_hint.expected_write_size = expected_write_size;
@@ -789,7 +795,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	}
 
 	if (opcode == CEPH_OSD_OP_CREATE || opcode == CEPH_OSD_OP_DELETE) {
-		osd_req_op_init(req, which, opcode);
+		osd_req_op_init(req, which, opcode, 0);
 	} else {
 		u32 object_size = le32_to_cpu(layout->fl_object_size);
 		u32 object_base = off - objoff;
-- 
1.9.3

