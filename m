From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/4] ceph: fix symlink inode operations
Date: Fri, 12 Apr 2013 16:11:12 +0800
Message-ID: <1365754273-14088-5-git-send-email-zheng.z.yan@intel.com>
References: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62108 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab3DLILV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Apr 2013 04:11:21 -0400
In-Reply-To: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: greg@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

add getattr/setattr and xattrs related methods.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5d730d4..d5cad38 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1523,6 +1523,12 @@ static void *ceph_sym_follow_link(struct dentry *dentry, struct nameidata *nd)
 static const struct inode_operations ceph_symlink_iops = {
 	.readlink = generic_readlink,
 	.follow_link = ceph_sym_follow_link,
+	.setattr = ceph_setattr,
+	.getattr = ceph_getattr,
+	.setxattr = ceph_setxattr,
+	.getxattr = ceph_getxattr,
+	.listxattr = ceph_listxattr,
+	.removexattr = ceph_removexattr,
 };
 
 /*
-- 
1.7.11.7

