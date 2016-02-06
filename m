From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v2 1/6] libceph: define new ceph_file_layout structure
Date: Sat,  6 Feb 2016 15:00:01 +0800
Message-ID: <1454742006-85706-2-git-send-email-zyan@redhat.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33889 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbcBFHAW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 6 Feb 2016 02:00:22 -0500
In-Reply-To: <1454742006-85706-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sweil@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Define new ceph_file_layout structure and rename old ceph_file_layout
to ceph_file_layout_legacy. This is preparation for adding namespace
to ceph_file_layout structure.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 drivers/block/rbd.c          | 12 +++++------
 fs/ceph/addr.c               | 18 ++++++++--------
 fs/ceph/caps.c               |  6 +++++-
 fs/ceph/file.c               |  6 +++---
 fs/ceph/inode.c              |  5 +++--
 fs/ceph/ioctl.c              | 22 +++++++++----------
 fs/ceph/mds_client.h         |  2 +-
 fs/ceph/xattr.c              | 28 ++++++++++---------------
 include/linux/ceph/ceph_fs.h | 50 +++++++++++++++++++-------------------------
 net/ceph/ceph_fs.c           | 30 +++++++++++++++++++++++---
 net/ceph/osd_client.c        |  4 ++--
 net/ceph/osdmap.c            |  6 +++---
 12 files changed, 102 insertions(+), 87 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 22cfc01..b0bcb2d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1967,7 +1967,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	osd_req->r_callback = rbd_osd_req_callback;
 	osd_req->r_priv = obj_request;
 
-	osd_req->r_base_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
+	osd_req->r_base_oloc.pool = rbd_dev->layout.pool_id;
 	ceph_oid_set_name(&osd_req->r_base_oid, obj_request->object_name);
 
 	return osd_req;
@@ -2012,7 +2012,7 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	osd_req->r_callback = rbd_osd_req_callback;
 	osd_req->r_priv = obj_request;
 
-	osd_req->r_base_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
+	osd_req->r_base_oloc.pool = rbd_dev->layout.pool_id;
 	ceph_oid_set_name(&osd_req->r_base_oid, obj_request->object_name);
 
 	return osd_req;
@@ -4084,10 +4084,10 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 
 	/* Initialize the layout used for all rbd requests */
 
-	rbd_dev->layout.fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	rbd_dev->layout.fl_stripe_count = cpu_to_le32(1);
-	rbd_dev->layout.fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	rbd_dev->layout.fl_pg_pool = cpu_to_le32((u32) spec->pool_id);
+	rbd_dev->layout.stripe_unit = 1 << RBD_MAX_OBJ_ORDER;
+	rbd_dev->layout.stripe_count = 1;
+	rbd_dev->layout.object_size = 1 << RBD_MAX_OBJ_ORDER;
+	rbd_dev->layout.pool_id = spec->pool_id;
 
 	/*
 	 * If this is a mapping rbd_dev (as opposed to a parent one),
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5b3a857..6047395 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1701,7 +1701,7 @@ enum {
 	POOL_WRITE	= 2,
 };
 
-static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
+static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_client(&ci->vfs_inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1728,7 +1728,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
 	if (*p)
 		goto out;
 
-	dout("__ceph_pool_perm_get pool %u no perm cached\n", pool);
+	dout("__ceph_pool_perm_get pool %lld no perm cached\n", pool);
 
 	down_write(&mdsc->pool_perm_rwsem);
 	parent = NULL;
@@ -1833,13 +1833,13 @@ out_unlock:
 out:
 	if (!err)
 		err = have;
-	dout("__ceph_pool_perm_get pool %u result = %d\n", pool, err);
+	dout("__ceph_pool_perm_get pool %lld result = %d\n", pool, err);
 	return err;
 }
 
 int ceph_pool_perm_check(struct ceph_inode_info *ci, int need)
 {
-	u32 pool;
+	s64 pool;
 	int ret, flags;
 
 	if (ceph_test_mount_opt(ceph_inode_to_client(&ci->vfs_inode),
@@ -1848,17 +1848,17 @@ int ceph_pool_perm_check(struct ceph_inode_info *ci, int need)
 
 	spin_lock(&ci->i_ceph_lock);
 	flags = ci->i_ceph_flags;
-	pool = ceph_file_layout_pg_pool(ci->i_layout);
+	pool = ci->i_layout.pool_id;
 	spin_unlock(&ci->i_ceph_lock);
 check:
 	if (flags & CEPH_I_POOL_PERM) {
 		if ((need & CEPH_CAP_FILE_RD) && !(flags & CEPH_I_POOL_RD)) {
-			dout("ceph_pool_perm_check pool %u no read perm\n",
+			dout("ceph_pool_perm_check pool %lld no read perm\n",
 			     pool);
 			return -EPERM;
 		}
 		if ((need & CEPH_CAP_FILE_WR) && !(flags & CEPH_I_POOL_WR)) {
-			dout("ceph_pool_perm_check pool %u no write perm\n",
+			dout("ceph_pool_perm_check pool %lld no write perm\n",
 			     pool);
 			return -EPERM;
 		}
@@ -1876,10 +1876,10 @@ check:
 		flags |= CEPH_I_POOL_WR;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (pool == ceph_file_layout_pg_pool(ci->i_layout)) {
+	if (pool == ci->i_layout.pool_id) {
 		ci->i_ceph_flags = flags;
         } else {
-		pool = ceph_file_layout_pg_pool(ci->i_layout);
+		pool = ci->i_layout.pool_id;
 		flags = ci->i_ceph_flags;
 	}
 	spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6094d0e..b68be57 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2875,7 +2875,11 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 
 	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
 		/* file layout may have changed */
-		ci->i_layout = grant->layout;
+		s64 old_pool = ci->i_layout.pool_id;
+		ceph_file_layout_from_legacy(&ci->i_layout, &grant->layout);
+		if (ci->i_layout.pool_id != old_pool)
+			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
+
 		/* size/truncate_seq? */
 		queue_trunc = ceph_fill_file_size(inode, issued,
 					le32_to_cpu(grant->truncate_seq),
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 389adac..dc6dc5b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1537,9 +1537,9 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 {
 	int ret = 0;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	s32 stripe_unit = ceph_file_layout_su(ci->i_layout);
-	s32 stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
-	s32 object_size = ceph_file_layout_object_size(ci->i_layout);
+	s32 stripe_unit = ci->i_layout.stripe_unit;
+	s32 stripe_count = ci->i_layout.stripe_count;
+	s32 object_size = ci->i_layout.object_size;
 	u64 object_set_size = object_size * stripe_count;
 	u64 nearly, t;
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 63d0198..b0ad53d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -753,9 +753,10 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
-		if (ci->i_layout.fl_pg_pool != info->layout.fl_pg_pool)
+		s64 old_pool = ci->i_layout.pool_id;
+		ceph_file_layout_from_legacy(&ci->i_layout, &info->layout);
+		if (ci->i_layout.pool_id != old_pool)
 			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
-		ci->i_layout = info->layout;
 
 		queue_trunc = ceph_fill_file_size(inode, issued,
 					le32_to_cpu(info->truncate_seq),
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index f851d8d..bd4a755 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -21,10 +21,10 @@ static long ceph_ioctl_get_layout(struct file *file, void __user *arg)
 
 	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
 	if (!err) {
-		l.stripe_unit = ceph_file_layout_su(ci->i_layout);
-		l.stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
-		l.object_size = ceph_file_layout_object_size(ci->i_layout);
-		l.data_pool = le32_to_cpu(ci->i_layout.fl_pg_pool);
+		l.stripe_unit = ci->i_layout.stripe_unit;
+		l.stripe_count = ci->i_layout.stripe_count;
+		l.object_size = ci->i_layout.object_size;
+		l.data_pool = ci->i_layout.pool_id;
 		l.preferred_osd = (s32)-1;
 		if (copy_to_user(arg, &l, sizeof(l)))
 			return -EFAULT;
@@ -82,19 +82,19 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	if (l.stripe_count)
 		nl.stripe_count = l.stripe_count;
 	else
-		nl.stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
+		nl.stripe_count = ci->i_layout.stripe_count;
 	if (l.stripe_unit)
 		nl.stripe_unit = l.stripe_unit;
 	else
-		nl.stripe_unit = ceph_file_layout_su(ci->i_layout);
+		nl.stripe_unit = ci->i_layout.stripe_unit;
 	if (l.object_size)
 		nl.object_size = l.object_size;
 	else
-		nl.object_size = ceph_file_layout_object_size(ci->i_layout);
+		nl.object_size = ci->i_layout.object_size;
 	if (l.data_pool)
 		nl.data_pool = l.data_pool;
 	else
-		nl.data_pool = ceph_file_layout_pg_pool(ci->i_layout);
+		nl.data_pool = ci->i_layout.pool_id;
 
 	/* this is obsolete, and always -1 */
 	nl.preferred_osd = le64_to_cpu(-1);
@@ -202,8 +202,8 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 		return -EIO;
 	}
 	dl.file_offset -= dl.object_offset;
-	dl.object_size = ceph_file_layout_object_size(ci->i_layout);
-	dl.block_size = ceph_file_layout_su(ci->i_layout);
+	dl.object_size = ci->i_layout.object_size;
+	dl.block_size = ci->i_layout.stripe_unit;
 
 	/* block_offset = object_offset % block_size */
 	tmp = dl.object_offset;
@@ -212,7 +212,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	snprintf(dl.object_name, sizeof(dl.object_name), "%llx.%08llx",
 		 ceph_ino(inode), dl.object_no);
 
-	oloc.pool = ceph_file_layout_pg_pool(ci->i_layout);
+	oloc.pool = ci->i_layout.pool_id;
 	ceph_oid_set_name(&oid, dl.object_name);
 
 	r = ceph_oloc_oid_to_pg(osdc->osdmap, &oloc, &oid, &pgid);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index ccf11ef..6eb331c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -267,8 +267,8 @@ struct ceph_mds_request {
 
 struct ceph_pool_perm {
 	struct rb_node node;
-	u32 pool;
 	int perm;
+	s64 pool;
 };
 
 /*
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 1e1c00a..c431f4c 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -70,7 +70,7 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	int ret;
 	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
-	s64 pool = ceph_file_layout_pg_pool(ci->i_layout);
+	s64 pool = ci->i_layout.pool_id;
 	const char *pool_name;
 	char buf[128];
 
@@ -80,10 +80,9 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	if (pool_name) {
 		size_t len = strlen(pool_name);
 		ret = snprintf(buf, sizeof(buf),
-		"stripe_unit=%lld stripe_count=%lld object_size=%lld pool=",
-		(unsigned long long)ceph_file_layout_su(ci->i_layout),
-		(unsigned long long)ceph_file_layout_stripe_count(ci->i_layout),
-	        (unsigned long long)ceph_file_layout_object_size(ci->i_layout));
+		"stripe_unit=%u stripe_count=%u object_size=%u pool=",
+		ci->i_layout.stripe_unit, ci->i_layout.stripe_count,
+	        ci->i_layout.object_size);
 		if (!size) {
 			ret += len;
 		} else if (ret + len > size) {
@@ -95,11 +94,9 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 		}
 	} else {
 		ret = snprintf(buf, sizeof(buf),
-		"stripe_unit=%lld stripe_count=%lld object_size=%lld pool=%lld",
-		(unsigned long long)ceph_file_layout_su(ci->i_layout),
-		(unsigned long long)ceph_file_layout_stripe_count(ci->i_layout),
-	        (unsigned long long)ceph_file_layout_object_size(ci->i_layout),
-		(unsigned long long)pool);
+		"stripe_unit=%u stripe_count=%u object_size=%u pool=%lld",
+		ci->i_layout.stripe_unit, ci->i_layout.stripe_count,
+	        ci->i_layout.object_size, (unsigned long long)pool);
 		if (size) {
 			if (ret <= size)
 				memcpy(val, buf, ret);
@@ -114,22 +111,19 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 static size_t ceph_vxattrcb_layout_stripe_unit(struct ceph_inode_info *ci,
 					       char *val, size_t size)
 {
-	return snprintf(val, size, "%lld",
-			(unsigned long long)ceph_file_layout_su(ci->i_layout));
+	return snprintf(val, size, "%u", ci->i_layout.stripe_unit);
 }
 
 static size_t ceph_vxattrcb_layout_stripe_count(struct ceph_inode_info *ci,
 						char *val, size_t size)
 {
-	return snprintf(val, size, "%lld",
-	       (unsigned long long)ceph_file_layout_stripe_count(ci->i_layout));
+	return snprintf(val, size, "%u", ci->i_layout.stripe_count);
 }
 
 static size_t ceph_vxattrcb_layout_object_size(struct ceph_inode_info *ci,
 					       char *val, size_t size)
 {
-	return snprintf(val, size, "%lld",
-	       (unsigned long long)ceph_file_layout_object_size(ci->i_layout));
+	return snprintf(val, size, "%u", ci->i_layout.object_size);
 }
 
 static size_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
@@ -138,7 +132,7 @@ static size_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 	int ret;
 	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
-	s64 pool = ceph_file_layout_pg_pool(ci->i_layout);
+	s64 pool = ci->i_layout.pool_id;
 	const char *pool_name;
 
 	down_read(&osdc->map_sem);
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index bf74005..7d8728e 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -34,9 +34,9 @@
 #define CEPH_MAX_MON   31
 
 /*
- * ceph_file_layout - describe data layout for a file/inode
+ * legacy ceph_file_layoute
  */
-struct ceph_file_layout {
+struct ceph_file_layout_legacy {
 	/* file -> object mapping */
 	__le32 fl_stripe_unit;     /* stripe unit, in bytes.  must be multiple
 				      of page size. */
@@ -53,33 +53,25 @@ struct ceph_file_layout {
 	__le32 fl_pg_pool;      /* namespace, crush ruleset, rep level */
 } __attribute__ ((packed));
 
-#define ceph_file_layout_su(l) ((__s32)le32_to_cpu((l).fl_stripe_unit))
-#define ceph_file_layout_stripe_count(l) \
-	((__s32)le32_to_cpu((l).fl_stripe_count))
-#define ceph_file_layout_object_size(l) ((__s32)le32_to_cpu((l).fl_object_size))
-#define ceph_file_layout_cas_hash(l) ((__s32)le32_to_cpu((l).fl_cas_hash))
-#define ceph_file_layout_object_su(l) \
-	((__s32)le32_to_cpu((l).fl_object_stripe_unit))
-#define ceph_file_layout_pg_pool(l) \
-	((__s32)le32_to_cpu((l).fl_pg_pool))
-
-static inline unsigned ceph_file_layout_stripe_width(struct ceph_file_layout *l)
-{
-	return le32_to_cpu(l->fl_stripe_unit) *
-		le32_to_cpu(l->fl_stripe_count);
-}
-
-/* "period" == bytes before i start on a new set of objects */
-static inline unsigned ceph_file_layout_period(struct ceph_file_layout *l)
-{
-	return le32_to_cpu(l->fl_object_size) *
-		le32_to_cpu(l->fl_stripe_count);
-}
+/*
+ * ceph_file_layout - describe data layout for a file/inode
+ */
+struct ceph_file_layout {
+	/* file -> object mapping */
+	u32 stripe_unit;   /* stripe unit, in bytes */
+	u32 stripe_count;  /* over this many objects */
+	u32 object_size;   /* until objects are this big */
+	s64 pool_id;        /* rados pool id */
+};
+
+extern int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
+extern void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
+				struct ceph_file_layout_legacy *legacy);
+extern void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
+				struct ceph_file_layout_legacy *legacy);
 
 #define CEPH_MIN_STRIPE_UNIT 65536
 
-int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
-
 struct ceph_dir_layout {
 	__u8   dl_dir_hash;   /* see ceph_hash.h for ids */
 	__u8   dl_unused1;
@@ -382,7 +374,7 @@ union ceph_mds_request_args {
 		__le32 flags;
 	} __attribute__ ((packed)) setxattr;
 	struct {
-		struct ceph_file_layout layout;
+		struct ceph_file_layout_legacy layout;
 	} __attribute__ ((packed)) setlayout;
 	struct {
 		__u8 rule; /* currently fcntl or flock */
@@ -461,7 +453,7 @@ struct ceph_mds_reply_inode {
 	__le64 version;                /* inode version */
 	__le64 xattr_version;          /* version for xattr blob */
 	struct ceph_mds_reply_cap cap; /* caps issued for this inode */
-	struct ceph_file_layout layout;
+	struct ceph_file_layout_legacy layout;
 	struct ceph_timespec ctime, mtime, atime;
 	__le32 time_warp_seq;
 	__le64 size, max_size, truncate_size;
@@ -656,7 +648,7 @@ struct ceph_mds_caps {
 	__le64 size, max_size, truncate_size;
 	__le32 truncate_seq;
 	struct ceph_timespec mtime, atime, ctime;
-	struct ceph_file_layout layout;
+	struct ceph_file_layout_legacy layout;
 	__le32 time_warp_seq;
 } __attribute__ ((packed));
 
diff --git a/net/ceph/ceph_fs.c b/net/ceph/ceph_fs.c
index 41466cc..52c8264 100644
--- a/net/ceph/ceph_fs.c
+++ b/net/ceph/ceph_fs.c
@@ -9,9 +9,9 @@
  */
 int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
 {
-	__u32 su = le32_to_cpu(layout->fl_stripe_unit);
-	__u32 sc = le32_to_cpu(layout->fl_stripe_count);
-	__u32 os = le32_to_cpu(layout->fl_object_size);
+	__u32 su = layout->stripe_unit;
+	__u32 sc = layout->stripe_count;
+	__u32 os = layout->object_size;
 
 	/* stripe unit, object size must be non-zero, 64k increment */
 	if (!su || (su & (CEPH_MIN_STRIPE_UNIT-1)))
@@ -27,6 +27,30 @@ int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
 	return 1;
 }
 
+void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
+				  struct ceph_file_layout_legacy *legacy)
+{       
+	fl->stripe_unit = le32_to_cpu(legacy->fl_stripe_unit);
+	fl->stripe_count = le32_to_cpu(legacy->fl_stripe_count);
+	fl->object_size = le32_to_cpu(legacy->fl_object_size);
+	fl->pool_id = le64_to_cpu(legacy->fl_pg_pool);
+	if (fl->pool_id == 0) 
+		fl->pool_id = -1;
+}
+EXPORT_SYMBOL(ceph_file_layout_from_legacy);
+
+void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
+				struct ceph_file_layout_legacy *legacy)
+{       
+	legacy->fl_stripe_unit = cpu_to_le32(fl->stripe_unit);
+	legacy->fl_stripe_count = cpu_to_le32(fl->stripe_count);
+	legacy->fl_object_size = cpu_to_le32(fl->object_size);
+	if (fl->pool_id >= 0)
+		legacy->fl_pg_pool = cpu_to_le64(fl->pool_id);
+	else    
+		legacy->fl_pg_pool = 0;
+}
+EXPORT_SYMBOL(ceph_file_layout_to_legacy);
 
 int ceph_flags_to_mode(int flags)
 {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index fb9da42..450955e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -848,7 +848,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	if (opcode == CEPH_OSD_OP_CREATE || opcode == CEPH_OSD_OP_DELETE) {
 		osd_req_op_init(req, which, opcode, 0);
 	} else {
-		u32 object_size = le32_to_cpu(layout->fl_object_size);
+		u32 object_size = layout->object_size;
 		u32 object_base = off - objoff;
 		if (!(truncate_seq == 1 && truncate_size == -1ULL)) {
 			if (truncate_size <= object_base) {
@@ -863,7 +863,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 				       truncate_size, truncate_seq);
 	}
 
-	req->r_base_oloc.pool = ceph_file_layout_pg_pool(*layout);
+	req->r_base_oloc.pool = layout->pool_id;
 
 	snprintf(req->r_base_oid.name, sizeof(req->r_base_oid.name),
 		 "%llx.%08llx", vino.ino, objnum);
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 243574c..f033ca5 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1397,9 +1397,9 @@ int ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
 				   u64 *ono,
 				   u64 *oxoff, u64 *oxlen)
 {
-	u32 osize = le32_to_cpu(layout->fl_object_size);
-	u32 su = le32_to_cpu(layout->fl_stripe_unit);
-	u32 sc = le32_to_cpu(layout->fl_stripe_count);
+	u32 osize = layout->object_size;
+	u32 su = layout->stripe_unit;
+	u32 sc = layout->stripe_count;
 	u32 bl, stripeno, stripepos, objsetno;
 	u32 su_per_object;
 	u64 t, su_offset;
-- 
2.5.0

