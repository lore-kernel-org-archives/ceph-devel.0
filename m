From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/5] ceph: fix ceph_set_acl()
Date: Tue, 11 Feb 2014 13:30:12 +0800
Message-ID: <1392096612-11481-5-git-send-email-zheng.z.yan@intel.com>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbaBKFaM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Feb 2014 00:30:12 -0500
In-Reply-To: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

If acl is equivalent to file mode permission bits, ceph_set_acl()
needs to remove any existing acl xattr. Use __ceph_setxattr() to
handle both setting and removing acl xattr cases, it doesn't return
-ENODATA when there is no acl xattr.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/acl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 4c2d452..accc9f2 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -160,11 +160,7 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 			goto out_dput;
 	}
 
-	if (value)
-		ret = __ceph_setxattr(dentry, name, value, size, 0);
-	else
-		ret = __ceph_removexattr(dentry, name);
-
+	ret = __ceph_setxattr(dentry, name, value, size, 0);
 	if (ret) {
 		if (new_mode != old_mode) {
 			newattrs.ia_mode = old_mode;
-- 
1.8.5.3

