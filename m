From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 7/7] ceph: acquire i_mutex in __ceph_do_pending_vmtruncate
Date: Fri,  1 Mar 2013 14:46:24 +0800
Message-ID: <1362120384-5188-8-git-send-email-zheng.z.yan@intel.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12200 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab3CAGqi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Mar 2013 01:46:38 -0500
In-Reply-To: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

make __ceph_do_pending_vmtruncate() acquire i_mutex if the caller
does not hold the mutex, so ceph_aio_read() can call it safely.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/file.c  |  6 +++---
 fs/ceph/inode.c | 18 +++++++++---------
 fs/ceph/super.h |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 28ef273..b9eedd4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -653,7 +653,7 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
 	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
 	     inode, ceph_vinop(inode), pos, (unsigned)len, inode);
 again:
-	__ceph_do_pending_vmtruncate(inode);
+	__ceph_do_pending_vmtruncate(inode, true);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -730,7 +730,7 @@ retry_snap:
 		ret = -ENOSPC;
 		goto out;
 	}
-	__ceph_do_pending_vmtruncate(inode);
+	__ceph_do_pending_vmtruncate(inode, true);
 	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
 	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
 	     inode->i_size);
@@ -801,7 +801,7 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 	int ret;
 
 	mutex_lock(&inode->i_mutex);
-	__ceph_do_pending_vmtruncate(inode);
+	__ceph_do_pending_vmtruncate(inode, false);
 
 	if (whence == SEEK_END || whence == SEEK_DATA || whence == SEEK_HOLE) {
 		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 42c5769..2b3fee7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1416,7 +1416,7 @@ out:
 
 
 /*
- * called by trunc_wq; take i_mutex ourselves
+ * called by trunc_wq;
  *
  * We also truncate in a separate thread as well.
  */
@@ -1427,9 +1427,7 @@ static void ceph_vmtruncate_work(struct work_struct *work)
 	struct inode *inode = &ci->vfs_inode;
 
 	dout("vmtruncate_work %p\n", inode);
-	mutex_lock(&inode->i_mutex);
-	__ceph_do_pending_vmtruncate(inode);
-	mutex_unlock(&inode->i_mutex);
+	__ceph_do_pending_vmtruncate(inode, true);
 	iput(inode);
 }
 
@@ -1453,12 +1451,10 @@ void ceph_queue_vmtruncate(struct inode *inode)
 }
 
 /*
- * called with i_mutex held.
- *
  * Make sure any pending truncation is applied before doing anything
  * that may depend on it.
  */
-void __ceph_do_pending_vmtruncate(struct inode *inode)
+void __ceph_do_pending_vmtruncate(struct inode *inode, bool needlock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 to;
@@ -1491,7 +1487,11 @@ retry:
 	     ci->i_truncate_pending, to);
 	spin_unlock(&ci->i_ceph_lock);
 
+	if (needlock)
+		mutex_lock(&inode->i_mutex);
 	truncate_inode_pages(inode->i_mapping, to);
+	if (needlock)
+		mutex_unlock(&inode->i_mutex);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (to == ci->i_truncate_size) {
@@ -1544,7 +1544,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
-	__ceph_do_pending_vmtruncate(inode);
+	__ceph_do_pending_vmtruncate(inode, false);
 
 	err = inode_change_ok(inode, attr);
 	if (err != 0)
@@ -1722,7 +1722,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	     ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
-	__ceph_do_pending_vmtruncate(inode);
+	__ceph_do_pending_vmtruncate(inode, false);
 	return err;
 out:
 	spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index efbcb56..e5f1875 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -694,7 +694,7 @@ extern int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 extern int ceph_inode_holds_cap(struct inode *inode, int mask);
 
 extern int ceph_inode_set_size(struct inode *inode, loff_t size);
-extern void __ceph_do_pending_vmtruncate(struct inode *inode);
+extern void __ceph_do_pending_vmtruncate(struct inode *inode, bool needlock);
 extern void ceph_queue_vmtruncate(struct inode *inode);
 
 extern void ceph_queue_invalidate(struct inode *inode);
-- 
1.7.11.7

