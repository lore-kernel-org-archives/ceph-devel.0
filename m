From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/8] Revert "ceph: keep reference to parent inode on ceph_dentry"
Date: Thu,  3 Mar 2011 12:40:03 -0800
Message-ID: <1299184810-19125-2-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52158 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab1CCUj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:58 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

This reverts commit 97d79b403ef03f729883246208ef5d8a2ebc4d68.

This fails to account for d_parent changes due to rename or disconnected
dentries due to submounts or NFS reexports.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c   |    5 +----
 fs/ceph/super.h |    1 -
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f0aef78..0bc68de 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -60,7 +60,6 @@ int ceph_init_dentry(struct dentry *dentry)
 	}
 	di->dentry = dentry;
 	di->lease_session = NULL;
-	di->parent_inode = igrab(dentry->d_parent->d_inode);
 	dentry->d_fsdata = di;
 	dentry->d_time = jiffies;
 	ceph_dentry_lru_add(dentry);
@@ -1034,7 +1033,7 @@ static void ceph_dentry_release(struct dentry *dentry)
 	u64 snapid = CEPH_NOSNAP;
 
 	if (!IS_ROOT(dentry)) {
-		parent_inode = di->parent_inode;
+		parent_inode = dentry->d_parent->d_inode;
 		if (parent_inode)
 			snapid = ceph_snap(parent_inode);
 	}
@@ -1059,8 +1058,6 @@ static void ceph_dentry_release(struct dentry *dentry)
 		kmem_cache_free(ceph_dentry_cachep, di);
 		dentry->d_fsdata = NULL;
 	}
-	if (parent_inode)
-		iput(parent_inode);
 }
 
 static int ceph_snapdir_d_revalidate(struct dentry *dentry,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 88fcaa2..20b907d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -207,7 +207,6 @@ struct ceph_dentry_info {
 	struct dentry *dentry;
 	u64 time;
 	u64 offset;
-	struct inode *parent_inode;
 };
 
 struct ceph_inode_xattrs_info {
-- 
1.7.0

