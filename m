From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 05/12] ceph: add inline data to pagecache
Date: Mon, 17 Nov 2014 15:56:59 +0800
Message-ID: <1416211026-11524-6-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52629 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKQH5v (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:57:51 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Request reply and cap message can contain inline data. add inline data
to the page cache if there is Fc cap.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c               | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/caps.c               | 11 +++++++++++
 fs/ceph/inode.c              | 16 ++++++++++++++++
 fs/ceph/inode.c.rej          | 21 +++++++++++++++++++++
 fs/ceph/mds_client.c.rej     | 10 ++++++++++
 fs/ceph/super.h              |  5 ++++-
 fs/ceph/super.h.rej          | 10 ++++++++++
 include/linux/ceph/ceph_fs.h |  1 +
 8 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 fs/ceph/inode.c.rej
 create mode 100644 fs/ceph/mds_client.c.rej
 create mode 100644 fs/ceph/super.h.rej

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f2c7aa8..7320b11 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1318,6 +1318,48 @@ out:
 	return ret;
 }
 
+void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
+			   char	*data, size_t len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+
+	if (locked_page) {
+		page = locked_page;
+	} else {
+		if (i_size_read(inode) == 0)
+			return;
+		page = find_or_create_page(mapping, 0, GFP_NOFS);
+		if (!page)
+			return;
+		if (PageUptodate(page)) {
+			unlock_page(page);
+			page_cache_release(page);
+			return;
+		}
+	}
+
+	dout("fill_inline_data %p %llx.%llx len %lu locked_page %p\n",
+	     inode, ceph_vinop(inode), len, locked_page);
+
+	if (len > 0) {
+		void *kaddr = kmap_atomic(page);
+		memcpy(kaddr, data, len);
+		kunmap_atomic(kaddr);
+	}
+
+	if (page != locked_page) {
+		if (len < PAGE_CACHE_SIZE)
+			zero_user_segment(page, len, PAGE_CACHE_SIZE);
+		else
+			flush_dcache_page(page);
+
+		SetPageUptodate(page);
+		unlock_page(page);
+		page_cache_release(page);
+	}
+}
+
 static struct vm_operations_struct ceph_vmops = {
 	.fault		= ceph_filemap_fault,
 	.page_mkwrite	= ceph_page_mkwrite,
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b88ae60..6372eb9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2405,6 +2405,7 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 	bool queue_invalidate = false;
 	bool queue_revalidate = false;
 	bool deleted_inode = false;
+	bool fill_inline = false;
 
 	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
 	     inode, cap, mds, seq, ceph_cap_string(newcaps));
@@ -2578,6 +2579,13 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 	}
 	BUG_ON(cap->issued & ~cap->implemented);
 
+	if (inline_version > 0 && inline_version >= ci->i_inline_version) {
+		ci->i_inline_version = inline_version;
+		if (ci->i_inline_version != CEPH_INLINE_NONE &&
+		    (newcaps & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)))
+			fill_inline = true;
+	}
+
 	spin_unlock(&ci->i_ceph_lock);
 
 	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) {
@@ -2591,6 +2599,9 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 			wake = true;
 	}
 
+	if (fill_inline)
+		ceph_fill_inline_data(inode, NULL, inline_data, inline_len);
+
 	if (queue_trunc) {
 		ceph_queue_vmtruncate(inode);
 		ceph_queue_revalidate(inode);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 72607c1..feea6a8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -387,6 +387,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ci->i_ceph_lock);
 
 	ci->i_version = 0;
+	ci->i_inline_version = 0;
 	ci->i_time_warp_seq = 0;
 	ci->i_ceph_flags = 0;
 	ci->i_ordered_count = 0;
@@ -676,6 +677,7 @@ static int fill_inode(struct inode *inode,
 	bool wake = false;
 	bool queue_trunc = false;
 	bool new_version = false;
+	bool fill_inline = false;
 
 	dout("fill_inode %p ino %llx.%llx v %llu had %llu\n",
 	     inode, ceph_vinop(inode), le64_to_cpu(info->version),
@@ -875,8 +877,22 @@ static int fill_inode(struct inode *inode,
 			   ceph_vinop(inode));
 		__ceph_get_fmode(ci, cap_fmode);
 	}
+
+	if (iinfo->inline_version > 0 &&
+	    iinfo->inline_version >= ci->i_inline_version) {
+		int cache_caps = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
+		ci->i_inline_version = iinfo->inline_version;
+		if (ci->i_inline_version != CEPH_INLINE_NONE &&
+		    (le32_to_cpu(info->cap.caps) & cache_caps))
+			fill_inline = true;
+	}
+
 	spin_unlock(&ci->i_ceph_lock);
 
+	if (fill_inline)
+		ceph_fill_inline_data(inode, NULL,
+				      iinfo->inline_data, iinfo->inline_len);
+
 	if (wake)
 		wake_up_all(&ci->i_cap_wq);
 
diff --git a/fs/ceph/inode.c.rej b/fs/ceph/inode.c.rej
new file mode 100644
index 0000000..cc4a5aa
--- /dev/null
+++ b/fs/ceph/inode.c.rej
@@ -0,0 +1,21 @@
+--- fs/ceph/inode.c
++++ fs/ceph/inode.c
+@@ -1960,7 +2016,8 @@
+  * Verify that we have a lease on the given mask.  If not,
+  * do a getattr against an mds.
+  */
+-int ceph_do_getattr(struct inode *inode, int mask, bool force)
++int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
++		      int mask, bool force)
+ {
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+@@ -1972,7 +2029,8 @@
+		return 0;
+	}
+
+-	dout("do_getattr inode %p mask %s mode 0%o\n", inode, ceph_cap_string(mask), inode->i_mode);
++	dout("do_getattr inode %p mask %s mode 0%o\n",
++	     inode, ceph_cap_string(mask), inode->i_mode);
+	if (!force && ceph_caps_issued_mask(ceph_inode(inode), mask, 1))
+		return 0;
diff --git a/fs/ceph/mds_client.c.rej b/fs/ceph/mds_client.c.rej
new file mode 100644
index 0000000..f70f300
--- /dev/null
+++ b/fs/ceph/mds_client.c.rej
@@ -0,0 +1,10 @@
+--- fs/ceph/mds_client.c
++++ fs/ceph/mds_client.c
+@@ -1848,7 +1848,6 @@
+	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
+
+	if (req->r_data_len) {
+-		/* outbound data set only by ceph_sync_setxattr() */
+		BUG_ON(!req->r_pages);
+		ceph_msg_data_add_pages(msg, req->r_pages, req->r_data_len, 0);
+	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9f63f18..f675dd9 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -253,6 +253,7 @@ struct ceph_inode_info {
 	spinlock_t i_ceph_lock;
 
 	u64 i_version;
+	u64 i_inline_version;
 	u32 i_time_warp_seq;
 
 	unsigned i_ceph_flags;
@@ -858,7 +859,7 @@ extern int ceph_encode_dentry_release(void **p, struct dentry *dn,
 				      int mds, int drop, int unless);
 
 extern int ceph_get_caps(struct ceph_inode_info *ci, int need, int want,
-			 int *got, loff_t endoff);
+			 loff_t endoff, int *got, struct page **pinned_page);
 
 /* for counting open files by mode */
 static inline void __ceph_get_fmode(struct ceph_inode_info *ci, int mode)
@@ -880,6 +881,8 @@ extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags, umode_t mode,
 			    int *opened);
 extern int ceph_release(struct inode *inode, struct file *filp);
+extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
+				  char *data, size_t len);
 
 /* dir.c */
 extern const struct file_operations ceph_dir_fops;
diff --git a/fs/ceph/super.h.rej b/fs/ceph/super.h.rej
new file mode 100644
index 0000000..88fe3df
--- /dev/null
+++ b/fs/ceph/super.h.rej
@@ -0,0 +1,10 @@
+--- fs/ceph/super.h
++++ fs/ceph/super.h
+@@ -254,6 +255,7 @@
+	spinlock_t i_ceph_lock;
+
+	u64 i_version;
++	u64 i_inline_version;
+	u32 i_time_warp_seq;
+
+	unsigned i_ceph_flags;
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 31d8b98..2d4acfa 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -552,6 +552,7 @@ struct ceph_filelock {
 
 int ceph_flags_to_mode(int flags);
 
+#define CEPH_INLINE_NONE	((__u64)-1)
 
 /* capability bits */
 #define CEPH_CAP_PIN         1  /* no specific capabilities beyond the pin */
-- 
1.9.3

