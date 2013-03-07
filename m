From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] ceph: increase i_release_count when clear I_COMPLETE flag
Date: Thu,  7 Mar 2013 19:36:10 +0800
Message-ID: <1362656170-4337-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23286 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737Ab3CGLga (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Mar 2013 06:36:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If some dentries were pruned or FILE_SHARED cap was revoked while
readdir is in progress. make sure ceph_readdir() does not mark the
directory as complete.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c |  1 +
 fs/ceph/dir.c  | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 76634f4..35cebf3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -500,6 +500,7 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
 		if (S_ISDIR(ci->vfs_inode.i_mode)) {
 			dout(" marking %p NOT complete\n", &ci->vfs_inode);
 			ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
+			ci->i_release_count++;
 		}
 	}
 }
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 76821be..068304c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -909,7 +909,11 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
 		 */
 
 		/* d_move screws up d_subdirs order */
-		ceph_i_clear(new_dir, CEPH_I_COMPLETE);
+		struct ceph_inode_info *ci = ceph_inode(new_dir);
+		spin_lock(&ci->i_ceph_lock);
+		ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
+		ci->i_release_count++;
+		spin_unlock(&ci->i_ceph_lock);
 
 		d_move(old_dentry, new_dentry);
 
@@ -1073,6 +1077,7 @@ static int ceph_snapdir_d_revalidate(struct dentry *dentry,
  */
 static void ceph_d_prune(struct dentry *dentry)
 {
+	struct ceph_inode_info *ci;
 	dout("ceph_d_prune %p\n", dentry);
 
 	/* do we have a valid parent? */
@@ -1087,7 +1092,11 @@ static void ceph_d_prune(struct dentry *dentry)
 	 * we hold d_lock, so d_parent is stable, and d_fsdata is never
 	 * cleared until d_release
 	 */
-	ceph_i_clear(dentry->d_parent->d_inode, CEPH_I_COMPLETE);
+	ci = ceph_inode(dentry->d_parent->d_inode);
+	spin_lock(&ci->i_ceph_lock);
+	ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
+	ci->i_release_count++;
+	spin_unlock(&ci->i_ceph_lock);
 }
 
 /*
-- 
1.7.11.7

