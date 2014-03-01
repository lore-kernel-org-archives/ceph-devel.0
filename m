From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/4] ceph: add get_parent() callback for export_operations
Date: Sat,  1 Mar 2014 23:23:30 +0800
Message-ID: <1393687411-2457-3-git-send-email-zheng.z.yan@intel.com>
References: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8582 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbaCAPYF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Mar 2014 10:24:05 -0500
In-Reply-To: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

The callback uses LOOKUPPARENT MDS request to find parent.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/export.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 017af26..817d370 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -139,8 +139,52 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	return __fh_to_dentry(sb, cfh->parent_ino);
 }
 
+static struct dentry *ceph_get_parent(struct dentry *child)
+{
+	struct ceph_mds_client *mdsc;
+	struct ceph_mds_request *req;
+	struct inode *inode;
+	struct dentry *dentry;
+	int err;
+
+	/* don't re-export snaps */
+	if (ceph_snap(child->d_inode) != CEPH_NOSNAP)
+		return ERR_PTR(-EINVAL);
+
+	mdsc = ceph_inode_to_client(child->d_inode)->mdsc;
+	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPPARENT,
+				       USE_ANY_MDS);
+	if (IS_ERR(req))
+		return ERR_CAST(req);
+
+	req->r_ino1 = ceph_vino(child->d_inode);
+	req->r_num_caps = 1;
+	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	inode = req->r_target_inode;
+	if (inode)
+		ihold(inode);
+	ceph_mdsc_put_request(req);
+	if (!inode)
+		return ERR_PTR(-ESTALE);
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
+	dout("get_parent child %p parent %llx %p\n",
+	     child, ceph_ino(inode), dentry);
+	return dentry;
+}
+
 const struct export_operations ceph_export_ops = {
 	.encode_fh = ceph_encode_fh,
 	.fh_to_dentry = ceph_fh_to_dentry,
 	.fh_to_parent = ceph_fh_to_parent,
+	.get_parent = ceph_get_parent,
 };
-- 
1.8.5.3

