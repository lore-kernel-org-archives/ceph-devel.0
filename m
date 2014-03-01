From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/4] ceph: fix ceph_fh_to_parent()
Date: Sat,  1 Mar 2014 23:23:29 +0800
Message-ID: <1393687411-2457-2-git-send-email-zheng.z.yan@intel.com>
References: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51314 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbaCAPYF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Mar 2014 10:24:05 -0500
In-Reply-To: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

ceph_fh_to_parent() finds the inode that corresponds to the 'ino' field
of struct ceph_nfs_confh. This is wrong, it should find the inode that
corresponds to the 'parent_ino' field.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/export.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 905d7f2..017af26 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -122,49 +122,21 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 }
 
 /*
- * get parent, if possible.
- *
- * FIXME: we could do better by querying the mds to discover the
- * parent.
+ * convert regular fh to parent
  */
 static struct dentry *ceph_fh_to_parent(struct super_block *sb,
-					 struct fid *fid,
+					struct fid *fid,
 					int fh_len, int fh_type)
 {
 	struct ceph_nfs_confh *cfh = (void *)fid->raw;
-	struct ceph_vino vino;
-	struct inode *inode;
-	struct dentry *dentry;
-	int err;
 
-	if (fh_type == 1)
+	if (fh_type != FILEID_INO32_GEN_PARENT)
 		return ERR_PTR(-ESTALE);
 	if (fh_len < sizeof(*cfh) / 4)
 		return ERR_PTR(-ESTALE);
 
-	pr_debug("fh_to_parent %llx/%d\n", cfh->parent_ino,
-		 cfh->parent_name_hash);
-
-	vino.ino = cfh->ino;
-	vino.snap = CEPH_NOSNAP;
-	inode = ceph_find_inode(sb, vino);
-	if (!inode)
-		return ERR_PTR(-ESTALE);
-
-	dentry = d_obtain_alias(inode);
-	if (IS_ERR(dentry)) {
-		pr_err("fh_to_parent %llx -- inode %p but ENOMEM\n",
-		       cfh->ino, inode);
-		iput(inode);
-		return dentry;
-	}
-	err = ceph_init_dentry(dentry);
-	if (err < 0) {
-		iput(inode);
-		return ERR_PTR(err);
-	}
-	dout("fh_to_parent %llx %p dentry %p\n", cfh->ino, inode, dentry);
-	return dentry;
+	pr_debug("fh_to_parent %llx\n", cfh->parent_ino);
+	return __fh_to_dentry(sb, cfh->parent_ino);
 }
 
 const struct export_operations ceph_export_ops = {
-- 
1.8.5.3

