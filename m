From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/3] ceph: fix pending vmtruncate race
Date: Tue,  2 Jul 2013 12:40:19 +0800
Message-ID: <1372740021-7980-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50682 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203Ab3GBEk1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Jul 2013 00:40:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The locking order for pending vmtruncate is wrong, it can lead to
following race:

        write                  wmtruncate work
------------------------    ----------------------
lock i_mutex
check i_truncate_pending   check i_truncate_pending
truncate_inode_pages()     lock i_mutex (blocked)
copy data to page cache
unlock i_mutex
                           truncate_inode_pages()

The fix is take i_mutex before calling __ceph_do_pending_vmtruncate()

Fixes: #5453
Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c  |  6 +++++-
 fs/ceph/file.c  |  2 +-
 fs/ceph/inode.c | 14 ++++++--------
 fs/ceph/super.h |  2 +-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 8ec27b1..16266f3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2057,7 +2057,11 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 	/* finish pending truncate */
 	while (ci->i_truncate_pending) {
 		spin_unlock(&ci->i_ceph_lock);
-		__ceph_do_pending_vmtruncate(inode, !(need & CEPH_CAP_FILE_WR));
+		if (!(need & CEPH_CAP_FILE_WR))
+			mutex_lock(&inode->i_mutex);
+		__ceph_do_pending_vmtruncate(inode);
+		if (!(need & CEPH_CAP_FILE_WR))
+			mutex_unlock(&inode->i_mutex);
 		spin_lock(&ci->i_ceph_lock);
 	}
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7c69f4f..a44d515 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -822,7 +822,7 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 	int ret;
 
 	mutex_lock(&inode->i_mutex);
-	__ceph_do_pending_vmtruncate(inode, false);
+	__ceph_do_pending_vmtruncate(inode);
 
 	if (whence == SEEK_END || whence == SEEK_DATA || whence == SEEK_HOLE) {
 		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index be0f7e2..4906ada 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1465,7 +1465,9 @@ static void ceph_vmtruncate_work(struct work_struct *work)
 	struct inode *inode = &ci->vfs_inode;
 
 	dout("vmtruncate_work %p\n", inode);
-	__ceph_do_pending_vmtruncate(inode, true);
+	mutex_lock(&inode->i_mutex);
+	__ceph_do_pending_vmtruncate(inode);
+	mutex_unlock(&inode->i_mutex);
 	iput(inode);
 }
 
@@ -1492,7 +1494,7 @@ void ceph_queue_vmtruncate(struct inode *inode)
  * Make sure any pending truncation is applied before doing anything
  * that may depend on it.
  */
-void __ceph_do_pending_vmtruncate(struct inode *inode, bool needlock)
+void __ceph_do_pending_vmtruncate(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 to;
@@ -1525,11 +1527,7 @@ retry:
 	     ci->i_truncate_pending, to);
 	spin_unlock(&ci->i_ceph_lock);
 
-	if (needlock)
-		mutex_lock(&inode->i_mutex);
 	truncate_inode_pages(inode->i_mapping, to);
-	if (needlock)
-		mutex_unlock(&inode->i_mutex);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (to == ci->i_truncate_size) {
@@ -1588,7 +1586,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
-	__ceph_do_pending_vmtruncate(inode, false);
+	__ceph_do_pending_vmtruncate(inode);
 
 	err = inode_change_ok(inode, attr);
 	if (err != 0)
@@ -1770,7 +1768,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	     ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
-	__ceph_do_pending_vmtruncate(inode, false);
+	__ceph_do_pending_vmtruncate(inode);
 	return err;
 out:
 	spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index dfbb729..cbded57 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -692,7 +692,7 @@ extern int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 extern int ceph_inode_holds_cap(struct inode *inode, int mask);
 
 extern int ceph_inode_set_size(struct inode *inode, loff_t size);
-extern void __ceph_do_pending_vmtruncate(struct inode *inode, bool needlock);
+extern void __ceph_do_pending_vmtruncate(struct inode *inode);
 extern void ceph_queue_vmtruncate(struct inode *inode);
 
 extern void ceph_queue_invalidate(struct inode *inode);
-- 
1.8.1.4

