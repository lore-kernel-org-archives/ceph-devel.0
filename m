From: Alex Elder <elder@inktank.com>
Subject: [PATCH 06/12] rbd: implement watch/unwatch with new code
Date: Tue, 22 Jan 2013 16:29:48 -0600
Message-ID: <50FF12DC.2070609@inktank.com>
References: <50FF11EA.3000808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63511 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3AVW3v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 17:29:51 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so12466579iea.38
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 14:29:51 -0800 (PST)
In-Reply-To: <50FF11EA.3000808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Implement a new function to set up or tear down a watch event
for an mapped rbd image header using the new request code.

Create a new object request type "nodata" to handle this.  And
define rbd_osd_trivial_callback() which simply marks a request done.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   87
+++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6193c69..3c110b3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -164,7 +164,7 @@ struct rbd_client {

 struct rbd_image_request;

-enum obj_req_type { obj_req_bio, obj_req_pages };
+enum obj_req_type { obj_req_nodata, obj_req_bio, obj_req_pages };

 struct rbd_obj_request;
 typedef void (*rbd_obj_callback_t)(struct rbd_obj_request *);
@@ -1071,6 +1071,7 @@ static void rbd_image_request_put(struct
rbd_image_request *image_request)
 static bool obj_req_type_valid(enum obj_req_type type)
 {
 	switch (type) {
+	case obj_req_nodata:
 	case obj_req_bio:
 	case obj_req_pages:
 		return true;
@@ -1491,6 +1492,12 @@ static void rbd_osd_write_callback(struct
rbd_obj_request *obj_request,
 	atomic_set(&obj_request->done, 1);
 }

+static void rbd_osd_trivial_callback(struct rbd_obj_request *obj_request,
+				struct ceph_osd_op *op)
+{
+	atomic_set(&obj_request->done, 1);
+}
+
 static void rbd_obj_request_complete(struct rbd_obj_request *obj_request)
 {
 	if (obj_request->callback)
@@ -1527,6 +1534,9 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_WRITE:
 		rbd_osd_write_callback(obj_request, op);
 		break;
+	case CEPH_OSD_OP_WATCH:
+		rbd_osd_trivial_callback(obj_request, op);
+		break;
 	default:
 		rbd_warn(NULL, "%s: unsupported op %hu\n",
 			obj_request->object_name, (unsigned short) opcode);
@@ -1570,6 +1580,8 @@ static struct ceph_osd_request *rbd_osd_req_create(

 	rbd_assert(obj_req_type_valid(obj_request->type));
 	switch (obj_request->type) {
+	case obj_req_nodata:
+		break;		/* Nothing to do */
 	case obj_req_bio:
 		rbd_assert(obj_request->bio_list != NULL);
 		osd_req->r_bio = obj_request->bio_list;
@@ -1658,6 +1670,8 @@ static void rbd_obj_request_destroy(struct kref *kref)

 	rbd_assert(obj_req_type_valid(obj_request->type));
 	switch (obj_request->type) {
+	case obj_req_nodata:
+		break;		/* Nothing to do */
 	case obj_req_bio:
 		if (obj_request->bio_list)
 			bio_chain_put(obj_request->bio_list);
@@ -1854,6 +1868,72 @@ static int rbd_image_request_submit(struct
rbd_image_request *image_request)
 	return ret;
 }

+/*
+ * Request sync osd watch/unwatch.  The value of "start" determines
+ * whether a watch request is being initiated or torn down.
+ */
+static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, int start)
+{
+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct rbd_obj_request *obj_request;
+	struct ceph_osd_req_op *op;
+	int ret;
+
+	rbd_assert(start ^ !!rbd_dev->watch_event);
+	rbd_assert(start ^ !!rbd_dev->watch_request);
+
+	if (start) {
+		ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0, rbd_dev,
+						&rbd_dev->watch_event);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = -ENOMEM;
+	obj_request = rbd_obj_request_create(rbd_dev->header_name,
+						0, 0, obj_req_nodata);
+	if (!obj_request)
+		goto out_cancel;
+
+	op = rbd_osd_req_op_create(CEPH_OSD_OP_WATCH,
+				rbd_dev->watch_event->cookie,
+				rbd_dev->header.obj_version, start);
+	if (!op)
+		goto out_cancel;
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true,
+							obj_request, op);
+	rbd_osd_req_op_destroy(op);
+	if (!obj_request->osd_req)
+		goto out_cancel;
+
+	if (start) {
+		rbd_dev->watch_request = obj_request->osd_req;
+		ceph_osdc_set_request_linger(osdc, rbd_dev->watch_request);
+	}
+	ret = rbd_obj_request_submit(osdc, obj_request);
+	if (ret)
+		goto out_cancel;
+	ret = rbd_obj_request_wait(obj_request);
+	if (ret)
+		goto out_cancel;
+
+	ret = obj_request->result;
+	if (ret)
+		goto out_cancel;
+
+	if (start)
+		goto done;	/* Done if setting up the watch request */
+out_cancel:
+	/* Cancel the event if we're tearing down, or on error */
+	ceph_osdc_cancel_event(rbd_dev->watch_event);
+	rbd_dev->watch_event = NULL;
+done:
+	if (obj_request)
+		rbd_obj_request_put(obj_request);
+
+	return ret;
+}
+
 static void rbd_request_fn(struct request_queue *q)
 {
 	struct rbd_device *rbd_dev = q->queuedata;
@@ -3876,7 +3956,8 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto err_out_bus;

-	ret = rbd_req_sync_watch(rbd_dev, 1);
+	(void) rbd_req_sync_watch;	/* avoid a warning */
+	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
 	if (ret)
 		goto err_out_bus;

@@ -4039,7 +4120,7 @@ static void rbd_dev_release(struct device *dev)
 						    rbd_dev->watch_request);
 	}
 	if (rbd_dev->watch_event)
-		rbd_req_sync_watch(rbd_dev, 0);
+		rbd_dev_header_watch_sync(rbd_dev, 0);

 	/* clean up and free blkdev */
 	rbd_free_disk(rbd_dev);
-- 
1.7.9.5

