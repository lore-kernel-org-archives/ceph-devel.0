From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ceph: remove ceph_get_direct_page_vector
Date: Wed,  1 May 2019 16:40:32 -0400
Message-ID: <20190501204032.26380-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This function is entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ceph/libceph.h |  4 ----
 net/ceph/pagevec.c           | 33 ---------------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 337d5049ff93..a3cddf5f0e60 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -299,10 +299,6 @@ int ceph_wait_for_latest_osdmap(struct ceph_client *client,
 
 /* pagevec.c */
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
-
-extern struct page **ceph_get_direct_page_vector(const void __user *data,
-						 int num_pages,
-						 bool write_page);
 extern void ceph_put_page_vector(struct page **pages, int num_pages,
 				 bool dirty);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index d3736f5bffec..64305e7056a1 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -10,39 +10,6 @@
 
 #include <linux/ceph/libceph.h>
 
-/*
- * build a vector of user pages
- */
-struct page **ceph_get_direct_page_vector(const void __user *data,
-					  int num_pages, bool write_page)
-{
-	struct page **pages;
-	int got = 0;
-	int rc = 0;
-
-	pages = kmalloc_array(num_pages, sizeof(*pages), GFP_NOFS);
-	if (!pages)
-		return ERR_PTR(-ENOMEM);
-
-	while (got < num_pages) {
-		rc = get_user_pages_fast(
-		    (unsigned long)data + ((unsigned long)got * PAGE_SIZE),
-		    num_pages - got, write_page, pages + got);
-		if (rc < 0)
-			break;
-		BUG_ON(rc == 0);
-		got += rc;
-	}
-	if (rc < 0)
-		goto fail;
-	return pages;
-
-fail:
-	ceph_put_page_vector(pages, got, false);
-	return ERR_PTR(rc);
-}
-EXPORT_SYMBOL(ceph_get_direct_page_vector);
-
 void ceph_put_page_vector(struct page **pages, int num_pages, bool dirty)
 {
 	int i;
-- 
2.20.1
