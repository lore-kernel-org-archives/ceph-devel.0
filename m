From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] ceph: Update the pages in fscache in writepages() path
Date: Fri,  1 Nov 2013 11:56:48 +0800
Message-ID: <1383278208-4053-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:60884 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3KAD5I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Oct 2013 23:57:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com, Sage Weil <sage@inktank.com>, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>, Min Chen <minchen@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Currently, the pages in fscache only are updated in writepage() path,
add the process in writepages().

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 fs/ceph/addr.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6df8bd4..cc57911 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -746,7 +746,7 @@ retry:
 
 	while (!done && index <= end) {
 		int num_ops = do_sync ? 2 : 1;
-		unsigned i;
+		unsigned i, j;
 		int first;
 		pgoff_t next;
 		int pvec_pages, locked_pages;
@@ -894,7 +894,6 @@ get_more_pages:
 		if (!locked_pages)
 			goto release_pvec_pages;
 		if (i) {
-			int j;
 			BUG_ON(!locked_pages || first < 0);
 
 			if (pvec_pages && i == pvec_pages &&
@@ -924,7 +923,10 @@ get_more_pages:
 
 		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
 							!!pool, false);
-
+		for(j = 0; j < locked_pages; j++) {
+			struct page *page = pages[j];
+			ceph_readpage_to_fscache(inode, page);
+		}		
 		pages = NULL;	/* request message now owns the pages array */
 		pool = NULL;
 
-- 
1.7.9.5

