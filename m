From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: separate read and write data
Date: Mon, 04 Mar 2013 12:18:27 -0600
Message-ID: <5134E573.2070508@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E515.6010006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35832 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757830Ab3CDSS0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:18:26 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so6449279iea.26
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:18:26 -0800 (PST)
In-Reply-To: <5134E515.6010006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An osd request defines information about where data to be read
should be placed as well as where data to write comes from.
Currently these are represented by common fields.

Keep information about data for writing separate from data to be
read by splitting these into data_in and data_out fields.

This is the key patch in this whole series, in that it actually
identifies which osd requests generate outgoing data and which
generate incoming data.  It's less obvious (currently) that an osd
CALL op generates both outgoing and incoming data; that's the focus
of some upcoming work.

This resolves:
    http://tracker.ceph.com/issues/4127

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |   18 +++++----
 fs/ceph/addr.c                  |   67 ++++++++++++++++---------------
 fs/ceph/file.c                  |   10 ++---
 include/linux/ceph/osd_client.h |    5 ++-
 net/ceph/osd_client.c           |   83
++++++++++++++++++++++++---------------
 5 files changed, 105 insertions(+), 78 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 70c3b39..a0a6182 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1385,6 +1385,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	struct ceph_snap_context *snapc = NULL;
 	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *osd_req;
+	struct ceph_osd_data *osd_data;
 	struct timespec now;
 	struct timespec *mtime;
 	u64 snap_id = CEPH_NOSNAP;
@@ -1405,6 +1406,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
+	osd_data = write_request ? &osd_req->r_data_out : &osd_req->r_data_in;

 	rbd_assert(obj_request_type_valid(obj_request->type));
 	switch (obj_request->type) {
@@ -1412,16 +1414,16 @@ static struct ceph_osd_request *rbd_osd_req_create(
 		break;		/* Nothing to do */
 	case OBJ_REQUEST_BIO:
 		rbd_assert(obj_request->bio_list != NULL);
-		osd_req->r_data.type = CEPH_OSD_DATA_TYPE_BIO;
-		osd_req->r_data.bio = obj_request->bio_list;
+		osd_data->type = CEPH_OSD_DATA_TYPE_BIO;
+		osd_data->bio = obj_request->bio_list;
 		break;
 	case OBJ_REQUEST_PAGES:
-		osd_req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
-		osd_req->r_data.pages = obj_request->pages;
-		osd_req->r_data.num_pages = obj_request->page_count;
-		osd_req->r_data.alignment = offset & ~PAGE_MASK;
-		osd_req->r_data.pages_from_pool = false;
-		osd_req->r_data.own_pages = false;
+		osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
+		osd_data->pages = obj_request->pages;
+		osd_data->num_pages = obj_request->page_count;
+		osd_data->alignment = offset & ~PAGE_MASK;
+		osd_data->pages_from_pool = false;
+		osd_data->own_pages = false;
 		break;
 	}

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1cf7894..6b223d5 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -243,9 +243,9 @@ static void finish_read(struct ceph_osd_request
*req, struct ceph_msg *msg)
 	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);

 	/* unlock all pages, zeroing any data we didn't read */
-	BUG_ON(req->r_data.type != CEPH_OSD_DATA_TYPE_PAGES);
-	for (i = 0; i < req->r_data.num_pages; i++, bytes -= PAGE_CACHE_SIZE) {
-		struct page *page = req->r_data.pages[i];
+	BUG_ON(req->r_data_in.type != CEPH_OSD_DATA_TYPE_PAGES);
+	for (i = 0; i < req->r_data_in.num_pages; i++) {
+		struct page *page = req->r_data_in.pages[i];

 		if (bytes < (int)PAGE_CACHE_SIZE) {
 			/* zero (remainder of) page */
@@ -258,8 +258,9 @@ static void finish_read(struct ceph_osd_request
*req, struct ceph_msg *msg)
 		SetPageUptodate(page);
 		unlock_page(page);
 		page_cache_release(page);
+		bytes -= PAGE_CACHE_SIZE;
 	}
-	kfree(req->r_data.pages);
+	kfree(req->r_data_in.pages);
 }

 static void ceph_unlock_page_vector(struct page **pages, int num_pages)
@@ -337,10 +338,10 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 		}
 		pages[i] = page;
 	}
-	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
-	req->r_data.pages = pages;
-	req->r_data.num_pages = nr_pages;
-	req->r_data.alignment = 0;
+	req->r_data_in.type = CEPH_OSD_DATA_TYPE_PAGES;
+	req->r_data_in.pages = pages;
+	req->r_data_in.num_pages = nr_pages;
+	req->r_data_in.alignment = 0;
 	req->r_callback = finish_read;
 	req->r_inode = inode;

@@ -563,7 +564,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	long writeback_stat;
 	unsigned issued = ceph_caps_issued(ci);

-	BUG_ON(req->r_data.type != CEPH_OSD_DATA_TYPE_PAGES);
+	BUG_ON(req->r_data_out.type != CEPH_OSD_DATA_TYPE_PAGES);
 	if (rc >= 0) {
 		/*
 		 * Assume we wrote the pages we originally sent.  The
@@ -571,7 +572,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 		 * raced with a truncation and was adjusted at the osd,
 		 * so don't believe the reply.
 		 */
-		wrote = req->r_data.num_pages;
+		wrote = req->r_data_out.num_pages;
 	} else {
 		wrote = 0;
 		mapping_set_error(mapping, rc);
@@ -580,8 +581,8 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	     inode, rc, bytes, wrote);

 	/* clean all pages */
-	for (i = 0; i < req->r_data.num_pages; i++) {
-		page = req->r_data.pages[i];
+	for (i = 0; i < req->r_data_out.num_pages; i++) {
+		page = req->r_data_out.pages[i];
 		BUG_ON(!page);
 		WARN_ON(!PageUptodate(page));

@@ -610,31 +611,34 @@ static void writepages_finish(struct
ceph_osd_request *req,
 		unlock_page(page);
 	}
 	dout("%p wrote+cleaned %d pages\n", inode, wrote);
-	ceph_put_wrbuffer_cap_refs(ci, req->r_data.num_pages, snapc);
+	ceph_put_wrbuffer_cap_refs(ci, req->r_data_out.num_pages, snapc);

-	ceph_release_pages(req->r_data.pages, req->r_data.num_pages);
-	if (req->r_data.pages_from_pool)
-		mempool_free(req->r_data.pages,
+	ceph_release_pages(req->r_data_out.pages, req->r_data_out.num_pages);
+	if (req->r_data_out.pages_from_pool)
+		mempool_free(req->r_data_out.pages,
 			     ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
 	else
-		kfree(req->r_data.pages);
+		kfree(req->r_data_out.pages);
 	ceph_osdc_put_request(req);
 }

 /*
  * allocate a page vec, either directly, or if necessary, via a the
- * mempool.  we avoid the mempool if we can because req->r_data.num_pages
+ * mempool.  we avoid the mempool if we can because
req->r_data_out.num_pages
  * may be less than the maximum write size.
  */
 static void alloc_page_vec(struct ceph_fs_client *fsc,
 			   struct ceph_osd_request *req)
 {
-	req->r_data.pages = kmalloc(sizeof(struct page *) * req->r_data.num_pages,
-			       GFP_NOFS);
-	if (!req->r_data.pages) {
-		req->r_data.pages = mempool_alloc(fsc->wb_pagevec_pool, GFP_NOFS);
-		req->r_data.pages_from_pool = 1;
-		WARN_ON(!req->r_data.pages);
+	size_t size;
+
+	size = sizeof (struct page *) * req->r_data_out.num_pages;
+	req->r_data_out.pages = kmalloc(size, GFP_NOFS);
+	if (!req->r_data_out.pages) {
+		req->r_data_out.pages = mempool_alloc(fsc->wb_pagevec_pool,
+							GFP_NOFS);
+		req->r_data_out.pages_from_pool = 1;
+		WARN_ON(!req->r_data_out.pages);
 	}
 }

@@ -833,10 +837,11 @@ get_more_pages:
 					break;
 				}

-				req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
-				req->r_data.num_pages = calc_pages_for(0, len);
-				req->r_data.alignment = 0;
-				max_pages = req->r_data.num_pages;
+				req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
+				req->r_data_out.num_pages =
+						calc_pages_for(0, len);
+				req->r_data_out.alignment = 0;
+				max_pages = req->r_data_out.num_pages;

 				alloc_page_vec(fsc, req);
 				req->r_callback = writepages_finish;
@@ -858,7 +863,7 @@ get_more_pages:
 			}

 			set_page_writeback(page);
-			req->r_data.pages[locked_pages] = page;
+			req->r_data_out.pages[locked_pages] = page;
 			locked_pages++;
 			next = page->index + 1;
 		}
@@ -888,14 +893,14 @@ get_more_pages:
 		}

 		/* submit the write */
-		offset = req->r_data.pages[0]->index << PAGE_CACHE_SHIFT;
+		offset = req->r_data_out.pages[0]->index << PAGE_CACHE_SHIFT;
 		len = min((snap_size ? snap_size : i_size_read(inode)) - offset,
 			  (u64)locked_pages << PAGE_CACHE_SHIFT);
 		dout("writepages got %d pages at %llu~%llu\n",
 		     locked_pages, offset, len);

 		/* revise final length, page count */
-		req->r_data.num_pages = locked_pages;
+		req->r_data_out.num_pages = locked_pages;
 		req->r_request_ops[0].extent.length = cpu_to_le64(len);
 		req->r_request_ops[0].payload_len = cpu_to_le32(len);
 		req->r_request->hdr.data_len = cpu_to_le32(len);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 0f7b3f4..431cd7b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -568,13 +568,13 @@ more:
 		if ((file->f_flags & O_SYNC) == 0) {
 			/* get a second commit callback */
 			req->r_safe_callback = sync_write_commit;
-			req->r_data.own_pages = 1;
+			req->r_data_out.own_pages = 1;
 		}
 	}
-	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
-	req->r_data.pages = pages;
-	req->r_data.num_pages = num_pages;
-	req->r_data.alignment = page_align;
+	req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
+	req->r_data_out.pages = pages;
+	req->r_data_out.num_pages = num_pages;
+	req->r_data_out.alignment = page_align;
 	req->r_inode = inode;

 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 56604b3..40e0260 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -130,8 +130,9 @@ struct ceph_osd_request {
 	struct ceph_file_layout r_file_layout;
 	struct ceph_snap_context *r_snapc;    /* snap context for writes */

-	struct ceph_osd_data r_data;
-	struct ceph_pagelist r_trail;	      /* trailing part of the data */
+	struct ceph_osd_data r_data_in;
+	struct ceph_osd_data r_data_out;
+	struct ceph_pagelist r_trail;	      /* trailing part of data out */
 };

 struct ceph_osd_event {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 591e1b0..f9cf445 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -122,10 +122,16 @@ void ceph_osdc_release_request(struct kref *kref)
 	}
 	if (req->r_reply)
 		ceph_msg_put(req->r_reply);
-	if (req->r_data.type == CEPH_OSD_DATA_TYPE_PAGES &&
-			req->r_data.own_pages)
-		ceph_release_page_vector(req->r_data.pages,
-					 req->r_data.num_pages);
+
+	if (req->r_data_in.type == CEPH_OSD_DATA_TYPE_PAGES &&
+			req->r_data_in.own_pages)
+		ceph_release_page_vector(req->r_data_in.pages,
+					 req->r_data_in.num_pages);
+	if (req->r_data_out.type == CEPH_OSD_DATA_TYPE_PAGES &&
+			req->r_data_out.own_pages)
+		ceph_release_page_vector(req->r_data_out.pages,
+					 req->r_data_out.num_pages);
+
 	ceph_put_snap_context(req->r_snapc);
 	ceph_pagelist_release(&req->r_trail);
 	if (req->r_mempool)
@@ -189,7 +195,8 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	}
 	req->r_reply = msg;

-	req->r_data.type = CEPH_OSD_DATA_TYPE_NONE;
+	req->r_data_in.type = CEPH_OSD_DATA_TYPE_NONE;
+	req->r_data_out.type = CEPH_OSD_DATA_TYPE_NONE;
 	ceph_pagelist_init(&req->r_trail);

 	/* create request message; allow space for oid */
@@ -1740,17 +1747,21 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,
 			    bool nofail)
 {
 	int rc = 0;
+	struct ceph_osd_data *osd_data;
+
+	/* Set up outgoing data */

-	if (req->r_data.type == CEPH_OSD_DATA_TYPE_PAGES) {
-		req->r_request->pages = req->r_data.pages;
-		req->r_request->page_count = req->r_data.num_pages;
-		req->r_request->page_alignment = req->r_data.alignment;
+	osd_data = &req->r_data_out;
+	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
+		req->r_request->pages = osd_data->pages;
+		req->r_request->page_count = osd_data->num_pages;
+		req->r_request->page_alignment = osd_data->alignment;
 #ifdef CONFIG_BLOCK
-	} else if (req->r_data.type == CEPH_OSD_DATA_TYPE_BIO) {
-		req->r_request->bio = req->r_data.bio;
+	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
+		req->r_request->bio = osd_data->bio;
 #endif
 	} else {
-		pr_err("unknown request data type %d\n", req->r_data.type);
+		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
 	}
 	req->r_request->trail = &req->r_trail;

@@ -1939,6 +1950,7 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 			struct page **pages, int num_pages, int page_align)
 {
 	struct ceph_osd_request *req;
+	struct ceph_osd_data *osd_data;
 	int rc = 0;

 	dout("readpages on ino %llx.%llx on %llu~%llu\n", vino.ino,
@@ -1951,13 +1963,15 @@ int ceph_osdc_readpages(struct ceph_osd_client
*osdc,
 		return PTR_ERR(req);

 	/* it may be a short read due to an object boundary */
-	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
-	req->r_data.pages = pages;
-	req->r_data.num_pages = calc_pages_for(page_align, *plen);
-	req->r_data.alignment = page_align;
+
+	osd_data = &req->r_data_in;
+	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
+	osd_data->pages = pages;
+	osd_data->num_pages = calc_pages_for(page_align, *plen);
+	osd_data->alignment = page_align;

 	dout("readpages  final extent is %llu~%llu (%d pages align %d)\n",
-	     off, *plen, req->r_data.num_pages, page_align);
+	     off, *plen, osd_data->num_pages, page_align);

 	rc = ceph_osdc_start_request(osdc, req, false);
 	if (!rc)
@@ -1981,6 +1995,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 			 struct page **pages, int num_pages)
 {
 	struct ceph_osd_request *req;
+	struct ceph_osd_data *osd_data;
 	int rc = 0;
 	int page_align = off & ~PAGE_MASK;

@@ -1995,11 +2010,13 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 		return PTR_ERR(req);

 	/* it may be a short write due to an object boundary */
-	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
-	req->r_data.pages = pages;
-	req->r_data.num_pages = calc_pages_for(page_align, len);
-	req->r_data.alignment = page_align;
-	dout("writepages %llu~%llu (%d pages)\n", off, len,
req->r_data.num_pages);
+	osd_data = &req->r_data_out;
+	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
+	osd_data->pages = pages;
+	osd_data->num_pages = calc_pages_for(page_align, len);
+	osd_data->alignment = page_align;
+	dout("writepages %llu~%llu (%d pages)\n", off, len,
+		osd_data->num_pages);

 	rc = ceph_osdc_start_request(osdc, req, true);
 	if (!rc)
@@ -2092,28 +2109,30 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 	m = ceph_msg_get(req->r_reply);

 	if (data_len > 0) {
-		if (req->r_data.type == CEPH_OSD_DATA_TYPE_PAGES) {
+		struct ceph_osd_data *osd_data = &req->r_data_in;
+
+		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 			int want;

-			want = calc_pages_for(req->r_data.alignment, data_len);
-			if (req->r_data.pages &&
-				unlikely(req->r_data.num_pages < want)) {
+			want = calc_pages_for(osd_data->alignment, data_len);
+			if (osd_data->pages &&
+				unlikely(osd_data->num_pages < want)) {

 				pr_warning("tid %lld reply has %d bytes %d "
 					"pages, we had only %d pages ready\n",
 					tid, data_len, want,
-					req->r_data.num_pages);
+					osd_data->num_pages);
 				*skip = 1;
 				ceph_msg_put(m);
 				m = NULL;
 				goto out;
 			}
-			m->pages = req->r_data.pages;
-			m->page_count = req->r_data.num_pages;
-			m->page_alignment = req->r_data.alignment;
+			m->pages = osd_data->pages;
+			m->page_count = osd_data->num_pages;
+			m->page_alignment = osd_data->alignment;
 #ifdef CONFIG_BLOCK
-		} else if (req->r_data.type == CEPH_OSD_DATA_TYPE_BIO) {
-			m->bio = req->r_data.bio;
+		} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
+			m->bio = osd_data->bio;
 #endif
 		}
 	}
-- 
1.7.9.5

