From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 09/13] ceph: cleanup local varibles in ceph_writepages_start()
Date: Mon,  4 Sep 2017 17:39:04 +0800
Message-ID: <20170904093908.57316-10-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753492AbdIDJkY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:40:24 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

remove two varibles and define varibles of same type together.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5ca887bb5cae..221df531b0c3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -784,7 +784,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 	pgoff_t index, start, end;
 	int range_whole = 0;
 	int should_loop = 1;
-	pgoff_t max_pages = 0, max_pages_ever = 0;
 	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
 	struct pagevec pvec;
 	int done = 0;
@@ -808,7 +807,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 	}
 	if (fsc->mount_options->wsize < wsize)
 		wsize = fsc->mount_options->wsize;
-	max_pages_ever = wsize >> PAGE_SHIFT;
 
 	pagevec_init(&pvec, 0);
 
@@ -850,26 +848,25 @@ static int ceph_writepages_start(struct address_space *mapping,
 	last_snapc = snapc;
 
 	while (!done && index <= end) {
-		unsigned i;
-		pgoff_t strip_unit_end = 0;
 		int num_ops = 0, op_idx;
-		int pvec_pages, locked_pages = 0;
+		unsigned i, pvec_pages, max_pages, locked_pages = 0;
 		struct page **pages = NULL, **data_pages;
 		mempool_t *pool = NULL;	/* Becomes non-null if mempool used */
 		struct page *page;
-		int want;
+		pgoff_t strip_unit_end = 0;
 		u64 offset = 0, len = 0;
 
-		max_pages = max_pages_ever;
+		max_pages = wsize >> PAGE_SHIFT;
 
 get_more_pages:
-		want = min(end - index,
-			   min((pgoff_t)PAGEVEC_SIZE,
-			       max_pages - (pgoff_t)locked_pages) - 1)
-			+ 1;
+		pvec_pages = min_t(unsigned, PAGEVEC_SIZE,
+				   max_pages - locked_pages);
+		if (end - index < (u64)(pvec_pages - 1))
+			pvec_pages = (unsigned)(end - index) + 1;
+
 		pvec_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 						PAGECACHE_TAG_DIRTY,
-						want);
+						pvec_pages);
 		dout("pagevec_lookup_tag got %d\n", pvec_pages);
 		if (!pvec_pages && !locked_pages)
 			break;
-- 
2.13.5

