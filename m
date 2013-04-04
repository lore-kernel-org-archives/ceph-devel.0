From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/9] ceph: kill ceph alloc_page_vec()
Date: Thu, 04 Apr 2013 11:19:52 -0500
Message-ID: <515DA828.7070206@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:52975 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762988Ab3DDQTy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:19:54 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so2369502iak.24
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:19:53 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There is a helper function alloc_page_vec() that, despite its
generic sounding name depends heavily on an osd request structure
being populated with certain information.

There is only one place this function is used, and it ends up
being a bit simpler to just open code what it does, so get
rid of the helper.

The real motivation for this is deferring building the of the osd
request message, and this is a step in that direction.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c |   45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5b4ac17..e976c6d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -631,29 +631,6 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	ceph_osdc_put_request(req);
 }

-/*
- * allocate a page vec, either directly, or if necessary, via a the
- * mempool.  we avoid the mempool if we can because req->r_data_out.length
- * may be less than the maximum write size.
- */
-static void alloc_page_vec(struct ceph_fs_client *fsc,
-			   struct ceph_osd_request *req)
-{
-	size_t size;
-	int num_pages;
-
-	num_pages = calc_pages_for((u64)req->r_data_out.alignment,
-					(u64)req->r_data_out.length);
-	size = sizeof (struct page *) * num_pages;
-	req->r_data_out.pages = kmalloc(size, GFP_NOFS);
-	if (!req->r_data_out.pages) {
-		req->r_data_out.pages = mempool_alloc(fsc->wb_pagevec_pool,
-							GFP_NOFS);
-		req->r_data_out.pages_from_pool = 1;
-		WARN_ON(!req->r_data_out.pages);
-	}
-}
-
 static struct ceph_osd_request *
 ceph_writepages_osd_request(struct inode *inode, u64 offset, u64 *len,
 				struct ceph_snap_context *snapc,
@@ -851,6 +828,9 @@ get_more_pages:
 			if (locked_pages == 0) {
 				struct ceph_vino vino;
 				int num_ops = do_sync ? 2 : 1;
+				size_t size;
+				struct page **pages;
+				mempool_t *pool = NULL;

 				/* prepare async write request */
 				offset = (u64) page_offset(page);
@@ -870,13 +850,24 @@ get_more_pages:
 					num_ops, ops, snapc, vino.snap,
 					&inode->i_mtime);

+				req->r_callback = writepages_finish;
+				req->r_inode = inode;
+
+				max_pages = calc_pages_for(0, (u64)len);
+				size = max_pages * sizeof (*pages);
+				pages = kmalloc(size, GFP_NOFS);
+				if (!pages) {
+					pool = fsc->wb_pagevec_pool;
+
+					pages = mempool_alloc(pool, GFP_NOFS);
+					WARN_ON(!pages);
+				}
+
+				req->r_data_out.pages = pages;
+				req->r_data_out.pages_from_pool = !!pool;
 				req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
 				req->r_data_out.length = len;
 				req->r_data_out.alignment = 0;
-				max_pages = calc_pages_for(0, (u64)len);
-				alloc_page_vec(fsc, req);
-				req->r_callback = writepages_finish;
-				req->r_inode = inode;
 			}

 			/* note position of first page in pvec */
-- 
1.7.9.5

