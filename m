From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 08/13] ceph: optimize pagevec iterating in ceph_writepages_start()
Date: Mon,  4 Sep 2017 17:39:03 +0800
Message-ID: <20170904093908.57316-9-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753364AbdIDJkR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:40:17 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

ceph_writepages_start() supports writing non-continuous pages.
If it encounters a non-dirty or non-writeable page in pagevec,
it can continue to check the rest pages in pagevec.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8526359c08b2..5ca887bb5cae 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -851,7 +851,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 	while (!done && index <= end) {
 		unsigned i;
-		int first;
 		pgoff_t strip_unit_end = 0;
 		int num_ops = 0, op_idx;
 		int pvec_pages, locked_pages = 0;
@@ -864,7 +863,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 		max_pages = max_pages_ever;
 
 get_more_pages:
-		first = -1;
 		want = min(end - index,
 			   min((pgoff_t)PAGEVEC_SIZE,
 			       max_pages - (pgoff_t)locked_pages) - 1)
@@ -888,7 +886,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			    unlikely(page->mapping != mapping)) {
 				dout("!dirty or !mapping %p\n", page);
 				unlock_page(page);
-				break;
+				continue;
 			}
 			if (!wbc->range_cyclic && page->index > end) {
 				dout("end of range %p\n", page);
@@ -901,10 +899,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				break;
 			}
-			if (wbc->sync_mode != WB_SYNC_NONE) {
-				dout("waiting on writeback %p\n", page);
-				wait_on_page_writeback(page);
-			}
 			if (page_offset(page) >= ceph_wbc.i_size) {
 				dout("%p page eof %llu\n",
 				     page, ceph_wbc.i_size);
@@ -913,9 +907,13 @@ static int ceph_writepages_start(struct address_space *mapping,
 				break;
 			}
 			if (PageWriteback(page)) {
-				dout("%p under writeback\n", page);
-				unlock_page(page);
-				break;
+				if (wbc->sync_mode == WB_SYNC_NONE) {
+					dout("%p under writeback\n", page);
+					unlock_page(page);
+					continue;
+				}
+				dout("waiting on writeback %p\n", page);
+				wait_on_page_writeback(page);
 			}
 
 			/* only if matching snap context */
@@ -924,15 +922,13 @@ static int ceph_writepages_start(struct address_space *mapping,
 				dout("page snapc %p %lld > oldest %p %lld\n",
 				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
 				unlock_page(page);
-				if (!locked_pages)
-					continue; /* keep looking for snap */
-				break;
+				continue;
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
 				dout("%p !clear_page_dirty_for_io\n", page);
 				unlock_page(page);
-				break;
+				continue;
 			}
 
 			/*
@@ -988,8 +984,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 			}
 
 			/* note position of first page in pvec */
-			if (first < 0)
-				first = i;
 			dout("%p will write page %p idx %lu\n",
 			     inode, page, page->index);
 
@@ -1000,8 +994,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 						  BLK_RW_ASYNC);
 			}
 
-			pages[locked_pages] = page;
-			locked_pages++;
+
+			pages[locked_pages++] = page;
+			pvec.pages[i] = NULL;
+
 			len += PAGE_SIZE;
 		}
 
@@ -1009,23 +1005,23 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (!locked_pages)
 			goto release_pvec_pages;
 		if (i) {
-			int j;
-			BUG_ON(!locked_pages || first < 0);
+			unsigned j, n = 0;
+			/* shift unused page to beginning of pvec */
+			for (j = 0; j < pvec_pages; j++) {
+				if (!pvec.pages[j])
+					continue;
+				if (n < j)
+					pvec.pages[n] = pvec.pages[j];
+				n++;
+			}
+			pvec.nr = n;
 
 			if (pvec_pages && i == pvec_pages &&
 			    locked_pages < max_pages) {
 				dout("reached end pvec, trying for more\n");
-				pagevec_reinit(&pvec);
+				pagevec_release(&pvec);
 				goto get_more_pages;
 			}
-
-			/* shift unused pages over in the pvec...  we
-			 * will need to release them below. */
-			for (j = i; j < pvec_pages; j++) {
-				dout(" pvec leftover page %p\n", pvec.pages[j]);
-				pvec.pages[j-i+first] = pvec.pages[j];
-			}
-			pvec.nr -= i-first;
 		}
 
 new_request:
-- 
2.13.5

