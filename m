From: Alex Elder <elder@inktank.com>
Subject: [PATCH 12/12, v2] rbd: get rid of rbd_req_sync_exec()
Date: Thu, 24 Jan 2013 10:36:37 -0600
Message-ID: <51016315.4050101@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:40481 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab3AXQgj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 11:36:39 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so5082863iag.27
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 08:36:39 -0800 (PST)
In-Reply-To: <5101406E.4060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Get rid rbd_req_sync_exec() because it is no longer used.  That
eliminates the last use of rbd_req_sync_op(), so get rid of that
too.  And finally, that leaves rbd_do_request() unreferenced, so get
rid of that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |  160
---------------------------------------------------
 1 file changed, 160 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5ad2ac2..c807a4c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1160,126 +1160,6 @@ static void rbd_osd_req_op_destroy(struct
ceph_osd_req_op *op)
 	kfree(op);
 }

-/*
- * Send ceph osd request
- */
-static int rbd_do_request(struct request *rq,
-			  struct rbd_device *rbd_dev,
-			  struct ceph_snap_context *snapc,
-			  u64 snapid,
-			  const char *object_name, u64 ofs, u64 len,
-			  struct bio *bio,
-			  struct page **pages,
-			  int num_pages,
-			  int flags,
-			  struct ceph_osd_req_op *op,
-			  void (*rbd_cb)(struct ceph_osd_request *,
-					 struct ceph_msg *),
-			  u64 *ver)
-{
-	struct ceph_osd_client *osdc;
-	struct ceph_osd_request *osd_req;
-	struct timespec mtime = CURRENT_TIME;
-	int ret;
-
-	dout("rbd_do_request object_name=%s ofs=%llu len=%llu\n",
-		object_name, (unsigned long long) ofs,
-		(unsigned long long) len);
-
-	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_NOIO);
-	if (!osd_req)
-		return -ENOMEM;
-
-	osd_req->r_flags = flags;
-	osd_req->r_pages = pages;
-	if (bio) {
-		osd_req->r_bio = bio;
-		bio_get(osd_req->r_bio);
-	}
-
-	osd_req->r_callback = rbd_cb;
-	osd_req->r_priv = NULL;
-
-	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
-	osd_req->r_oid_len = strlen(osd_req->r_oid);
-
-	osd_req->r_file_layout = rbd_dev->layout;	/* struct */
-	osd_req->r_num_pages = calc_pages_for(ofs, len);
-	osd_req->r_page_alignment = ofs & ~PAGE_MASK;
-
-	ceph_osdc_build_request(osd_req, ofs, len, 1, op,
-				snapc, snapid, &mtime);
-
-	if (op->op == CEPH_OSD_OP_WATCH && op->watch.flag) {
-		ceph_osdc_set_request_linger(osdc, osd_req);
-		rbd_dev->watch_request = osd_req;
-	}
-
-	ret = ceph_osdc_start_request(osdc, osd_req, false);
-	if (ret < 0)
-		goto done_err;
-
-	if (!rbd_cb) {
-		u64 version;
-
-		ret = ceph_osdc_wait_request(osdc, osd_req);
-		version = le64_to_cpu(osd_req->r_reassert_version.version);
-		if (ver)
-			*ver = version;
-		dout("reassert_ver=%llu\n", (unsigned long long) version);
-		ceph_osdc_put_request(osd_req);
-	}
-	return ret;
-
-done_err:
-	if (bio)
-		bio_chain_put(osd_req->r_bio);
-	ceph_osdc_put_request(osd_req);
-
-	return ret;
-}
-
-/*
- * Do a synchronous ceph osd operation
- */
-static int rbd_req_sync_op(struct rbd_device *rbd_dev,
-			   int flags,
-			   struct ceph_osd_req_op *op,
-			   const char *object_name,
-			   u64 ofs, u64 inbound_size,
-			   char *inbound,
-			   u64 *ver)
-{
-	int ret;
-	struct page **pages;
-	int num_pages;
-
-	rbd_assert(op != NULL);
-
-	num_pages = calc_pages_for(ofs, inbound_size);
-	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
-
-	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
-			  object_name, ofs, inbound_size, NULL,
-			  pages, num_pages,
-			  flags,
-			  op,
-			  NULL,
-			  ver);
-	if (ret < 0)
-		goto done;
-
-	if ((flags & CEPH_OSD_FLAG_READ) && inbound)
-		ret = ceph_copy_from_page_vector(pages, inbound, ofs, ret);
-
-done:
-	ceph_release_page_vector(pages, num_pages);
-	return ret;
-}
-
 static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
 				struct rbd_obj_request *obj_request)
 {
@@ -1315,45 +1195,6 @@ static void rbd_obj_request_complete(struct
rbd_obj_request *obj_request)
 		complete_all(&obj_request->completion);
 }

-/*
- * Synchronous osd object method call
- */
-static int rbd_req_sync_exec(struct rbd_device *rbd_dev,
-			     const char *object_name,
-			     const char *class_name,
-			     const char *method_name,
-			     const char *outbound,
-			     size_t outbound_size,
-			     char *inbound,
-			     size_t inbound_size,
-			     u64 *ver)
-{
-	struct ceph_osd_req_op *op;
-	int ret;
-
-	/*
-	 * Any input parameters required by the method we're calling
-	 * will be sent along with the class and method names as
-	 * part of the message payload.  That data and its size are
-	 * supplied via the indata and indata_len fields (named from
-	 * the perspective of the server side) in the OSD request
-	 * operation.
-	 */
-	op = rbd_osd_req_op_create(CEPH_OSD_OP_CALL, class_name,
-					method_name, outbound, outbound_size);
-	if (!op)
-		return -ENOMEM;
-
-	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, op,
-			       object_name, 0, inbound_size, inbound,
-			       ver);
-
-	rbd_osd_req_op_destroy(op);
-
-	dout("cls_exec returned %d\n", ret);
-	return ret;
-}
-
 static void rbd_osd_read_callback(struct rbd_obj_request *obj_request,
 				struct ceph_osd_op *op)
 {
@@ -2829,7 +2670,6 @@ static int _rbd_dev_v2_snap_size(struct rbd_device
*rbd_dev, u64 snap_id,
 		__le64 size;
 	} __attribute__ ((packed)) size_buf = { 0 };

-	(void) rbd_req_sync_exec;	/* Avoid a warning */
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_size",
 				(char *) &snapid, sizeof (snapid),
-- 
1.7.9.5

