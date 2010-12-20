From: Sage Weil <sage@newdream.net>
Subject: [PATCH 5/5] ceph: handle partial result from get_user_pages
Date: Mon, 20 Dec 2010 11:15:31 -0800
Message-ID: <1292872531-18396-6-git-send-email-sage@newdream.net>
References: <1292872531-18396-1-git-send-email-sage@newdream.net>
 <1292872531-18396-2-git-send-email-sage@newdream.net>
 <1292872531-18396-3-git-send-email-sage@newdream.net>
 <1292872531-18396-4-git-send-email-sage@newdream.net>
 <1292872531-18396-5-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41950 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915Ab0LTTPe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Dec 2010 14:15:34 -0500
In-Reply-To: <1292872531-18396-5-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>, Sage Weil <sage@newdream.net>

From: Henry C Chang <henry_c_chang@tcloudcomputing.com>

The get_user_pages() helper can return fewer than the requested pages.
Error out in that case, and clean up the partial result.

Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/pagevec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index 01947a5..1a040e6 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -26,12 +26,12 @@ struct page **ceph_get_direct_page_vector(const char __user *data,
 	rc = get_user_pages(current, current->mm, (unsigned long)data,
 			    num_pages, write_page, 0, pages, NULL);
 	up_read(&current->mm->mmap_sem);
-	if (rc < 0)
+	if (rc < num_pages)
 		goto fail;
 	return pages;
 
 fail:
-	kfree(pages);
+	ceph_put_page_vector(pages, rc > 0 ? rc : 0, false);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL(ceph_get_direct_page_vector);
-- 
1.6.6.1

