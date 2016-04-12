From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/3] ceph: Switch to generic xattr handlers
Date: Tue, 12 Apr 2016 20:19:25 +0800
Message-ID: <1460463566-75273-2-git-send-email-zyan@redhat.com>
References: <1460463566-75273-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932759AbcDLMTk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2016 08:19:40 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEA1764D01
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 12:19:39 +0000 (UTC)
In-Reply-To: <1460463566-75273-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agruenba@redhat.com, "Yan, Zheng" <zyan@redhat.com>

From: Andreas Gruenbacher <agruenba@redhat.com>

Add a catch-all xattr handler at the end of ceph_xattr_handlers.  Check
for valid attribute names there, and remove those checks from
__ceph_{get,set,remove}xattr instead.  No "system.*" xattrs need to be
handled by the catch-all handler anymore.

The set xattr handler is called with a NULL value to indicate that the
attribute should be removed, so call __ceph_removexattr instead of
__ceph_setxattr in that case.

Move the check for snapshots from ceph_{set,remove}xattr into
__ceph_{set,remove}xattr.  With that, ceph_{get,set,remove}xattr can be
replaced with the generic iops.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/dir.c   |  7 +++---
 fs/ceph/inode.c | 13 ++++++------
 fs/ceph/super.h |  4 ----
 fs/ceph/xattr.c | 66 +++++++++++++++++++++++----------------------------------
 4 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index fadc243..2e0afdc 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -5,6 +5,7 @@
 #include <linux/namei.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/xattr.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -1342,10 +1343,10 @@ const struct inode_operations ceph_dir_iops = {
 	.permission = ceph_permission,
 	.getattr = ceph_getattr,
 	.setattr = ceph_setattr,
-	.setxattr = ceph_setxattr,
-	.getxattr = ceph_getxattr,
+	.setxattr = generic_setxattr,
+	.getxattr = generic_getxattr,
 	.listxattr = ceph_listxattr,
-	.removexattr = ceph_removexattr,
+	.removexattr = generic_removexattr,
 	.get_acl = ceph_get_acl,
 	.set_acl = ceph_set_acl,
 	.mknod = ceph_mknod,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4839f48..4f3b401 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/writeback.h>
 #include <linux/vmalloc.h>
+#include <linux/xattr.h>
 #include <linux/posix_acl.h>
 #include <linux/random.h>
 
@@ -92,10 +93,10 @@ const struct inode_operations ceph_file_iops = {
 	.permission = ceph_permission,
 	.setattr = ceph_setattr,
 	.getattr = ceph_getattr,
-	.setxattr = ceph_setxattr,
-	.getxattr = ceph_getxattr,
+	.setxattr = generic_setxattr,
+	.getxattr = generic_getxattr,
 	.listxattr = ceph_listxattr,
-	.removexattr = ceph_removexattr,
+	.removexattr = generic_removexattr,
 	.get_acl = ceph_get_acl,
 	.set_acl = ceph_set_acl,
 };
@@ -1786,10 +1787,10 @@ static const struct inode_operations ceph_symlink_iops = {
 	.get_link = simple_get_link,
 	.setattr = ceph_setattr,
 	.getattr = ceph_getattr,
-	.setxattr = ceph_setxattr,
-	.getxattr = ceph_getxattr,
+	.setxattr = generic_setxattr,
+	.getxattr = generic_getxattr,
 	.listxattr = ceph_listxattr,
-	.removexattr = ceph_removexattr,
+	.removexattr = generic_removexattr,
 };
 
 int __ceph_setattr(struct inode *inode, struct iattr *attr)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3dcaf51..6570c70 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -792,13 +792,9 @@ extern int ceph_getattr(struct vfsmount *mnt, struct dentry *dentry,
 			struct kstat *stat);
 
 /* xattr.c */
-extern int ceph_setxattr(struct dentry *, const char *, const void *,
-			 size_t, int);
 int __ceph_setxattr(struct inode *, const char *, const void *, size_t, int);
 ssize_t __ceph_getxattr(struct inode *, const char *, void *, size_t);
-extern ssize_t ceph_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
-extern int ceph_removexattr(struct dentry *, const char *);
 extern void __ceph_build_xattrs_blob(struct ceph_inode_info *ci);
 extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
 extern void __init ceph_xattr_init(void);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index f3bd667..adc81f6 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -16,6 +16,8 @@
 static int __remove_xattr(struct ceph_inode_info *ci,
 			  struct ceph_inode_xattr *xattr);
 
+const struct xattr_handler ceph_other_xattr_handler;
+
 /*
  * List of handlers for synthetic system.* attributes. Other
  * attributes are handled directly.
@@ -25,6 +27,7 @@ const struct xattr_handler *ceph_xattr_handlers[] = {
 	&posix_acl_access_xattr_handler,
 	&posix_acl_default_xattr_handler,
 #endif
+	&ceph_other_xattr_handler,
 	NULL,
 };
 
@@ -33,7 +36,6 @@ static bool ceph_is_valid_xattr(const char *name)
 	return !strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN) ||
 	       !strncmp(name, XATTR_SECURITY_PREFIX,
 			XATTR_SECURITY_PREFIX_LEN) ||
-	       !strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN) ||
 	       !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) ||
 	       !strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
 }
@@ -761,9 +763,6 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	int req_mask;
 	int err;
 
-	if (!ceph_is_valid_xattr(name))
-		return -ENODATA;
-
 	/* let's see if a virtual xattr was requested */
 	vxattr = ceph_match_vxattr(inode, name);
 	if (vxattr) {
@@ -825,15 +824,6 @@ out:
 	return err;
 }
 
-ssize_t ceph_getxattr(struct dentry *dentry, const char *name, void *value,
-		      size_t size)
-{
-	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_getxattr(dentry, name, value, size);
-
-	return __ceph_getxattr(d_inode(dentry), name, value, size);
-}
-
 ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 {
 	struct inode *inode = d_inode(dentry);
@@ -977,8 +967,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	int required_blob_size;
 	bool lock_snap_rwsem = false;
 
-	if (!ceph_is_valid_xattr(name))
-		return -EOPNOTSUPP;
+	if (ceph_snap(inode) != CEPH_NOSNAP)
+		return -EROFS;
 
 	vxattr = ceph_match_vxattr(inode, name);
 	if (vxattr && vxattr->readonly)
@@ -1085,21 +1075,6 @@ out:
 	return err;
 }
 
-int ceph_setxattr(struct dentry *dentry, const char *name,
-		  const void *value, size_t size, int flags)
-{
-	if (ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
-		return -EROFS;
-
-	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_setxattr(dentry, name, value, size, flags);
-
-	if (size == 0)
-		value = "";  /* empty EA, do not remove */
-
-	return __ceph_setxattr(d_inode(dentry), name, value, size, flags);
-}
-
 static int ceph_send_removexattr(struct inode *inode, const char *name)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
@@ -1136,8 +1111,8 @@ static int __ceph_removexattr(struct inode *inode, const char *name)
 	int dirty;
 	bool lock_snap_rwsem = false;
 
-	if (!ceph_is_valid_xattr(name))
-		return -EOPNOTSUPP;
+	if (ceph_snap(inode) != CEPH_NOSNAP)
+		return -EROFS;
 
 	vxattr = ceph_match_vxattr(inode, name);
 	if (vxattr && vxattr->readonly)
@@ -1213,17 +1188,30 @@ do_sync_unlocked:
 	return err;
 }
 
-int ceph_removexattr(struct dentry *dentry, const char *name)
+static int ceph_get_xattr_handler(const struct xattr_handler *handler,
+				  struct dentry *dentry, const char *name,
+				  void *value, size_t size)
 {
-	if (ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
-		return -EROFS;
-
-	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_removexattr(dentry, name);
+	if (!ceph_is_valid_xattr(name))
+		return -EOPNOTSUPP;
+	return __ceph_getxattr(d_inode(dentry), name, value, size);
+}
 
-	return __ceph_removexattr(d_inode(dentry), name);
+static int ceph_set_xattr_handler(const struct xattr_handler *handler,
+				  struct dentry *dentry, const char *name,
+				  const void *value, size_t size, int flags)
+{
+	if (!ceph_is_valid_xattr(name))
+		return -EOPNOTSUPP;
+	return __ceph_setxattr(d_inode(dentry), name, value, size, flags);
 }
 
+const struct xattr_handler ceph_other_xattr_handler = {
+	.prefix = "",  /* match any name => handlers called with full name */
+	.get = ceph_get_xattr_handler,
+	.set = ceph_set_xattr_handler,
+};
+
 #ifdef CONFIG_SECURITY
 bool ceph_security_xattr_wanted(struct inode *in)
 {
-- 
2.5.0

