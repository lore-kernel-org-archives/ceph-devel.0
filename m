From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 09/12] ceph: convert inline data to normal data before data write
Date: Mon, 17 Nov 2014 15:57:03 +0800
Message-ID: <1416211026-11524-10-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbaKQH6O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:58:14 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Before any data write, convert inline data to normal data and set
i_inline_version to CEPH_INLINE_NONE. The OSD request that saves
inline data to object contains 3 operations (CMPXATTR, WRITE and
SETXATTR). It compares a xattr named 'inline_version' to prevent
old data overwrites newer data.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c  | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/file.c  |  14 ++++++
 fs/ceph/super.h |   2 +-
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9dcb4a9..72336bd 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1262,6 +1262,19 @@ static int ceph_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf)
 	size_t len;
 	int want, got, ret;
 
+	if (ci->i_inline_version != CEPH_INLINE_NONE) {
+		struct page *locked_page = NULL;
+		if (off == 0) {
+			lock_page(page);
+			locked_page = page;
+		}
+		ret = ceph_uninline_data(vma->vm_file, locked_page);
+		if (locked_page)
+			unlock_page(locked_page);
+		if (ret < 0)
+			return VM_FAULT_SIGBUS;
+	}
+
 	if (off + PAGE_CACHE_SIZE <= size)
 		len = PAGE_CACHE_SIZE;
 	else
@@ -1315,6 +1328,7 @@ out:
 	} else {
 		int dirty;
 		spin_lock(&ci->i_ceph_lock);
+		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
 		spin_unlock(&ci->i_ceph_lock);
 		if (dirty)
@@ -1370,6 +1384,128 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 	}
 }
 
+int ceph_uninline_data(struct file *filp, struct page *locked_page)
+{
+	struct inode *inode = file_inode(filp);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_osd_request *req;
+	struct page *page = NULL;
+	u64 len, inline_version;
+	int err = 0;
+	bool from_pagecache = false;
+
+	spin_lock(&ci->i_ceph_lock);
+	inline_version = ci->i_inline_version;
+	spin_unlock(&ci->i_ceph_lock);
+
+	dout("uninline_data %p %llx.%llx inline_version %llu\n",
+	     inode, ceph_vinop(inode), inline_version);
+
+	if (inline_version == 1 || /* initial version, no data */
+	    inline_version == CEPH_INLINE_NONE)
+		goto out;
+
+	if (locked_page) {
+		page = locked_page;
+		WARN_ON(!PageUptodate(page));
+	} else if (ceph_caps_issued(ci) &
+		   (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) {
+		page = find_get_page(inode->i_mapping, 0);
+		if (page) {
+			if (PageUptodate(page)) {
+				from_pagecache = true;
+				lock_page(page);
+			} else {
+				page_cache_release(page);
+				page = NULL;
+			}
+		}
+	}
+
+	if (page) {
+		len = i_size_read(inode);
+		if (len > PAGE_CACHE_SIZE)
+			len = PAGE_CACHE_SIZE;
+	} else {
+		page = __page_cache_alloc(GFP_NOFS);
+		if (!page) {
+			err = -ENOMEM;
+			goto out;
+		}
+		err = __ceph_do_getattr(inode, page,
+					CEPH_STAT_CAP_INLINE_DATA, true);
+		if (err < 0) {
+			/* no inline data */
+			if (err == -ENODATA)
+				err = 0;
+			goto out;
+		}
+		len = err;
+	}
+
+	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
+				    ceph_vino(inode), 0, &len, 0, 1,
+				    CEPH_OSD_OP_CREATE,
+				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
+				    ci->i_snap_realm->cached_context,
+				    0, 0, false);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out;
+	}
+
+	ceph_osdc_build_request(req, 0, NULL, CEPH_NOSNAP, &inode->i_mtime);
+	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
+	if (!err)
+		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
+	ceph_osdc_put_request(req);
+	if (err < 0)
+		goto out;
+
+	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
+				    ceph_vino(inode), 0, &len, 1, 3,
+				    CEPH_OSD_OP_WRITE,
+				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
+				    ci->i_snap_realm->cached_context,
+				    ci->i_truncate_seq, ci->i_truncate_size,
+				    false);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out;
+	}
+
+	osd_req_op_extent_osd_data_pages(req, 1, &page, len, 0, false, false);
+
+	osd_req_op_xattr_init(req, 0, CEPH_OSD_OP_CMPXATTR, "inline_version",
+			      &inline_version, sizeof(inline_version),
+			      CEPH_OSD_CMPXATTR_OP_GT,
+			      CEPH_OSD_CMPXATTR_MODE_U64);
+
+	osd_req_op_xattr_init(req, 2, CEPH_OSD_OP_SETXATTR, "inline_version",
+			      &inline_version, sizeof(inline_version), 0, 0);
+
+	ceph_osdc_build_request(req, 0, NULL, CEPH_NOSNAP, &inode->i_mtime);
+	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
+	if (!err)
+		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
+	ceph_osdc_put_request(req);
+	if (err == -ECANCELED)
+		err = 0;
+out:
+	if (page && page != locked_page) {
+		if (from_pagecache) {
+			unlock_page(page);
+			page_cache_release(page);
+		} else
+			__free_pages(page, 0);
+	}
+
+	dout("uninline_data %p %llx.%llx inline_version %llu = %d\n",
+	     inode, ceph_vinop(inode), inline_version, err);
+	return err;
+}
+
 static struct vm_operations_struct ceph_vmops = {
 	.fault		= ceph_filemap_fault,
 	.page_mkwrite	= ceph_page_mkwrite,
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5b092bd..9b5901f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -963,6 +963,12 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		goto out;
 
+	if (ci->i_inline_version != CEPH_INLINE_NONE) {
+		err = ceph_uninline_data(file, NULL);
+		if (err < 0)
+			goto out;
+	}
+
 retry_snap:
 	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL)) {
 		err = -ENOSPC;
@@ -1024,6 +1030,7 @@ retry_snap:
 	if (written >= 0) {
 		int dirty;
 		spin_lock(&ci->i_ceph_lock);
+		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
 		spin_unlock(&ci->i_ceph_lock);
 		if (dirty)
@@ -1269,6 +1276,12 @@ static long ceph_fallocate(struct file *file, int mode,
 		goto unlock;
 	}
 
+	if (ci->i_inline_version != CEPH_INLINE_NONE) {
+		ret = ceph_uninline_data(file, NULL);
+		if (ret < 0)
+			goto unlock;
+	}
+
 	size = i_size_read(inode);
 	if (!(mode & FALLOC_FL_KEEP_SIZE))
 		endoff = offset + length;
@@ -1295,6 +1308,7 @@ static long ceph_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		spin_lock(&ci->i_ceph_lock);
+		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
 		spin_unlock(&ci->i_ceph_lock);
 		if (dirty)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 90f79b5..02de104 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -888,7 +888,7 @@ extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 extern int ceph_release(struct inode *inode, struct file *filp);
 extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 				  char *data, size_t len);
-
+int ceph_uninline_data(struct file *filp, struct page *locked_page);
 /* dir.c */
 extern const struct file_operations ceph_dir_fops;
 extern const struct inode_operations ceph_dir_iops;
-- 
1.9.3

