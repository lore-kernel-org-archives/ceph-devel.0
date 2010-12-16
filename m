From: Sage Weil <sage@newdream.net>
Subject: [PATCH 2/2] ceph: mark user pages dirty on direct-io reads
Date: Wed, 15 Dec 2010 20:49:19 -0800
Message-ID: <1292474959-2834-2-git-send-email-sage@newdream.net>
References: <1292474959-2834-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49575 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab0LPFFh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 00:05:37 -0500
In-Reply-To: <1292474959-2834-1-git-send-email-sage@newdream.net>
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
 fs/ceph/file.c               |    4 ++--
 include/linux/ceph/libceph.h |    3 ++-
 net/ceph/pagevec.c           |    6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e860d8f..e0f136d 100644
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
@@ -522,7 +522,7 @@ more:
 		return -ENOMEM;
 
 	if (file->f_flags & O_DIRECT) {
-		pages = ceph_get_direct_page_vector(data, num_pages);
+		pages = ceph_get_direct_page_vector(data, num_pages, false);
 		if (IS_ERR(pages)) {
 			ret = PTR_ERR(pages);
 			goto out;
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 9e76d35..11992e8 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -227,7 +227,8 @@ extern int ceph_open_session(struct ceph_client *client);
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
 
 extern struct page **ceph_get_direct_page_vector(const char __user *data,
-						 int num_pages);
+						 int num_pages,
+						 bool write_page);
 extern void ceph_put_page_vector(struct page **pages, int num_pages);
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index ac34fee..128d5ba 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -13,18 +13,18 @@
  * build a vector of user pages
  */
 struct page **ceph_get_direct_page_vector(const char __user *data,
-					  int num_pages)
+					  int num_pages, bool write_page)
 {
 	struct page **pages;
 	int rc;
 
-	pages = kmalloc(sizeof(*pages) * num_pages, GFP_NOFS);
+	pages = kzalloc(sizeof(*pages) * num_pages, GFP_NOFS);
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
 
 	down_read(&current->mm->mmap_sem);
 	rc = get_user_pages(current, current->mm, (unsigned long)data,
-			    num_pages, 0, 0, pages, NULL);
+			    num_pages, write_page, 0, pages, NULL);
 	up_read(&current->mm->mmap_sem);
 	if (rc < 0)
 		goto fail;
-- 
1.7.1

