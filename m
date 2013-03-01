From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 6/7] ceph: don't early drop Fw cap
Date: Fri,  1 Mar 2013 14:46:23 +0800
Message-ID: <1362120384-5188-7-git-send-email-zheng.z.yan@intel.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12200 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3CAGqf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Mar 2013 01:46:35 -0500
In-Reply-To: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

ceph_aio_write() has an optimization that marks CEPH_CAP_FILE_WR
cap dirty before data is copied to page cache and inode size is
updated. The optimization avoids slow cap revocation caused by
balance_dirty_pages(), but introduces inode size update race. If
ceph_check_caps() flushes the dirty cap before the inode size is
updated, MDS can miss the new inode size. So just remove the
optimization.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/file.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a949805..28ef273 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -724,9 +724,12 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
+	sb_start_write(inode->i_sb);
 retry_snap:
-	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
-		return -ENOSPC;
+	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL)) {
+		ret = -ENOSPC;
+		goto out;
+	}
 	__ceph_do_pending_vmtruncate(inode);
 	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
 	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
@@ -750,29 +753,10 @@ retry_snap:
 		ret = ceph_sync_write(file, iov->iov_base, iov->iov_len,
 			&iocb->ki_pos);
 	} else {
-		/*
-		 * buffered write; drop Fw early to avoid slow
-		 * revocation if we get stuck on balance_dirty_pages
-		 */
-		int dirty;
-
-		spin_lock(&ci->i_ceph_lock);
-		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
-		spin_unlock(&ci->i_ceph_lock);
-		ceph_put_cap_refs(ci, got);
-
-		ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
-		if ((ret >= 0 || ret == -EIOCBQUEUED) &&
-		    ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->host)
-		     || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) {
-			err = vfs_fsync_range(file, pos, pos + ret - 1, 1);
-			if (err < 0)
-				ret = err;
-		}
-
-		if (dirty)
-			__mark_inode_dirty(inode, dirty);
-		goto out;
+		mutex_lock(&inode->i_mutex);
+		ret = __generic_file_aio_write(iocb, iov, nr_segs,
+					       &iocb->ki_pos);
+		mutex_unlock(&inode->i_mutex);
 	}
 
 	if (ret >= 0) {
@@ -790,12 +774,20 @@ out_put:
 	     ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
 
+	if (ret >= 0 &&
+	    ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->host) ||
+	     ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) {
+		err = vfs_fsync_range(file, pos, pos + ret - 1, 1);
+		if (err < 0)
+			ret = err;
+	}
 out:
 	if (ret == -EOLDSNAPC) {
 		dout("aio_write %p %llx.%llx %llu~%u got EOLDSNAPC, retrying\n",
 		     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len);
 		goto retry_snap;
 	}
+	sb_end_write(inode->i_sb);
 
 	return ret;
 }
-- 
1.7.11.7

