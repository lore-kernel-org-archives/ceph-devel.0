From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH v2 2/5] ceph: add get_parent() NFS export callback
Date: Fri,  7 Mar 2014 17:04:34 +0800
Message-ID: <1394183077-399-3-git-send-email-zheng.z.yan@intel.com>
References: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17762 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaCGJEu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Mar 2014 04:04:50 -0500
In-Reply-To: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

The callback uses LOOKUPPARENT MDS request to find parent.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/export.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 976d341..3794255 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -121,6 +121,58 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 	return __fh_to_dentry(sb, fh->ino);
 }
 
+static struct dentry *__get_parent(struct super_block *sb, u64 ino)
+{
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_request *req;
+	struct inode *inode;
+	struct dentry *dentry;
+	int err;
+
+	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPPARENT,
+				       USE_ANY_MDS);
+	if (IS_ERR(req))
+		return ERR_CAST(req);
+
+	req->r_ino1 = (struct ceph_vino) {
+		.ino = ino,
+		.snap = CEPH_NOSNAP,
+	};
+	req->r_num_caps = 1;
+	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	inode = req->r_target_inode;
+	if (inode)
+		ihold(inode);
+	ceph_mdsc_put_request(req);
+	if (!inode)
+		return ERR_PTR(-ENOENT);
+
+	dentry = d_obtain_alias(inode);
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		return dentry;
+	}
+	err = ceph_init_dentry(dentry);
+	if (err < 0) {
+		dput(dentry);
+		return ERR_PTR(err);
+	}
+	dout("__get_parent ino %llx parent %p ino %llx.%llx\n",
+	     ino, dentry, ceph_vinop(inode));
+	return dentry;
+}
+
+struct dentry *ceph_get_parent(struct dentry *child)
+{
+	/* don't re-export snaps */
+	if (ceph_snap(child->d_inode) != CEPH_NOSNAP)
+		return ERR_PTR(-EINVAL);
+
+	dout("get_parent %p ino %llx.%llx\n",
+	     child, ceph_vinop(child->d_inode));
+	return __get_parent(child->d_sb, ceph_ino(child->d_inode));
+}
+
 /*
  * get parent, if possible.
  *
@@ -171,4 +223,5 @@ const struct export_operations ceph_export_ops = {
 	.encode_fh = ceph_encode_fh,
 	.fh_to_dentry = ceph_fh_to_dentry,
 	.fh_to_parent = ceph_fh_to_parent,
+	.get_parent = ceph_get_parent,
 };
-- 
1.8.5.3

