From: Sage Weil <sage@newdream.net>
Subject: [PATCH 21/23] ceph: document locking for ceph_set_dentry_offset
Date: Fri, 22 Jul 2011 17:03:00 -0700
Message-ID: <1311379382-9218-22-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44337 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab1GWAF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:56 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/inode.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a7db56f..5f0013a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -843,11 +843,13 @@ out_unlock:
 /*
  * Set dentry's directory position based on the current dir's max, and
  * order it in d_subdirs, so that dcache_readdir behaves.
+ *
+ * Always called under directory's i_mutex.
  */
 static void ceph_set_dentry_offset(struct dentry *dn)
 {
 	struct dentry *dir = dn->d_parent;
-	struct inode *inode = dn->d_parent->d_inode;
+	struct inode *inode = dir->d_inode;
 	struct ceph_dentry_info *di;
 
 	BUG_ON(!inode);
-- 
1.7.0

