From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: trim deleted inode
Date: Sun, 21 Jul 2013 10:21:12 +0800
Message-ID: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36648 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631Ab3GUCVY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 20 Jul 2013 22:21:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The MDS uses caps message to notify clients about deleted inode.
when receiving a such message, invalidate any alias of the inode.
This makes the kernel release the inode ASAP.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 25442b4..b446fdd 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2334,6 +2334,28 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 }
 
 /*
+ * Invalidate unlinked inode's aliases, so we can drop the inode
+ * from the cache ASAP.
+ */
+static void invalidate_aliases(struct inode *inode)
+{
+	struct dentry *dn;
+
+	dout("invalidate_aliases inode %p\n", inode);
+	d_prune_aliases(inode);
+	while ((dn = d_find_alias(inode))) {
+		d_delete(dn);
+		dput(dn);
+		/*
+		 * for dir inode, d_find_alias() can return
+		 * disconnected dentry
+		 */
+		if (S_ISDIR(inode->i_mode))
+			break;
+	}
+}
+
+/*
  * Handle a cap GRANT message from the MDS.  (Note that a GRANT may
  * actually be a revocation if it specifies a smaller cap set.)
  *
@@ -2363,6 +2385,7 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	int writeback = 0;
 	int revoked_rdcache = 0;
 	int queue_invalidate = 0;
+	int deleted_inode = 0;
 
 	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
 	     inode, cap, mds, seq, ceph_cap_string(newcaps));
@@ -2407,8 +2430,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		     from_kgid(&init_user_ns, inode->i_gid));
 	}
 
-	if ((issued & CEPH_CAP_LINK_EXCL) == 0)
+	if ((issued & CEPH_CAP_LINK_EXCL) == 0) {
 		set_nlink(inode, le32_to_cpu(grant->nlink));
+		if (inode->i_nlink == 0 &&
+		    (newcaps & (CEPH_CAP_LINK_SHARED | CEPH_CAP_LINK_EXCL)))
+			deleted_inode = 1;
+	}
 
 	if ((issued & CEPH_CAP_XATTR_EXCL) == 0 && grant->xattr_len) {
 		int len = le32_to_cpu(grant->xattr_len);
@@ -2517,6 +2544,8 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		ceph_queue_writeback(inode);
 	if (queue_invalidate)
 		ceph_queue_invalidate(inode);
+	if (deleted_inode)
+		invalidate_aliases(inode);
 	if (wake)
 		wake_up_all(&ci->i_cap_wq);
 
-- 
1.8.1.4

