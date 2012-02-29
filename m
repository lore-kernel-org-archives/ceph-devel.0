From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: pass inode rather than table to ceph_match_vxattr()
Date: Tue, 28 Feb 2012 19:13:14 -0800
Message-ID: <4F4D97CA.5060302@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44168 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030700Ab2B2DNO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:13:14 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 81CCB24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:13:14 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 696D624314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:13:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All callers of ceph_match_vxattr() determine what to pass as the
first argument by calling ceph_inode_vxattrs(inode).  Just do that
inside ceph_match_vxattr() itself, changing it to take an inode
rather than the vxattr pointer as its first argument.

Also ensure the function works correctly for an empty table (i.e.,
containing only a terminating null entry).

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |   42 +++++++++++++++++++-----------------------
  1 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index b98b91d..bec9c30 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -126,14 +126,18 @@ static struct ceph_vxattr_cb 
*ceph_inode_vxattrs(struct inode *inode)
  	return NULL;
  }

-static struct ceph_vxattr_cb *ceph_match_vxattr(struct ceph_vxattr_cb 
*vxattr,
+static struct ceph_vxattr_cb *ceph_match_vxattr(struct inode *inode,
  						const char *name)
  {
-	do {
-		if (strcmp(vxattr->name, name) == 0)
-			return vxattr;
-		vxattr++;
-	} while (vxattr->name);
+	struct ceph_vxattr_cb *vxattr = ceph_inode_vxattrs(inode);
+
+	if (vxattr)
+		while (vxattr->name) {
+			if (!strcmp(vxattr->name, name))
+				return vxattr;
+			vxattr++;
+		}
+
  	return NULL;
  }

@@ -502,7 +506,6 @@ ssize_t ceph_getxattr(struct dentry *dentry, const 
char *name, void *value,
  {
  	struct inode *inode = dentry->d_inode;
  	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_vxattr_cb *vxattrs = ceph_inode_vxattrs(inode);
  	int err;
  	struct ceph_inode_xattr *xattr;
  	struct ceph_vxattr_cb *vxattr = NULL;
@@ -511,8 +514,7 @@ ssize_t ceph_getxattr(struct dentry *dentry, const 
char *name, void *value,
  		return -ENODATA;

  	/* let's see if a virtual xattr was requested */
-	if (vxattrs)
-		vxattr = ceph_match_vxattr(vxattrs, name);
+	vxattr = ceph_match_vxattr(inode, name);

  	spin_lock(&ci->i_ceph_lock);
  	dout("getxattr %p ver=%lld index_ver=%lld\n", inode,
@@ -698,8 +700,8 @@ int ceph_setxattr(struct dentry *dentry, const char 
*name,
  		  const void *value, size_t size, int flags)
  {
  	struct inode *inode = dentry->d_inode;
+	struct ceph_vxattr_cb *vxattr;
  	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_vxattr_cb *vxattrs = ceph_inode_vxattrs(inode);
  	int err;
  	int name_len = strlen(name);
  	int val_len = size;
@@ -716,12 +718,9 @@ int ceph_setxattr(struct dentry *dentry, const char 
*name,
  	if (!ceph_is_valid_xattr(name))
  		return -EOPNOTSUPP;

-	if (vxattrs) {
-		struct ceph_vxattr_cb *vxattr =
-			ceph_match_vxattr(vxattrs, name);
-		if (vxattr && vxattr->readonly)
-			return -EOPNOTSUPP;
-	}
+	vxattr = ceph_match_vxattr(inode, name);
+	if (vxattr && vxattr->readonly)
+		return -EOPNOTSUPP;

  	/* preallocate memory for xattr name, value, index node */
  	err = -ENOMEM;
@@ -814,8 +813,8 @@ static int ceph_send_removexattr(struct dentry 
*dentry, const char *name)
  int ceph_removexattr(struct dentry *dentry, const char *name)
  {
  	struct inode *inode = dentry->d_inode;
+	struct ceph_vxattr_cb *vxattr;
  	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_vxattr_cb *vxattrs = ceph_inode_vxattrs(inode);
  	int issued;
  	int err;
  	int dirty;
@@ -826,12 +825,9 @@ int ceph_removexattr(struct dentry *dentry, const 
char *name)
  	if (!ceph_is_valid_xattr(name))
  		return -EOPNOTSUPP;

-	if (vxattrs) {
-		struct ceph_vxattr_cb *vxattr =
-			ceph_match_vxattr(vxattrs, name);
-		if (vxattr && vxattr->readonly)
-			return -EOPNOTSUPP;
-	}
+	vxattr = ceph_match_vxattr(inode, name);
+	if (vxattr && vxattr->readonly)
+		return -EOPNOTSUPP;

  	spin_lock(&ci->i_ceph_lock);
  	__build_xattrs(inode);
-- 
1.7.5.4

