From: Sage Weil <sage@inktank.com>
Subject: [PATCH] ceph: fix missing dput in ceph_set_acl
Date: Fri, 31 Jan 2014 07:25:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401310623140.11178@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54322 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412AbaAaPZ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jan 2014 10:25:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, julia.lawall@lip6.fr, fengguang.wu@intel.com

Add matching dput() for d_find_alias().  Move d_find_alias() down a bit
at Julia's suggestion.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Sage Weil <sage@inktank.com>
Reviewed-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 fs/ceph/acl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 9ab312e..4c2d452 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -107,7 +107,7 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	char *value = NULL;
 	struct iattr newattrs;
 	umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
-	struct dentry *dentry = d_find_alias(inode);
+	struct dentry *dentry;
 
 	if (acl) {
 		ret = posix_acl_valid(acl);
@@ -151,12 +151,13 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 			goto out_free;
 	}
 
+	dentry = d_find_alias(inode);
 	if (new_mode != old_mode) {
 		newattrs.ia_mode = new_mode;
 		newattrs.ia_valid = ATTR_MODE;
 		ret = ceph_setattr(dentry, &newattrs);
 		if (ret)
-			goto out_free;
+			goto out_dput;
 	}
 
 	if (value)
@@ -170,11 +171,13 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 			newattrs.ia_valid = ATTR_MODE;
 			ceph_setattr(dentry, &newattrs);
 		}
-		goto out_free;
+		goto out_dput;
 	}
 
 	ceph_set_cached_acl(inode, type, acl);
 
+out_dput:
+	dput(dentry);
 out_free:
 	kfree(value);
 out:
-- 
1.8.5.1

