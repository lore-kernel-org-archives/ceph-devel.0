From: Sage Weil <sage@newdream.net>
Subject: [PATCH 19/23] ceph: protect d_parent access in ceph_d_revalidate
Date: Fri, 22 Jul 2011 17:02:58 -0700
Message-ID: <1311379382-9218-20-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44333 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab1GWAFz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:55 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Protect d_parent with d_lock.  Carry a reference.  Simplify the flow so
that there is a single exit point and cleanup.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index e90315b..4f7c30e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1022,36 +1022,38 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry)
  */
 static int ceph_d_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
+	int valid = 0;
 	struct inode *dir;
 
 	if (nd && nd->flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	dir = dentry->d_parent->d_inode;
-
 	dout("d_revalidate %p '%.*s' inode %p offset %lld\n", dentry,
 	     dentry->d_name.len, dentry->d_name.name, dentry->d_inode,
 	     ceph_dentry(dentry)->offset);
 
+	dir = ceph_get_dentry_parent_inode(dentry);
+
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
 		dout("d_revalidate %p '%.*s' inode %p is SNAPPED\n", dentry,
 		     dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
-		goto out_touch;
+		valid = 1;
+	} else if (dentry->d_inode &&
+		   ceph_snap(dentry->d_inode) == CEPH_SNAPDIR) {
+		valid = 1;
+	} else if (dentry_lease_is_valid(dentry) ||
+		   dir_lease_is_valid(dir, dentry)) {
+		valid = 1;
 	}
-	if (dentry->d_inode && ceph_snap(dentry->d_inode) == CEPH_SNAPDIR)
-		goto out_touch;
 
-	if (dentry_lease_is_valid(dentry) ||
-	    dir_lease_is_valid(dir, dentry))
-		goto out_touch;
-
-	dout("d_revalidate %p invalid\n", dentry);
-	d_drop(dentry);
-	return 0;
-out_touch:
-	ceph_dentry_lru_touch(dentry);
-	return 1;
+	dout("d_revalidate %p %s\n", dentry, valid ? "valid" : "invalid");
+	if (valid)
+		ceph_dentry_lru_touch(dentry);
+	else
+		d_drop(dentry);
+	iput(dir);
+	return valid;
 }
 
 /*
-- 
1.7.0

