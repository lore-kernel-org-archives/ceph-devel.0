From: Cheng Renquan <crquan@gmail.com>
Subject: [PATCH] ceph: use ceph_sb_to_client instead of
	ceph_client
Date: Fri, 26 Mar 2010 17:40:33 +0800
Message-ID: <1269596433-4483-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

ceph_sb_to_client and ceph_client are really identical, we need to dump
one; while function ceph_client is confusing with "struct ceph_client",
ceph_sb_to_client's definition is more clear; so we'd better switch all
call to ceph_sb_to_client.

  -static inline struct ceph_client *ceph_client(struct super_block *sb)
  -{
  -	return sb->s_fs_info;
  -}

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 fs/ceph/addr.c   |    2 +-
 fs/ceph/caps.c   |   15 +++++++++------
 fs/ceph/dir.c    |   10 +++++-----
 fs/ceph/export.c |    2 +-
 fs/ceph/file.c   |    2 +-
 fs/ceph/inode.c  |   10 +++++-----
 fs/ceph/ioctl.c  |    2 +-
 fs/ceph/snap.c   |    2 +-
 fs/ceph/super.c  |   10 +++++-----
 fs/ceph/super.h  |    6 ------
 fs/ceph/xattr.c  |    4 ++--
 11 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ce8ef61..74227ab 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -580,7 +580,7 @@ static void writepages_finish(struct ceph_osd_request *req,
 	ceph_release_pages(req->r_pages, req->r_num_pages);
 	if (req->r_pages_from_pool)
 		mempool_free(req->r_pages,
-			     ceph_client(inode->i_sb)->wb_pagevec_pool);
+			     ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
 	else
 		kfree(req->r_pages);
 	ceph_osdc_put_request(req);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 7d0a0d0..fd41384 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -864,7 +864,8 @@ void __ceph_remove_cap(struct ceph_cap *cap)
 {
 	struct ceph_mds_session *session = cap->session;
 	struct ceph_inode_info *ci = cap->ci;
-	struct ceph_mds_client *mdsc = &ceph_client(ci->vfs_inode.i_sb)->mdsc;
+	struct ceph_mds_client *mdsc =
+		&ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
 
 	dout("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
 
@@ -1286,7 +1287,8 @@ static void ceph_flush_snaps(struct ceph_inode_info *ci)
  */
 void __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask)
 {
-	struct ceph_mds_client *mdsc = &ceph_client(ci->vfs_inode.i_sb)->mdsc;
+	struct ceph_mds_client *mdsc =
+		&ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
 	struct inode *inode = &ci->vfs_inode;
 	int was = ci->i_dirty_caps;
 	int dirty = 0;
@@ -1324,7 +1326,7 @@ void __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask)
 static int __mark_caps_flushing(struct inode *inode,
 				 struct ceph_mds_session *session)
 {
-	struct ceph_mds_client *mdsc = &ceph_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = &ceph_sb_to_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int flushing;
 
@@ -1651,7 +1653,7 @@ ack:
 static int try_flush_caps(struct inode *inode, struct ceph_mds_session *session,
 			  unsigned *flush_tid)
 {
-	struct ceph_mds_client *mdsc = &ceph_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = &ceph_sb_to_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int unlock_session = session ? 0 : 1;
 	int flushing = 0;
@@ -1817,7 +1819,8 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 			err = wait_event_interruptible(ci->i_cap_wq,
 				       caps_are_flushed(inode, flush_tid));
 	} else {
-		struct ceph_mds_client *mdsc = &ceph_client(inode->i_sb)->mdsc;
+		struct ceph_mds_client *mdsc =
+			&ceph_sb_to_client(inode->i_sb)->mdsc;
 
 		spin_lock(&inode->i_lock);
 		if (__ceph_caps_dirty(ci))
@@ -2383,7 +2386,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	__releases(inode->i_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = &ceph_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = &ceph_sb_to_client(inode->i_sb)->mdsc;
 	unsigned seq = le32_to_cpu(m->seq);
 	int dirty = le32_to_cpu(m->dirty);
 	int cleaned = 0;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8a9116e..d5a0af7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -477,7 +477,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int origin)
 struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				  struct dentry *dentry, int err)
 {
-	struct ceph_client *client = ceph_client(dentry->d_sb);
+	struct ceph_client *client = ceph_sb_to_client(dentry->d_sb);
 	struct inode *parent = dentry->d_parent->d_inode;
 
 	/* .snap dir? */
@@ -1039,7 +1039,7 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int left;
 
-	if (!ceph_test_opt(ceph_client(inode->i_sb), DIRSTAT))
+	if (!ceph_test_opt(ceph_sb_to_client(inode->i_sb), DIRSTAT))
 		return -EISDIR;
 
 	if (!cf->dir_info) {
@@ -1141,7 +1141,7 @@ void ceph_dentry_lru_add(struct dentry *dn)
 	dout("dentry_lru_add %p %p '%.*s'\n", di, dn,
 	     dn->d_name.len, dn->d_name.name);
 	if (di) {
-		mdsc = &ceph_client(dn->d_sb)->mdsc;
+		mdsc = &ceph_sb_to_client(dn->d_sb)->mdsc;
 		spin_lock(&mdsc->dentry_lru_lock);
 		list_add_tail(&di->lru, &mdsc->dentry_lru);
 		mdsc->num_dentry++;
@@ -1157,7 +1157,7 @@ void ceph_dentry_lru_touch(struct dentry *dn)
 	dout("dentry_lru_touch %p %p '%.*s'\n", di, dn,
 	     dn->d_name.len, dn->d_name.name);
 	if (di) {
-		mdsc = &ceph_client(dn->d_sb)->mdsc;
+		mdsc = &ceph_sb_to_client(dn->d_sb)->mdsc;
 		spin_lock(&mdsc->dentry_lru_lock);
 		list_move_tail(&di->lru, &mdsc->dentry_lru);
 		spin_unlock(&mdsc->dentry_lru_lock);
@@ -1172,7 +1172,7 @@ void ceph_dentry_lru_del(struct dentry *dn)
 	dout("dentry_lru_del %p %p '%.*s'\n", di, dn,
 	     dn->d_name.len, dn->d_name.name);
 	if (di) {
-		mdsc = &ceph_client(dn->d_sb)->mdsc;
+		mdsc = &ceph_sb_to_client(dn->d_sb)->mdsc;
 		spin_lock(&mdsc->dentry_lru_lock);
 		list_del_init(&di->lru);
 		mdsc->num_dentry--;
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index fc68e39..5cb2ffc 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -114,7 +114,7 @@ static struct dentry *__fh_to_dentry(struct super_block *sb,
 static struct dentry *__cfh_to_dentry(struct super_block *sb,
 				      struct ceph_nfs_confh *cfh)
 {
-	struct ceph_mds_client *mdsc = &ceph_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = &ceph_sb_to_client(sb)->mdsc;
 	struct inode *inode;
 	struct dentry *dentry;
 	struct ceph_vino vino;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5d2af84..7b09b82 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -807,7 +807,7 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_osd_client *osdc = &ceph_client(inode->i_sb)->osdc;
+	struct ceph_osd_client *osdc = &ceph_sb_to_client(inode->i_sb)->osdc;
 	loff_t endoff = pos + iov->iov_len;
 	int got = 0;
 	int ret, err;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index aca82d5..bc2efd2 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -384,7 +384,7 @@ void ceph_destroy_inode(struct inode *inode)
 	 */
 	if (ci->i_snap_realm) {
 		struct ceph_mds_client *mdsc =
-			&ceph_client(ci->vfs_inode.i_sb)->mdsc;
+			&ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
 		struct ceph_snap_realm *realm = ci->i_snap_realm;
 
 		dout(" dropping residual ref to snap realm %p\n", realm);
@@ -623,7 +623,7 @@ static int fill_inode(struct inode *inode,
 
 	inode->i_mapping->a_ops = &ceph_aops;
 	inode->i_mapping->backing_dev_info =
-		&ceph_client(inode->i_sb)->backing_dev_info;
+		&ceph_sb_to_client(inode->i_sb)->backing_dev_info;
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFIFO:
@@ -681,7 +681,7 @@ static int fill_inode(struct inode *inode,
 		}
 
 		/* it may be better to set st_size in getattr instead? */
-		if (ceph_test_opt(ceph_client(inode->i_sb), RBYTES))
+		if (ceph_test_opt(ceph_sb_to_client(inode->i_sb), RBYTES))
 			inode->i_size = ci->i_rbytes;
 		break;
 	default:
@@ -1413,7 +1413,7 @@ void ceph_queue_vmtruncate(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
-	if (queue_work(ceph_client(inode->i_sb)->trunc_wq,
+	if (queue_work(ceph_sb_to_client(inode->i_sb)->trunc_wq,
 		       &ci->i_vmtruncate_work)) {
 		dout("ceph_queue_vmtruncate %p\n", inode);
 		igrab(inode);
@@ -1502,7 +1502,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *parent_inode = dentry->d_parent->d_inode;
 	const unsigned int ia_valid = attr->ia_valid;
 	struct ceph_mds_request *req;
-	struct ceph_mds_client *mdsc = &ceph_client(dentry->d_sb)->mdsc;
+	struct ceph_mds_client *mdsc = &ceph_sb_to_client(dentry->d_sb)->mdsc;
 	int issued;
 	int release = 0, dirtied = 0;
 	int mask = 0;
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 8a5bcae..d085f07 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -98,7 +98,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	struct ceph_ioctl_dataloc dl;
 	struct inode *inode = file->f_dentry->d_inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_osd_client *osdc = &ceph_client(inode->i_sb)->osdc;
+	struct ceph_osd_client *osdc = &ceph_sb_to_client(inode->i_sb)->osdc;
 	u64 len = 1, olen;
 	u64 tmp;
 	struct ceph_object_layout ol;
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index df04e21..b148fb8 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -512,7 +512,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 			    struct ceph_cap_snap *capsnap)
 {
 	struct inode *inode = &ci->vfs_inode;
-	struct ceph_mds_client *mdsc = &ceph_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = &ceph_sb_to_client(inode->i_sb)->mdsc;
 
 	BUG_ON(capsnap->writing);
 	capsnap->size = inode->i_size;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 4290a6e..37f3d58 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -46,7 +46,7 @@ const char *ceph_file_part(const char *s, int len)
  */
 static void ceph_put_super(struct super_block *s)
 {
-	struct ceph_client *cl = ceph_client(s);
+	struct ceph_client *cl = ceph_sb_to_client(s);
 
 	dout("put_super\n");
 	ceph_mdsc_close_sessions(&cl->mdsc);
@@ -96,8 +96,8 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 static int ceph_syncfs(struct super_block *sb, int wait)
 {
 	dout("sync_fs %d\n", wait);
-	ceph_osdc_sync(&ceph_client(sb)->osdc);
-	ceph_mdsc_sync(&ceph_client(sb)->mdsc);
+	ceph_osdc_sync(&ceph_sb_to_client(sb)->osdc);
+	ceph_mdsc_sync(&ceph_sb_to_client(sb)->mdsc);
 	dout("sync_fs %d done\n", wait);
 	return 0;
 }
@@ -919,9 +919,9 @@ static int ceph_get_sb(struct file_system_type *fs_type,
 		goto out;
 	}
 
-	if (ceph_client(sb) != client) {
+	if (ceph_sb_to_client(sb) != client) {
 		ceph_destroy_client(client);
-		client = ceph_client(sb);
+		client = ceph_sb_to_client(sb);
 		dout("get_sb got existing client %p\n", client);
 	} else {
 		dout("get_sb using new client %p\n", client);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 65d1203..b6c197d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -158,12 +158,6 @@ struct ceph_client {
 #endif
 };
 
-static inline struct ceph_client *ceph_client(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
-
 /*
  * File i/o capability.  This tracks shared state with the metadata
  * server that allows us to cache or writeback attributes or to read
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 37d6ce6..538271a 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -621,7 +621,7 @@ out:
 static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
 			      const char *value, size_t size, int flags)
 {
-	struct ceph_client *client = ceph_client(dentry->d_sb);
+	struct ceph_client *client = ceph_sb_to_client(dentry->d_sb);
 	struct inode *inode = dentry->d_inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct inode *parent_inode = dentry->d_parent->d_inode;
@@ -778,7 +778,7 @@ out:
 
 static int ceph_send_removexattr(struct dentry *dentry, const char *name)
 {
-	struct ceph_client *client = ceph_client(dentry->d_sb);
+	struct ceph_client *client = ceph_sb_to_client(dentry->d_sb);
 	struct ceph_mds_client *mdsc = &client->mdsc;
 	struct inode *inode = dentry->d_inode;
 	struct inode *parent_inode = dentry->d_parent->d_inode;
-- 
1.7.0.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
