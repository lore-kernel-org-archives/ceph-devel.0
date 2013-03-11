From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] fs: remove dentry_lru_prune()
Date: Mon, 11 Mar 2013 20:42:45 +0800
Message-ID: <1363005765-15305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, david@fromorbit.com, viro@zeniv.linux.org.uk, "Yan, Zheng" <zheng.z.yan@intel.com>
List-Id: ceph-devel.vger.kernel.org

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When pruning a dentry, its ancestor dentry can also be pruned. But
the ancestor dentry does not go through dput(), so it does not get
put on the dentry LRU. Hence associating d_prune with removing the
dentry from the LRU is the wrong.

The fix is remove dentry_lru_prune(). Modify all its callers to use
dentry_lru_del() and call file system's d_prune() callback directly.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/dcache.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 19153a0..ceedd04 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -337,23 +337,6 @@ static void dentry_lru_del(struct dentry *dentry)
 	}
 }
 
-/*
- * Remove a dentry that is unreferenced and about to be pruned
- * (unhashed and destroyed) from the LRU, and inform the file system.
- * This wrapper should be called _prior_ to unhashing a victim dentry.
- */
-static void dentry_lru_prune(struct dentry *dentry)
-{
-	if (!list_empty(&dentry->d_lru)) {
-		if (dentry->d_flags & DCACHE_OP_PRUNE)
-			dentry->d_op->d_prune(dentry);
-
-		spin_lock(&dcache_lru_lock);
-		__dentry_lru_del(dentry);
-		spin_unlock(&dcache_lru_lock);
-	}
-}
-
 static void dentry_lru_move_list(struct dentry *dentry, struct list_head *list)
 {
 	spin_lock(&dcache_lru_lock);
@@ -486,11 +469,13 @@ relock:
 	if (ref)
 		dentry->d_count--;
 	/*
-	 * if dentry was on the d_lru list delete it from there.
 	 * inform the fs via d_prune that this dentry is about to be
 	 * unhashed and destroyed.
 	 */
-	dentry_lru_prune(dentry);
+	if (dentry->d_flags & DCACHE_OP_PRUNE)
+		dentry->d_op->d_prune(dentry);
+
+	dentry_lru_del(dentry);
 	/* if it was on the hash then remove it */
 	__d_drop(dentry);
 	return d_kill(dentry, parent);
@@ -921,11 +906,13 @@ static void shrink_dcache_for_umount_subtree(struct dentry *dentry)
 			struct inode *inode;
 
 			/*
-			 * remove the dentry from the lru, and inform
-			 * the fs that this dentry is about to be
+			 * inform the fs that this dentry is about to be
 			 * unhashed and destroyed.
 			 */
-			dentry_lru_prune(dentry);
+			if (dentry->d_flags & DCACHE_OP_PRUNE)
+				dentry->d_op->d_prune(dentry);
+
+			dentry_lru_del(dentry);
 			__d_shrink(dentry);
 
 			if (dentry->d_count != 0) {
-- 
1.7.11.7

