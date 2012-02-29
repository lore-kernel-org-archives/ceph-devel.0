From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/6] ceph: drop "_cb" from name of struct ceph_vxattr_cb
Date: Tue, 28 Feb 2012 19:21:47 -0800
Message-ID: <4F4D99CB.9040208@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38150 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030689Ab2B2DVs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:21:48 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6622F24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:48 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5386C24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:48 -0800 (PST)
In-Reply-To: <4F4D98D5.1010506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A struct ceph_vxattr_cb does not represent a callback at all, but
rather a virtual extended attribute itself.  Drop the "_cb" suffix
from its name to reflect that.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |   20 ++++++++++----------
  1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 9ef0134..3e0ef77 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -24,7 +24,7 @@ static bool ceph_is_valid_xattr(const char *name)
   * These define virtual xattrs exposing the recursive directory
   * statistics and layout metadata.
   */
-struct ceph_vxattr_cb {
+struct ceph_vxattr {
  	char *name;
  	size_t (*getxattr_cb)(struct ceph_inode_info *ci, char *val,
  			      size_t size);
@@ -91,7 +91,7 @@ static size_t ceph_vxattrcb_rctime(struct 
ceph_inode_info *ci, char *val,
  			.readonly = true, \
  		}

-static struct ceph_vxattr_cb ceph_dir_vxattrs[] = {
+static struct ceph_vxattr ceph_dir_vxattrs[] = {
  	XATTR_NAME_CEPH(dir, entries),
  	XATTR_NAME_CEPH(dir, files),
  	XATTR_NAME_CEPH(dir, subdirs),
@@ -122,7 +122,7 @@ static size_t ceph_vxattrcb_layout(struct 
ceph_inode_info *ci, char *val,
  	return ret;
  }

-static struct ceph_vxattr_cb ceph_file_vxattrs[] = {
+static struct ceph_vxattr ceph_file_vxattrs[] = {
  	XATTR_NAME_CEPH(file, layout),
  	/* The following extended attribute name is deprecated */
  	{
@@ -133,7 +133,7 @@ static struct ceph_vxattr_cb ceph_file_vxattrs[] = {
  	{ 0 }	/* Required table terminator */
  };

-static struct ceph_vxattr_cb *ceph_inode_vxattrs(struct inode *inode)
+static struct ceph_vxattr *ceph_inode_vxattrs(struct inode *inode)
  {
  	if (S_ISDIR(inode->i_mode))
  		return ceph_dir_vxattrs;
@@ -142,10 +142,10 @@ static struct ceph_vxattr_cb 
*ceph_inode_vxattrs(struct inode *inode)
  	return NULL;
  }

-static struct ceph_vxattr_cb *ceph_match_vxattr(struct inode *inode,
+static struct ceph_vxattr *ceph_match_vxattr(struct inode *inode,
  						const char *name)
  {
-	struct ceph_vxattr_cb *vxattr = ceph_inode_vxattrs(inode);
+	struct ceph_vxattr *vxattr = ceph_inode_vxattrs(inode);

  	if (vxattr)
  		while (vxattr->name) {
@@ -524,7 +524,7 @@ ssize_t ceph_getxattr(struct dentry *dentry, const 
char *name, void *value,
  	struct ceph_inode_info *ci = ceph_inode(inode);
  	int err;
  	struct ceph_inode_xattr *xattr;
-	struct ceph_vxattr_cb *vxattr = NULL;
+	struct ceph_vxattr *vxattr = NULL;

  	if (!ceph_is_valid_xattr(name))
  		return -ENODATA;
@@ -586,7 +586,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char 
*names, size_t size)
  {
  	struct inode *inode = dentry->d_inode;
  	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_vxattr_cb *vxattrs = ceph_inode_vxattrs(inode);
+	struct ceph_vxattr *vxattrs = ceph_inode_vxattrs(inode);
  	u32 vir_namelen = 0;
  	u32 namelen;
  	int err;
@@ -716,7 +716,7 @@ int ceph_setxattr(struct dentry *dentry, const char 
*name,
  		  const void *value, size_t size, int flags)
  {
  	struct inode *inode = dentry->d_inode;
-	struct ceph_vxattr_cb *vxattr;
+	struct ceph_vxattr *vxattr;
  	struct ceph_inode_info *ci = ceph_inode(inode);
  	int err;
  	int name_len = strlen(name);
@@ -829,7 +829,7 @@ static int ceph_send_removexattr(struct dentry 
*dentry, const char *name)
  int ceph_removexattr(struct dentry *dentry, const char *name)
  {
  	struct inode *inode = dentry->d_inode;
-	struct ceph_vxattr_cb *vxattr;
+	struct ceph_vxattr *vxattr;
  	struct ceph_inode_info *ci = ceph_inode(inode);
  	int issued;
  	int err;
-- 
1.7.5.4

