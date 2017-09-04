From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 10/13] ceph: fix "range cyclic" mode writepages
Date: Mon,  4 Sep 2017 17:39:05 +0800
Message-ID: <20170904093908.57316-11-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753409AbdIDJkd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:40:33 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

In range cyclic mode, writepages() should first write dirty pages
in range [writeback_index, (pgoff_t)-1], then write pages in range
[0, writeback_index -1]. Besides, if writepages() encounters a page
that beyond EOF, it should restart from the beginning.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 221df531b0c3..46658d548a6e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -781,16 +781,15 @@ static int ceph_writepages_start(struct address_space *mapping,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_vino vino = ceph_vino(inode);
-	pgoff_t index, start, end;
-	int range_whole = 0;
-	int should_loop = 1;
+	pgoff_t index, start_index, end;
 	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
 	struct pagevec pvec;
-	int done = 0;
 	int rc = 0;
 	unsigned int wsize = i_blocksize(inode);
 	struct ceph_osd_request *req = NULL;
 	struct ceph_writeback_ctl ceph_wbc;
+	bool should_loop, range_whole = false;
+	bool stop, done = false;
 
 	dout("writepages_start %p (mode=%s)\n", inode,
 	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
@@ -810,20 +809,22 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 	pagevec_init(&pvec, 0);
 
+	start_index = wbc->range_cyclic ? mapping->writeback_index : 0;
+
 	/* where to start/end? */
 	if (wbc->range_cyclic) {
-		start = mapping->writeback_index; /* Start from prev offset */
+		index = start_index
 		end = -1;
-		dout(" cyclic, start at %lu\n", start);
+		should_loop = (index > 0);
+		dout(" cyclic, start at %lu\n", index);
 	} else {
-		start = wbc->range_start >> PAGE_SHIFT;
+		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			range_whole = 1;
-		should_loop = 0;
-		dout(" not cyclic, %lu to %lu\n", start, end);
+			range_whole = true;
+		should_loop = false;
+		dout(" not cyclic, %lu to %lu\n", index, end);
 	}
-	index = start;
 
 retry:
 	/* find oldest snap context with dirty data */
@@ -847,7 +848,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 	}
 	last_snapc = snapc;
 
-	while (!done && index <= end) {
+	stop = false;
+	while (!stop && index <= end) {
 		int num_ops = 0, op_idx;
 		unsigned i, pvec_pages, max_pages, locked_pages = 0;
 		struct page **pages = NULL, **data_pages;
@@ -885,9 +887,11 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				continue;
 			}
-			if (!wbc->range_cyclic && page->index > end) {
+			if (page->index > end) {
 				dout("end of range %p\n", page);
-				done = 1;
+				/* can't be range_cyclic (1st pass) because
+				 * end == -1 in that case. */
+				stop = done = true;
 				unlock_page(page);
 				break;
 			}
@@ -899,7 +903,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 			if (page_offset(page) >= ceph_wbc.i_size) {
 				dout("%p page eof %llu\n",
 				     page, ceph_wbc.i_size);
-				done = 1;
+				/* not done if range_cyclic */
+				stop = true;
 				unlock_page(page);
 				break;
 			}
@@ -1132,7 +1137,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			goto new_request;
 
 		if (wbc->nr_to_write <= 0)
-			done = 1;
+			stop = done = true;
 
 release_pvec_pages:
 		dout("pagevec_release on %d pages (%p)\n", (int)pvec.nr,
@@ -1146,7 +1151,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 	if (should_loop && !done) {
 		/* more to do; loop back to beginning of file */
 		dout("writepages looping back to beginning of file\n");
-		should_loop = 0;
+		should_loop = false;
+		end = start_index - 1;
+
 		index = 0;
 		goto retry;
 	}
-- 
2.13.5

