From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 6/6] ceph: make ceph_setxattr() and ceph_removexattr() more
 alike
Date: Tue, 28 Feb 2012 19:21:55 -0800
Message-ID: <4F4D99D3.8070501@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38161 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030700Ab2B2DV5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:21:57 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4666224322
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:57 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id B345524314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:55 -0800 (PST)
In-Reply-To: <4F4D98D5.1010506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch just rearranges a few bits of code to make more
portions of ceph_setxattr() and ceph_removexattr() identical.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |   15 ++++++++-------
  1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 984c863..3fccd3b 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -764,15 +764,15 @@ int ceph_setxattr(struct dentry *dentry, const 
char *name,
  	struct inode *inode = dentry->d_inode;
  	struct ceph_vxattr *vxattr;
  	struct ceph_inode_info *ci = ceph_inode(inode);
+	int issued;
  	int err;
+	int dirty;
  	int name_len = strlen(name);
  	int val_len = size;
  	char *newname = NULL;
  	char *newval = NULL;
  	struct ceph_inode_xattr *xattr = NULL;
-	int issued;
  	int required_blob_size;
-	int dirty;

  	if (ceph_snap(inode) != CEPH_NOSNAP)
  		return -EROFS;
@@ -803,6 +803,7 @@ int ceph_setxattr(struct dentry *dentry, const char 
*name,
  	spin_lock(&ci->i_ceph_lock);
  retry:
  	issued = __ceph_caps_issued(ci, NULL);
+	dout("setxattr %p issued %s\n", inode, ceph_cap_string(issued));
  	if (!(issued & CEPH_CAP_XATTR_EXCL))
  		goto do_sync;
  	__build_xattrs(inode);
@@ -811,7 +812,7 @@ retry:

  	if (!ci->i_xattrs.prealloc_blob ||
  	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
-		struct ceph_buffer *blob = NULL;
+		struct ceph_buffer *blob;

  		spin_unlock(&ci->i_ceph_lock);
  		dout(" preaallocating new blob size=%d\n", required_blob_size);
@@ -825,12 +826,13 @@ retry:
  		goto retry;
  	}

-	dout("setxattr %p issued %s\n", inode, ceph_cap_string(issued));
  	err = __set_xattr(ci, newname, name_len, newval,
  			  val_len, 1, 1, 1, &xattr);
+
  	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
  	ci->i_xattrs.dirty = true;
  	inode->i_ctime = CURRENT_TIME;
+
  	spin_unlock(&ci->i_ceph_lock);
  	if (dirty)
  		__mark_inode_dirty(inode, dirty);
@@ -892,18 +894,17 @@ int ceph_removexattr(struct dentry *dentry, const 
char *name)
  		return -EOPNOTSUPP;

  	spin_lock(&ci->i_ceph_lock);
-	__build_xattrs(inode);
  	issued = __ceph_caps_issued(ci, NULL);
  	dout("removexattr %p issued %s\n", inode, ceph_cap_string(issued));
-
  	if (!(issued & CEPH_CAP_XATTR_EXCL))
  		goto do_sync;
+	__build_xattrs(inode);

  	err = __remove_xattr_by_name(ceph_inode(inode), name);
+
  	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
  	ci->i_xattrs.dirty = true;
  	inode->i_ctime = CURRENT_TIME;
-
  	spin_unlock(&ci->i_ceph_lock);
  	if (dirty)
  		__mark_inode_dirty(inode, dirty);
-- 
1.7.5.4


