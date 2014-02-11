From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/5] ceph: fix ceph_removexattr()
Date: Tue, 11 Feb 2014 13:30:10 +0800
Message-ID: <1392096612-11481-3-git-send-email-zheng.z.yan@intel.com>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaBKFaJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Feb 2014 00:30:09 -0500
In-Reply-To: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 6ed0e5a..79f9c12 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -463,7 +463,7 @@ static int __remove_xattr(struct ceph_inode_info *ci,
 			  struct ceph_inode_xattr *xattr)
 {
 	if (!xattr)
-		return -EOPNOTSUPP;
+		return -ENODATA;
 
 	rb_erase(&xattr->node, &ci->i_xattrs.index);
 
-- 
1.8.5.3

