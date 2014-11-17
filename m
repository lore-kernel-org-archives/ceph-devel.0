From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 07/12] ceph: fetch inline data while getting Fcr cap refs
Date: Mon, 17 Nov 2014 15:57:01 +0800
Message-ID: <1416211026-11524-8-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbaKQH6E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:58:04 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

we can't use getattr to fetch inline data after getting Fcr caps,
because it can cause deadlock. The solution is try bringing inline
data to page cache when not holding any cap, and hope the inline
data page is still there after getting the Fcr caps. If the page
is still there, pin it in page cache for later IO.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c |  9 +++++++--
 fs/ceph/caps.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 fs/ceph/file.c | 12 +++++++++---
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7320b11..fdbdbbe 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1207,6 +1207,7 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	struct inode *inode = file_inode(vma->vm_file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
+	struct page *pinned_page = NULL;
 	loff_t off = vmf->pgoff << PAGE_CACHE_SHIFT;
 	int want, got, ret;
 
@@ -1218,7 +1219,8 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 		want = CEPH_CAP_FILE_CACHE;
 	while (1) {
 		got = 0;
-		ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, &got, -1);
+		ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1,
+				    &got, &pinned_page);
 		if (ret == 0)
 			break;
 		if (ret != -ERESTARTSYS) {
@@ -1233,6 +1235,8 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 
 	dout("filemap_fault %p %llu~%zd dropping cap refs on %s ret %d\n",
 	     inode, off, (size_t)PAGE_CACHE_SIZE, ceph_cap_string(got), ret);
+	if (pinned_page)
+		page_cache_release(pinned_page);
 	ceph_put_cap_refs(ci, got);
 
 	return ret;
@@ -1266,7 +1270,8 @@ static int ceph_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf)
 		want = CEPH_CAP_FILE_BUFFER;
 	while (1) {
 		got = 0;
-		ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, off + len);
+		ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, off + len,
+				    &got, NULL);
 		if (ret == 0)
 			break;
 		if (ret != -ERESTARTSYS) {
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6372eb9..3bc0908 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2057,15 +2057,18 @@ static void __take_cap_refs(struct ceph_inode_info *ci, int got)
  * requested from the MDS.
  */
 static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
-			    int *got, loff_t endoff, int *check_max, int *err)
+			    loff_t endoff, int *got, struct page **pinned_page,
+			    int *check_max, int *err)
 {
 	struct inode *inode = &ci->vfs_inode;
+	struct page *page = NULL;
 	int ret = 0;
-	int have, implemented;
+	int have, implemented, _got = 0;
 	int file_wanted;
 
 	dout("get_cap_refs %p need %s want %s\n", inode,
 	     ceph_cap_string(need), ceph_cap_string(want));
+again:
 	spin_lock(&ci->i_ceph_lock);
 
 	/* make sure file is actually open */
@@ -2120,8 +2123,8 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 		     inode, ceph_cap_string(have), ceph_cap_string(not),
 		     ceph_cap_string(revoking));
 		if ((revoking & not) == 0) {
-			*got = need | (have & want);
-			__take_cap_refs(ci, *got);
+			_got = need | (have & want);
+			__take_cap_refs(ci, _got);
 			ret = 1;
 		}
 	} else {
@@ -2130,8 +2133,42 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 	}
 out:
 	spin_unlock(&ci->i_ceph_lock);
+
+	if ((_got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
+	    ci->i_inline_version != CEPH_INLINE_NONE &&
+	    i_size_read(inode) > 0) {
+		page = find_get_page(inode->i_mapping, 0);
+		if (page) {
+			if (!PageUptodate(page)) {
+				page_cache_release(page);
+				page = NULL;
+			}
+		}
+		if (page) {
+			*pinned_page = page;
+		} else {
+			int ret1;
+			/*
+			 * drop cap refs first because getattr while holding
+			 * caps refs can cause deadlock.
+			 */
+			ceph_put_cap_refs(ci, _got);
+			_got = 0;
+			/* getattt will bring inline data to page cache */
+			ret1 = __ceph_do_getattr(inode, NULL,
+						 CEPH_STAT_CAP_INLINE_DATA,
+						 true);
+			if (ret1 >= 0) {
+				ret = 0;
+				goto again;
+			}
+			*err = ret1;
+		}
+	}
+
 	dout("get_cap_refs %p ret %d got %s\n", inode,
-	     ret, ceph_cap_string(*got));
+	     ret, ceph_cap_string(_got));
+	*got = _got;
 	return ret;
 }
 
@@ -2168,8 +2205,8 @@ static void check_max_size(struct inode *inode, loff_t endoff)
  * due to a small max_size, make sure we check_max_size (and possibly
  * ask the mds) so we don't get hung up indefinitely.
  */
-int ceph_get_caps(struct ceph_inode_info *ci, int need, int want, int *got,
-		  loff_t endoff)
+int ceph_get_caps(struct ceph_inode_info *ci, int need, int want,
+		  loff_t endoff, int *got, struct page **pinned_page)
 {
 	int check_max, ret, err;
 
@@ -2179,8 +2216,8 @@ retry:
 	check_max = 0;
 	err = 0;
 	ret = wait_event_interruptible(ci->i_cap_wq,
-				       try_get_cap_refs(ci, need, want,
-							got, endoff,
+				       try_get_cap_refs(ci, need, want, endoff,
+							got, pinned_page,
 							&check_max, &err));
 	if (err)
 		ret = err;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c03ac4c..861b995 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -805,6 +805,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	size_t len = iocb->ki_nbytes;
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct page *pinned_page = NULL;
 	ssize_t ret;
 	int want, got = 0;
 	int checkeof = 0, read = 0;
@@ -817,7 +818,7 @@ again:
 		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 	else
 		want = CEPH_CAP_FILE_CACHE;
-	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, &got, -1);
+	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1, &got, &pinned_page);
 	if (ret < 0)
 		return ret;
 
@@ -840,6 +841,10 @@ again:
 	}
 	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
 	     inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
+	if (pinned_page) {
+		page_cache_release(pinned_page);
+		pinned_page = NULL;
+	}
 	ceph_put_cap_refs(ci, got);
 
 	if (checkeof && ret >= 0) {
@@ -924,7 +929,8 @@ retry_snap:
 	else
 		want = CEPH_CAP_FILE_BUFFER;
 	got = 0;
-	err = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, pos + count);
+	err = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, pos + count,
+			    &got, NULL);
 	if (err < 0)
 		goto out;
 
@@ -1225,7 +1231,7 @@ static long ceph_fallocate(struct file *file, int mode,
 	else
 		want = CEPH_CAP_FILE_BUFFER;
 
-	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, endoff);
+	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, endoff, &got, NULL);
 	if (ret < 0)
 		goto unlock;
 
-- 
1.9.3

