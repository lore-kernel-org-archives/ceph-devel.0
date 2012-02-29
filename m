From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/6] ceph: encode type in vxattr callback routines
Date: Tue, 28 Feb 2012 19:21:49 -0800
Message-ID: <4F4D99CD.3070807@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38153 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030698Ab2B2DVt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:21:49 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BAC5824318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:49 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id B18C724314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:49 -0800 (PST)
In-Reply-To: <4F4D98D5.1010506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The names of the callback functions used for virtual extended
attributes are based only on the last component of the attribute
name.  Because of the way these are defined, this precludes allowing
a single (lowest) attribute name for different callbacks, dependent
on the type of file being operated on.  (For example, it might be
nice to support both "ceph.dir.layout" and "ceph.file.layout".)

Just change the callback names to avoid this problem.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |   22 +++++++++++-----------
  1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 3e0ef77..83366f9 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -33,49 +33,49 @@ struct ceph_vxattr {

  /* directories */

-static size_t ceph_vxattrcb_entries(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_entries(struct ceph_inode_info *ci, 
char *val,
  					size_t size)
  {
  	return snprintf(val, size, "%lld", ci->i_files + ci->i_subdirs);
  }

-static size_t ceph_vxattrcb_files(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_files(struct ceph_inode_info *ci, char 
*val,
  				      size_t size)
  {
  	return snprintf(val, size, "%lld", ci->i_files);
  }

-static size_t ceph_vxattrcb_subdirs(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_subdirs(struct ceph_inode_info *ci, 
char *val,
  					size_t size)
  {
  	return snprintf(val, size, "%lld", ci->i_subdirs);
  }

-static size_t ceph_vxattrcb_rentries(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_rentries(struct ceph_inode_info *ci, 
char *val,
  					 size_t size)
  {
  	return snprintf(val, size, "%lld", ci->i_rfiles + ci->i_rsubdirs);
  }

-static size_t ceph_vxattrcb_rfiles(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_rfiles(struct ceph_inode_info *ci, char 
*val,
  				       size_t size)
  {
  	return snprintf(val, size, "%lld", ci->i_rfiles);
  }

-static size_t ceph_vxattrcb_rsubdirs(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_rsubdirs(struct ceph_inode_info *ci, 
char *val,
  					 size_t size)
  {
  	return snprintf(val, size, "%lld", ci->i_rsubdirs);
  }

-static size_t ceph_vxattrcb_rbytes(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_rbytes(struct ceph_inode_info *ci, char 
*val,
  				       size_t size)
  {
  	return snprintf(val, size, "%lld", ci->i_rbytes);
  }

-static size_t ceph_vxattrcb_rctime(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char 
*val,
  				       size_t size)
  {
  	return snprintf(val, size, "%ld.%ld", (long)ci->i_rctime.tv_sec,
@@ -87,7 +87,7 @@ static size_t ceph_vxattrcb_rctime(struct 
ceph_inode_info *ci, char *val,
  #define XATTR_NAME_CEPH(_type, _name) \
  		{ \
  			.name = CEPH_XATTR_NAME(_type, _name), \
-			.getxattr_cb = ceph_vxattrcb_ ## _name, \
+			.getxattr_cb = ceph_vxattrcb_ ## _type ## _ ## _name, \
  			.readonly = true, \
  		}

@@ -105,7 +105,7 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {

  /* files */

-static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
+static size_t ceph_vxattrcb_file_layout(struct ceph_inode_info *ci, 
char *val,
  				   size_t size)
  {
  	int ret;
@@ -127,7 +127,7 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
  	/* The following extended attribute name is deprecated */
  	{
  		.name = XATTR_CEPH_PREFIX "layout",
-		.getxattr_cb = ceph_vxattrcb_layout,
+		.getxattr_cb = ceph_vxattrcb_file_layout,
  		.readonly = true,
  	},
  	{ 0 }	/* Required table terminator */
-- 
1.7.5.4

