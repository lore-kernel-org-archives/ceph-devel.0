From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/6] ceph: use macros to normalize vxattr table definitions
Date: Tue, 28 Feb 2012 19:21:46 -0800
Message-ID: <4F4D99CA.8070509@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38147 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170Ab2B2DVq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:21:46 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7130124314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:46 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 6499A24325
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:46 -0800 (PST)
In-Reply-To: <4F4D98D5.1010506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Entries in the ceph virtual extended attribute tables all follow a
distinct pattern in their definition.  Enforce this pattern through
the use of a macro.

Also, a null name field signals the end of the table, so make that
be the first field in the ceph_vxattr_cb structure.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |   39 ++++++++++++++++++++++++++-------------
  1 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 21ee6aa..9ef0134 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -25,10 +25,10 @@ static bool ceph_is_valid_xattr(const char *name)
   * statistics and layout metadata.
   */
  struct ceph_vxattr_cb {
-	bool readonly;
  	char *name;
  	size_t (*getxattr_cb)(struct ceph_inode_info *ci, char *val,
  			      size_t size);
+	bool readonly;
  };

  /* directories */
@@ -82,16 +82,25 @@ static size_t ceph_vxattrcb_rctime(struct 
ceph_inode_info *ci, char *val,
  			(long)ci->i_rctime.tv_nsec);
  }

+#define CEPH_XATTR_NAME(_type, _name)	XATTR_CEPH_PREFIX #_type "." #_name
+
+#define XATTR_NAME_CEPH(_type, _name) \
+		{ \
+			.name = CEPH_XATTR_NAME(_type, _name), \
+			.getxattr_cb = ceph_vxattrcb_ ## _name, \
+			.readonly = true, \
+		}
+
  static struct ceph_vxattr_cb ceph_dir_vxattrs[] = {
-	{ true, XATTR_CEPH_PREFIX "dir.entries", ceph_vxattrcb_entries},
-	{ true, XATTR_CEPH_PREFIX "dir.files", ceph_vxattrcb_files},
-	{ true, XATTR_CEPH_PREFIX "dir.subdirs", ceph_vxattrcb_subdirs},
-	{ true, XATTR_CEPH_PREFIX "dir.rentries", ceph_vxattrcb_rentries},
-	{ true, XATTR_CEPH_PREFIX "dir.rfiles", ceph_vxattrcb_rfiles},
-	{ true, XATTR_CEPH_PREFIX "dir.rsubdirs", ceph_vxattrcb_rsubdirs},
-	{ true, XATTR_CEPH_PREFIX "dir.rbytes", ceph_vxattrcb_rbytes},
-	{ true, XATTR_CEPH_PREFIX "dir.rctime", ceph_vxattrcb_rctime},
-	{ true, NULL, NULL }
+	XATTR_NAME_CEPH(dir, entries),
+	XATTR_NAME_CEPH(dir, files),
+	XATTR_NAME_CEPH(dir, subdirs),
+	XATTR_NAME_CEPH(dir, rentries),
+	XATTR_NAME_CEPH(dir, rfiles),
+	XATTR_NAME_CEPH(dir, rsubdirs),
+	XATTR_NAME_CEPH(dir, rbytes),
+	XATTR_NAME_CEPH(dir, rctime),
+	{ 0 }	/* Required table terminator */
  };

  /* files */
@@ -114,10 +123,14 @@ static size_t ceph_vxattrcb_layout(struct 
ceph_inode_info *ci, char *val,
  }

  static struct ceph_vxattr_cb ceph_file_vxattrs[] = {
-	{ true, XATTR_CEPH_PREFIX "file.layout", ceph_vxattrcb_layout},
+	XATTR_NAME_CEPH(file, layout),
  	/* The following extended attribute name is deprecated */
-	{ true, XATTR_CEPH_PREFIX "layout", ceph_vxattrcb_layout},
-	{ true, NULL, NULL }
+	{
+		.name = XATTR_CEPH_PREFIX "layout",
+		.getxattr_cb = ceph_vxattrcb_layout,
+		.readonly = true,
+	},
+	{ 0 }	/* Required table terminator */
  };

  static struct ceph_vxattr_cb *ceph_inode_vxattrs(struct inode *inode)
-- 
1.7.5.4

