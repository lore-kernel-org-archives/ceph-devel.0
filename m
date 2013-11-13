From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Ceph: Avoid data inconsistency due to d-cache aliasing in readpage()
Date: Wed, 13 Nov 2013 15:22:14 +0800
Message-ID: <1384327335-18812-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:36081 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480Ab3KMHdC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 02:33:02 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>

If the length of data to be read in readpage() is exactly
PAGE_CACHE_SIZE, the original code does not flush d-cache
for data consistency after finishing reading. This patches fixes
this.

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/addr.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6df8bd4..7b0000a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -210,9 +210,13 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 	if (err < 0) {
 		SetPageError(page);
 		goto out;
-	} else if (err < PAGE_CACHE_SIZE) {
+	} else {
+		if (err < PAGE_CACHE_SIZE) {
 		/* zero fill remainder of page */
-		zero_user_segment(page, err, PAGE_CACHE_SIZE);
+			zero_user_segment(page, err, PAGE_CACHE_SIZE);
+		} else {
+			flush_dcache_page(page);
+		}
 	}
 	SetPageUptodate(page);
 
-- 
1.7.9.5

