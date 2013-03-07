From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] fs: fix dentry_lru_prune()
Date: Thu,  7 Mar 2013 19:37:36 +0800
Message-ID: <1362656256-4397-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30324 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932358Ab3CGLhm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Mar 2013 06:37:42 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: sage@inktank.com, viro@zeniv.linux.org.uk, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

dentry_lru_prune() should always call file system's d_prune callback.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/dcache.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 19153a0..f0060aa 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -344,14 +344,9 @@ static void dentry_lru_del(struct dentry *dentry)
  */
 static void dentry_lru_prune(struct dentry *dentry)
 {
-	if (!list_empty(&dentry->d_lru)) {
-		if (dentry->d_flags & DCACHE_OP_PRUNE)
-			dentry->d_op->d_prune(dentry);
-
-		spin_lock(&dcache_lru_lock);
-		__dentry_lru_del(dentry);
-		spin_unlock(&dcache_lru_lock);
-	}
+	if (dentry->d_flags & DCACHE_OP_PRUNE)
+		dentry->d_op->d_prune(dentry);
+	dentry_lru_del(dentry);
 }
 
 static void dentry_lru_move_list(struct dentry *dentry, struct list_head *list)
-- 
1.7.11.7

