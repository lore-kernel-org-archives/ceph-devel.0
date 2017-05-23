From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/3] ceph: remove useless page->mapping check in writepage_nounlock()
Date: Tue, 23 May 2017 17:54:37 +0800
Message-ID: <20170523095439.63347-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933487AbdEWJyv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 05:54:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, dan.carpenter@oracle.com, "Yan, Zheng" <zyan@redhat.com>

Callers of writepage_nounlock() have already ensured non-null
page->mapping.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f49d6630..ff25239 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -534,10 +534,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	dout("writepage %p idx %lu\n", page, page->index);
 
-	if (!page->mapping || !page->mapping->host) {
-		dout("writepage %p - no mapping\n", page);
-		return -EFAULT;
-	}
 	inode = page->mapping->host;
 	ci = ceph_inode(inode);
 	fsc = ceph_inode_to_client(inode);
-- 
2.9.4

