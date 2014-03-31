From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] differentiate getattr that is for permission check
Date: Mon, 31 Mar 2014 15:28:57 +0800
Message-ID: <1396250938-18904-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4290 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbaCaH3C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 Mar 2014 03:29:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: fuse-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org
Cc: mszeredi@suse.cz, "Yan, Zheng" <zheng.z.yan@intel.com>

Introduce a new flag FUSE_GETATTR_PERM for getattr request. The flag
indicates that the getattr request is for permission check. When getattr
is for permission check, the user space daemon does not need to provide
accurate size/ctime/mtime.

This optimization is for Ceph fuse client. When a directory is accessed
by multiple clients, getting accurate size/ctime/mtime of inode can be
slow.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 include/fuse_common.h | 8 ++++++--
 include/fuse_kernel.h | 1 +
 lib/fuse_lowlevel.c   | 7 +++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/fuse_common.h b/include/fuse_common.h
index 22d9591..19cc13f 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -34,7 +34,7 @@ extern "C" {
 /**
  * Information about open files
  *
- * Changed in version 3.0
+ * Changed in version 3.1
  */
 struct fuse_file_info {
 	/** Open flags.	 Available in open() and release() */
@@ -67,8 +67,12 @@ struct fuse_file_info {
 	   2.9 */
 	unsigned int flock_release : 1;
 
+	/* Indicates that the getattr request is for inode permission
+	 * check. Introduced in version 3.1 */
+	unsigned int getattr_perm : 1;
+
 	/** Padding.  Do not use*/
-	unsigned int padding : 27;
+	unsigned int padding : 26;
 
 	/** File handle.  May be filled in by filesystem in open().
 	    Available in all other file operations */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 7974721..a88d134 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -259,6 +259,7 @@ struct fuse_file_lock {
  * Getattr flags
  */
 #define FUSE_GETATTR_FH		(1 << 0)
+#define FUSE_GETATTR_PERM	(1 << 1)
 
 /**
  * Lock flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 4284535..8b203e7 100755
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -1136,11 +1136,14 @@ static void do_getattr(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 	if (req->f->conn.proto_minor >= 9) {
 		struct fuse_getattr_in *arg = (struct fuse_getattr_in *) inarg;
 
-		if (arg->getattr_flags & FUSE_GETATTR_FH) {
+		if (arg->getattr_flags) {
 			memset(&fi, 0, sizeof(fi));
-			fi.fh = arg->fh;
 			fip = &fi;
 		}
+		if (arg->getattr_flags & FUSE_GETATTR_FH)
+			fi.fh = arg->fh;
+		if (arg->getattr_flags & FUSE_GETATTR_PERM)
+			fi.getattr_perm = 1;
 	}
 
 	if (req->f->op.getattr)
-- 
1.8.5.3

