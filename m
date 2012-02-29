From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/6] ceph: use a symbolic name for "ceph." extended attribute
 namespace
Date: Tue, 28 Feb 2012 19:21:43 -0800
Message-ID: <4F4D99C7.8010000@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38137 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab2B2DVo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:21:44 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 04C5424322
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:44 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E831C24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:21:43 -0800 (PST)
In-Reply-To: <4F4D98D5.1010506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Use symbolic constants to define the top-level prefix for "ceph."
extended attribute names.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |   25 ++++++++++++++-----------
  1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index bec9c30..21ee6aa 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -8,9 +8,12 @@
  #include <linux/xattr.h>
  #include <linux/slab.h>

+#define XATTR_CEPH_PREFIX "ceph."
+#define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
+
  static bool ceph_is_valid_xattr(const char *name)
  {
-	return !strncmp(name, "ceph.", 5) ||
+	return !strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN) ||
  	       !strncmp(name, XATTR_SECURITY_PREFIX,
  			XATTR_SECURITY_PREFIX_LEN) ||
  	       !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) ||
@@ -80,14 +83,14 @@ static size_t ceph_vxattrcb_rctime(struct 
ceph_inode_info *ci, char *val,
  }

  static struct ceph_vxattr_cb ceph_dir_vxattrs[] = {
-	{ true, "ceph.dir.entries", ceph_vxattrcb_entries},
-	{ true, "ceph.dir.files", ceph_vxattrcb_files},
-	{ true, "ceph.dir.subdirs", ceph_vxattrcb_subdirs},
-	{ true, "ceph.dir.rentries", ceph_vxattrcb_rentries},
-	{ true, "ceph.dir.rfiles", ceph_vxattrcb_rfiles},
-	{ true, "ceph.dir.rsubdirs", ceph_vxattrcb_rsubdirs},
-	{ true, "ceph.dir.rbytes", ceph_vxattrcb_rbytes},
-	{ true, "ceph.dir.rctime", ceph_vxattrcb_rctime},
+	{ true, XATTR_CEPH_PREFIX "dir.entries", ceph_vxattrcb_entries},
+	{ true, XATTR_CEPH_PREFIX "dir.files", ceph_vxattrcb_files},
+	{ true, XATTR_CEPH_PREFIX "dir.subdirs", ceph_vxattrcb_subdirs},
+	{ true, XATTR_CEPH_PREFIX "dir.rentries", ceph_vxattrcb_rentries},
+	{ true, XATTR_CEPH_PREFIX "dir.rfiles", ceph_vxattrcb_rfiles},
+	{ true, XATTR_CEPH_PREFIX "dir.rsubdirs", ceph_vxattrcb_rsubdirs},
+	{ true, XATTR_CEPH_PREFIX "dir.rbytes", ceph_vxattrcb_rbytes},
+	{ true, XATTR_CEPH_PREFIX "dir.rctime", ceph_vxattrcb_rctime},
  	{ true, NULL, NULL }
  };

@@ -111,9 +114,9 @@ static size_t ceph_vxattrcb_layout(struct 
ceph_inode_info *ci, char *val,
  }

  static struct ceph_vxattr_cb ceph_file_vxattrs[] = {
-	{ true, "ceph.file.layout", ceph_vxattrcb_layout},
+	{ true, XATTR_CEPH_PREFIX "file.layout", ceph_vxattrcb_layout},
  	/* The following extended attribute name is deprecated */
-	{ true, "ceph.layout", ceph_vxattrcb_layout},
+	{ true, XATTR_CEPH_PREFIX "layout", ceph_vxattrcb_layout},
  	{ true, NULL, NULL }
  };

-- 
1.7.5.4

