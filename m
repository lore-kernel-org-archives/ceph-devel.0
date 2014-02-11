From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/5] ceph: properly handle XATTR_CREATE and XATTR_REPLACE
Date: Tue, 11 Feb 2014 13:30:08 +0800
Message-ID: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaBKFaH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Feb 2014 00:30:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

return -EEXIST if XATTR_CREATE is set and xattr alread exists.
return -ENODATA if XATTR_REPLACE is set but xattr does not exist.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/xattr.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 898b656..28f9793 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -319,8 +319,7 @@ static struct ceph_vxattr *ceph_match_vxattr(struct inode *inode,
 static int __set_xattr(struct ceph_inode_info *ci,
 			   const char *name, int name_len,
 			   const char *val, int val_len,
-			   int dirty,
-			   int should_free_name, int should_free_val,
+			   int flags, int update_xattr,
 			   struct ceph_inode_xattr **newxattr)
 {
 	struct rb_node **p;
@@ -349,12 +348,25 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		xattr = NULL;
 	}
 
+	if (update_xattr) {
+		int err = 0;
+		if (xattr && (flags & XATTR_CREATE))
+			err = -EEXIST;
+		else if (!xattr && (flags & XATTR_REPLACE))
+			err = -ENODATA;
+		if (err) {
+			kfree(name);
+			kfree(val);
+			return err;
+		}
+	}
+
 	if (!xattr) {
 		new = 1;
 		xattr = *newxattr;
 		xattr->name = name;
 		xattr->name_len = name_len;
-		xattr->should_free_name = should_free_name;
+		xattr->should_free_name = update_xattr;
 
 		ci->i_xattrs.count++;
 		dout("__set_xattr count=%d\n", ci->i_xattrs.count);
@@ -364,7 +376,7 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		if (xattr->should_free_val)
 			kfree((void *)xattr->val);
 
-		if (should_free_name) {
+		if (update_xattr) {
 			kfree((void *)name);
 			name = xattr->name;
 		}
@@ -379,8 +391,8 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		xattr->val = "";
 
 	xattr->val_len = val_len;
-	xattr->dirty = dirty;
-	xattr->should_free_val = (val && should_free_val);
+	xattr->dirty = update_xattr;
+	xattr->should_free_val = (val && update_xattr);
 
 	if (new) {
 		rb_link_node(&xattr->node, parent, p);
@@ -588,7 +600,7 @@ start:
 			p += len;
 
 			err = __set_xattr(ci, name, namelen, val, len,
-					  0, 0, 0, &xattrs[numattr]);
+					  0, 0, &xattrs[numattr]);
 
 			if (err < 0)
 				goto bad;
@@ -892,7 +904,7 @@ int __ceph_setxattr(struct dentry *dentry, const char *name,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int issued;
 	int err;
-	int dirty;
+	int dirty = 0;
 	int name_len = strlen(name);
 	int val_len = size;
 	char *newname = NULL;
@@ -954,11 +966,13 @@ retry:
 	}
 
 	err = __set_xattr(ci, newname, name_len, newval,
-			  val_len, 1, 1, 1, &xattr);
+			  val_len, flags, 1, &xattr);
 
-	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
-	ci->i_xattrs.dirty = true;
-	inode->i_ctime = CURRENT_TIME;
+	if (!err) {
+		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
+		ci->i_xattrs.dirty = true;
+		inode->i_ctime = CURRENT_TIME;
+	}
 
 	spin_unlock(&ci->i_ceph_lock);
 	if (dirty)
-- 
1.8.5.3

