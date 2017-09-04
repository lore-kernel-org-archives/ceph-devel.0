From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 05/13] ceph: remove stale check in ceph_invalidatepage()
Date: Mon,  4 Sep 2017 17:39:00 +0800
Message-ID: <20170904093908.57316-6-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753364AbdIDJj5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:39:57 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

both set_page_dirty and truncate_complete_page should be called
for locked page. they can't race with each other.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d82036e19083..b6ac3da9ddab 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -152,17 +152,10 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 
 	ceph_invalidate_fscache_page(inode, page);
 
+	WARN_ON(!PageLocked(page));
 	if (!PagePrivate(page))
 		return;
 
-	/*
-	 * We can get non-dirty pages here due to races between
-	 * set_page_dirty and truncate_complete_page; just spit out a
-	 * warning, in case we end up with accounting problems later.
-	 */
-	if (!PageDirty(page))
-		pr_err("%p invalidatepage %p page not dirty\n", inode, page);
-
 	ClearPageChecked(page);
 
 	dout("%p invalidatepage %p idx %lu full dirty page\n",
-- 
2.13.5

