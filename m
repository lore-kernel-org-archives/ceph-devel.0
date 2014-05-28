From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] ceph: refactor readpage_nounlock() to make the logic clearer
Date: Wed, 28 May 2014 15:09:55 +0800
Message-ID: <53858BC3.8070604@huawei.com>
References: <1401260798-28541-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:21468 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbaE1HKG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 May 2014 03:10:06 -0400
In-Reply-To: <1401260798-28541-1-git-send-email-zhenzhang.zhang@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ukernel@gmail.com, elder@ieee.org
Cc: ceph-devel@vger.kernel.org

If the return value of ceph_osdc_readpages() is not negative,
it is certainly greater than or equal to zero.

Remove the useless condition judgment and redundant braces.

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/ceph/addr.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b53278c..6aa2e3f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -211,18 +211,15 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 		SetPageError(page);
 		ceph_fscache_readpage_cancel(inode, page);
 		goto out;
-	} else {
-		if (err < PAGE_CACHE_SIZE) {
-		/* zero fill remainder of page */
-			zero_user_segment(page, err, PAGE_CACHE_SIZE);
-		} else {
-			flush_dcache_page(page);
-		}
 	}
-	SetPageUptodate(page);
+	if (err < PAGE_CACHE_SIZE)
+		/* zero fill remainder of page */
+		zero_user_segment(page, err, PAGE_CACHE_SIZE);
+	else
+		flush_dcache_page(page);

-	if (err >= 0)
-		ceph_readpage_to_fscache(inode, page);
+	SetPageUptodate(page);
+	ceph_readpage_to_fscache(inode, page);

 out:
 	return err < 0 ? err : 0;
-- 
1.8.1.2


.




