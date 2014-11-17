From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 08/12] ceph: sync read inline data
Date: Mon, 17 Nov 2014 15:57:02 +0800
Message-ID: <1416211026-11524-9-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbaKQH6E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:58:04 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

we can't use getattr to fetch inline data while holding Fr cap,
because it can cause deadlock. If we need to sync read inline data,
drop cap refs first, then use getattr to fetch inline data.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c |  7 ++++++-
 fs/ceph/file.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fdbdbbe..9dcb4a9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -194,8 +194,10 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 	int err = 0;
 	u64 len = PAGE_CACHE_SIZE;
 
-	err = ceph_readpage_from_fscache(inode, page);
+	if (ci->i_inline_version != CEPH_INLINE_NONE)
+		return -EINVAL;
 
+	err = ceph_readpage_from_fscache(inode, page);
 	if (err == 0)
 		goto out;
 
@@ -384,6 +386,9 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 	int rc = 0;
 	int max = 0;
 
+	if (ceph_inode(inode)->i_inline_version != CEPH_INLINE_NONE)
+		return -EINVAL;
+
 	rc = ceph_readpages_from_fscache(mapping->host, mapping, page_list,
 					 &nr_pages);
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 861b995..5b092bd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -333,6 +333,11 @@ int ceph_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+enum {
+	CHECK_EOF = 1,
+	READ_INLINE = 2,
+};
+
 /*
  * Read a range of bytes striped over one or more objects.  Iterate over
  * objects we stripe over.  (That's not atomic, but good enough for now.)
@@ -412,7 +417,7 @@ more:
 		ret = read;
 		/* did we bounce off eof? */
 		if (pos + left > inode->i_size)
-			*checkeof = 1;
+			*checkeof = CHECK_EOF;
 	}
 
 	dout("striped_read returns %d\n", ret);
@@ -808,7 +813,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct page *pinned_page = NULL;
 	ssize_t ret;
 	int want, got = 0;
-	int checkeof = 0, read = 0;
+	int retry_op = 0, read = 0;
 
 again:
 	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
@@ -830,8 +835,12 @@ again:
 		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
 		     ceph_cap_string(got));
 
-		/* hmm, this isn't really async... */
-		ret = ceph_sync_read(iocb, to, &checkeof);
+		if (ci->i_inline_version == CEPH_INLINE_NONE) {
+			/* hmm, this isn't really async... */
+			ret = ceph_sync_read(iocb, to, &retry_op);
+		} else {
+			retry_op = READ_INLINE;
+		}
 	} else {
 		dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
 		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
@@ -846,12 +855,50 @@ again:
 		pinned_page = NULL;
 	}
 	ceph_put_cap_refs(ci, got);
+	if (retry_op && ret >= 0) {
+		int statret;
+		struct page *page = NULL;
+		loff_t i_size;
+		if (retry_op == READ_INLINE) {
+			page = __page_cache_alloc(GFP_NOFS);
+			if (!page)
+				return -ENOMEM;
+		}
+
+		statret = __ceph_do_getattr(inode, page,
+					    CEPH_STAT_CAP_INLINE_DATA, !!page);
+		if (statret < 0) {
+			 __free_page(page);
+			if (statret == -ENODATA) {
+				BUG_ON(retry_op != READ_INLINE);
+				goto again;
+			}
+			return statret;
+		}
 
-	if (checkeof && ret >= 0) {
-		int statret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
+		i_size = i_size_read(inode);
+		if (retry_op == READ_INLINE) {
+			/* does not support inline data > PAGE_SIZE */
+			if (i_size > PAGE_CACHE_SIZE) {
+				ret = -EIO;
+			} else if (iocb->ki_pos < i_size) {
+				loff_t end = min_t(loff_t, i_size,
+						   iocb->ki_pos + len);
+				if (statret < end)
+					zero_user_segment(page, statret, end);
+				ret = copy_page_to_iter(page,
+						iocb->ki_pos & ~PAGE_MASK,
+						end - iocb->ki_pos, to);
+				iocb->ki_pos += ret;
+			} else {
+				ret = 0;
+			}
+			__free_pages(page, 0);
+			return ret;
+		}
 
 		/* hit EOF or hole? */
-		if (statret == 0 && iocb->ki_pos < inode->i_size &&
+		if (retry_op == CHECK_EOF && iocb->ki_pos < i_size &&
 			ret < len) {
 			dout("sync_read hit hole, ppos %lld < size %lld"
 			     ", reading more\n", iocb->ki_pos,
@@ -859,7 +906,7 @@ again:
 
 			read += ret;
 			len -= ret;
-			checkeof = 0;
+			retry_op = 0;
 			goto again;
 		}
 	}
-- 
1.9.3

