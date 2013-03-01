From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/7] ceph: revert commit 22cddde104
Date: Fri,  1 Mar 2013 14:46:22 +0800
Message-ID: <1362120384-5188-6-git-send-email-zheng.z.yan@intel.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58983 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3CAGqd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Mar 2013 01:46:33 -0500
In-Reply-To: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

commit 22cddde104 breaks the atomicity of write operation, it also
introduces a deadlock between write and truncate.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/addr.c       | 51 +++---------------------------------
 fs/ceph/file.c       | 73 +++++++++++++++++++++++++++++++---------------------
 fs/ceph/mds_client.c |  1 +
 3 files changed, 48 insertions(+), 77 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cfef3e0..d662025 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1067,51 +1067,23 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 			    struct page **pagep, void **fsdata)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_file_info *fi = file->private_data;
 	struct page *page;
 	pgoff_t index = pos >> PAGE_CACHE_SHIFT;
-	int r, want, got = 0;
-
-	if (fi->fmode & CEPH_FILE_MODE_LAZY)
-		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
-	else
-		want = CEPH_CAP_FILE_BUFFER;
-
-	dout("write_begin %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
-	     inode, ceph_vinop(inode), pos, len, inode->i_size);
-	r = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, pos+len);
-	if (r < 0)
-		return r;
-	dout("write_begin %p %llx.%llx %llu~%u  got cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos, len, ceph_cap_string(got));
-	if (!(got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO))) {
-		ceph_put_cap_refs(ci, got);
-		return -EAGAIN;
-	}
+	int r;
 
 	do {
 		/* get a page */
 		page = grab_cache_page_write_begin(mapping, index, 0);
-		if (!page) {
-			r = -ENOMEM;
-			break;
-		}
+		if (!page)
+			return -ENOMEM;
+		*pagep = page;
 
 		dout("write_begin file %p inode %p page %p %d~%d\n", file,
 		     inode, page, (int)pos, (int)len);
 
 		r = ceph_update_writeable_page(file, pos, len, page);
-		if (r)
-			page_cache_release(page);
 	} while (r == -EAGAIN);
 
-	if (r) {
-		ceph_put_cap_refs(ci, got);
-	} else {
-		*pagep = page;
-		*(int *)fsdata = got;
-	}
 	return r;
 }
 
@@ -1125,12 +1097,10 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 			  struct page *page, void *fsdata)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	unsigned from = pos & (PAGE_CACHE_SIZE - 1);
 	int check_cap = 0;
-	int got = (unsigned long)fsdata;
 
 	dout("write_end file %p inode %p page %p %d~%d (%d)\n", file,
 	     inode, page, (int)pos, (int)copied, (int)len);
@@ -1153,19 +1123,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 	up_read(&mdsc->snap_rwsem);
 	page_cache_release(page);
 
-	if (copied > 0) {
-		int dirty;
-		spin_lock(&ci->i_ceph_lock);
-		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
-		spin_unlock(&ci->i_ceph_lock);
-		if (dirty)
-			__mark_inode_dirty(inode, dirty);
-	}
-
-	dout("write_end %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos, len, ceph_cap_string(got));
-	ceph_put_cap_refs(ci, got);
-
 	if (check_cap)
 		ceph_check_caps(ceph_inode(inode), CHECK_CAPS_AUTHONLY, NULL);
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 9c4325e..a949805 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -718,53 +718,63 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
 	struct ceph_osd_client *osdc =
 		&ceph_sb_to_client(inode->i_sb)->client->osdc;
 	loff_t endoff = pos + iov->iov_len;
-	int got = 0;
-	int ret, err, written;
+	int want, got = 0;
+	int ret, err;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
 retry_snap:
-	written = 0;
 	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
 		return -ENOSPC;
 	__ceph_do_pending_vmtruncate(inode);
+	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
+	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
+	     inode->i_size);
+	if (fi->fmode & CEPH_FILE_MODE_LAZY)
+		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
+	else
+		want = CEPH_CAP_FILE_BUFFER;
+	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, endoff);
+	if (ret < 0)
+		goto out_put;
 
-	/*
-	 * try to do a buffered write.  if we don't have sufficient
-	 * caps, we'll get -EAGAIN from generic_file_aio_write, or a
-	 * short write if we only get caps for some pages.
-	 */
-	if (!(iocb->ki_filp->f_flags & O_DIRECT) &&
-	    !(inode->i_sb->s_flags & MS_SYNCHRONOUS) &&
-	    !(fi->flags & CEPH_F_SYNC)) {
-		ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
-		if (ret >= 0)
-			written = ret;
+	dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
+	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
+	     ceph_cap_string(got));
+
+	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
+	    (iocb->ki_filp->f_flags & O_DIRECT) ||
+	    (inode->i_sb->s_flags & MS_SYNCHRONOUS) ||
+	    (fi->flags & CEPH_F_SYNC)) {
+		ret = ceph_sync_write(file, iov->iov_base, iov->iov_len,
+			&iocb->ki_pos);
+	} else {
+		/*
+		 * buffered write; drop Fw early to avoid slow
+		 * revocation if we get stuck on balance_dirty_pages
+		 */
+		int dirty;
 
+		spin_lock(&ci->i_ceph_lock);
+		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
+		spin_unlock(&ci->i_ceph_lock);
+		ceph_put_cap_refs(ci, got);
+
+		ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
 		if ((ret >= 0 || ret == -EIOCBQUEUED) &&
 		    ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->host)
 		     || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) {
-			err = vfs_fsync_range(file, pos, pos + written - 1, 1);
+			err = vfs_fsync_range(file, pos, pos + ret - 1, 1);
 			if (err < 0)
 				ret = err;
 		}
-		if ((ret < 0 && ret != -EAGAIN) || pos + written >= endoff)
-			goto out;
-	}
 
-	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
-	     inode, ceph_vinop(inode), pos + written,
-	     (unsigned)iov->iov_len - written, inode->i_size);
-	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, 0, &got, endoff);
-	if (ret < 0)
+		if (dirty)
+			__mark_inode_dirty(inode, dirty);
 		goto out;
+	}
 
-	dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos + written,
-	     (unsigned)iov->iov_len - written, ceph_cap_string(got));
-	ret = ceph_sync_write(file, iov->iov_base + written,
-			      iov->iov_len - written, &iocb->ki_pos);
 	if (ret >= 0) {
 		int dirty;
 		spin_lock(&ci->i_ceph_lock);
@@ -773,10 +783,13 @@ retry_snap:
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
 	}
+
+out_put:
 	dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos + written,
-	     (unsigned)iov->iov_len - written, ceph_cap_string(got));
+	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
+	     ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
+
 out:
 	if (ret == -EOLDSNAPC) {
 		dout("aio_write %p %llx.%llx %llu~%u got EOLDSNAPC, retrying\n",
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e52b0fb..ab899c8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1916,6 +1916,7 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 		req = list_entry(tmp_list.next,
 				 struct ceph_mds_request, r_wait);
 		list_del_init(&req->r_wait);
+		dout(" wake request %p tid %llu\n", req, req->r_tid);
 		__do_request(mdsc, req);
 	}
 }
-- 
1.7.11.7

