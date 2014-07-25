From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] ceph: remove redundant memset(0)
Date: Fri, 25 Jul 2014 13:26:04 +0400
Message-ID: <1406280364-30198-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:55602 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaGYJ0L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 05:26:11 -0400
Received: by mail-lb0-f176.google.com with SMTP id u10so3214265lbd.35
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 02:26:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Yan Zheng <zheng.z.yan@intel.com>

xattrs array of pointers is allocated with kcalloc() - no need to
memset() it to 0 right after that.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 fs/ceph/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index c9c2b887381e..f89698cdbc41 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -597,7 +597,7 @@ start:
 		err = -ENOMEM;
 		if (!xattrs)
 			goto bad_lock;
-		memset(xattrs, 0, numattr*sizeof(struct ceph_xattr *));
+
 		for (i = 0; i < numattr; i++) {
 			xattrs[i] = kmalloc(sizeof(struct ceph_inode_xattr),
 					    GFP_NOFS);
-- 
1.7.10.4

