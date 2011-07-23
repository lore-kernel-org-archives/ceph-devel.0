From: Sage Weil <sage@newdream.net>
Subject: [PATCH 20/23] ceph: avoid d_parent in ceph_dentry_hash; fix ceph_encode_fh() hashing bug
Date: Fri, 22 Jul 2011 17:02:59 -0700
Message-ID: <1311379382-9218-21-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44335 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab1GWAF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:56 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Have caller pass in a safely-obtained reference to the parent directory
for calculating a dentry's hash valud.

While we're here, simpify the flow through ceph_encode_fh() so that there
is a single exit point and cleanup.

Also fix a bug with the dentry hash calculation: calculate the hash for the
dentry we were given, not its parent.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c        |    3 +--
 fs/ceph/export.c     |   23 +++++++++++++++--------
 fs/ceph/mds_client.c |    2 +-
 fs/ceph/super.h      |    2 +-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 4f7c30e..1d6aef4 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1242,9 +1242,8 @@ void ceph_dentry_lru_del(struct dentry *dn)
  * Return name hash for a given dentry.  This is dependent on
  * the parent directory's hash function.
  */
-unsigned ceph_dentry_hash(struct dentry *dn)
+unsigned ceph_dentry_hash(struct inode *dir, struct dentry *dn)
 {
-	struct inode *dir = dn->d_parent->d_inode;
 	struct ceph_inode_info *dci = ceph_inode(dir);
 
 	switch (dci->i_dir_layout.dl_dir_hash) {
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index f67b687..54757ed 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -46,7 +46,7 @@ static int ceph_encode_fh(struct dentry *dentry, u32 *rawfh, int *max_len,
 	int type;
 	struct ceph_nfs_fh *fh = (void *)rawfh;
 	struct ceph_nfs_confh *cfh = (void *)rawfh;
-	struct dentry *parent = dentry->d_parent;
+	struct dentry *parent;
 	struct inode *inode = dentry->d_inode;
 	int connected_handle_length = sizeof(*cfh)/4;
 	int handle_length = sizeof(*fh)/4;
@@ -55,26 +55,33 @@ static int ceph_encode_fh(struct dentry *dentry, u32 *rawfh, int *max_len,
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EINVAL;
 
+	spin_lock(&dentry->d_lock);
+	parent = dget(dentry->d_parent);
+	spin_unlock(&dentry->d_lock);
+
 	if (*max_len >= connected_handle_length) {
 		dout("encode_fh %p connectable\n", dentry);
 		cfh->ino = ceph_ino(dentry->d_inode);
 		cfh->parent_ino = ceph_ino(parent->d_inode);
-		cfh->parent_name_hash = ceph_dentry_hash(parent);
+		cfh->parent_name_hash = ceph_dentry_hash(parent->d_inode,
+							 dentry);
 		*max_len = connected_handle_length;
 		type = 2;
 	} else if (*max_len >= handle_length) {
 		if (connectable) {
 			*max_len = connected_handle_length;
-			return 255;
+			type = 255;
+		} else {
+			dout("encode_fh %p\n", dentry);
+			fh->ino = ceph_ino(dentry->d_inode);
+			*max_len = handle_length;
+			type = 1;
 		}
-		dout("encode_fh %p\n", dentry);
-		fh->ino = ceph_ino(dentry->d_inode);
-		*max_len = handle_length;
-		type = 1;
 	} else {
 		*max_len = handle_length;
-		return 255;
+		type = 255;
 	}
+	dput(parent);
 	return type;
 }
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3b1e743..8a09cd5 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -670,7 +670,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		} else {
 			/* dir + name */
 			inode = dir;
-			hash = ceph_dentry_hash(req->r_dentry);
+			hash = ceph_dentry_hash(dir, req->r_dentry);
 			is_hash = true;
 		}
 	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c1eb9a0..35dc965 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -800,7 +800,7 @@ extern void ceph_dentry_lru_add(struct dentry *dn);
 extern void ceph_dentry_lru_touch(struct dentry *dn);
 extern void ceph_dentry_lru_del(struct dentry *dn);
 extern void ceph_invalidate_dentry_lease(struct dentry *dentry);
-extern unsigned ceph_dentry_hash(struct dentry *dn);
+extern unsigned ceph_dentry_hash(struct inode *dir, struct dentry *dn);
 extern struct inode *ceph_get_dentry_parent_inode(struct dentry *dentry);
 
 /*
-- 
1.7.0

