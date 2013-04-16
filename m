From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/7] libceph: kill off osd data write_request parameters
Date: Mon, 15 Apr 2013 22:36:49 -0500
Message-ID: <516CC751.6000209@inktank.com>
References: <516CC6E4.6070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35209 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDgw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 23:36:52 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so61617ieb.3
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:36:51 -0700 (PDT)
In-Reply-To: <516CC6E4.6070307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In the incremental move toward supporting distinct data items in an
osd request some of the functions had "write_request" parameters to
indicate, basically, whether the data belonged to in_data or the
out_data.  Now that we maintain the data fields in the op structure
there is no need to indicate the direction, so get rid of the
"write_request" parameters.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    4 ++--
 fs/ceph/addr.c                  |    9 ++++-----
 fs/ceph/file.c                  |    4 ++--
 include/linux/ceph/osd_client.h |    8 ++++----
 net/ceph/osd_client.c           |   25 +++++++++++--------------
 5 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 13a381b..8e8b876 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1779,7 +1779,7 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,

 		osd_req_op_extent_init(osd_req, 0, opcode, offset, length,
 						0, 0);
-		osd_req_op_extent_osd_data_bio(osd_req, 0, write_request,
+		osd_req_op_extent_osd_data_bio(osd_req, 0,
 				obj_request->bio_list, obj_request->length);
 		rbd_osd_req_format(obj_request, write_request);

@@ -2281,7 +2281,7 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,

 	osd_req_op_extent_init(obj_request->osd_req, 0, CEPH_OSD_OP_READ,
 					offset, length, 0, 0);
-	osd_req_op_extent_osd_data_pages(obj_request->osd_req, 0, false,
+	osd_req_op_extent_osd_data_pages(obj_request->osd_req, 0,
 					obj_request->pages,
 					obj_request->length,
 					obj_request->offset & ~PAGE_MASK,
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 068d2c8..68c187b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -245,7 +245,7 @@ static void finish_read(struct ceph_osd_request
*req, struct ceph_msg *msg)
 	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);

 	/* unlock all pages, zeroing any data we didn't read */
-	osd_data = osd_req_op_extent_osd_data(req, 0, false);
+	osd_data = osd_req_op_extent_osd_data(req, 0);
 	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
 	num_pages = calc_pages_for((u64)osd_data->alignment,
 					(u64)osd_data->length);
@@ -343,8 +343,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 		}
 		pages[i] = page;
 	}
-	osd_req_op_extent_osd_data_pages(req, 0, false, pages, len, 0,
-					false, false);
+	osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false, false);
 	req->r_callback = finish_read;
 	req->r_inode = inode;

@@ -571,7 +570,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	long writeback_stat;
 	unsigned issued = ceph_caps_issued(ci);

-	osd_data = osd_req_op_extent_osd_data(req, 0, true);
+	osd_data = osd_req_op_extent_osd_data(req, 0);
 	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
 	num_pages = calc_pages_for((u64)osd_data->alignment,
 					(u64)osd_data->length);
@@ -916,7 +915,7 @@ get_more_pages:
 		dout("writepages got %d pages at %llu~%llu\n",
 		     locked_pages, offset, len);

-		osd_req_op_extent_osd_data_pages(req, 0, true, pages, len, 0,
+		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
 							!!pool, false);

 		pages = NULL;	/* request message now owns the pages array */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b7e6caa..4c87e17 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -574,8 +574,8 @@ more:
 			own_pages = true;
 		}
 	}
-	osd_req_op_extent_osd_data_pages(req, 0, true, pages, len,
-					page_align, false, own_pages);
+	osd_req_op_extent_osd_data_pages(req, 0, pages, len, page_align,
+					false, own_pages);

 	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
 	ceph_osdc_build_request(req, pos, snapc, vino.snap, &mtime);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 2a68a74..26d29cd 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -239,22 +239,22 @@ extern void osd_req_op_extent_update(struct
ceph_osd_request *osd_req,

 extern struct ceph_osd_data *osd_req_op_extent_osd_data(
 					struct ceph_osd_request *osd_req,
-					unsigned int which, bool write_request);
+					unsigned int which);
 extern struct ceph_osd_data *osd_req_op_cls_response_data(
 					struct ceph_osd_request *osd_req,
 					unsigned int which);

 extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
-					unsigned int which, bool write_request,
+					unsigned int which,
 					struct page **pages, u64 length,
 					u32 alignment, bool pages_from_pool,
 					bool own_pages);
 extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
-					unsigned int which, bool write_request,
+					unsigned int which,
 					struct ceph_pagelist *pagelist);
 #ifdef CONFIG_BLOCK
 extern void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *,
-					unsigned int which, bool write_request,
+					unsigned int which,
 					struct bio *bio, size_t bio_length);
 #endif /* CONFIG_BLOCK */

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 939be67..b76e416 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -117,7 +117,7 @@ static void ceph_osd_data_bio_init(struct
ceph_osd_data *osd_data,

 struct ceph_osd_data *
 osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
-			unsigned int which, bool write_request)
+			unsigned int which)
 {
 	BUG_ON(which >= osd_req->r_num_ops);

@@ -156,37 +156,34 @@ osd_req_op_cls_response_data(struct
ceph_osd_request *osd_req,
 EXPORT_SYMBOL(osd_req_op_cls_response_data);	/* ??? */

 void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
-			unsigned int which, bool write_request,
-			struct page **pages, u64 length, u32 alignment,
+			unsigned int which, struct page **pages,
+			u64 length, u32 alignment,
 			bool pages_from_pool, bool own_pages)
 {
 	struct ceph_osd_data *osd_data;

-	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
+	osd_data = osd_req_op_extent_osd_data(osd_req, which);
 	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
 				pages_from_pool, own_pages);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pages);

 void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *osd_req,
-			unsigned int which, bool write_request,
-			struct ceph_pagelist *pagelist)
+			unsigned int which, struct ceph_pagelist *pagelist)
 {
 	struct ceph_osd_data *osd_data;

-	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
+	osd_data = osd_req_op_extent_osd_data(osd_req, which);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);

 #ifdef CONFIG_BLOCK
 void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *osd_req,
-			unsigned int which, bool write_request,
-			struct bio *bio, size_t bio_length)
+			unsigned int which, struct bio *bio, size_t bio_length)
 {
 	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
+	osd_data = osd_req_op_extent_osd_data(osd_req, which);
 	ceph_osd_data_bio_init(osd_data, bio, bio_length);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_bio);
@@ -2278,7 +2275,7 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,

 	/* it may be a short read due to an object boundary */

-	osd_req_op_extent_osd_data_pages(req, 0, false,
+	osd_req_op_extent_osd_data_pages(req, 0,
 				pages, *plen, page_align, false, false);

 	dout("readpages  final extent is %llu~%llu (%llu bytes align %d)\n",
@@ -2321,7 +2318,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 		return PTR_ERR(req);

 	/* it may be a short write due to an object boundary */
-	osd_req_op_extent_osd_data_pages(req, 0, true, pages, len, page_align,
+	osd_req_op_extent_osd_data_pages(req, 0, pages, len, page_align,
 				false, false);
 	dout("writepages %llu~%llu (%llu bytes)\n", off, len, len);

@@ -2422,7 +2419,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 		 * XXX page data.  Probably OK for reads, but this
 		 * XXX ought to be done more generally.
 		 */
-		osd_data = osd_req_op_extent_osd_data(req, 0, false);
+		osd_data = osd_req_op_extent_osd_data(req, 0);
 		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 			if (osd_data->pages &&
 				unlikely(osd_data->length < data_len)) {
-- 
1.7.9.5

