From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] ceph: Document that dentry is unused in xattr ->get
Date: Wed, 25 May 2016 13:21:05 +0200
Message-ID: <1464175265-1339-1-git-send-email-agruenba@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbcEYLVJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 May 2016 07:21:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, ceph-devel@vger.kernel.org

For consistency with the other filesystems, rename the dentry argument
to "unused" here.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/ceph/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 0d66722..223f567 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1042,7 +1042,7 @@ out:
 }
 
 static int ceph_get_xattr_handler(const struct xattr_handler *handler,
-				  struct dentry *dentry, struct inode *inode,
+				  struct dentry *unused, struct inode *inode,
 				  const char *name, void *value, size_t size)
 {
 	if (!ceph_is_valid_xattr(name))
-- 
2.5.5

