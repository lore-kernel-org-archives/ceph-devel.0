From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH V2 6/6] ceph: scattered page writeback
Date: Tue, 19 Jan 2016 16:08:11 +0800
Message-ID: <1453190891-40937-7-git-send-email-zyan@redhat.com>
References: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbcASIJC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 03:09:02 -0500
In-Reply-To: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

This patch makes ceph_writepages_start() try using single OSD request
to write all dirty pages within a strip. When a nonconsecutive dirty
page is found, ceph_writepages_start() tries starting a new write
operation to existing OSD request. If it succeeds, it uses the new
operation to writeback the dirty page.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c | 221 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 137 insertions(+), 84 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c222137..a423f02 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -606,71 +606,71 @@ static void writepages_finish(struct ceph_osd_request *req,
 	struct inode *inode = req->r_inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_data *osd_data;
-	unsigned wrote;
 	struct page *page;
-	int num_pages;
-	int i;
+	int num_pages, total_pages = 0;
+	int i, j;
+	int rc = req->r_result;
 	struct ceph_snap_context *snapc = req->r_snapc;
 	struct address_space *mapping = inode->i_mapping;
-	int rc = req->r_result;
-	u64 bytes = req->r_ops[0].extent.length;
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
-	long writeback_stat;
-	unsigned issued = ceph_caps_issued(ci);
+	bool remove_page;
 
-	osd_data = osd_req_op_extent_osd_data(req, 0);
-	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
-	num_pages = calc_pages_for((u64)osd_data->alignment,
-					(u64)osd_data->length);
-	if (rc >= 0) {
-		/*
-		 * Assume we wrote the pages we originally sent.  The
-		 * osd might reply with fewer pages if our writeback
-		 * raced with a truncation and was adjusted at the osd,
-		 * so don't believe the reply.
-		 */
-		wrote = num_pages;
-	} else {
-		wrote = 0;
+
+	dout("writepages_finish %p rc %d\n", inode, rc);
+	if (rc < 0)
 		mapping_set_error(mapping, rc);
-	}
-	dout("writepages_finish %p rc %d bytes %llu wrote %d (pages)\n",
-	     inode, rc, bytes, wrote);
 
-	/* clean all pages */
-	for (i = 0; i < num_pages; i++) {
-		page = osd_data->pages[i];
-		BUG_ON(!page);
-		WARN_ON(!PageUptodate(page));
+	/*
+	 * We lost the cache cap, need to truncate the page before
+	 * it is unlocked, otherwise we'd truncate it later in the
+	 * page truncation thread, possibly losing some data that
+	 * raced its way in
+	 */
+	remove_page = !(ceph_caps_issued(ci) &
+			(CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO));
 
-		writeback_stat =
-			atomic_long_dec_return(&fsc->writeback_count);
-		if (writeback_stat <
-		    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
-			clear_bdi_congested(&fsc->backing_dev_info,
-					    BLK_RW_ASYNC);
+	/* clean all pages */
+	for (i = 0; i < req->r_num_ops; i++) {
+		if (req->r_ops[i].op != CEPH_OSD_OP_WRITE)
+			break;
 
-		ceph_put_snap_context(page_snap_context(page));
-		page->private = 0;
-		ClearPagePrivate(page);
-		dout("unlocking %d %p\n", i, page);
-		end_page_writeback(page);
+		osd_data = osd_req_op_extent_osd_data(req, i);
+		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
+		num_pages = calc_pages_for((u64)osd_data->alignment,
+					   (u64)osd_data->length);
+		total_pages += num_pages;
+		for (j = 0; j < num_pages; j++) {
+			page = osd_data->pages[j];
+			BUG_ON(!page);
+			WARN_ON(!PageUptodate(page));
+
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+			     CONGESTION_OFF_THRESH(
+					fsc->mount_options->congestion_kb))
+				clear_bdi_congested(&fsc->backing_dev_info,
+						    BLK_RW_ASYNC);
+
+			ceph_put_snap_context(page_snap_context(page));
+			page->private = 0;
+			ClearPagePrivate(page);
+			dout("unlocking %p\n", page);
+			end_page_writeback(page);
+
+			if (remove_page)
+				generic_error_remove_page(inode->i_mapping,
+							  page);
 
-		/*
-		 * We lost the cache cap, need to truncate the page before
-		 * it is unlocked, otherwise we'd truncate it later in the
-		 * page truncation thread, possibly losing some data that
-		 * raced its way in
-		 */
-		if ((issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0)
-			generic_error_remove_page(inode->i_mapping, page);
+			unlock_page(page);
+		}
+		dout("writepages_finish %p wrote %llu bytes cleaned %d pages\n",
+		     inode, osd_data->length, rc >= 0 ? num_pages : 0);
 
-		unlock_page(page);
+		ceph_release_pages(osd_data->pages, num_pages);
 	}
-	dout("%p wrote+cleaned %d pages\n", inode, wrote);
-	ceph_put_wrbuffer_cap_refs(ci, num_pages, snapc);
 
-	ceph_release_pages(osd_data->pages, num_pages);
+	ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
+
+	osd_data = osd_req_op_extent_osd_data(req, 0);
 	if (osd_data->pages_from_pool)
 		mempool_free(osd_data->pages,
 			     ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
@@ -778,17 +778,15 @@ retry:
 	while (!done && index <= end) {
 		unsigned i;
 		int first;
-		pgoff_t next;
-		int pvec_pages, locked_pages;
-		struct page **pages = NULL;
+		pgoff_t strip_end = 0;
+		int num_ops = 0, max_ops = 0;
+		int pvec_pages, locked_pages = 0;
+		struct page **pages = NULL, **data_pages = NULL;
 		mempool_t *pool = NULL;	/* Becomes non-null if mempool used */
 		struct page *page;
 		int want;
-		u64 offset, len;
-		long writeback_stat;
+		u64 offset = 0, len = 0;
 
-		next = 0;
-		locked_pages = 0;
 		max_pages = max_pages_ever;
 
 get_more_pages:
@@ -824,8 +822,8 @@ get_more_pages:
 				unlock_page(page);
 				break;
 			}
-			if (next && (page->index != next)) {
-				dout("not consecutive %p\n", page);
+			if (strip_end && (page->index > strip_end)) {
+				dout("end of strip %p\n", page);
 				unlock_page(page);
 				break;
 			}
@@ -875,10 +873,11 @@ get_more_pages:
 				/* prepare async write request */
 				offset = (u64)page_offset(page);
 				len = wsize;
+				max_ops = CEPH_OSD_INITIAL_OP;
 				req = ceph_osdc_new_request(&fsc->client->osdc,
 							&ci->i_layout, vino,
-							offset, &len, 0,
-							do_sync ? 2 : 1,
+							offset, &len,
+							0, max_ops,
 							CEPH_OSD_OP_WRITE,
 							CEPH_OSD_FLAG_WRITE |
 							CEPH_OSD_FLAG_ONDISK,
@@ -890,9 +889,8 @@ get_more_pages:
 					break;
 				}
 
-				if (do_sync)
-					osd_req_op_init(req, 1,
-							CEPH_OSD_OP_STARTSYNC, 0);
+				strip_end = page->index +
+					    ((len - 1) >> PAGE_CACHE_SHIFT);
 
 				req->r_callback = writepages_finish;
 				req->r_inode = inode;
@@ -905,6 +903,60 @@ get_more_pages:
 					pages = mempool_alloc(pool, GFP_NOFS);
 					BUG_ON(!pages);
 				}
+
+				num_ops = 1;
+				data_pages = pages;
+				len = 0;
+			} else if (page->index !=
+				   (offset + len) >> PAGE_CACHE_SHIFT) {
+				u64 offset_inc;
+				bool new_op = true;
+
+				if (num_ops + do_sync == CEPH_OSD_MAX_OP) {
+					new_op = false;
+				} else if (num_ops + do_sync == max_ops) {
+					int new_max = max_ops;
+					int j;
+					for (j = i + 1; j < pvec_pages; j++) {
+						if (pvec.pages[j]->index >
+						    strip_end)
+							break;
+						if (pvec.pages[j]->index - 1 !=
+						    pvec.pages[j - 1]->index)
+							new_max++;
+					}
+					new_max++;
+					new_max = min(new_max, CEPH_OSD_MAX_OP);
+					if (ceph_osdc_extend_request(req,
+								new_max,
+								GFP_NOFS) >= 0)
+						max_ops = new_max;
+					else
+						new_op = false;
+				}
+				if (!new_op) {
+					redirty_page_for_writepage(wbc, page);
+					unlock_page(page);
+					break;
+				}
+
+				offset_inc = (u64)page_offset(page) - offset;
+				osd_req_op_extent_dup_last(req, offset_inc);
+
+				dout("writepages got pages at %llu~%llu\n",
+				      offset, len);
+
+				osd_req_op_extent_update(req, num_ops - 1, len);
+				osd_req_op_extent_osd_data_pages(req,
+								num_ops - 1,
+								data_pages,
+								len, 0,
+								!!pool, false);
+
+				num_ops++;
+				data_pages = pages + locked_pages;
+				offset = (u64)page_offset(page);
+				len = 0;
 			}
 
 			/* note position of first page in pvec */
@@ -913,9 +965,8 @@ get_more_pages:
 			dout("%p will write page %p idx %lu\n",
 			     inode, page, page->index);
 
-			writeback_stat =
-			       atomic_long_inc_return(&fsc->writeback_count);
-			if (writeback_stat > CONGESTION_ON_THRESH(
+			if (atomic_long_inc_return(&fsc->writeback_count) >
+			    CONGESTION_ON_THRESH(
 				    fsc->mount_options->congestion_kb)) {
 				set_bdi_congested(&fsc->backing_dev_info,
 						  BLK_RW_ASYNC);
@@ -924,7 +975,7 @@ get_more_pages:
 			set_page_writeback(page);
 			pages[locked_pages] = page;
 			locked_pages++;
-			next = page->index + 1;
+			len += PAGE_CACHE_SIZE;
 		}
 
 		/* did we get anything? */
@@ -952,31 +1003,34 @@ get_more_pages:
 		}
 
 		/* Format the osd request message and submit the write */
-		offset = page_offset(pages[0]);
-		len = (u64)locked_pages << PAGE_CACHE_SHIFT;
 		if (snap_size == -1) {
+			/* writepages_finish() clears writeback pages
+			 * according to the data length, so make sure
+			 * data length covers all locked pages */
+			u64 min_len = len + 1 - PAGE_CACHE_SIZE;
 			len = min(len, (u64)i_size_read(inode) - offset);
-			 /* writepages_finish() clears writeback pages
-			  * according to the data length, so make sure
-			  * data length covers all locked pages */
-			len = max(len, 1 +
-				((u64)(locked_pages - 1) << PAGE_CACHE_SHIFT));
+			len = max(len, min_len);
 		} else {
 			len = min(len, snap_size - offset);
 		}
-		dout("writepages got %d pages at %llu~%llu\n",
-		     locked_pages, offset, len);
+		dout("writepages got pages at %llu~%llu\n", offset, len);
 
-		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
-							!!pool, false);
+		osd_req_op_extent_osd_data_pages(req, num_ops - 1, data_pages,
+						 len, 0, !!pool, false);
+		osd_req_op_extent_update(req, num_ops - 1, len);
 
+		if (do_sync) {
+			osd_req_op_init(req, num_ops, CEPH_OSD_OP_STARTSYNC, 0);
+			num_ops++;
+		}
+		BUG_ON(num_ops > max_ops);
+
+		index = pages[locked_pages - 1]->index + 1;
 		pages = NULL;	/* request message now owns the pages array */
 		pool = NULL;
 
 		/* Update the write op length in case we changed it */
 
-		osd_req_op_extent_update(req, 0, len);
-
 		vino = ceph_vino(inode);
 		ceph_osdc_build_request(req, offset, snapc, vino.snap,
 					&inode->i_mtime);
@@ -986,7 +1040,6 @@ get_more_pages:
 		req = NULL;
 
 		/* continue? */
-		index = next;
 		wbc->nr_to_write -= locked_pages;
 		if (wbc->nr_to_write <= 0)
 			done = 1;
-- 
2.5.0

