From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] ceph: use d_invalidate() to invalidate aliases
Date: Mon,  2 Sep 2013 15:19:54 +0800
Message-ID: <1378106394-14481-2-git-send-email-zheng.z.yan@intel.com>
References: <1378106394-14481-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34488 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757600Ab3IBHUZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Sep 2013 03:20:25 -0400
In-Reply-To: <1378106394-14481-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

d_invalidate() is the standard VFS method to invalidate dentry.
compare to d_delete(), it also try shrinking children dentries.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 7b451eb..13976c3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2346,10 +2346,10 @@ static void invalidate_aliases(struct inode *inode)
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
-	 * connected dentry. After calling d_delete(), the dentry
-	 * become disconnected.
+	 * connected dentry. After calling d_invalidate(), the
+	 * dentry become disconnected.
 	 *
-	 * For directory inode, d_find_alias() only can return
+	 * For directory inode, d_find_alias() can return
 	 * disconnected dentry. But directory inode should have
 	 * one alias at most.
 	 */
@@ -2358,7 +2358,7 @@ static void invalidate_aliases(struct inode *inode)
 			dput(dn);
 			break;
 		}
-		d_delete(dn);
+		d_invalidate(dn);
 		if (prev)
 			dput(prev);
 		prev = dn;
-- 
1.8.1.4

