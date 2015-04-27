From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/3] ceph: check OSD caps before read/write
Date: Mon, 27 Apr 2015 16:24:56 +0800
Message-ID: <1430123096-11516-3-git-send-email-zyan@redhat.com>
References: <1430123096-11516-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbbD0IZT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Apr 2015 04:25:19 -0400
In-Reply-To: <1430123096-11516-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c       | 203 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/caps.c       |   4 +
 fs/ceph/inode.c      |   3 +
 fs/ceph/mds_client.c |   4 +
 fs/ceph/mds_client.h |   9 +++
 fs/ceph/super.c      |  15 +++-
 fs/ceph/super.h      |  17 +++--
 7 files changed, 249 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index bdeea57..c65f9e0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1599,3 +1599,206 @@ int ceph_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_ops = &ceph_vmops;
 	return 0;
 }
+
+enum {
+	POOL_READ	= 1,
+	POOL_WRITE	= 2,
+};
+
+static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
+{
+	struct ceph_fs_client *fsc = ceph_inode_to_client(&ci->vfs_inode);
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_osd_request *rd_req = NULL, *wr_req = NULL;
+	struct rb_node **p, *parent;
+	struct ceph_pool_perm *perm;
+	struct page **pages;
+	int err = 0, err2 = 0, have = 0;
+
+	down_read(&mdsc->pool_perm_rwsem);
+	p = &mdsc->pool_perm_tree.rb_node;
+	while (*p) {
+		perm = rb_entry(*p, struct ceph_pool_perm, node);
+		if (pool < perm->pool)
+			p = &(*p)->rb_left;
+		else if (pool > perm->pool)
+			p = &(*p)->rb_right;
+		else {
+			have = perm->perm;
+			break;
+		}
+	}
+	up_read(&mdsc->pool_perm_rwsem);
+	if (*p)
+		goto out;
+
+	dout("__ceph_pool_perm_get pool %u no perm cached\n", pool);
+
+	down_write(&mdsc->pool_perm_rwsem);
+	parent = NULL;
+	while (*p) {
+		parent = *p;
+		perm = rb_entry(parent, struct ceph_pool_perm, node);
+		if (pool < perm->pool)
+			p = &(*p)->rb_left;
+		else if (pool > perm->pool)
+			p = &(*p)->rb_right;
+		else {
+			have = perm->perm;
+			break;
+		}
+	}
+	if (*p) {
+		up_write(&mdsc->pool_perm_rwsem);
+		goto out;
+	}
+
+	rd_req = ceph_osdc_alloc_request(&fsc->client->osdc,
+					 ci->i_snap_realm->cached_context,
+					 1, false, GFP_NOFS);
+	if (!rd_req) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	rd_req->r_flags = CEPH_OSD_FLAG_READ;
+	osd_req_op_init(rd_req, 0, CEPH_OSD_OP_STAT, 0);
+	rd_req->r_base_oloc.pool = pool;
+	snprintf(rd_req->r_base_oid.name, sizeof(rd_req->r_base_oid.name),
+		 "%llx.00000000", ci->i_vino.ino);
+	rd_req->r_base_oid.name_len = strlen(rd_req->r_base_oid.name);
+
+	wr_req = ceph_osdc_alloc_request(&fsc->client->osdc,
+					 ci->i_snap_realm->cached_context,
+					 1, false, GFP_NOFS);
+	if (!wr_req) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	wr_req->r_flags = CEPH_OSD_FLAG_WRITE |
+			  CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK;
+	osd_req_op_init(wr_req, 0, CEPH_OSD_OP_CREATE, CEPH_OSD_OP_FLAG_EXCL);
+	wr_req->r_base_oloc.pool = pool;
+	wr_req->r_base_oid = rd_req->r_base_oid;
+
+	/* one page should be large enough for STAT data */
+	pages = ceph_alloc_page_vector(1, GFP_KERNEL);
+	if (IS_ERR(pages)) {
+		err = PTR_ERR(pages);
+		goto out_unlock;
+	}
+
+	osd_req_op_raw_data_in_pages(rd_req, 0, pages, PAGE_SIZE,
+				     0, false, true);
+	ceph_osdc_build_request(rd_req, 0, NULL, CEPH_NOSNAP,
+				&ci->vfs_inode.i_mtime);
+	err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
+
+	ceph_osdc_build_request(wr_req, 0, NULL, CEPH_NOSNAP,
+				&ci->vfs_inode.i_mtime);
+	err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
+
+	if (!err)
+		err = ceph_osdc_wait_request(&fsc->client->osdc, rd_req);
+	if (!err2)
+		err2 = ceph_osdc_wait_request(&fsc->client->osdc, wr_req);
+
+	if (err >= 0 || err == -ENOENT)
+		have |= POOL_READ;
+	else if (err != -EPERM)
+		goto out_unlock;
+
+	if (err2 == 0 || err2 == -EEXIST)
+		have |= POOL_WRITE;
+	else if (err2 != -EPERM) {
+		err = err2;
+		goto out_unlock;
+	}
+
+	perm = kmalloc(sizeof(*perm), GFP_NOFS);
+	if (!perm) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	perm->pool = pool;
+	perm->perm = have;
+	rb_link_node(&perm->node, parent, p);
+	rb_insert_color(&perm->node, &mdsc->pool_perm_tree);
+	err = 0;
+out_unlock:
+	up_write(&mdsc->pool_perm_rwsem);
+
+	if (rd_req)
+		ceph_osdc_put_request(rd_req);
+	if (wr_req)
+		ceph_osdc_put_request(wr_req);
+out:
+	if (!err)
+		err = have;
+	dout("__ceph_pool_perm_get pool %u result = %d\n", pool, err);
+	return err;
+}
+
+int ceph_pool_perm_check(struct ceph_inode_info *ci, int need)
+{
+	u32 pool;
+	int ret, flags;
+
+	if (ceph_test_mount_opt(ceph_inode_to_client(&ci->vfs_inode),
+				NOPOOLPERM))
+		return 0;
+
+	spin_lock(&ci->i_ceph_lock);
+	flags = ci->i_ceph_flags;
+	pool = ceph_file_layout_pg_pool(ci->i_layout);
+	spin_unlock(&ci->i_ceph_lock);
+check:
+	if (flags & CEPH_I_POOL_PERM) {
+		if ((need & CEPH_CAP_FILE_RD) && !(flags & CEPH_I_POOL_RD)) {
+			dout("ceph_pool_perm_check pool %u no read perm\n",
+			     pool);
+			return -EPERM;
+		}
+		if ((need & CEPH_CAP_FILE_WR) && !(flags & CEPH_I_POOL_WR)) {
+			dout("ceph_pool_perm_check pool %u no write perm\n",
+			     pool);
+			return -EPERM;
+		}
+		return 0;
+	}
+
+	ret = __ceph_pool_perm_get(ci, pool);
+	if (ret < 0)
+		return ret;
+
+	flags = CEPH_I_POOL_PERM;
+	if (ret & POOL_READ)
+		flags |= CEPH_I_POOL_RD;
+	if (ret & POOL_WRITE)
+		flags |= CEPH_I_POOL_WR;
+
+	spin_lock(&ci->i_ceph_lock);
+	if (pool == ceph_file_layout_pg_pool(ci->i_layout)) {
+		ci->i_ceph_flags = flags;
+        } else {
+		pool = ceph_file_layout_pg_pool(ci->i_layout);
+		flags = ci->i_ceph_flags;
+	}
+	spin_unlock(&ci->i_ceph_lock);
+	goto check;
+}
+
+void ceph_pool_perm_destroy(struct ceph_mds_client *mdsc)
+{
+	struct ceph_pool_perm *perm;
+	struct rb_node *n;
+
+	while (!RB_EMPTY_ROOT(&mdsc->pool_perm_tree)) {
+		n = rb_first(&mdsc->pool_perm_tree);
+		perm = rb_entry(n, struct ceph_pool_perm, node);
+		rb_erase(n, &mdsc->pool_perm_tree);
+		kfree(perm);
+	}
+}
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 11631c4..7438c00 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2233,6 +2233,10 @@ int ceph_get_caps(struct ceph_inode_info *ci, int need, int want,
 {
 	int _got, check_max, ret, err = 0;
 
+	ret = ceph_pool_perm_check(ci, need);
+	if (ret < 0)
+		return ret;
+
 retry:
 	if (endoff > 0)
 		check_max_size(&ci->vfs_inode, endoff);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 119c43c..7ae320bc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -753,7 +753,10 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
+		if (ci->i_layout.fl_pg_pool != info->layout.fl_pg_pool)
+			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
 		ci->i_layout = info->layout;
+
 		queue_trunc = ceph_fill_file_size(inode, issued,
 					le32_to_cpu(info->truncate_seq),
 					le64_to_cpu(info->truncate_size),
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0a2eb32..61e316a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3414,6 +3414,9 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	ceph_caps_init(mdsc);
 	ceph_adjust_min_caps(mdsc, fsc->min_caps);
 
+	init_rwsem(&mdsc->pool_perm_rwsem);
+	mdsc->pool_perm_tree = RB_ROOT;
+
 	return 0;
 }
 
@@ -3607,6 +3610,7 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 		ceph_mdsmap_destroy(mdsc->mdsmap);
 	kfree(mdsc->sessions);
 	ceph_caps_finalize(mdsc);
+	ceph_pool_perm_destroy(mdsc);
 }
 
 void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 1875b5d..d474141 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -260,6 +260,12 @@ struct ceph_mds_request {
 	int r_num_caps;
 };
 
+struct ceph_pool_perm {
+	struct rb_node node;
+	u32 pool;
+	int perm;
+};
+
 /*
  * mds client state
  */
@@ -328,6 +334,9 @@ struct ceph_mds_client {
 	spinlock_t	  dentry_lru_lock;
 	struct list_head  dentry_lru;
 	int		  num_dentry;
+
+	struct rw_semaphore     pool_perm_rwsem;
+	struct rb_root		pool_perm_tree;
 };
 
 extern const char *ceph_mds_op_name(int op);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index e463ebd..43c7193 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -134,10 +134,12 @@ enum {
 	Opt_noino32,
 	Opt_fscache,
 	Opt_nofscache,
+	Opt_poolperm,
+	Opt_nopoolperm,
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	Opt_acl,
 #endif
-	Opt_noacl
+	Opt_noacl,
 };
 
 static match_table_t fsopt_tokens = {
@@ -165,6 +167,8 @@ static match_table_t fsopt_tokens = {
 	{Opt_noino32, "noino32"},
 	{Opt_fscache, "fsc"},
 	{Opt_nofscache, "nofsc"},
+	{Opt_poolperm, "poolperm"},
+	{Opt_nopoolperm, "nopoolperm"},
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	{Opt_acl, "acl"},
 #endif
@@ -268,6 +272,13 @@ static int parse_fsopt_token(char *c, void *private)
 	case Opt_nofscache:
 		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
 		break;
+	case Opt_poolperm:
+		fsopt->flags &= ~CEPH_MOUNT_OPT_NOPOOLPERM;
+		printk ("pool perm");
+		break;
+	case Opt_nopoolperm:
+		fsopt->flags |= CEPH_MOUNT_OPT_NOPOOLPERM;
+		break;
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	case Opt_acl:
 		fsopt->sb_flags |= MS_POSIXACL;
@@ -436,6 +447,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",nodcache");
 	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE)
 		seq_puts(m, ",fsc");
+	if (fsopt->flags & CEPH_MOUNT_OPT_NOPOOLPERM)
+		seq_puts(m, ",nopoolperm");
 
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	if (fsopt->sb_flags & MS_POSIXACL)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index fa20e13..18b917c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -35,6 +35,7 @@
 #define CEPH_MOUNT_OPT_INO32           (1<<8) /* 32 bit inos */
 #define CEPH_MOUNT_OPT_DCACHE          (1<<9) /* use dcache for readdir etc */
 #define CEPH_MOUNT_OPT_FSCACHE         (1<<10) /* use fscache */
+#define CEPH_MOUNT_OPT_NOPOOLPERM      (1<<11) /* no pool permission check */
 
 #define CEPH_MOUNT_OPT_DEFAULT    (CEPH_MOUNT_OPT_RBYTES | \
 				   CEPH_MOUNT_OPT_DCACHE)
@@ -438,10 +439,14 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 /*
  * Ceph inode.
  */
-#define CEPH_I_DIR_ORDERED	1  /* dentries in dir are ordered */
-#define CEPH_I_NODELAY		4  /* do not delay cap release */
-#define CEPH_I_FLUSH		8  /* do not delay flush of dirty metadata */
-#define CEPH_I_NOFLUSH		16 /* do not flush dirty caps */
+#define CEPH_I_DIR_ORDERED	(1 << 0)  /* dentries in dir are ordered */
+#define CEPH_I_NODELAY		(1 << 1)  /* do not delay cap release */
+#define CEPH_I_FLUSH		(1 << 2)  /* do not delay flush of dirty metadata */
+#define CEPH_I_NOFLUSH		(1 << 3)  /* do not flush dirty caps */
+#define CEPH_I_POOL_PERM	(1 << 4)  /* pool rd/wr bits are valid */
+#define CEPH_I_POOL_RD		(1 << 5)  /* can read from pool */
+#define CEPH_I_POOL_WR		(1 << 6)  /* can write to pool */
+
 
 static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
 					   int release_count, int ordered_count)
@@ -879,6 +884,9 @@ extern void ceph_put_fmode(struct ceph_inode_info *ci, int mode);
 /* addr.c */
 extern const struct address_space_operations ceph_aops;
 extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
+extern int ceph_uninline_data(struct file *filp, struct page *locked_page);
+extern int ceph_pool_perm_check(struct ceph_inode_info *ci, int need);
+extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
 
 /* file.c */
 extern const struct file_operations ceph_file_fops;
@@ -890,7 +898,6 @@ extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 extern int ceph_release(struct inode *inode, struct file *filp);
 extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 				  char *data, size_t len);
-int ceph_uninline_data(struct file *filp, struct page *locked_page);
 /* dir.c */
 extern const struct file_operations ceph_dir_fops;
 extern const struct file_operations ceph_snapdir_fops;
-- 
1.9.3

