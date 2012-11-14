From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: assume single op in a request
Date: Wed, 14 Nov 2012 10:35:20 -0600
Message-ID: <50A3C848.30902@inktank.com>
References: <50A3C7D0.2050809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54151 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671Ab2KNQfX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:35:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so882810iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:35:23 -0800 (PST)
In-Reply-To: <50A3C7D0.2050809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We now know that every of rbd_req_sync_op() passes an array of
exactly one operation, as evidenced by all callers passing 1 as its
num_op argument.  So get rid of that argument, assuming a single op.

Similarly, we now know that all callers of rbd_do_request() pass 1
as the num_op value, so that parameter can be eliminated as well.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0922fbb..a2f9df7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1115,8 +1115,7 @@ static int rbd_do_request(struct request *rq,
 			  struct page **pages,
 			  int num_pages,
 			  int flags,
-			  unsigned int num_op,
-			  struct ceph_osd_req_op *ops,
+			  struct ceph_osd_req_op *op,
 			  struct rbd_req_coll *coll,
 			  int coll_index,
 			  void (*rbd_cb)(struct ceph_osd_request *,
@@ -1145,7 +1144,7 @@ static int rbd_do_request(struct request *rq,
 		(unsigned long long) len, coll, coll_index);

 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_op, false, GFP_NOIO);
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_NOIO);
 	if (!osd_req) {
 		ret = -ENOMEM;
 		goto done_pages;
@@ -1171,10 +1170,10 @@ static int rbd_do_request(struct request *rq,

 	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
 	ret = ceph_calc_raw_layout(&osd_req->r_file_layout,
-				ofs, &len, &bno, osd_req, ops);
+				ofs, &len, &bno, osd_req, op);
 	rbd_assert(ret == 0);

-	ceph_osdc_build_request(osd_req, ofs, len, num_op, ops,
+	ceph_osdc_build_request(osd_req, ofs, len, 1, op,
 				snapc, snapid, &mtime);

 	if (linger_req) {
@@ -1257,8 +1256,7 @@ static void rbd_simple_req_cb(struct
ceph_osd_request *osd_req,
  */
 static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			   int flags,
-			   unsigned int num_op,
-			   struct ceph_osd_req_op *ops,
+			   struct ceph_osd_req_op *op,
 			   const char *object_name,
 			   u64 ofs, u64 inbound_size,
 			   char *inbound,
@@ -1269,7 +1267,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 	struct page **pages;
 	int num_pages;

-	rbd_assert(ops != NULL);
+	rbd_assert(op != NULL);

 	num_pages = calc_pages_for(ofs, inbound_size);
 	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
@@ -1280,7 +1278,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			  object_name, ofs, inbound_size, NULL,
 			  pages, num_pages,
 			  flags,
-			  num_op, ops,
+			  op,
 			  NULL, 0,
 			  NULL,
 			  linger_req, ver);
@@ -1350,7 +1348,7 @@ static int rbd_do_op(struct request *rq,
 			     bio,
 			     NULL, 0,
 			     flags,
-			     1, op,
+			     op,
 			     coll, coll_index,
 			     rbd_req_cb, 0, NULL);
 	if (ret < 0)
@@ -1379,7 +1377,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 		return -ENOMEM;

 	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
-			       1, op, object_name, ofs, len, buf, NULL, ver);
+			       op, object_name, ofs, len, buf, NULL, ver);
 	rbd_destroy_op(op);

 	return ret;
@@ -1407,7 +1405,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 			  rbd_dev->header_name, 0, 0, NULL,
 			  NULL, 0,
 			  CEPH_OSD_FLAG_READ,
-			  1, op,
+			  op,
 			  NULL, 0,
 			  rbd_simple_req_cb, 0, NULL);

@@ -1459,7 +1457,7 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev)

 	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      1, op,
+			      op,
 			      rbd_dev->header_name,
 			      0, 0, NULL,
 			      &rbd_dev->watch_request, NULL);
@@ -1496,7 +1494,7 @@ static int rbd_req_sync_unwatch(struct rbd_device
*rbd_dev)

 	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      1, op,
+			      op,
 			      rbd_dev->header_name,
 			      0, 0, NULL, NULL, NULL);

@@ -1547,7 +1545,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	op->cls.indata = outbound;
 	op->cls.indata_len = outbound_size;

-	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, 1, op,
+	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, op,
 			       object_name, 0, inbound_size, inbound,
 			       NULL, ver);

-- 
1.7.9.5

