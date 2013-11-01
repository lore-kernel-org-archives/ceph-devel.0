From: Li Wang <liwang@ubuntukylin.com>
Subject: [RFC PATCH] ceph: Capture stride readahead
Date: Fri,  1 Nov 2013 17:31:46 +0800
Message-ID: <1383298306-8492-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:48709 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab3KAJb7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Nov 2013 05:31:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Enable ceph to capture stride readahead, the algorithm is simple and
straightforward: prefetch the next stripe if hit. In the future, it
may be implemented as enabled only when user requests explicitly as a
mount option.

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/file.c  |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ceph/super.h |    8 ++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3de8982..16a3981 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -9,6 +9,7 @@
 #include <linux/writeback.h>
 #include <linux/aio.h>
 #include <linux/falloc.h>
+#include <linux/blkdev.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -635,6 +636,60 @@ out:
 	return ret;
 }
 
+static void ceph_stride_readahead(struct file *file, loff_t pos, size_t length)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct ceph_file_info *fi = file->private_data;
+	struct ceph_file_stride_ra_info *info = &fi->stride;
+	struct blk_plug plug;
+	LIST_HEAD(page_pool);
+	loff_t next_pos;
+	pgoff_t start, end, page_idx;
+	unsigned int nr_pages = 0;
+
+	if (info->length != length)
+		goto skip;
+	if (pos != info->pos + info->stride)
+		goto skip;
+
+	next_pos = pos + info->stride;
+	start = next_pos >> PAGE_CACHE_SHIFT;
+	end = (next_pos + length - 1) >> PAGE_CACHE_SHIFT;
+	end = min(end, start + file->f_ra.ra_pages);
+
+	for (page_idx = start; page_idx <= end; ++page_idx) {
+		struct page *page;
+		
+		rcu_read_lock();
+		page = radix_tree_lookup(&mapping->page_tree, page_idx);
+		rcu_read_unlock();
+
+		if (page)
+			continue;
+
+		page = page_cache_alloc_readahead(mapping);
+		if (!page)
+			break;
+		page->index = page_idx;
+		list_add(&page->lru, &page_pool);
+
+		++nr_pages;
+	}
+
+	if (!nr_pages)
+		goto skip;
+
+	blk_start_plug(&plug);
+	mapping->a_ops->readpages(file, mapping, &page_pool, nr_pages);
+	put_pages_list(&page_pool);
+	blk_finish_plug(&plug);
+
+skip:
+	info->length = length;
+	info->stride = pos - info->pos;
+	info->pos = pos;
+}
+
 /*
  * Wrap generic_file_aio_read with checks for cap bits on the inode.
  * Atomically grab references, so that those bits are not released
@@ -675,8 +730,11 @@ again:
 	    (fi->flags & CEPH_F_SYNC))
 		/* hmm, this isn't really async... */
 		ret = ceph_sync_read(filp, base, len, ppos, &checkeof);
-	else
+	else {
 		ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
+		if (ret >= 0)
+			ceph_stride_readahead(filp, pos, iocb->ki_nbytes);
+	}
 
 out:
 	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 6014b0a..72b4382 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -567,6 +567,12 @@ extern void ceph_reservation_status(struct ceph_fs_client *client,
 #define CEPH_F_SYNC     1
 #define CEPH_F_ATEND    2
 
+struct ceph_file_stride_ra_info {
+	loff_t pos;
+	size_t length;
+	loff_t stride;
+};
+
 struct ceph_file_info {
 	short fmode;     /* initialized on open */
 	short flags;     /* CEPH_F_* */
@@ -585,6 +591,8 @@ struct ceph_file_info {
 	/* used for -o dirstat read() on directory thing */
 	char *dir_info;
 	int dir_info_len;
+
+	struct ceph_file_stride_ra_info stride;
 };
 
 
-- 
1.7.9.5

