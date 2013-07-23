From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: introduce i_truncate_mutex
Date: Tue, 23 Jul 2013 16:24:36 +0800
Message-ID: <1374567876-24160-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52189 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821Ab3GWIYj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Jul 2013 04:24:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, viro@zeniv.linux.org.uk, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

I encountered below deadlock when running fsstress

wmtruncate work      truncate                 MDS
---------------  ------------------  --------------------------
                   lock i_mutex
                                      <- truncate file
lock i_mutex (blocked)
                                      <- issue Fcb caps
                                      <- revoking Fcb (filelock to MIX)
                   send request ->
                                         handle request (xlock filelock)

At the initial time, there are some dirty pages in the page cache.
When the kclient receives the truncate message, it reduces inode size
and creates some 'out of i_size' dirty pages. wmtruncate work can't
truncate these dirty pages because it's blocked by the i_mutex. Later
when the kclient receives the cap message that revokes Fcb caps, It
can't flush all dirty pages because writepages() only flushes dirty
pages within the inode size.

When the MDS handles the 'truncate' request from kclient, it waits
for the filelock to become stable. But the filelock is stuck in
unstable state because it can't finish revoking kclient's Fcb caps.

The truncate pagecache locking has already caused lots of trouble
for use. I think it's time simplify it by introducing a new mutex.
We use the new mutex to prevent concurrent truncate_inode_pages().
There is no need to worry about race between buffered write and
truncate_inode_pages(), because our "get caps" mechanism prevents
them from concurrent execution.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c  |  4 ----
 fs/ceph/file.c  |  8 +++++++-
 fs/ceph/inode.c | 32 ++++++++++++++++++++++----------
 fs/ceph/super.h |  1 +
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 430121a..0e94d27 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2072,11 +2072,7 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 	/* finish pending truncate */
 	while (ci->i_truncate_pending) {
 		spin_unlock(&ci->i_ceph_lock);
-		if (!(need & CEPH_CAP_FILE_WR))
-			mutex_lock(&inode->i_mutex);
 		__ceph_do_pending_vmtruncate(inode);
-		if (!(need & CEPH_CAP_FILE_WR))
-			mutex_unlock(&inode->i_mutex);
 		spin_lock(&ci->i_ceph_lock);
 	}
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a44d515..271a346 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -769,6 +769,13 @@ retry_snap:
 		written = ceph_sync_write(file, iov->iov_base, count,
 					  pos, &iocb->ki_pos);
 	} else {
+		/*
+		 * No need to acquire the i_truncate_mutex. Because
+		 * the MDS revokes Fwb caps before sending truncate
+		 * message to us. We can't get Fwb cap while there
+		 * are pending vmtruncate. So write and vmtruncate
+		 * can not run at the same time
+		 */
 		written = generic_file_buffered_write(iocb, iov, nr_segs,
 						      pos, &iocb->ki_pos,
 						      count, 0);
@@ -822,7 +829,6 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 	int ret;
 
 	mutex_lock(&inode->i_mutex);
-	__ceph_do_pending_vmtruncate(inode);
 
 	if (whence == SEEK_END || whence == SEEK_DATA || whence == SEEK_HOLE) {
 		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4906ada..5437e76 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -344,6 +344,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	for (i = 0; i < CEPH_FILE_MODE_NUM; i++)
 		ci->i_nr_by_mode[i] = 0;
 
+	mutex_init(&ci->i_truncate_mutex);
 	ci->i_truncate_seq = 0;
 	ci->i_truncate_size = 0;
 	ci->i_truncate_pending = 0;
@@ -455,16 +456,20 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			dout("truncate_seq %u -> %u\n",
 			     ci->i_truncate_seq, truncate_seq);
 			ci->i_truncate_seq = truncate_seq;
+
+			/* the MDS should have revoked these caps */
+			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_EXCL |
+					       CEPH_CAP_FILE_RD |
+					       CEPH_CAP_FILE_WR |
+					       CEPH_CAP_FILE_LAZYIO));
 			/*
 			 * If we hold relevant caps, or in the case where we're
 			 * not the only client referencing this file and we
 			 * don't hold those caps, then we need to check whether
 			 * the file is either opened or mmaped
 			 */
-			if ((issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_RD|
-				       CEPH_CAP_FILE_WR|CEPH_CAP_FILE_BUFFER|
-				       CEPH_CAP_FILE_EXCL|
-				       CEPH_CAP_FILE_LAZYIO)) ||
+			if ((issued & (CEPH_CAP_FILE_CACHE|
+				       CEPH_CAP_FILE_BUFFER)) ||
 			    mapping_mapped(inode->i_mapping) ||
 			    __ceph_caps_file_wanted(ci)) {
 				ci->i_truncate_pending++;
@@ -1419,18 +1424,20 @@ static void ceph_invalidate_work(struct work_struct *work)
 	u32 orig_gen;
 	int check = 0;
 
+	mutex_lock(&ci->i_truncate_mutex);
 	spin_lock(&ci->i_ceph_lock);
 	dout("invalidate_pages %p gen %d revoking %d\n", inode,
 	     ci->i_rdcache_gen, ci->i_rdcache_revoking);
 	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
 		/* nevermind! */
 		spin_unlock(&ci->i_ceph_lock);
+		mutex_unlock(&ci->i_truncate_mutex);
 		goto out;
 	}
 	orig_gen = ci->i_rdcache_gen;
 	spin_unlock(&ci->i_ceph_lock);
 
-	truncate_inode_pages(&inode->i_data, 0);
+	truncate_inode_pages(inode->i_mapping, 0);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (orig_gen == ci->i_rdcache_gen &&
@@ -1445,6 +1452,7 @@ static void ceph_invalidate_work(struct work_struct *work)
 		     ci->i_rdcache_revoking);
 	}
 	spin_unlock(&ci->i_ceph_lock);
+	mutex_unlock(&ci->i_truncate_mutex);
 
 	if (check)
 		ceph_check_caps(ci, 0, NULL);
@@ -1465,9 +1473,7 @@ static void ceph_vmtruncate_work(struct work_struct *work)
 	struct inode *inode = &ci->vfs_inode;
 
 	dout("vmtruncate_work %p\n", inode);
-	mutex_lock(&inode->i_mutex);
 	__ceph_do_pending_vmtruncate(inode);
-	mutex_unlock(&inode->i_mutex);
 	iput(inode);
 }
 
@@ -1500,11 +1506,13 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	u64 to;
 	int wrbuffer_refs, finish = 0;
 
+	mutex_lock(&ci->i_truncate_mutex);
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_truncate_pending == 0) {
 		dout("__do_pending_vmtruncate %p none pending\n", inode);
 		spin_unlock(&ci->i_ceph_lock);
+		mutex_unlock(&ci->i_truncate_mutex);
 		return;
 	}
 
@@ -1521,6 +1529,9 @@ retry:
 		goto retry;
 	}
 
+	/* there should be no reader or writer */
+	WARN_ON_ONCE(ci->i_rd_ref || ci->i_wr_ref);
+
 	to = ci->i_truncate_size;
 	wrbuffer_refs = ci->i_wrbuffer_ref;
 	dout("__do_pending_vmtruncate %p (%d) to %lld\n", inode,
@@ -1538,6 +1549,8 @@ retry:
 	if (!finish)
 		goto retry;
 
+	mutex_unlock(&ci->i_truncate_mutex);
+
 	if (wrbuffer_refs == 0)
 		ceph_check_caps(ci, CHECK_CAPS_AUTHONLY, NULL);
 
@@ -1586,8 +1599,6 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
-	__ceph_do_pending_vmtruncate(inode);
-
 	err = inode_change_ok(inode, attr);
 	if (err != 0)
 		return err;
@@ -1768,7 +1779,8 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	     ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
-	__ceph_do_pending_vmtruncate(inode);
+	if (mask & CEPH_SETATTR_SIZE)
+		__ceph_do_pending_vmtruncate(inode);	
 	return err;
 out:
 	spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index cbded57..e81c0b6 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -288,6 +288,7 @@ struct ceph_inode_info {
 
 	int i_nr_by_mode[CEPH_FILE_MODE_NUM];  /* open file counts */
 
+	struct mutex i_truncate_mutex;
 	u32 i_truncate_seq;        /* last truncate to smaller size */
 	u64 i_truncate_size;       /*  and the size we last truncated down to */
 	int i_truncate_pending;    /*  still need to call vmtruncate */
-- 
1.8.1.4

