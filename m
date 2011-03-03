From: Sage Weil <sage@newdream.net>
Subject: [PATCH 3/8] ceph: do not clear I_COMPLETE from d_release
Date: Thu,  3 Mar 2011 12:40:05 -0800
Message-ID: <1299184810-19125-4-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52162 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758655Ab1CCUj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:58 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

First, this was racy anyway: d_release isn't called until well after the
dentry is unhashed.  Second, this runs afoul of the recent dcache change
that clears d_parent prior to calling d_release (949854d0), causing a NULL
pointer dereference.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 9b4f9d9..196fd4c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1029,28 +1029,8 @@ out_touch:
 static void ceph_dentry_release(struct dentry *dentry)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
-	struct inode *parent_inode = NULL;
-	u64 snapid = CEPH_NOSNAP;
 
-	if (!IS_ROOT(dentry)) {
-		parent_inode = dentry->d_parent->d_inode;
-		if (parent_inode)
-			snapid = ceph_snap(parent_inode);
-	}
-	dout("dentry_release %p parent %p\n", dentry, parent_inode);
-	if (parent_inode && snapid != CEPH_SNAPDIR) {
-		struct ceph_inode_info *ci = ceph_inode(parent_inode);
-
-		spin_lock(&parent_inode->i_lock);
-		if (ci->i_shared_gen == di->lease_shared_gen ||
-		    snapid <= CEPH_MAXSNAP) {
-			dout(" clearing %p complete (d_release)\n",
-			     parent_inode);
-			ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
-			ci->i_release_count++;
-		}
-		spin_unlock(&parent_inode->i_lock);
-	}
+	dout("dentry_release %p\n", dentry);
 	if (di) {
 		ceph_dentry_lru_del(dentry);
 		if (di->lease_session)
-- 
1.7.0

