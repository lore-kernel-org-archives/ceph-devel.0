From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: request xattrs if xattr_version is zero
Date: Tue, 16 Sep 2014 15:10:53 +0800
Message-ID: <1410851453-11107-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbaIPHLF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Sep 2014 03:11:05 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8G7B5UR029206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 16 Sep 2014 03:11:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

Following sequence of events can happen.
 - Client releases an inode, queues cap release message.
 - A 'lookup' reply brings the same inode back, but the reply
   doesn't contain xattrs because MDS didn't receive the cap release
   message and thought client already has up-to-data xattrs.

The fix is force sending a getattr request to MDS if xattrs_version is 0.
The getattr mask is set to CEPH_STAT_CAP_XATTR, so MDS knows client does
not have xattr.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/file.c  |  5 ++---
 fs/ceph/inode.c |  8 ++++----
 fs/ceph/ioctl.c |  4 ++--
 fs/ceph/super.h |  2 +-
 fs/ceph/xattr.c | 29 ++++++++++-------------------
 5 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 46a0525f..bf926fb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -841,8 +841,7 @@ again:
 	ceph_put_cap_refs(ci, got);
 
 	if (checkeof && ret >= 0) {
-		int statret = ceph_do_getattr(inode,
-					      CEPH_STAT_CAP_SIZE);
+		int statret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
 
 		/* hit EOF or hole? */
 		if (statret == 0 && iocb->ki_pos < inode->i_size &&
@@ -1010,7 +1009,7 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 	mutex_lock(&inode->i_mutex);
 
 	if (whence == SEEK_END || whence == SEEK_DATA || whence == SEEK_HOLE) {
-		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE);
+		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
 		if (ret < 0) {
 			offset = ret;
 			goto out;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 04c89c2..40e6289 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1907,7 +1907,7 @@ out_put:
  * Verify that we have a lease on the given mask.  If not,
  * do a getattr against an mds.
  */
-int ceph_do_getattr(struct inode *inode, int mask)
+int ceph_do_getattr(struct inode *inode, int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1920,7 +1920,7 @@ int ceph_do_getattr(struct inode *inode, int mask)
 	}
 
 	dout("do_getattr inode %p mask %s mode 0%o\n", inode, ceph_cap_string(mask), inode->i_mode);
-	if (ceph_caps_issued_mask(ceph_inode(inode), mask, 1))
+	if (!force && ceph_caps_issued_mask(ceph_inode(inode), mask, 1))
 		return 0;
 
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, USE_ANY_MDS);
@@ -1948,7 +1948,7 @@ int ceph_permission(struct inode *inode, int mask)
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
-	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED);
+	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
 		err = generic_permission(inode, mask);
@@ -1966,7 +1966,7 @@ int ceph_getattr(struct vfsmount *mnt, struct dentry *dentry,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int err;
 
-	err = ceph_do_getattr(inode, CEPH_STAT_CAP_INODE_ALL);
+	err = ceph_do_getattr(inode, CEPH_STAT_CAP_INODE_ALL, false);
 	if (!err) {
 		generic_fillattr(inode, stat);
 		stat->ino = ceph_translate_ino(inode->i_sb, inode->i_ino);
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index a822a6e..d7dc812 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -19,7 +19,7 @@ static long ceph_ioctl_get_layout(struct file *file, void __user *arg)
 	struct ceph_ioctl_layout l;
 	int err;
 
-	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT);
+	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
 	if (!err) {
 		l.stripe_unit = ceph_file_layout_su(ci->i_layout);
 		l.stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
@@ -74,7 +74,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 		return -EFAULT;
 
 	/* validate changed params against current layout */
-	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT);
+	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
 	if (err)
 		return err;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 0cfb1ec..8405a79 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -714,7 +714,7 @@ extern void ceph_queue_vmtruncate(struct inode *inode);
 extern void ceph_queue_invalidate(struct inode *inode);
 extern void ceph_queue_writeback(struct inode *inode);
 
-extern int ceph_do_getattr(struct inode *inode, int mask);
+extern int ceph_do_getattr(struct inode *inode, int mask, bool force);
 extern int ceph_permission(struct inode *inode, int mask);
 extern int ceph_setattr(struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct vfsmount *mnt, struct dentry *dentry,
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 12f58d2..eab3e2f 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -736,24 +736,20 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	dout("getxattr %p ver=%lld index_ver=%lld\n", inode,
 	     ci->i_xattrs.version, ci->i_xattrs.index_version);
 
-	if (__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 1) &&
-	    (ci->i_xattrs.index_version >= ci->i_xattrs.version)) {
-		goto get_xattr;
-	} else {
+	if (ci->i_xattrs.version == 0 ||
+	    !__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 1)) {
 		spin_unlock(&ci->i_ceph_lock);
 		/* get xattrs from mds (if we don't already have them) */
-		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR);
+		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true);
 		if (err)
 			return err;
+		spin_lock(&ci->i_ceph_lock);
 	}
 
-	spin_lock(&ci->i_ceph_lock);
-
 	err = __build_xattrs(inode);
 	if (err < 0)
 		goto out;
 
-get_xattr:
 	err = -ENODATA;  /* == ENOATTR */
 	xattr = __get_xattr(ci, name);
 	if (!xattr)
@@ -798,23 +794,18 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	dout("listxattr %p ver=%lld index_ver=%lld\n", inode,
 	     ci->i_xattrs.version, ci->i_xattrs.index_version);
 
-	if (__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 1) &&
-	    (ci->i_xattrs.index_version >= ci->i_xattrs.version)) {
-		goto list_xattr;
-	} else {
+	if (ci->i_xattrs.version == 0 ||
+	    !__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 1)) {
 		spin_unlock(&ci->i_ceph_lock);
-		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR);
+		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true);
 		if (err)
 			return err;
+		spin_lock(&ci->i_ceph_lock);
 	}
 
-	spin_lock(&ci->i_ceph_lock);
-
 	err = __build_xattrs(inode);
 	if (err < 0)
 		goto out;
-
-list_xattr:
 	/*
 	 * Start with virtual dir xattr names (if any) (including
 	 * terminating '\0' characters for each).
@@ -968,7 +959,7 @@ int __ceph_setxattr(struct dentry *dentry, const char *name,
 retry:
 	issued = __ceph_caps_issued(ci, NULL);
 	dout("setxattr %p issued %s\n", inode, ceph_cap_string(issued));
-	if (!(issued & CEPH_CAP_XATTR_EXCL))
+	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
 		goto do_sync;
 	__build_xattrs(inode);
 
@@ -1077,7 +1068,7 @@ retry:
 	issued = __ceph_caps_issued(ci, NULL);
 	dout("removexattr %p issued %s\n", inode, ceph_cap_string(issued));
 
-	if (!(issued & CEPH_CAP_XATTR_EXCL))
+	if (ci->i_xattrs.version == 0 && !(issued & CEPH_CAP_XATTR_EXCL))
 		goto do_sync;
 	__build_xattrs(inode);
 
-- 
1.9.3

