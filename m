From: Alex Elder <elder@inktank.com>
Subject: [PATCH 12/20] rbd: don't set data in rbd_osd_req_format_op()
Date: Fri, 05 Apr 2013 09:04:24 -0500
Message-ID: <515ED9E8.6030308@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:45625 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161842Ab3DEOE0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:04:26 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so3224501iak.10
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:04:26 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Currently an object request has its osd request's data field set in
rbd_osd_req_format_op().  That assumes a single osd op per object
request, and that won't be the case for long.

Move the code that sets this out and into the caller.

Rename rbd_osd_req_format_op() to be just rbd_osd_req_format(),
removing the notion that it's doing anything op-specific.

This and the next patch resolve:
    http://tracker.ceph.com/issues/4658

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   55
+++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7a62327..3b90283 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1311,12 +1311,11 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,
 		rbd_obj_request_complete(obj_request);
 }

-static void rbd_osd_req_format_op(struct rbd_obj_request *obj_request,
+static void rbd_osd_req_format(struct rbd_obj_request *obj_request,
 					bool write_request)
 {
 	struct rbd_img_request *img_request = obj_request->img_request;
 	struct ceph_osd_request *osd_req = obj_request->osd_req;
-	struct ceph_osd_data *osd_data = NULL;
 	struct ceph_snap_context *snapc = NULL;
 	u64 snap_id = CEPH_NOSNAP;
 	struct timespec *mtime = NULL;
@@ -1325,28 +1324,12 @@ static void rbd_osd_req_format_op(struct
rbd_obj_request *obj_request,
 	rbd_assert(osd_req != NULL);

 	if (write_request) {
-		osd_data = &osd_req->r_data_out;
 		now = CURRENT_TIME;
 		mtime = &now;
 		if (img_request)
 			snapc = img_request->snapc;
-	} else {
-		osd_data = &osd_req->r_data_in;
-		if (img_request)
-			snap_id = img_request->snap_id;
-	}
-	if (obj_request->type != OBJ_REQUEST_NODATA) {
-		/*
-		 * If it has data, it's either a object class method
-		 * call (cls) or it's an extent operation.
-		 */
-		/* XXX This use of the ops array goes away in the next patch */
-		if (obj_request->osd_req->r_ops[0].op == CEPH_OSD_OP_CALL)
-			osd_req_op_cls_response_data(obj_request->osd_req, 0,
-						osd_data);
-		else
-			osd_req_op_extent_osd_data(obj_request->osd_req, 0,
-						osd_data);
+	} else if (img_request) {
+		snap_id = img_request->snap_id;
 	}
 	ceph_osdc_build_request(osd_req, obj_request->offset,
 			snapc, snap_id, mtime);
@@ -1576,6 +1559,8 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 	resid = img_request->length;
 	rbd_assert(resid > 0);
 	while (resid) {
+		struct ceph_osd_request *osd_req;
+		struct ceph_osd_data *osd_data;
 		const char *object_name;
 		unsigned int clone_size;
 		u64 offset;
@@ -1601,14 +1586,18 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 		if (!obj_request->bio_list)
 			goto out_partial;

-		obj_request->osd_req = rbd_osd_req_create(rbd_dev,
-						write_request, obj_request);
-		if (!obj_request->osd_req)
+		osd_req = rbd_osd_req_create(rbd_dev, write_request,
+						obj_request);
+		if (!osd_req)
 			goto out_partial;
+		obj_request->osd_req = osd_req;

-		osd_req_op_extent_init(obj_request->osd_req, 0,
-					opcode, offset, length, 0, 0);
-		rbd_osd_req_format_op(obj_request, write_request);
+		osd_data = write_request ? &osd_req->r_data_out
+					 : &osd_req->r_data_in;
+		osd_req_op_extent_init(osd_req, 0, opcode, offset, length,
+						0, 0);
+		osd_req_op_extent_osd_data(osd_req, 0, osd_data);
+		rbd_osd_req_format(obj_request, write_request);

 		/* status and version are initially zero-filled */

@@ -1724,7 +1713,7 @@ static int rbd_obj_notify_ack(struct rbd_device
*rbd_dev,

 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
 					notify_id, ver, 0);
-	rbd_osd_req_format_op(obj_request, false);
+	rbd_osd_req_format(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	obj_request->callback = rbd_obj_request_put;
@@ -1790,7 +1779,7 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
 				rbd_dev->watch_event->cookie,
 				rbd_dev->header.obj_version, start);
-	rbd_osd_req_format_op(obj_request, true);
+	rbd_osd_req_format(obj_request, true);

 	if (start)
 		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
@@ -1849,6 +1838,7 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 			     u64 *version)
 {
 	struct rbd_obj_request *obj_request;
+	struct ceph_osd_data *osd_data;
 	struct ceph_osd_client *osdc;
 	struct page **pages;
 	u32 page_count;
@@ -1879,10 +1869,12 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

+	osd_data = &obj_request->osd_req->r_data_in;
 	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
 					class_name, method_name,
 					outbound, outbound_size);
-	rbd_osd_req_format_op(obj_request, false);
+	osd_req_op_cls_response_data(obj_request->osd_req, 0, osd_data);
+	rbd_osd_req_format(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	ret = rbd_obj_request_submit(osdc, obj_request);
@@ -2061,6 +2053,7 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,

 {
 	struct rbd_obj_request *obj_request;
+	struct ceph_osd_data *osd_data;
 	struct ceph_osd_client *osdc;
 	struct page **pages = NULL;
 	u32 page_count;
@@ -2085,9 +2078,11 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

+	osd_data = &obj_request->osd_req->r_data_in;
 	osd_req_op_extent_init(obj_request->osd_req, 0, CEPH_OSD_OP_READ,
 					offset, length, 0, 0);
-	rbd_osd_req_format_op(obj_request, false);
+	osd_req_op_extent_osd_data(obj_request->osd_req, 0, osd_data);
+	rbd_osd_req_format(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	ret = rbd_obj_request_submit(osdc, obj_request);
-- 
1.7.9.5

