From: Sage Weil <sage@newdream.net>
Subject: re: ceph: move encode_fh to new API
Date: Wed, 18 Apr 2012 10:39:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204181035450.15730@cobra.newdream.net>
References: <20120418094028.GA6866@elgon.mountain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48027 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2DRRjN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 13:39:13 -0400
In-Reply-To: <20120418094028.GA6866@elgon.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: viro@ZenIV.linux.org.uk, Dan Carpenter <dan.carpenter@oracle.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 18 Apr 2012, Dan Carpenter wrote:
> Hello Sage Weil,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch f59919a07e03: "ceph: move encode_fh to new API" from Apr 5, 
> 2012, leads to the following Smatch complaint:
> 
> fs/ceph/export.c:85 ceph_encode_fh()
> 	 error: we previously assumed 'dentry' could be null (see line 67)

Thanks, Dan!  This caught a minor bug.

Al, can you update f59919a07e0335358d9470289cf46ffb83b7d2f9 in your 
for-next with the following?

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 869c554..8e1b60e 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -82,7 +82,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
                        type = 255;
                } else {
                        dout("encode_fh %p\n", dentry);
-                       fh->ino = ceph_ino(dentry->d_inode);
+                       fh->ino = ceph_ino(inode);
                        *max_len = handle_length;
                        type = 1;
                }

...or the complete patch is below.

Thanks!
sage


From 21d32da4f1731a583a471b24308b5f8c4e065ab6 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Wed, 18 Apr 2012 10:39:14 -0700
Subject: [PATCH] ceph: move encode_fh to new API

Use parent_inode has a flag for whether nfsd wants a connectable fh, but
generate one opportunistically so that we can take advantage of the
additional info in there.

Signed-off-by: Sage Weil <sage@newdream.net>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/export.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 4f9234c..8e1b60e 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -40,38 +40,49 @@ struct ceph_nfs_confh {
 	u32 parent_name_hash;
 } __attribute__ ((packed));
 
-static int ceph_encode_fh(struct dentry *dentry, u32 *rawfh, int *max_len,
-			  int connectable)
+/*
+ * The presence of @parent_inode here tells us whether NFS wants a
+ * connectable file handle.  However, we want to make a connectionable
+ * file handle unconditionally so that the MDS gets as much of a hint
+ * as possible.  That means we only use @parent_dentry to indicate
+ * whether nfsd wants a connectable fh, and whether we should indicate
+ * failure from a too-small @max_len.
+ */
+static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
+			  struct inode *parent_inode)
 {
 	int type;
 	struct ceph_nfs_fh *fh = (void *)rawfh;
 	struct ceph_nfs_confh *cfh = (void *)rawfh;
-	struct dentry *parent;
-	struct inode *inode = dentry->d_inode;
 	int connected_handle_length = sizeof(*cfh)/4;
 	int handle_length = sizeof(*fh)/4;
+	struct dentry *dentry = d_find_alias(inode);
+	struct dentry *parent;
 
 	/* don't re-export snaps */
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EINVAL;
 
-	spin_lock(&dentry->d_lock);
-	parent = dentry->d_parent;
-	if (*max_len >= connected_handle_length) {
+	/* if we found an alias, generate a connectable fh */
+	if (*max_len >= connected_handle_length && dentry) {
 		dout("encode_fh %p connectable\n", dentry);
-		cfh->ino = ceph_ino(dentry->d_inode);
+		spin_lock(&dentry->d_lock);
+		parent = dentry->d_parent;
+		cfh->ino = ceph_ino(inode);
 		cfh->parent_ino = ceph_ino(parent->d_inode);
 		cfh->parent_name_hash = ceph_dentry_hash(parent->d_inode,
 							 dentry);
 		*max_len = connected_handle_length;
 		type = 2;
+		spin_unlock(&dentry->d_lock);
 	} else if (*max_len >= handle_length) {
-		if (connectable) {
+		if (parent_inode) {
+			/* nfsd wants connectable */
 			*max_len = connected_handle_length;
 			type = 255;
 		} else {
 			dout("encode_fh %p\n", dentry);
-			fh->ino = ceph_ino(dentry->d_inode);
+			fh->ino = ceph_ino(inode);
 			*max_len = handle_length;
 			type = 1;
 		}
@@ -79,7 +90,6 @@ static int ceph_encode_fh(struct dentry *dentry, u32 *rawfh, int *max_len,
 		*max_len = handle_length;
 		type = 255;
 	}
-	spin_unlock(&dentry->d_lock);
 	return type;
 }
 
@@ -247,9 +257,7 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 }
 
 const struct export_operations ceph_export_ops = {
-#ifdef CEPH_BREAKAGE_FIXED
 	.encode_fh = ceph_encode_fh,
-#endif
 	.fh_to_dentry = ceph_fh_to_dentry,
 	.fh_to_parent = ceph_fh_to_parent,
 };
-- 
1.7.9

