From: Alex Elder <elder@inktank.com>
Subject: [PATCH 8/8] libceph: record byte count not page count
Date: Sat, 09 Mar 2013 09:15:37 -0600
Message-ID: <513B5219.9040803@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:37828 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310Ab3CIPPk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:15:40 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so2382685iaz.30
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:15:39 -0800 (PST)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Record the byte count for an osd request rather than the page count.
The number of pages can always be derived from the byte count (and
alignment/offset) but the reverse is not true.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    2 +-
 fs/ceph/addr.c                  |   33 ++++++++++++++++----------
 fs/ceph/file.c                  |    2 +-
 include/linux/ceph/osd_client.h |    2 +-
 net/ceph/osd_client.c           |   50
+++++++++++++++++++++++----------------
 5 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a0a6182..ae6b976 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1420,7 +1420,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	case OBJ_REQUEST_PAGES:
 		osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
 		osd_data->pages = obj_request->pages;
-		osd_data->num_pages = obj_request->page_count;
+		osd_data->length = obj_request->length;
 		osd_data->alignment = offset & ~PAGE_MASK;
 		osd_data->pages_from_pool = false;
 		osd_data->own_pages = false;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ceb2829..67d4965 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -238,13 +238,16 @@ static void finish_read(struct ceph_osd_request
*req, struct ceph_msg *msg)
 	struct inode *inode = req->r_inode;
 	int rc = req->r_result;
 	int bytes = le32_to_cpu(msg->hdr.data_len);
+	int num_pages;
 	int i;

 	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);

 	/* unlock all pages, zeroing any data we didn't read */
 	BUG_ON(req->r_data_in.type != CEPH_OSD_DATA_TYPE_PAGES);
-	for (i = 0; i < req->r_data_in.num_pages; i++) {
+	num_pages = calc_pages_for((u64)req->r_data_in.alignment,
+					(u64)req->r_data_in.length);
+	for (i = 0; i < num_pages; i++) {
 		struct page *page = req->r_data_in.pages[i];

 		if (bytes < (int)PAGE_CACHE_SIZE) {
@@ -340,7 +343,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	}
 	req->r_data_in.type = CEPH_OSD_DATA_TYPE_PAGES;
 	req->r_data_in.pages = pages;
-	req->r_data_in.num_pages = nr_pages;
+	req->r_data_in.length = len;
 	req->r_data_in.alignment = 0;
 	req->r_callback = finish_read;
 	req->r_inode = inode;
@@ -555,6 +558,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned wrote;
 	struct page *page;
+	int num_pages;
 	int i;
 	struct ceph_snap_context *snapc = req->r_snapc;
 	struct address_space *mapping = inode->i_mapping;
@@ -565,6 +569,8 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	unsigned issued = ceph_caps_issued(ci);

 	BUG_ON(req->r_data_out.type != CEPH_OSD_DATA_TYPE_PAGES);
+	num_pages = calc_pages_for((u64)req->r_data_out.alignment,
+					(u64)req->r_data_out.length);
 	if (rc >= 0) {
 		/*
 		 * Assume we wrote the pages we originally sent.  The
@@ -572,7 +578,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 		 * raced with a truncation and was adjusted at the osd,
 		 * so don't believe the reply.
 		 */
-		wrote = req->r_data_out.num_pages;
+		wrote = num_pages;
 	} else {
 		wrote = 0;
 		mapping_set_error(mapping, rc);
@@ -581,7 +587,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	     inode, rc, bytes, wrote);

 	/* clean all pages */
-	for (i = 0; i < req->r_data_out.num_pages; i++) {
+	for (i = 0; i < num_pages; i++) {
 		page = req->r_data_out.pages[i];
 		BUG_ON(!page);
 		WARN_ON(!PageUptodate(page));
@@ -611,9 +617,9 @@ static void writepages_finish(struct
ceph_osd_request *req,
 		unlock_page(page);
 	}
 	dout("%p wrote+cleaned %d pages\n", inode, wrote);
-	ceph_put_wrbuffer_cap_refs(ci, req->r_data_out.num_pages, snapc);
+	ceph_put_wrbuffer_cap_refs(ci, num_pages, snapc);

-	ceph_release_pages(req->r_data_out.pages, req->r_data_out.num_pages);
+	ceph_release_pages(req->r_data_out.pages, num_pages);
 	if (req->r_data_out.pages_from_pool)
 		mempool_free(req->r_data_out.pages,
 			     ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
@@ -624,15 +630,18 @@ static void writepages_finish(struct
ceph_osd_request *req,

 /*
  * allocate a page vec, either directly, or if necessary, via a the
- * mempool.  we avoid the mempool if we can because
req->r_data_out.num_pages
+ * mempool.  we avoid the mempool if we can because req->r_data_out.length
  * may be less than the maximum write size.
  */
 static void alloc_page_vec(struct ceph_fs_client *fsc,
 			   struct ceph_osd_request *req)
 {
 	size_t size;
+	int num_pages;

-	size = sizeof (struct page *) * req->r_data_out.num_pages;
+	num_pages = calc_pages_for((u64)req->r_data_out.alignment,
+					(u64)req->r_data_out.length);
+	size = sizeof (struct page *) * num_pages;
 	req->r_data_out.pages = kmalloc(size, GFP_NOFS);
 	if (!req->r_data_out.pages) {
 		req->r_data_out.pages = mempool_alloc(fsc->wb_pagevec_pool,
@@ -838,11 +847,9 @@ get_more_pages:
 				}

 				req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
-				req->r_data_out.num_pages =
-						calc_pages_for(0, len);
+				req->r_data_out.length = len;
 				req->r_data_out.alignment = 0;
-				max_pages = req->r_data_out.num_pages;
-
+				max_pages = calc_pages_for(0, (u64)len);
 				alloc_page_vec(fsc, req);
 				req->r_callback = writepages_finish;
 				req->r_inode = inode;
@@ -900,7 +907,7 @@ get_more_pages:
 		     locked_pages, offset, len);

 		/* revise final length, page count */
-		req->r_data_out.num_pages = locked_pages;
+		req->r_data_out.length = len;
 		req->r_request_ops[0].extent.length = cpu_to_le64(len);
 		req->r_request_ops[0].payload_len = cpu_to_le32(len);
 		req->r_request->hdr.data_len = cpu_to_le32(len);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3e0a6da..1cd009a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -573,7 +573,7 @@ more:
 	}
 	req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
 	req->r_data_out.pages = pages;
-	req->r_data_out.num_pages = num_pages;
+	req->r_data_out.length = len;
 	req->r_data_out.alignment = page_align;
 	req->r_inode = inode;

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 40e0260..a8016df 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -63,7 +63,7 @@ struct ceph_osd_data {
 	union {
 		struct {
 			struct page	**pages;
-			u32		num_pages;
+			u64		length;
 			u32		alignment;
 			bool		pages_from_pool;
 			bool		own_pages;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f9cf445..202af14 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -107,6 +107,7 @@ static int calc_layout(struct ceph_file_layout
*layout, u64 off, u64 *plen,
  */
 void ceph_osdc_release_request(struct kref *kref)
 {
+	int num_pages;
 	struct ceph_osd_request *req = container_of(kref,
 						    struct ceph_osd_request,
 						    r_kref);
@@ -124,13 +125,17 @@ void ceph_osdc_release_request(struct kref *kref)
 		ceph_msg_put(req->r_reply);

 	if (req->r_data_in.type == CEPH_OSD_DATA_TYPE_PAGES &&
-			req->r_data_in.own_pages)
-		ceph_release_page_vector(req->r_data_in.pages,
-					 req->r_data_in.num_pages);
+			req->r_data_in.own_pages) {
+		num_pages = calc_pages_for((u64)req->r_data_in.alignment,
+						(u64)req->r_data_in.length);
+		ceph_release_page_vector(req->r_data_in.pages, num_pages);
+	}
 	if (req->r_data_out.type == CEPH_OSD_DATA_TYPE_PAGES &&
-			req->r_data_out.own_pages)
-		ceph_release_page_vector(req->r_data_out.pages,
-					 req->r_data_out.num_pages);
+			req->r_data_out.own_pages) {
+		num_pages = calc_pages_for((u64)req->r_data_out.alignment,
+						(u64)req->r_data_out.length);
+		ceph_release_page_vector(req->r_data_out.pages, num_pages);
+	}

 	ceph_put_snap_context(req->r_snapc);
 	ceph_pagelist_release(&req->r_trail);
@@ -1753,8 +1758,12 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,

 	osd_data = &req->r_data_out;
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
+		unsigned int page_count;
+
 		req->r_request->pages = osd_data->pages;
-		req->r_request->page_count = osd_data->num_pages;
+		page_count = calc_pages_for((u64)osd_data->alignment,
+						(u64)osd_data->length);
+		req->r_request->page_count = page_count;
 		req->r_request->page_alignment = osd_data->alignment;
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
@@ -1967,11 +1976,11 @@ int ceph_osdc_readpages(struct ceph_osd_client
*osdc,
 	osd_data = &req->r_data_in;
 	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
 	osd_data->pages = pages;
-	osd_data->num_pages = calc_pages_for(page_align, *plen);
+	osd_data->length = *plen;
 	osd_data->alignment = page_align;

-	dout("readpages  final extent is %llu~%llu (%d pages align %d)\n",
-	     off, *plen, osd_data->num_pages, page_align);
+	dout("readpages  final extent is %llu~%llu (%llu bytes align %d)\n",
+	     off, *plen, osd_data->length, page_align);

 	rc = ceph_osdc_start_request(osdc, req, false);
 	if (!rc)
@@ -2013,10 +2022,9 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 	osd_data = &req->r_data_out;
 	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
 	osd_data->pages = pages;
-	osd_data->num_pages = calc_pages_for(page_align, len);
+	osd_data->length = len;
 	osd_data->alignment = page_align;
-	dout("writepages %llu~%llu (%d pages)\n", off, len,
-		osd_data->num_pages);
+	dout("writepages %llu~%llu (%llu bytes)\n", off, len, osd_data->length);

 	rc = ceph_osdc_start_request(osdc, req, true);
 	if (!rc)
@@ -2112,23 +2120,23 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 		struct ceph_osd_data *osd_data = &req->r_data_in;

 		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-			int want;
+			unsigned int page_count;

-			want = calc_pages_for(osd_data->alignment, data_len);
 			if (osd_data->pages &&
-				unlikely(osd_data->num_pages < want)) {
+				unlikely(osd_data->length < data_len)) {

-				pr_warning("tid %lld reply has %d bytes %d "
-					"pages, we had only %d pages ready\n",
-					tid, data_len, want,
-					osd_data->num_pages);
+				pr_warning("tid %lld reply has %d bytes "
+					"we had only %llu bytes ready\n",
+					tid, data_len, osd_data->length);
 				*skip = 1;
 				ceph_msg_put(m);
 				m = NULL;
 				goto out;
 			}
+			page_count = calc_pages_for((u64)osd_data->alignment,
+							(u64)osd_data->length);
 			m->pages = osd_data->pages;
-			m->page_count = osd_data->num_pages;
+			m->page_count = page_count;
 			m->page_alignment = osd_data->alignment;
 #ifdef CONFIG_BLOCK
 		} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-- 
1.7.9.5

