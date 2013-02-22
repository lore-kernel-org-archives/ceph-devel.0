From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/3] ceph: fix vmtruncate deadlock
Date: Fri, 22 Feb 2013 10:08:19 +0800
Message-ID: <1361498899-15831-4-git-send-email-zheng.z.yan@intel.com>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37776 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728Ab3BVCI2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Feb 2013 21:08:28 -0500
In-Reply-To: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If there is pending truncation, ceph_get_caps() waits for a work thread
to apply it. To apply pending truncation, the work thread needs acquire
i_mutex. But in the buffered write case, ceph_get_caps() is called while
i_mutex is locked. So the writer and the work thread wait for each other

The fix is make ceph_get_caps() not wait, apply pending truncation in
ceph_aio_write() instead.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c |  6 ------
 fs/ceph/file.c | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 5d5c32b..b9d8417 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2067,12 +2067,6 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 	}
 	have = __ceph_caps_issued(ci, &implemented);
 
-	/*
-	 * disallow writes while a truncate is pending
-	 */
-	if (ci->i_truncate_pending)
-		have &= ~CEPH_CAP_FILE_WR;
-
 	if ((have & need) == need) {
 		/*
 		 * Look at (implemented & ~have & not) so that we keep waiting
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a1e5b81..bf7849a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -653,7 +653,6 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
 	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
 	     inode, ceph_vinop(inode), pos, (unsigned)len, inode);
 again:
-	__ceph_do_pending_vmtruncate(inode);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -724,11 +723,13 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
+	sb_start_write(inode->i_sb);
 retry_snap:
 	written = 0;
-	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
-		return -ENOSPC;
-	__ceph_do_pending_vmtruncate(inode);
+	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL)) {
+		ret = -ENOSPC;
+		goto out;
+	}
 
 	/*
 	 * try to do a buffered write.  if we don't have sufficient
@@ -738,7 +739,10 @@ retry_snap:
 	if (!(iocb->ki_filp->f_flags & O_DIRECT) &&
 	    !(inode->i_sb->s_flags & MS_SYNCHRONOUS) &&
 	    !(fi->flags & CEPH_F_SYNC)) {
-		ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
+		mutex_lock(&inode->i_mutex);
+		__ceph_do_pending_vmtruncate(inode);
+		ret = __generic_file_aio_write(iocb, iov, nr_segs, &iocb->ki_pos);
+		mutex_unlock(&inode->i_mutex);
 		if (ret >= 0)
 			written = ret;
 
@@ -783,6 +787,7 @@ out:
 		     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len);
 		goto retry_snap;
 	}
+	sb_end_write(inode->i_sb);
 
 	return ret;
 }
-- 
1.7.11.7

