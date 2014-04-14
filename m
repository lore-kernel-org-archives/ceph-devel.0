From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: clear directory's completeness when creating file
Date: Mon, 14 Apr 2014 14:35:28 +0800
Message-ID: <1397457328-18905-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11830 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbaDNGfd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Apr 2014 02:35:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

When creating a file, ceph_set_dentry_offset() puts the new dentry
at the end of directory's d_subdirs, then set the dentry's offset
based on directory's max offset. The offset does not reflect the
real postion of the dentry in directory. Later readdir reply from
MDS may change the dentry's position/offset. This inconsistency
can cause missing/duplicate entries in readdir result if readdir
is partly satisfied by dcache_readdir().

The fix is clear directory's completeness after creating/renaming
file. It prevents later readdir from using dcache_readdir().

Fixes: http://tracker.ceph.com/issues/8025
Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c   |  9 ++++----
 fs/ceph/inode.c | 71 +++++++++++++--------------------------------------------
 fs/ceph/super.h |  1 -
 3 files changed, 21 insertions(+), 60 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index fb4f7a2..c29d6ae 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -448,7 +448,6 @@ more:
 	if (atomic_read(&ci->i_release_count) == fi->dir_release_count) {
 		dout(" marking %p complete\n", inode);
 		__ceph_dir_set_complete(ci, fi->dir_release_count);
-		ci->i_max_offset = ctx->pos;
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -937,14 +936,16 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
 		 * to do it here.
 		 */
 
-		/* d_move screws up d_subdirs order */
-		ceph_dir_clear_complete(new_dir);
-
 		d_move(old_dentry, new_dentry);
 
 		/* ensure target dentry is invalidated, despite
 		   rehashing bug in vfs_rename_dir */
 		ceph_invalidate_dentry_lease(new_dentry);
+
+		/* d_move screws up sibling dentries' offsets */
+		ceph_dir_clear_complete(old_dir);
+		ceph_dir_clear_complete(new_dir);
+
 	}
 	ceph_mdsc_put_request(req);
 	return err;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 0b0728e..233c6f9 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -744,7 +744,6 @@ static int fill_inode(struct inode *inode,
 	    !__ceph_dir_is_complete(ci)) {
 		dout(" marking %p complete (empty)\n", inode);
 		__ceph_dir_set_complete(ci, atomic_read(&ci->i_release_count));
-		ci->i_max_offset = 2;
 	}
 no_change:
 	/* only update max_size on auth cap */
@@ -890,41 +889,6 @@ out_unlock:
 }
 
 /*
- * Set dentry's directory position based on the current dir's max, and
- * order it in d_subdirs, so that dcache_readdir behaves.
- *
- * Always called under directory's i_mutex.
- */
-static void ceph_set_dentry_offset(struct dentry *dn)
-{
-	struct dentry *dir = dn->d_parent;
-	struct inode *inode = dir->d_inode;
-	struct ceph_inode_info *ci;
-	struct ceph_dentry_info *di;
-
-	BUG_ON(!inode);
-
-	ci = ceph_inode(inode);
-	di = ceph_dentry(dn);
-
-	spin_lock(&ci->i_ceph_lock);
-	if (!__ceph_dir_is_complete(ci)) {
-		spin_unlock(&ci->i_ceph_lock);
-		return;
-	}
-	di->offset = ceph_inode(inode)->i_max_offset++;
-	spin_unlock(&ci->i_ceph_lock);
-
-	spin_lock(&dir->d_lock);
-	spin_lock_nested(&dn->d_lock, DENTRY_D_LOCK_NESTED);
-	list_move(&dn->d_u.d_child, &dir->d_subdirs);
-	dout("set_dentry_offset %p %lld (%p %p)\n", dn, di->offset,
-	     dn->d_u.d_child.prev, dn->d_u.d_child.next);
-	spin_unlock(&dn->d_lock);
-	spin_unlock(&dir->d_lock);
-}
-
-/*
  * splice a dentry to an inode.
  * caller must hold directory i_mutex for this to be safe.
  *
@@ -933,7 +897,7 @@ static void ceph_set_dentry_offset(struct dentry *dn)
  * the caller) if we fail.
  */
 static struct dentry *splice_dentry(struct dentry *dn, struct inode *in,
-				    bool *prehash, bool set_offset)
+				    bool *prehash)
 {
 	struct dentry *realdn;
 
@@ -965,8 +929,6 @@ static struct dentry *splice_dentry(struct dentry *dn, struct inode *in,
 	}
 	if ((!prehash || *prehash) && d_unhashed(dn))
 		d_rehash(dn);
-	if (set_offset)
-		ceph_set_dentry_offset(dn);
 out:
 	return dn;
 }
@@ -987,7 +949,6 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 {
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct inode *in = NULL;
-	struct ceph_mds_reply_inode *ininfo;
 	struct ceph_vino vino;
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 	int err = 0;
@@ -1161,6 +1122,9 @@ retry_lookup:
 
 		/* rename? */
 		if (req->r_old_dentry && req->r_op == CEPH_MDS_OP_RENAME) {
+			struct inode *olddir = req->r_old_dentry_dir;
+			BUG_ON(!olddir);
+
 			dout(" src %p '%.*s' dst %p '%.*s'\n",
 			     req->r_old_dentry,
 			     req->r_old_dentry->d_name.len,
@@ -1180,13 +1144,10 @@ retry_lookup:
 			   rehashing bug in vfs_rename_dir */
 			ceph_invalidate_dentry_lease(dn);
 
-			/*
-			 * d_move() puts the renamed dentry at the end of
-			 * d_subdirs.  We need to assign it an appropriate
-			 * directory offset so we can behave when dir is
-			 * complete.
-			 */
-			ceph_set_dentry_offset(req->r_old_dentry);
+			/* d_move screws up sibling dentries' offsets */
+			ceph_dir_clear_complete(dir);
+			ceph_dir_clear_complete(olddir);
+
 			dout("dn %p gets new offset %lld\n", req->r_old_dentry,
 			     ceph_dentry(req->r_old_dentry)->offset);
 
@@ -1213,8 +1174,9 @@ retry_lookup:
 
 		/* attach proper inode */
 		if (!dn->d_inode) {
+			ceph_dir_clear_complete(dir);
 			ihold(in);
-			dn = splice_dentry(dn, in, &have_lease, true);
+			dn = splice_dentry(dn, in, &have_lease);
 			if (IS_ERR(dn)) {
 				err = PTR_ERR(dn);
 				goto done;
@@ -1235,17 +1197,16 @@ retry_lookup:
 		   (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP)) {
 		struct dentry *dn = req->r_dentry;
+		struct inode *dir = req->r_locked_dir;
 
 		/* fill out a snapdir LOOKUPSNAP dentry */
 		BUG_ON(!dn);
-		BUG_ON(!req->r_locked_dir);
-		BUG_ON(ceph_snap(req->r_locked_dir) != CEPH_SNAPDIR);
-		ininfo = rinfo->targeti.in;
-		vino.ino = le64_to_cpu(ininfo->ino);
-		vino.snap = le64_to_cpu(ininfo->snapid);
+		BUG_ON(!dir);
+		BUG_ON(ceph_snap(dir) != CEPH_SNAPDIR);
 		dout(" linking snapped dir %p to dn %p\n", in, dn);
+		ceph_dir_clear_complete(dir);
 		ihold(in);
-		dn = splice_dentry(dn, in, NULL, true);
+		dn = splice_dentry(dn, in, NULL);
 		if (IS_ERR(dn)) {
 			err = PTR_ERR(dn);
 			goto done;
@@ -1407,7 +1368,7 @@ retry_lookup:
 		}
 
 		if (!dn->d_inode) {
-			dn = splice_dentry(dn, in, NULL, false);
+			dn = splice_dentry(dn, in, NULL);
 			if (IS_ERR(dn)) {
 				err = PTR_ERR(dn);
 				dn = NULL;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7866cd0..ead05cc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -266,7 +266,6 @@ struct ceph_inode_info {
 	struct timespec i_rctime;
 	u64 i_rbytes, i_rfiles, i_rsubdirs;
 	u64 i_files, i_subdirs;
-	u64 i_max_offset;  /* largest readdir offset, set with complete dir */
 
 	struct rb_root i_fragtree;
 	struct mutex i_fragtree_mutex;
-- 
1.9.0

