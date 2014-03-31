From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] fuse: differentiate getattr that is for permission check
Date: Mon, 31 Mar 2014 15:28:58 +0800
Message-ID: <1396250938-18904-2-git-send-email-zheng.z.yan@intel.com>
References: <1396250938-18904-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4290 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbaCaH3E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 Mar 2014 03:29:04 -0400
In-Reply-To: <1396250938-18904-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: fuse-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org
Cc: mszeredi@suse.cz, "Yan, Zheng" <zheng.z.yan@intel.com>

Introduce a new flag FUSE_GETATTR_PERM. The flag allows user space
daemon to differentiate getattr that is for permission check from
real getattr. When getattr is for permission check, the user space
daemon does not need to provide accurate size/ctime/mtime of inode.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/fuse/dir.c             | 9 +++++----
 include/uapi/linux/fuse.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1d1292c..a4018ed 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -865,7 +865,7 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 }
 
 static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
-			   struct file *file)
+			   struct file *file, unsigned flags)
 {
 	int err;
 	struct fuse_getattr_in inarg;
@@ -886,9 +886,10 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	if (file && S_ISREG(inode->i_mode)) {
 		struct fuse_file *ff = file->private_data;
 
-		inarg.getattr_flags |= FUSE_GETATTR_FH;
 		inarg.fh = ff->fh;
+		flags |= FUSE_GETATTR_FH;
 	}
+	inarg.getattr_flags |= flags;
 	req->in.h.opcode = FUSE_GETATTR;
 	req->in.h.nodeid = get_node_id(inode);
 	req->in.numargs = 1;
@@ -927,7 +928,7 @@ int fuse_update_attributes(struct inode *inode, struct kstat *stat,
 
 	if (fi->i_time < get_jiffies_64()) {
 		r = true;
-		err = fuse_do_getattr(inode, stat, file);
+		err = fuse_do_getattr(inode, stat, file, 0);
 	} else {
 		r = false;
 		err = 0;
@@ -1079,7 +1080,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
-	return fuse_do_getattr(inode, NULL, NULL);
+	return fuse_do_getattr(inode, NULL, NULL, FUSE_GETATTR_PERM);
 }
 
 /*
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 60bb2f9..f888f7c 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -254,6 +254,7 @@ struct fuse_file_lock {
  * Getattr flags
  */
 #define FUSE_GETATTR_FH		(1 << 0)
+#define FUSE_GETATTR_PERM	(1 << 1)
 
 /**
  * Lock flags
-- 
1.8.5.3

