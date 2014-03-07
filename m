From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH v2 3/5] ceph: fix ceph_fh_to_parent()
Date: Fri,  7 Mar 2014 17:04:35 +0800
Message-ID: <1394183077-399-4-git-send-email-zheng.z.yan@intel.com>
References: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10125 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaCGJEx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Mar 2014 04:04:53 -0500
In-Reply-To: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

ceph_fh_to_parent() returns dentry that corresponds to the 'ino' field
of struct ceph_nfs_confh. This is wrong, it should return dentry that
corresponds to the 'parent_ino' field.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/export.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 3794255..6e611e7 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -174,48 +174,24 @@ struct dentry *ceph_get_parent(struct dentry *child)
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
 	struct dentry *dentry;
-	int err;
 
-	if (fh_type == 1)
-		return ERR_PTR(-ESTALE);
+	if (fh_type != FILEID_INO32_GEN_PARENT)
+		return NULL;
 	if (fh_len < sizeof(*cfh) / 4)
-		return ERR_PTR(-ESTALE);
-
-	pr_debug("fh_to_parent %llx/%d\n", cfh->parent_ino,
-		 cfh->parent_name_hash);
-
-	vino.ino = cfh->ino;
-	vino.snap = CEPH_NOSNAP;
-	inode = ceph_find_inode(sb, vino);
-	if (!inode)
-		return ERR_PTR(-ESTALE);
+		return NULL;
 
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
+	dout("fh_to_parent %llx\n", cfh->parent_ino);
+	dentry = __get_parent(sb, cfh->ino);
+	if (IS_ERR(dentry) && PTR_ERR(dentry) == -ENOENT)
+		dentry = __fh_to_dentry(sb, cfh->parent_ino);
 	return dentry;
 }
 
-- 
1.8.5.3

