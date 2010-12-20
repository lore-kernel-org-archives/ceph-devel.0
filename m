From: Sage Weil <sage@newdream.net>
Subject: [PATCH 4/5] ceph: mark user pages dirty on direct-io reads
Date: Mon, 20 Dec 2010 11:15:30 -0800
Message-ID: <1292872531-18396-5-git-send-email-sage@newdream.net>
References: <1292872531-18396-1-git-send-email-sage@newdream.net>
 <1292872531-18396-2-git-send-email-sage@newdream.net>
 <1292872531-18396-3-git-send-email-sage@newdream.net>
 <1292872531-18396-4-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41948 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932913Ab0LTTPe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Dec 2010 14:15:34 -0500
In-Reply-To: <1292872531-18396-4-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>, Sage Weil <sage@newdream.net>

From: Henry C Chang <henry_c_chang@tcloudcomputing.com>

For read operation, we have to set the argument _write_ of get_user_pages
to 1 since we will write data to pages. Also, we need to SetPageDirty before
releasing these pages.

Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/file.c               |    8 ++++----
 include/linux/ceph/libceph.h |    6 ++++--
 net/ceph/pagevec.c           |   11 +++++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e860d8f..7d0e4a8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -384,7 +384,7 @@ static ssize_t ceph_sync_read(struct file *file, char __user *data,
 
 	if (file->f_flags & O_DIRECT) {
 		num_pages = calc_pages_for((unsigned long)data, len);
-		pages = ceph_get_direct_page_vector(data, num_pages);
+		pages = ceph_get_direct_page_vector(data, num_pages, true);
 	} else {
 		num_pages = calc_pages_for(off, len);
 		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
@@ -413,7 +413,7 @@ static ssize_t ceph_sync_read(struct file *file, char __user *data,
 
 done:
 	if (file->f_flags & O_DIRECT)
-		ceph_put_page_vector(pages, num_pages);
+		ceph_put_page_vector(pages, num_pages, true);
 	else
 		ceph_release_page_vector(pages, num_pages);
 	dout("sync_read result %d\n", ret);
@@ -522,7 +522,7 @@ more:
 		return -ENOMEM;
 
 	if (file->f_flags & O_DIRECT) {
-		pages = ceph_get_direct_page_vector(data, num_pages);
+		pages = ceph_get_direct_page_vector(data, num_pages, false);
 		if (IS_ERR(pages)) {
 			ret = PTR_ERR(pages);
 			goto out;
@@ -572,7 +572,7 @@ more:
 	}
 
 	if (file->f_flags & O_DIRECT)
-		ceph_put_page_vector(pages, num_pages);
+		ceph_put_page_vector(pages, num_pages, false);
 	else if (file->f_flags & O_SYNC)
 		ceph_release_page_vector(pages, num_pages);
 
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 9e76d35..72c72bf 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -227,8 +227,10 @@ extern int ceph_open_session(struct ceph_client *client);
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
 
 extern struct page **ceph_get_direct_page_vector(const char __user *data,
-						 int num_pages);
-extern void ceph_put_page_vector(struct page **pages, int num_pages);
+						 int num_pages,
+						 bool write_page);
+extern void ceph_put_page_vector(struct page **pages, int num_pages,
+				 bool dirty);
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
 extern int ceph_copy_user_to_page_vector(struct page **pages,
diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index ac34fee..01947a5 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -13,7 +13,7 @@
  * build a vector of user pages
  */
 struct page **ceph_get_direct_page_vector(const char __user *data,
-					  int num_pages)
+					  int num_pages, bool write_page)
 {
 	struct page **pages;
 	int rc;
@@ -24,7 +24,7 @@ struct page **ceph_get_direct_page_vector(const char __user *data,
 
 	down_read(&current->mm->mmap_sem);
 	rc = get_user_pages(current, current->mm, (unsigned long)data,
-			    num_pages, 0, 0, pages, NULL);
+			    num_pages, write_page, 0, pages, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (rc < 0)
 		goto fail;
@@ -36,12 +36,15 @@ fail:
 }
 EXPORT_SYMBOL(ceph_get_direct_page_vector);
 
-void ceph_put_page_vector(struct page **pages, int num_pages)
+void ceph_put_page_vector(struct page **pages, int num_pages, bool dirty)
 {
 	int i;
 
-	for (i = 0; i < num_pages; i++)
+	for (i = 0; i < num_pages; i++) {
+		if (dirty)
+			set_page_dirty_lock(pages[i]);
 		put_page(pages[i]);
+	}
 	kfree(pages);
 }
 EXPORT_SYMBOL(ceph_put_page_vector);
-- 
1.6.6.1

