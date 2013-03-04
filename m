From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] libceph: separate osd request data info
Date: Mon, 04 Mar 2013 12:17:49 -0600
Message-ID: <5134E54D.1040900@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E515.6010006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:54496 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757830Ab3CDSRu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:17:50 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so4986873iac.7
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:17:48 -0800 (PST)
In-Reply-To: <5134E515.6010006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Pull the fields in an osd request structure that define the data for
the request out into a separate structure.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    8 +++---
 fs/ceph/addr.c                  |   59
+++++++++++++++++++++------------------
 fs/ceph/file.c                  |    8 +++---
 include/linux/ceph/osd_client.h |   24 ++++++++++------
 net/ceph/osd_client.c           |   44 ++++++++++++++---------------
 5 files changed, 78 insertions(+), 65 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6c81a4c..dcf08f2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1412,12 +1412,12 @@ static struct ceph_osd_request *rbd_osd_req_create(
 		break;		/* Nothing to do */
 	case OBJ_REQUEST_BIO:
 		rbd_assert(obj_request->bio_list != NULL);
-		osd_req->r_bio = obj_request->bio_list;
+		osd_req->r_data.bio = obj_request->bio_list;
 		break;
 	case OBJ_REQUEST_PAGES:
-		osd_req->r_pages = obj_request->pages;
-		osd_req->r_num_pages = obj_request->page_count;
-		osd_req->r_page_alignment = offset & ~PAGE_MASK;
+		osd_req->r_data.pages = obj_request->pages;
+		osd_req->r_data.num_pages = obj_request->page_count;
+		osd_req->r_data.alignment = offset & ~PAGE_MASK;
 		break;
 	}

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e46e944..1cf7894 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -243,8 +243,9 @@ static void finish_read(struct ceph_osd_request
*req, struct ceph_msg *msg)
 	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);

 	/* unlock all pages, zeroing any data we didn't read */
-	for (i = 0; i < req->r_num_pages; i++, bytes -= PAGE_CACHE_SIZE) {
-		struct page *page = req->r_pages[i];
+	BUG_ON(req->r_data.type != CEPH_OSD_DATA_TYPE_PAGES);
+	for (i = 0; i < req->r_data.num_pages; i++, bytes -= PAGE_CACHE_SIZE) {
+		struct page *page = req->r_data.pages[i];

 		if (bytes < (int)PAGE_CACHE_SIZE) {
 			/* zero (remainder of) page */
@@ -258,7 +259,7 @@ static void finish_read(struct ceph_osd_request
*req, struct ceph_msg *msg)
 		unlock_page(page);
 		page_cache_release(page);
 	}
-	kfree(req->r_pages);
+	kfree(req->r_data.pages);
 }

 static void ceph_unlock_page_vector(struct page **pages, int num_pages)
@@ -336,9 +337,10 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 		}
 		pages[i] = page;
 	}
-	req->r_pages = pages;
-	req->r_num_pages = nr_pages;
-	req->r_page_alignment = 0;
+	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
+	req->r_data.pages = pages;
+	req->r_data.num_pages = nr_pages;
+	req->r_data.alignment = 0;
 	req->r_callback = finish_read;
 	req->r_inode = inode;

@@ -374,7 +376,8 @@ static int ceph_readpages(struct file *file, struct
address_space *mapping,
 		max = (fsc->mount_options->rsize + PAGE_CACHE_SIZE - 1)
 			>> PAGE_SHIFT;

-	dout("readpages %p file %p nr_pages %d max %d\n", inode, file, nr_pages,
+	dout("readpages %p file %p nr_pages %d max %d\n", inode,
+		file, nr_pages,
 	     max);
 	while (!list_empty(page_list)) {
 		rc = start_read(inode, page_list, max);
@@ -560,6 +563,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	long writeback_stat;
 	unsigned issued = ceph_caps_issued(ci);

+	BUG_ON(req->r_data.type != CEPH_OSD_DATA_TYPE_PAGES);
 	if (rc >= 0) {
 		/*
 		 * Assume we wrote the pages we originally sent.  The
@@ -567,7 +571,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 		 * raced with a truncation and was adjusted at the osd,
 		 * so don't believe the reply.
 		 */
-		wrote = req->r_num_pages;
+		wrote = req->r_data.num_pages;
 	} else {
 		wrote = 0;
 		mapping_set_error(mapping, rc);
@@ -576,8 +580,8 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	     inode, rc, bytes, wrote);

 	/* clean all pages */
-	for (i = 0; i < req->r_num_pages; i++) {
-		page = req->r_pages[i];
+	for (i = 0; i < req->r_data.num_pages; i++) {
+		page = req->r_data.pages[i];
 		BUG_ON(!page);
 		WARN_ON(!PageUptodate(page));

@@ -606,31 +610,31 @@ static void writepages_finish(struct
ceph_osd_request *req,
 		unlock_page(page);
 	}
 	dout("%p wrote+cleaned %d pages\n", inode, wrote);
-	ceph_put_wrbuffer_cap_refs(ci, req->r_num_pages, snapc);
+	ceph_put_wrbuffer_cap_refs(ci, req->r_data.num_pages, snapc);

-	ceph_release_pages(req->r_pages, req->r_num_pages);
-	if (req->r_pages_from_pool)
-		mempool_free(req->r_pages,
+	ceph_release_pages(req->r_data.pages, req->r_data.num_pages);
+	if (req->r_data.pages_from_pool)
+		mempool_free(req->r_data.pages,
 			     ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
 	else
-		kfree(req->r_pages);
+		kfree(req->r_data.pages);
 	ceph_osdc_put_request(req);
 }

 /*
  * allocate a page vec, either directly, or if necessary, via a the
- * mempool.  we avoid the mempool if we can because req->r_num_pages
+ * mempool.  we avoid the mempool if we can because req->r_data.num_pages
  * may be less than the maximum write size.
  */
 static void alloc_page_vec(struct ceph_fs_client *fsc,
 			   struct ceph_osd_request *req)
 {
-	req->r_pages = kmalloc(sizeof(struct page *) * req->r_num_pages,
+	req->r_data.pages = kmalloc(sizeof(struct page *) * req->r_data.num_pages,
 			       GFP_NOFS);
-	if (!req->r_pages) {
-		req->r_pages = mempool_alloc(fsc->wb_pagevec_pool, GFP_NOFS);
-		req->r_pages_from_pool = 1;
-		WARN_ON(!req->r_pages);
+	if (!req->r_data.pages) {
+		req->r_data.pages = mempool_alloc(fsc->wb_pagevec_pool, GFP_NOFS);
+		req->r_data.pages_from_pool = 1;
+		WARN_ON(!req->r_data.pages);
 	}
 }

@@ -829,9 +833,10 @@ get_more_pages:
 					break;
 				}

-				req->r_num_pages = calc_pages_for(0, len);
-				req->r_page_alignment = 0;
-				max_pages = req->r_num_pages;
+				req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
+				req->r_data.num_pages = calc_pages_for(0, len);
+				req->r_data.alignment = 0;
+				max_pages = req->r_data.num_pages;

 				alloc_page_vec(fsc, req);
 				req->r_callback = writepages_finish;
@@ -853,7 +858,7 @@ get_more_pages:
 			}

 			set_page_writeback(page);
-			req->r_pages[locked_pages] = page;
+			req->r_data.pages[locked_pages] = page;
 			locked_pages++;
 			next = page->index + 1;
 		}
@@ -883,14 +888,14 @@ get_more_pages:
 		}

 		/* submit the write */
-		offset = req->r_pages[0]->index << PAGE_CACHE_SHIFT;
+		offset = req->r_data.pages[0]->index << PAGE_CACHE_SHIFT;
 		len = min((snap_size ? snap_size : i_size_read(inode)) - offset,
 			  (u64)locked_pages << PAGE_CACHE_SHIFT);
 		dout("writepages got %d pages at %llu~%llu\n",
 		     locked_pages, offset, len);

 		/* revise final length, page count */
-		req->r_num_pages = locked_pages;
+		req->r_data.num_pages = locked_pages;
 		req->r_request_ops[0].extent.length = cpu_to_le64(len);
 		req->r_request_ops[0].payload_len = cpu_to_le32(len);
 		req->r_request->hdr.data_len = cpu_to_le32(len);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index fe7f711..76739049 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -568,12 +568,12 @@ more:
 		if ((file->f_flags & O_SYNC) == 0) {
 			/* get a second commit callback */
 			req->r_safe_callback = sync_write_commit;
-			req->r_own_pages = 1;
+			req->r_data.own_pages = 1;
 		}
 	}
-	req->r_pages = pages;
-	req->r_num_pages = num_pages;
-	req->r_page_alignment = page_align;
+	req->r_data.pages = pages;
+	req->r_data.num_pages = num_pages;
+	req->r_data.alignment = page_align;
 	req->r_inode = inode;

 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 803a9db..600b827 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -50,6 +50,21 @@ struct ceph_osd {

 #define CEPH_OSD_MAX_OP 10

+struct ceph_osd_data {
+	struct {
+		struct {
+			struct page	**pages;
+			u32		num_pages;
+			u32		alignment;
+			bool		pages_from_pool;
+			bool		own_pages;
+		};
+#ifdef CONFIG_BLOCK
+		struct bio       *bio;
+#endif /* CONFIG_BLOCK */
+	};
+};
+
 /* an in-flight request */
 struct ceph_osd_request {
 	u64             r_tid;              /* unique for this client */
@@ -105,15 +120,8 @@ struct ceph_osd_request {

 	struct ceph_file_layout r_file_layout;
 	struct ceph_snap_context *r_snapc;    /* snap context for writes */
-	unsigned          r_num_pages;        /* size of page array (follows) */
-	unsigned          r_page_alignment;   /* io offset in first page */
-	struct page     **r_pages;            /* pages for data payload */
-	int               r_pages_from_pool;
-	int               r_own_pages;        /* if true, i own page list */
-#ifdef CONFIG_BLOCK
-	struct bio       *r_bio;	      /* instead of pages */
-#endif

+	struct ceph_osd_data r_data;
 	struct ceph_pagelist r_trail;	      /* trailing part of the data */
 };

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index de427cc..1f8c7a7 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -122,9 +122,9 @@ void ceph_osdc_release_request(struct kref *kref)
 	}
 	if (req->r_reply)
 		ceph_msg_put(req->r_reply);
-	if (req->r_own_pages)
-		ceph_release_page_vector(req->r_pages,
-					 req->r_num_pages);
+	if (req->r_data.own_pages)
+		ceph_release_page_vector(req->r_data.pages,
+					 req->r_data.num_pages);
 	ceph_put_snap_context(req->r_snapc);
 	ceph_pagelist_release(&req->r_trail);
 	if (req->r_mempool)
@@ -1739,11 +1739,11 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,
 {
 	int rc = 0;

-	req->r_request->pages = req->r_pages;
-	req->r_request->page_count = req->r_num_pages;
-	req->r_request->page_alignment = req->r_page_alignment;
+	req->r_request->pages = req->r_data.pages;
+	req->r_request->page_count = req->r_data.num_pages;
+	req->r_request->page_alignment = req->r_data.alignment;
 #ifdef CONFIG_BLOCK
-	req->r_request->bio = req->r_bio;
+	req->r_request->bio = req->r_data.bio;
 #endif
 	req->r_request->trail = &req->r_trail;

@@ -1944,12 +1944,12 @@ int ceph_osdc_readpages(struct ceph_osd_client
*osdc,
 		return PTR_ERR(req);

 	/* it may be a short read due to an object boundary */
-	req->r_pages = pages;
-	req->r_num_pages = calc_pages_for(page_align, *plen);
-	req->r_page_alignment = page_align;
+	req->r_data.pages = pages;
+	req->r_data.num_pages = calc_pages_for(page_align, *plen);
+	req->r_data.alignment = page_align;

 	dout("readpages  final extent is %llu~%llu (%d pages align %d)\n",
-	     off, *plen, req->r_num_pages, page_align);
+	     off, *plen, req->r_data.num_pages, page_align);

 	rc = ceph_osdc_start_request(osdc, req, false);
 	if (!rc)
@@ -1987,10 +1987,10 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 		return PTR_ERR(req);

 	/* it may be a short write due to an object boundary */
-	req->r_pages = pages;
-	req->r_num_pages = calc_pages_for(page_align, len);
-	req->r_page_alignment = page_align;
-	dout("writepages %llu~%llu (%d pages)\n", off, len, req->r_num_pages);
+	req->r_data.pages = pages;
+	req->r_data.num_pages = calc_pages_for(page_align, len);
+	req->r_data.alignment = page_align;
+	dout("writepages %llu~%llu (%d pages)\n", off, len,
req->r_data.num_pages);

 	rc = ceph_osdc_start_request(osdc, req, true);
 	if (!rc)
@@ -2083,22 +2083,22 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 	m = ceph_msg_get(req->r_reply);

 	if (data_len > 0) {
-		int want = calc_pages_for(req->r_page_alignment, data_len);
+		int want = calc_pages_for(req->r_data.alignment, data_len);

-		if (req->r_pages && unlikely(req->r_num_pages < want)) {
+		if (req->r_data.pages && unlikely(req->r_data.num_pages < want)) {
 			pr_warning("tid %lld reply has %d bytes %d pages, we"
 				   " had only %d pages ready\n", tid, data_len,
-				   want, req->r_num_pages);
+				   want, req->r_data.num_pages);
 			*skip = 1;
 			ceph_msg_put(m);
 			m = NULL;
 			goto out;
 		}
-		m->pages = req->r_pages;
-		m->page_count = req->r_num_pages;
-		m->page_alignment = req->r_page_alignment;
+		m->pages = req->r_data.pages;
+		m->page_count = req->r_data.num_pages;
+		m->page_alignment = req->r_data.alignment;
 #ifdef CONFIG_BLOCK
-		m->bio = req->r_bio;
+		m->bio = req->r_data.bio;
 #endif
 	}
 	*skip = 0;
-- 
1.7.9.5

