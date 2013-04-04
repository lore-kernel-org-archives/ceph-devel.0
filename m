From: Alex Elder <elder@inktank.com>
Subject: [PATCH 9/9] ceph: build osd request message later for writepages
Date: Thu, 04 Apr 2013 11:20:21 -0500
Message-ID: <515DA845.2060204@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:50270 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763045Ab3DDQUX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:20:23 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so3236919iec.32
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:20:22 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hold off building the osd request message in ceph_writepages_start()
until just before it will be submitted to the osd client for
execution.

We'll still create the request and allocate the page pointer array
after we learn we have at least one page to write.  A local variable
will be used to keep track of the allocated array of pages.  Wait
until just before submitting the request for assigning that page
array pointer to the request message.

Create ands use a new function osd_req_op_extent_update() whose
purpose is to serve this one spot where the length value supplied
when an osd request's op was initially formatted might need to get
changed (reduced, never increased) before submitting the request.

Previously, ceph_writepages_start() assigned the message header's
data length because of this update.  That's no longer necessary,
because ceph_osdc_build_request() will recalculate the right
value to use based on the content of the ops in the request.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c                  |   59
++++++++++++++++++++++-----------------
 include/linux/ceph/osd_client.h |    1 +
 net/ceph/osd_client.c           |   13 +++++++++
 3 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 125d0a8..e0dd74c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -737,10 +737,14 @@ retry:

 	while (!done && index <= end) {
 		struct ceph_osd_req_op ops[2];
+		int num_ops = do_sync ? 2 : 1;
+		struct ceph_vino vino;
 		unsigned i;
 		int first;
 		pgoff_t next;
 		int pvec_pages, locked_pages;
+		struct page **pages = NULL;
+		mempool_t *pool = NULL;	/* Becomes non-null if mempool used */
 		struct page *page;
 		int want;
 		u64 offset, len;
@@ -824,16 +828,19 @@ get_more_pages:
 				break;
 			}

-			/* ok */
+			/*
+			 * We have something to write.  If this is
+			 * the first locked page this time through,
+			 * allocate an osd request and a page array
+			 * that it will use.
+			 */
 			if (locked_pages == 0) {
-				struct ceph_vino vino;
-				int num_ops = do_sync ? 2 : 1;
 				size_t size;
-				struct page **pages;
-				mempool_t *pool = NULL;
+
+				BUG_ON(pages);

 				/* prepare async write request */
-				offset = (u64) page_offset(page);
+				offset = (u64)page_offset(page);
 				len = wsize;
 				req = ceph_writepages_osd_request(inode,
 							offset, &len, snapc,
@@ -845,11 +852,6 @@ get_more_pages:
 					break;
 				}

-				vino = ceph_vino(inode);
-				ceph_osdc_build_request(req, offset,
-					num_ops, ops, snapc, vino.snap,
-					&inode->i_mtime);
-
 				req->r_callback = writepages_finish;
 				req->r_inode = inode;

@@ -858,16 +860,9 @@ get_more_pages:
 				pages = kmalloc(size, GFP_NOFS);
 				if (!pages) {
 					pool = fsc->wb_pagevec_pool;
-
 					pages = mempool_alloc(pool, GFP_NOFS);
-					WARN_ON(!pages);
+					BUG_ON(!pages);
 				}
-
-				req->r_data_out.pages = pages;
-				req->r_data_out.pages_from_pool = !!pool;
-				req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
-				req->r_data_out.length = len;
-				req->r_data_out.alignment = 0;
 			}

 			/* note position of first page in pvec */
@@ -885,7 +880,7 @@ get_more_pages:
 			}

 			set_page_writeback(page);
-			req->r_data_out.pages[locked_pages] = page;
+			pages[locked_pages] = page;
 			locked_pages++;
 			next = page->index + 1;
 		}
@@ -914,18 +909,30 @@ get_more_pages:
 			pvec.nr -= i-first;
 		}

-		/* submit the write */
-		offset = page_offset(req->r_data_out.pages[0]);
+		/* Format the osd request message and submit the write */
+
+		offset = page_offset(pages[0]);
 		len = min((snap_size ? snap_size : i_size_read(inode)) - offset,
 			  (u64)locked_pages << PAGE_CACHE_SHIFT);
 		dout("writepages got %d pages at %llu~%llu\n",
 		     locked_pages, offset, len);

-		/* revise final length, page count */
+		req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
+		req->r_data_out.pages = pages;
 		req->r_data_out.length = len;
-		req->r_request_ops[0].extent.length = cpu_to_le64(len);
-		req->r_request_ops[0].payload_len = cpu_to_le32(len);
-		req->r_request->hdr.data_len = cpu_to_le32(len);
+		req->r_data_out.alignment = 0;
+		req->r_data_out.pages_from_pool = !!pool;
+
+		pages = NULL;	/* request message now owns the pages array */
+		pool = NULL;
+
+		/* Update the write op length in case we changed it */
+
+		osd_req_op_extent_update(&ops[0], len);
+
+		vino = ceph_vino(inode);
+		ceph_osdc_build_request(req, offset, num_ops, ops,
+					snapc, vino.snap, &inode->i_mtime);

 		rc = ceph_osdc_start_request(&fsc->client->osdc, req, true);
 		BUG_ON(rc);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index ffaf907..5ee1a37 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -234,6 +234,7 @@ extern void osd_req_op_init(struct ceph_osd_req_op
*op, u16 opcode);
 extern void osd_req_op_extent_init(struct ceph_osd_req_op *op, u16 opcode,
 					u64 offset, u64 length,
 					u64 truncate_size, u32 truncate_seq);
+extern void osd_req_op_extent_update(struct ceph_osd_req_op *op, u64
length);
 extern void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
 					const char *class, const char *method,
 					const void *request_data,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 9ca693d..426ca1f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -296,6 +296,19 @@ void osd_req_op_extent_init(struct ceph_osd_req_op
*op, u16 opcode,
 }
 EXPORT_SYMBOL(osd_req_op_extent_init);

+void osd_req_op_extent_update(struct ceph_osd_req_op *op, u64 length)
+{
+	u64 previous = op->extent.length;
+
+	if (length == previous)
+		return;		/* Nothing to do */
+	BUG_ON(length > previous);
+
+	op->extent.length = length;
+	op->payload_len -= previous - length;
+}
+EXPORT_SYMBOL(osd_req_op_extent_update);
+
 void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
 			const char *class, const char *method,
 			const void *request_data, size_t request_data_size)
-- 
1.7.9.5

