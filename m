From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 13/13] ceph: wait on writeback after writing snapshot data
Date: Mon,  4 Sep 2017 17:39:08 +0800
Message-ID: <20170904093908.57316-14-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753390AbdIDJkz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:40:55 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

In sync mode, writepages() needs to write all dirty pages. But
it can only write dirty pages associated with the oldest snapc.
To write dirty pages associated with next snapc, it needs to wait
until current writes complete.

Without this wait, writepages() keeps looking up dirty pages, but
the found dirty pages are not writeable. It wastes CPU time.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1ffdb903eb79..b3e3edc09d80 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1165,6 +1165,30 @@ static int ceph_writepages_start(struct address_space *mapping,
 		/* more to do; loop back to beginning of file */
 		dout("writepages looping back to beginning of file\n");
 		end = start_index - 1; /* OK even when start_index == 0 */
+
+		/* to write dirty pages associated with next snapc,
+		 * we need to wait until current writes complete */
+		if (wbc->sync_mode != WB_SYNC_NONE &&
+		    start_index == 0 && /* all dirty pages were checked */
+		    !ceph_wbc.head_snapc) {
+			struct page *page;
+			unsigned i, nr;
+			index = 0;
+			while ((index <= end) &&
+			       (nr = pagevec_lookup_tag(&pvec, mapping, &index,
+							PAGECACHE_TAG_WRITEBACK,
+							PAGEVEC_SIZE))) {
+				for (i = 0; i < nr; i++) {
+					page = pvec.pages[i];
+					if (page_snap_context(page) != snapc)
+						continue;
+					wait_on_page_writeback(page);
+				}
+				pagevec_release(&pvec);
+				cond_resched();
+			}
+		}
+
 		start_index = 0;
 		index = 0;
 		goto retry;
-- 
2.13.5

