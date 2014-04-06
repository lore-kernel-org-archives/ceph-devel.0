From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: skip invalid dentry during dcache readdir
Date: Sun,  6 Apr 2014 14:10:04 +0800
Message-ID: <1396764604-14817-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16138 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaDFGKY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 6 Apr 2014 02:10:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

skip dentries that were added before MDS issued FILE_SHARED to
client.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 46cd092..766410a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -119,7 +119,8 @@ static int fpos_cmp(loff_t l, loff_t r)
  * defined IFF we hold CEPH_CAP_FILE_SHARED (which will be revoked by
  * the MDS if/when the directory is modified).
  */
-static int __dcache_readdir(struct file *file, struct dir_context *ctx)
+static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
+			    u32 shared_gen)
 {
 	struct ceph_file_info *fi = file->private_data;
 	struct dentry *parent = file->f_dentry;
@@ -133,8 +134,8 @@ static int __dcache_readdir(struct file *file, struct dir_context *ctx)
 	last = fi->dentry;
 	fi->dentry = NULL;
 
-	dout("__dcache_readdir %p at %llu (last %p)\n", dir, ctx->pos,
-	     last);
+	dout("__dcache_readdir %p v%u at %llu (last %p)\n",
+	     dir, shared_gen, ctx->pos, last);
 
 	spin_lock(&parent->d_lock);
 
@@ -161,7 +162,8 @@ more:
 			goto out_unlock;
 		}
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-		if (!d_unhashed(dentry) && dentry->d_inode &&
+		if (di->lease_shared_gen == shared_gen &&
+		    !d_unhashed(dentry) && dentry->d_inode &&
 		    ceph_snap(dentry->d_inode) != CEPH_SNAPDIR &&
 		    ceph_ino(dentry->d_inode) != CEPH_INO_CEPH &&
 		    fpos_cmp(ctx->pos, di->offset) <= 0)
@@ -289,8 +291,9 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	    ceph_snap(inode) != CEPH_SNAPDIR &&
 	    __ceph_dir_is_complete(ci) &&
 	    __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1)) {
+		u32 shared_gen = ci->i_shared_gen;
 		spin_unlock(&ci->i_ceph_lock);
-		err = __dcache_readdir(file, ctx);
+		err = __dcache_readdir(file, ctx, shared_gen);
 		if (err != -EAGAIN)
 			return err;
 	} else {
-- 
1.8.5.3

