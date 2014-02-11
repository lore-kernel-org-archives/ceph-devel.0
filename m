From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/5] ceph: remove zero-size xattr
Date: Tue, 11 Feb 2014 13:30:09 +0800
Message-ID: <1392096612-11481-2-git-send-email-zheng.z.yan@intel.com>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbaBKFaI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Feb 2014 00:30:08 -0500
In-Reply-To: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/xattr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 28f9793..6ed0e5a 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -12,6 +12,9 @@
 #define XATTR_CEPH_PREFIX "ceph."
 #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
 
+static int __remove_xattr(struct ceph_inode_info *ci,
+			  struct ceph_inode_xattr *xattr);
+
 /*
  * List of handlers for synthetic system.* attributes. Other
  * attributes are handled directly.
@@ -359,6 +362,12 @@ static int __set_xattr(struct ceph_inode_info *ci,
 			kfree(val);
 			return err;
 		}
+		if (!val_len) {
+			if (xattr)
+				__remove_xattr(ci, xattr);
+			kfree(name);
+			return 0;
+		}
 	}
 
 	if (!xattr) {
-- 
1.8.5.3

