From: Sage Weil <sage@newdream.net>
Subject: [PATCH 4/8] libceph: fix handling of short returns from get_user_pages
Date: Thu,  3 Mar 2011 12:40:06 -0800
Message-ID: <1299184810-19125-5-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52164 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758700Ab1CCUj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:58 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

get_user_pages() can return fewer pages than we ask for.  We were returning
a bogus pointer/error code in that case.  Instead, loop until we get all
the pages we want or get an error we can return to the caller.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/pagevec.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index 1a040e6..b6cf888 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -16,6 +16,7 @@ struct page **ceph_get_direct_page_vector(const char __user *data,
 					  int num_pages, bool write_page)
 {
 	struct page **pages;
+	int got = 0;
 	int rc;
 
 	pages = kmalloc(sizeof(*pages) * num_pages, GFP_NOFS);
@@ -23,15 +24,22 @@ struct page **ceph_get_direct_page_vector(const char __user *data,
 		return ERR_PTR(-ENOMEM);
 
 	down_read(&current->mm->mmap_sem);
-	rc = get_user_pages(current, current->mm, (unsigned long)data,
-			    num_pages, write_page, 0, pages, NULL);
+	while (got < num_pages) {
+		rc = get_user_pages(current, current->mm,
+		    (unsigned long)data + ((unsigned long)got * PAGE_SIZE),
+		    num_pages - got, write_page, 0, pages + got, NULL);
+		if (rc < 0)
+			break;
+		BUG_ON(rc == 0);
+		got += rc;
+	}
 	up_read(&current->mm->mmap_sem);
-	if (rc < num_pages)
+	if (rc < 0)
 		goto fail;
 	return pages;
 
 fail:
-	ceph_put_page_vector(pages, rc > 0 ? rc : 0, false);
+	ceph_put_page_vector(pages, got, false);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL(ceph_get_direct_page_vector);
-- 
1.7.0

