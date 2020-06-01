From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/2] libceph: support for alloc hint flags
Date: Mon,  1 Jun 2020 21:58:25 +0200
Message-ID: <20200601195826.17159-2-idryomov@gmail.com>
References: <20200601195826.17159-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgFAT7G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2020 15:59:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D97C061A0E
        for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2020 12:59:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so1074370wrv.4
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2020 12:59:06 -0700 (PDT)
In-Reply-To: <20200601195826.17159-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jason Dillaman <jdillama@redhat.com>

Allow indicating future I/O pattern via flags.  This is supported since
Kraken (and bluestore persists flags together with expected_object_size
and expected_write_size).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c             |  3 ++-
 include/linux/ceph/osd_client.h |  4 +++-
 include/linux/ceph/rados.h      | 14 ++++++++++++++
 net/ceph/osd_client.c           |  8 +++++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 74b2f00199ac..b1cd41e671d1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2253,7 +2253,8 @@ static void __rbd_osd_setup_write_ops(struct ceph_osd_request *osd_req,
 	    !(obj_req->flags & RBD_OBJ_FLAG_MAY_EXIST)) {
 		osd_req_op_alloc_hint_init(osd_req, which++,
 					   rbd_dev->layout.object_size,
-					   rbd_dev->layout.object_size);
+					   rbd_dev->layout.object_size,
+					   0);
 	}
 
 	if (rbd_obj_is_entire(obj_req))
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 671fb93e8c60..c60b59e9291b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -136,6 +136,7 @@ struct ceph_osd_req_op {
 		struct {
 			u64 expected_object_size;
 			u64 expected_write_size;
+			u32 flags;  /* CEPH_OSD_OP_ALLOC_HINT_FLAG_* */
 		} alloc_hint;
 		struct {
 			u64 snapid;
@@ -472,7 +473,8 @@ extern int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int
 extern void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
 				       unsigned int which,
 				       u64 expected_object_size,
-				       u64 expected_write_size);
+				       u64 expected_write_size,
+				       u32 flags);
 
 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 88ed3c5c04c5..3a518fd0eaad 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -464,6 +464,19 @@ enum {
 
 const char *ceph_osd_watch_op_name(int o);
 
+enum {
+	CEPH_OSD_ALLOC_HINT_FLAG_SEQUENTIAL_WRITE = 1,
+	CEPH_OSD_ALLOC_HINT_FLAG_RANDOM_WRITE = 2,
+	CEPH_OSD_ALLOC_HINT_FLAG_SEQUENTIAL_READ = 4,
+	CEPH_OSD_ALLOC_HINT_FLAG_RANDOM_READ = 8,
+	CEPH_OSD_ALLOC_HINT_FLAG_APPEND_ONLY = 16,
+	CEPH_OSD_ALLOC_HINT_FLAG_IMMUTABLE = 32,
+	CEPH_OSD_ALLOC_HINT_FLAG_SHORTLIVED = 64,
+	CEPH_OSD_ALLOC_HINT_FLAG_LONGLIVED = 128,
+	CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE = 256,
+	CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE = 512,
+};
+
 enum {
 	CEPH_OSD_BACKOFF_OP_BLOCK = 1,
 	CEPH_OSD_BACKOFF_OP_ACK_BLOCK = 2,
@@ -517,6 +530,7 @@ struct ceph_osd_op {
 		struct {
 			__le64 expected_object_size;
 			__le64 expected_write_size;
+			__le32 flags;  /* CEPH_OSD_OP_ALLOC_HINT_FLAG_* */
 		} __attribute__ ((packed)) alloc_hint;
 		struct {
 			__le64 snapid;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 22733e844be1..4fea3c33af2a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -932,10 +932,14 @@ static void osd_req_op_watch_init(struct ceph_osd_request *req, int which,
 	op->watch.gen = 0;
 }
 
+/*
+ * @flags: CEPH_OSD_OP_ALLOC_HINT_FLAG_*
+ */
 void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
 				unsigned int which,
 				u64 expected_object_size,
-				u64 expected_write_size)
+				u64 expected_write_size,
+				u32 flags)
 {
 	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
 						      CEPH_OSD_OP_SETALLOCHINT,
@@ -943,6 +947,7 @@ void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
 
 	op->alloc_hint.expected_object_size = expected_object_size;
 	op->alloc_hint.expected_write_size = expected_write_size;
+	op->alloc_hint.flags = flags;
 
 	/*
 	 * CEPH_OSD_OP_SETALLOCHINT op is advisory and therefore deemed
@@ -1018,6 +1023,7 @@ static u32 osd_req_encode_op(struct ceph_osd_op *dst,
 		    cpu_to_le64(src->alloc_hint.expected_object_size);
 		dst->alloc_hint.expected_write_size =
 		    cpu_to_le64(src->alloc_hint.expected_write_size);
+		dst->alloc_hint.flags = cpu_to_le32(src->alloc_hint.flags);
 		break;
 	case CEPH_OSD_OP_SETXATTR:
 	case CEPH_OSD_OP_CMPXATTR:
-- 
2.19.2
