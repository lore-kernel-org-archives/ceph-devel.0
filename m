From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/6] libceph: variable-sized ceph_object_id
Date: Thu, 19 May 2016 16:06:41 +0200
Message-ID: <1463666802-25140-6-git-send-email-idryomov@gmail.com>
References: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34361 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbcESOHM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 10:07:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so21394819wmn.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 07:07:11 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-165-81.net.upcbroadband.cz. [94.112.165.81])
        by smtp.gmail.com with ESMTPSA id b124sm3586833wmb.1.2016.05.19.07.07.09
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 07:07:10 -0700 (PDT)
In-Reply-To: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently ceph_object_id can hold object names of up to 100
(CEPH_MAX_OID_NAME_LEN) characters.  This is enough for all use cases,
expect one - long rbd image names:

- a format 1 header is named "<imgname>.rbd"
- an object that points to a format 2 header is named "rbd_id.<imgname>"

We operate on these potentially long-named objects during rbd map, and,
for format 1 images, during header refresh.  (A format 2 header name is
a small system-generated string.)

Lift this 100 character limit by making ceph_object_id be able to point
to an externally-allocated string.  Apart from being able to work with
almost arbitrarily-long named objects, this allows us to reduce the
size of ceph_object_id from >100 bytes to 64 bytes.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c         |  8 +++-
 fs/ceph/addr.c              |  6 +--
 fs/ceph/file.c              |  2 +-
 fs/ceph/ioctl.c             |  2 +-
 include/linux/ceph/osdmap.h | 62 ++++++++++++++++++------------
 net/ceph/debugfs.c          |  2 +-
 net/ceph/osd_client.c       | 16 +++++---
 net/ceph/osdmap.c           | 93 ++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 150 insertions(+), 41 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a90c9291cbf9..a41a44d08397 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1965,7 +1965,9 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	osd_req->r_priv = obj_request;
 
 	osd_req->r_base_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
-	ceph_oid_set_name(&osd_req->r_base_oid, obj_request->object_name);
+	if (ceph_oid_aprintf(&osd_req->r_base_oid, GFP_NOIO, "%s",
+			     obj_request->object_name))
+		goto fail;
 
 	if (ceph_osdc_alloc_messages(osd_req, GFP_NOIO))
 		goto fail;
@@ -2017,7 +2019,9 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	osd_req->r_priv = obj_request;
 
 	osd_req->r_base_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
-	ceph_oid_set_name(&osd_req->r_base_oid, obj_request->object_name);
+	if (ceph_oid_aprintf(&osd_req->r_base_oid, GFP_NOIO, "%s",
+			     obj_request->object_name))
+		goto fail;
 
 	if (ceph_osdc_alloc_messages(osd_req, GFP_NOIO))
 		goto fail;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6fee7e0b8931..6f28dd9bacb2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1758,9 +1758,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
 	rd_req->r_flags = CEPH_OSD_FLAG_READ;
 	osd_req_op_init(rd_req, 0, CEPH_OSD_OP_STAT, 0);
 	rd_req->r_base_oloc.pool = pool;
-	snprintf(rd_req->r_base_oid.name, sizeof(rd_req->r_base_oid.name),
-		 "%llx.00000000", ci->i_vino.ino);
-	rd_req->r_base_oid.name_len = strlen(rd_req->r_base_oid.name);
+	ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ci->i_vino.ino);
 
 	err = ceph_osdc_alloc_messages(rd_req, GFP_NOFS);
 	if (err)
@@ -1777,7 +1775,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
 			  CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK;
 	osd_req_op_init(wr_req, 0, CEPH_OSD_OP_CREATE, CEPH_OSD_OP_FLAG_EXCL);
 	wr_req->r_base_oloc.pool = pool;
-	wr_req->r_base_oid = rd_req->r_base_oid;
+	ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
 
 	err = ceph_osdc_alloc_messages(wr_req, GFP_NOFS);
 	if (err)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5d46d106bbb7..9d470397e249 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -715,7 +715,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
 			CEPH_OSD_FLAG_ONDISK |
 			CEPH_OSD_FLAG_WRITE;
 	req->r_base_oloc = orig_req->r_base_oloc;
-	req->r_base_oid = orig_req->r_base_oid;
+	ceph_oid_copy(&req->r_base_oid, &orig_req->r_base_oid);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOFS);
 	if (ret) {
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index f851d8d70158..db296709784a 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -213,7 +213,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 		 ceph_ino(inode), dl.object_no);
 
 	oloc.pool = ceph_file_layout_pg_pool(ci->i_layout);
-	ceph_oid_set_name(&oid, dl.object_name);
+	ceph_oid_printf(&oid, "%s", dl.object_name);
 
 	r = ceph_oloc_oid_to_pg(osdc->osdmap, &oloc, &oid, &pgid);
 	if (r < 0) {
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index e55c08bc3a96..777a29412706 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -64,11 +64,47 @@ struct ceph_object_locator {
  */
 #define CEPH_MAX_OID_NAME_LEN 100
 
+/*
+ * 51-char inline_name is long enough for all cephfs and all but one
+ * rbd requests: <imgname> in "<imgname>.rbd"/"rbd_id.<imgname>" can be
+ * arbitrarily long (~PAGE_SIZE).  It's done once during rbd map; all
+ * other rbd requests fit into inline_name.
+ *
+ * Makes ceph_object_id 64 bytes on 64-bit.
+ */
+#define CEPH_OID_INLINE_LEN 52
+
+/*
+ * Both inline and external buffers have space for a NUL-terminator,
+ * which is carried around.  It's not required though - RADOS object
+ * names don't have to be NUL-terminated and may contain NULs.
+ */
 struct ceph_object_id {
-	char name[CEPH_MAX_OID_NAME_LEN];
+	char *name;
+	char inline_name[CEPH_OID_INLINE_LEN];
 	int name_len;
 };
 
+static inline void ceph_oid_init(struct ceph_object_id *oid)
+{
+	oid->name = oid->inline_name;
+	oid->name_len = 0;
+}
+
+static inline bool ceph_oid_empty(const struct ceph_object_id *oid)
+{
+	return oid->name == oid->inline_name && !oid->name_len;
+}
+
+void ceph_oid_copy(struct ceph_object_id *dest,
+		   const struct ceph_object_id *src);
+__printf(2, 3)
+void ceph_oid_printf(struct ceph_object_id *oid, const char *fmt, ...);
+__printf(3, 4)
+int ceph_oid_aprintf(struct ceph_object_id *oid, gfp_t gfp,
+		     const char *fmt, ...);
+void ceph_oid_destroy(struct ceph_object_id *oid);
+
 struct ceph_pg_mapping {
 	struct rb_node node;
 	struct ceph_pg pgid;
@@ -113,30 +149,6 @@ struct ceph_osdmap {
 	int crush_scratch_ary[CEPH_PG_MAX_SIZE * 3];
 };
 
-static inline void ceph_oid_set_name(struct ceph_object_id *oid,
-				     const char *name)
-{
-	int len;
-
-	len = strlen(name);
-	if (len > sizeof(oid->name)) {
-		WARN(1, "ceph_oid_set_name '%s' len %d vs %zu, truncating\n",
-		     name, len, sizeof(oid->name));
-		len = sizeof(oid->name);
-	}
-
-	memcpy(oid->name, name, len);
-	oid->name_len = len;
-}
-
-static inline void ceph_oid_copy(struct ceph_object_id *dest,
-				 struct ceph_object_id *src)
-{
-	BUG_ON(src->name_len > sizeof(dest->name));
-	memcpy(dest->name, src->name, src->name_len);
-	dest->name_len = src->name_len;
-}
-
 static inline int ceph_osd_exists(struct ceph_osdmap *map, int osd)
 {
 	return osd >= 0 && osd < map->max_osd &&
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index b902fbc7863e..6f8413293d15 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -161,7 +161,7 @@ static int osdc_show(struct seq_file *s, void *pp)
 			   req->r_osd ? req->r_osd->o_osd : -1,
 			   req->r_pgid.pool, req->r_pgid.seed);
 
-		seq_printf(s, "%.*s", req->r_base_oid.name_len,
+		seq_printf(s, "%*pE", req->r_base_oid.name_len,
 			   req->r_base_oid.name);
 
 		if (req->r_reassert_version.epoch)
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 75e27bd3d372..95910aed8e2e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -334,7 +334,10 @@ static void ceph_osdc_release_request(struct kref *kref)
 	for (which = 0; which < req->r_num_ops; which++)
 		osd_req_op_data_release(req, which);
 
+	ceph_oid_destroy(&req->r_base_oid);
+	ceph_oid_destroy(&req->r_target_oid);
 	ceph_put_snap_context(req->r_snapc);
+
 	if (req->r_mempool)
 		mempool_free(req, req->r_osdc->req_mempool);
 	else if (req->r_num_ops <= CEPH_OSD_SLAB_OPS)
@@ -401,7 +404,9 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	INIT_LIST_HEAD(&req->r_req_lru_item);
 	INIT_LIST_HEAD(&req->r_osd_item);
 
+	ceph_oid_init(&req->r_base_oid);
 	req->r_base_oloc.pool = -1;
+	ceph_oid_init(&req->r_target_oid);
 	req->r_target_oloc.pool = -1;
 
 	dout("%s req %p\n", __func__, req);
@@ -415,6 +420,8 @@ int ceph_osdc_alloc_messages(struct ceph_osd_request *req, gfp_t gfp)
 	struct ceph_msg *msg;
 	int msg_size;
 
+	WARN_ON(ceph_oid_empty(&req->r_base_oid));
+
 	/* create request message */
 	msg_size = 4 + 4 + 4; /* client_inc, osdmap_epoch, flags */
 	msg_size += 4 + 4 + 4 + 8; /* mtime, reassert_version */
@@ -859,10 +866,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	}
 
 	req->r_base_oloc.pool = ceph_file_layout_pg_pool(*layout);
-
-	snprintf(req->r_base_oid.name, sizeof(req->r_base_oid.name),
-		 "%llx.%08llx", vino.ino, objnum);
-	req->r_base_oid.name_len = strlen(req->r_base_oid.name);
+	ceph_oid_printf(&req->r_base_oid, "%llx.%08llx", vino.ino, objnum);
 
 	r = ceph_osdc_alloc_messages(req, GFP_NOFS);
 	if (r)
@@ -1410,7 +1414,7 @@ static int __calc_request_pg(struct ceph_osdmap *osdmap,
 		req->r_target_oloc = req->r_base_oloc; /* struct */
 		need_check_tiering = true;
 	}
-	if (req->r_target_oid.name_len == 0) {
+	if (ceph_oid_empty(&req->r_target_oid)) {
 		ceph_oid_copy(&req->r_target_oid, &req->r_base_oid);
 		need_check_tiering = true;
 	}
@@ -2501,7 +2505,7 @@ void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 	/* oid */
 	ceph_encode_32(&p, req->r_base_oid.name_len);
 	memcpy(p, req->r_base_oid.name, req->r_base_oid.name_len);
-	dout("oid '%.*s' len %d\n", req->r_base_oid.name_len,
+	dout("oid %*pE len %d\n", req->r_base_oid.name_len,
 	     req->r_base_oid.name, req->r_base_oid.name_len);
 	p += req->r_base_oid.name_len;
 
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 243574c8cf33..4668b871ca47 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1381,8 +1381,99 @@ bad:
 	return ERR_PTR(err);
 }
 
+void ceph_oid_copy(struct ceph_object_id *dest,
+		   const struct ceph_object_id *src)
+{
+	WARN_ON(!ceph_oid_empty(dest));
+
+	if (src->name != src->inline_name) {
+		/* very rare, see ceph_object_id definition */
+		dest->name = kmalloc(src->name_len + 1,
+				     GFP_NOIO | __GFP_NOFAIL);
+	}
 
+	memcpy(dest->name, src->name, src->name_len + 1);
+	dest->name_len = src->name_len;
+}
+EXPORT_SYMBOL(ceph_oid_copy);
 
+static __printf(2, 0)
+int oid_printf_vargs(struct ceph_object_id *oid, const char *fmt, va_list ap)
+{
+	int len;
+
+	WARN_ON(!ceph_oid_empty(oid));
+
+	len = vsnprintf(oid->inline_name, sizeof(oid->inline_name), fmt, ap);
+	if (len >= sizeof(oid->inline_name))
+		return len;
+
+	oid->name_len = len;
+	return 0;
+}
+
+/*
+ * If oid doesn't fit into inline buffer, BUG.
+ */
+void ceph_oid_printf(struct ceph_object_id *oid, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	BUG_ON(oid_printf_vargs(oid, fmt, ap));
+	va_end(ap);
+}
+EXPORT_SYMBOL(ceph_oid_printf);
+
+static __printf(3, 0)
+int oid_aprintf_vargs(struct ceph_object_id *oid, gfp_t gfp,
+		      const char *fmt, va_list ap)
+{
+	va_list aq;
+	int len;
+
+	va_copy(aq, ap);
+	len = oid_printf_vargs(oid, fmt, aq);
+	va_end(aq);
+
+	if (len) {
+		char *external_name;
+
+		external_name = kmalloc(len + 1, gfp);
+		if (!external_name)
+			return -ENOMEM;
+
+		oid->name = external_name;
+		WARN_ON(vsnprintf(oid->name, len + 1, fmt, ap) != len);
+		oid->name_len = len;
+	}
+
+	return 0;
+}
+
+/*
+ * If oid doesn't fit into inline buffer, allocate.
+ */
+int ceph_oid_aprintf(struct ceph_object_id *oid, gfp_t gfp,
+		     const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = oid_aprintf_vargs(oid, gfp, fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
+EXPORT_SYMBOL(ceph_oid_aprintf);
+
+void ceph_oid_destroy(struct ceph_object_id *oid)
+{
+	if (oid->name != oid->inline_name)
+		kfree(oid->name);
+}
+EXPORT_SYMBOL(ceph_oid_destroy);
 
 /*
  * calculate file layout from given offset, length.
@@ -1474,7 +1565,7 @@ int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
 	pg_out->seed = ceph_str_hash(pi->object_hash, oid->name,
 				     oid->name_len);
 
-	dout("%s '%.*s' pgid %llu.%x\n", __func__, oid->name_len, oid->name,
+	dout("%s %*pE pgid %llu.%x\n", __func__, oid->name_len, oid->name,
 	     pg_out->pool, pg_out->seed);
 	return 0;
 }
-- 
2.4.3

