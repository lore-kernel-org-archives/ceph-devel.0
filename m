From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/6] libceph: rados pool namesapce support
Date: Fri,  5 Feb 2016 22:31:34 +0800
Message-ID: <1454682697-84638-4-git-send-email-zyan@redhat.com>
References: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbcBEOcI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 09:32:08 -0500
In-Reply-To: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sweil@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 drivers/block/rbd.c          |  1 +
 fs/ceph/inode.c              |  3 +++
 include/linux/ceph/ceph_fs.h |  2 ++
 include/linux/ceph/osdmap.h  |  2 ++
 net/ceph/ceph_fs.c           |  1 +
 net/ceph/osd_client.c        | 42 +++++++++++++++++++++++++++++++-----------
 net/ceph/osdmap.c            | 33 +++++++++++++++++++++++++++------
 7 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b0bcb2d..13be37a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4088,6 +4088,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	rbd_dev->layout.stripe_count = 1;
 	rbd_dev->layout.object_size = 1 << RBD_MAX_OBJ_ORDER;
 	rbd_dev->layout.pool_id = spec->pool_id;
+	rbd_dev->layout.pool_ns = NULL;
 
 	/*
 	 * If this is a mapping rbd_dev (as opposed to a parent one),
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b0ad53d..009a917 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -396,6 +396,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_symlink = NULL;
 
 	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
+	memset(&ci->i_layout, 0, sizeof(ci->i_layout));
 
 	ci->i_fragtree = RB_ROOT;
 	mutex_init(&ci->i_fragtree_mutex);
@@ -518,6 +519,8 @@ void ceph_destroy_inode(struct inode *inode)
 	if (ci->i_xattrs.prealloc_blob)
 		ceph_buffer_put(ci->i_xattrs.prealloc_blob);
 
+	ceph_put_pool_ns(ci->i_layout.pool_ns);
+
 	call_rcu(&inode->i_rcu, ceph_i_callback);
 }
 
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 7d8728e..c5675bc 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -53,6 +53,7 @@ struct ceph_file_layout_legacy {
 	__le32 fl_pg_pool;      /* namespace, crush ruleset, rep level */
 } __attribute__ ((packed));
 
+struct ceph_pool_ns;
 /*
  * ceph_file_layout - describe data layout for a file/inode
  */
@@ -62,6 +63,7 @@ struct ceph_file_layout {
 	u32 stripe_count;  /* over this many objects */
 	u32 object_size;   /* until objects are this big */
 	s64 pool_id;        /* rados pool id */
+	struct ceph_pool_ns *pool_ns; /* rados pool namespace */
 };
 
 extern int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index e55c08b..b2e3649 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -55,6 +55,7 @@ static inline bool ceph_can_shift_osds(struct ceph_pg_pool_info *pool)
 
 struct ceph_object_locator {
 	s64 pool;
+	struct ceph_pool_ns *pool_ns;
 };
 
 /*
@@ -63,6 +64,7 @@ struct ceph_object_locator {
  * (probably outdated: must be >= RBD_MAX_MD_NAME_LEN -- currently 100)
  */
 #define CEPH_MAX_OID_NAME_LEN 100
+#define CEPH_MAX_NAMESPACE_LEN 100
 
 struct ceph_object_id {
 	char name[CEPH_MAX_OID_NAME_LEN];
diff --git a/net/ceph/ceph_fs.c b/net/ceph/ceph_fs.c
index 52c8264..47175de 100644
--- a/net/ceph/ceph_fs.c
+++ b/net/ceph/ceph_fs.c
@@ -36,6 +36,7 @@ void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
 	fl->pool_id = le64_to_cpu(legacy->fl_pg_pool);
 	if (fl->pool_id == 0) 
 		fl->pool_id = -1;
+	fl->pool_ns = NULL;
 }
 EXPORT_SYMBOL(ceph_file_layout_from_legacy);
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 450955e..0eb27ad 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -339,6 +339,9 @@ static void ceph_osdc_release_request(struct kref *kref)
 		kfree(req->r_ops);
 
 	ceph_put_snap_context(req->r_snapc);
+	ceph_put_pool_ns(req->r_base_oloc.pool_ns);
+	ceph_put_pool_ns(req->r_target_oloc.pool_ns);
+
 	if (req->r_mempool)
 		mempool_free(req, req->r_osdc->req_mempool);
 	else
@@ -388,6 +391,9 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	req->r_num_ops = 0;
 	req->r_max_ops = num_ops;
 
+	req->r_base_oloc.pool = -1;
+	req->r_target_oloc.pool = -1;
+
 	if (num_ops <= CEPH_OSD_INITIAL_OP) {
 		req->r_ops = req->r_inline_ops;
 	} else {
@@ -409,9 +415,6 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	INIT_LIST_HEAD(&req->r_req_lru_item);
 	INIT_LIST_HEAD(&req->r_osd_item);
 
-	req->r_base_oloc.pool = -1;
-	req->r_target_oloc.pool = -1;
-
 	/* create reply message */
 	msg_size = OSD_OPREPLY_FRONT_LEN;
 	if (num_ops > CEPH_OSD_INITIAL_OP) {
@@ -433,7 +436,7 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 
 	/* create request message; allow space for oid */
 	msg_size = 4 + 4 + 8 + 8 + 4 + 8;
-	msg_size += 2 + 4 + 8 + 4 + 4; /* oloc */
+	msg_size += 2 + 4 + 8 + 4 + 4 + 4 + CEPH_MAX_NAMESPACE_LEN; /* oloc */
 	msg_size += 1 + 8 + 4 + 4;     /* pg_t */
 	msg_size += 4 + CEPH_MAX_OID_NAME_LEN; /* oid */
 	msg_size += 2 + num_ops * sizeof(struct ceph_osd_op);
@@ -864,6 +867,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	}
 
 	req->r_base_oloc.pool = layout->pool_id;
+	req->r_base_oloc.pool_ns = ceph_try_get_pool_ns(&layout->pool_ns);
 
 	snprintf(req->r_base_oid.name, sizeof(req->r_base_oid.name),
 		 "%llx.%08llx", vino.ino, objnum);
@@ -1407,6 +1411,8 @@ static int __calc_request_pg(struct ceph_osdmap *osdmap,
 	need_check_tiering = false;
 	if (req->r_target_oloc.pool == -1) {
 		req->r_target_oloc = req->r_base_oloc; /* struct */
+		if (req->r_target_oloc.pool_ns)
+			ceph_get_pool_ns(req->r_target_oloc.pool_ns);
 		need_check_tiering = true;
 	}
 	if (req->r_target_oid.name_len == 0) {
@@ -1719,10 +1725,10 @@ static int ceph_oloc_decode(void **p, void *end,
 	}
 
 	if (struct_v >= 5) {
-		len = ceph_decode_32(p);
-		if (len > 0) {
-			pr_warn("ceph_object_locator::nspace is set\n");
-			goto e_inval;
+		u32 ns_len = ceph_decode_32(p);
+		if (ns_len > 0) {
+			ceph_decode_need(p, end, ns_len, e_inval);
+			*p += ns_len;
 		}
 	}
 
@@ -1907,7 +1913,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 
 		__unregister_request(osdc, req);
 
-		req->r_target_oloc = redir.oloc; /* struct */
+		req->r_target_oloc.pool = redir.oloc.pool;
 
 		/*
 		 * Start redirect requests with nofail=true.  If
@@ -2459,6 +2465,7 @@ void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 				struct timespec *mtime)
 {
 	struct ceph_msg *msg = req->r_request;
+	struct ceph_pool_ns *pool_ns;
 	void *p;
 	size_t msg_size;
 	int flags = req->r_flags;
@@ -2483,14 +2490,27 @@ void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 	req->r_request_reassert_version = p;
 	p += sizeof(struct ceph_eversion); /* will get filled in */
 
+	if (req->r_target_oloc.pool_ns)
+		pool_ns = req->r_target_oloc.pool_ns;
+	else if (req->r_base_oloc.pool_ns)
+		pool_ns = req->r_base_oloc.pool_ns;
+	else
+		pool_ns = NULL;
+
 	/* oloc */
+	ceph_encode_8(&p, 5);
 	ceph_encode_8(&p, 4);
-	ceph_encode_8(&p, 4);
-	ceph_encode_32(&p, 8 + 4 + 4);
+	ceph_encode_32(&p, 8 + 4 + 4 + 4 + (pool_ns ? pool_ns->name_len : 0));
 	req->r_request_pool = p;
 	p += 8;
 	ceph_encode_32(&p, -1);  /* preferred */
 	ceph_encode_32(&p, 0);   /* key len */
+	if (pool_ns) {
+		ceph_encode_32(&p, pool_ns->name_len);
+		ceph_encode_copy(&p, pool_ns->name, pool_ns->name_len);
+	} else {
+		ceph_encode_32(&p, 0);
+	}
 
 	ceph_encode_8(&p, 1);
 	req->r_request_pgid = p;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index f033ca5..63ade3a 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1470,12 +1470,33 @@ int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
 	if (!pi)
 		return -EIO;
 
-	pg_out->pool = oloc->pool;
-	pg_out->seed = ceph_str_hash(pi->object_hash, oid->name,
-				     oid->name_len);
-
-	dout("%s '%.*s' pgid %llu.%x\n", __func__, oid->name_len, oid->name,
-	     pg_out->pool, pg_out->seed);
+	if (!oloc->pool_ns) {
+		pg_out->pool = oloc->pool;
+		pg_out->seed = ceph_str_hash(pi->object_hash, oid->name,
+					     oid->name_len);
+		dout("%s '%.*s' pgid %llu.%x\n", __func__,
+		     oid->name_len, oid->name, pg_out->pool, pg_out->seed);
+	} else {
+		char stack_buf[256];
+		char *buf = stack_buf;
+		int nsl = oloc->pool_ns->name_len;
+		size_t total = nsl + 1 + oid->name_len;
+		if (total > sizeof(stack_buf)) {
+			buf = kmalloc(total, GFP_NOFS);
+			if (!buf)
+				return -ENOMEM;
+		}
+		memcpy(buf, oloc->pool_ns->name, nsl);
+		buf[nsl] = '\037';
+		memcpy(buf + nsl + 1, oid->name, oid->name_len);
+		pg_out->pool = oloc->pool;
+		pg_out->seed = ceph_str_hash(pi->object_hash, buf, total);
+		if (buf != stack_buf)
+			kfree(buf);
+		dout("%s '%.*s' ns '%.*s' pgid %llu.%x\n", __func__,
+		     oid->name_len, oid->name, nsl, oloc->pool_ns->name,
+		     pg_out->pool, pg_out->seed);
+	}
 	return 0;
 }
 EXPORT_SYMBOL(ceph_oloc_oid_to_pg);
-- 
2.5.0

