From: Alex Elder <elder@inktank.com>
Subject: [PATCH 11/12, v2] rbd: implement sync method with new code
Date: Thu, 24 Jan 2013 10:36:11 -0600
Message-ID: <510162FB.7060400@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:46058 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab3AXQgO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 11:36:14 -0500
Received: by mail-ob0-f182.google.com with SMTP id uo13so5050781obb.41
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 08:36:14 -0800 (PST)
In-Reply-To: <5101406E.4060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reimplement synchronous object method calls using the new request
tracking code.  Use the name rbd_obj_method_sync()

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |  111
+++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 48650d1..5ad2ac2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1413,6 +1413,7 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_WRITE:
 		rbd_osd_write_callback(obj_request, op);
 		break;
+	case CEPH_OSD_OP_CALL:
 	case CEPH_OSD_OP_NOTIFY_ACK:
 	case CEPH_OSD_OP_WATCH:
 		rbd_osd_trivial_callback(obj_request, op);
@@ -1903,6 +1904,81 @@ done:
 	return ret;
 }

+/*
+ * Synchronous osd object method call
+ */
+static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
+			     const char *object_name,
+			     const char *class_name,
+			     const char *method_name,
+			     const char *outbound,
+			     size_t outbound_size,
+			     char *inbound,
+			     size_t inbound_size,
+			     u64 *version)
+{
+	struct rbd_obj_request *obj_request;
+	struct ceph_osd_client *osdc;
+	struct ceph_osd_req_op *op;
+	struct page **pages;
+	u32 page_count;
+	int ret;
+
+	/*
+	 * Method calls are ultimately read operations but they
+	 * don't involve object data (so no offset or length).
+	 * The result should placed into the inbound buffer
+	 * provided.  They also supply outbound data--parameters for
+	 * the object method.  Currently if this is present it will
+	 * be a snapshot id.
+	 */
+	page_count = (u32) calc_pages_for(0, inbound_size);
+	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+
+	ret = -ENOMEM;
+	obj_request = rbd_obj_request_create(object_name, 0, 0, obj_req_pages);
+	if (!obj_request)
+		goto out;
+
+	obj_request->pages = pages;
+	obj_request->page_count = page_count;
+
+	op = rbd_osd_req_op_create(CEPH_OSD_OP_CALL, class_name,
+					method_name, outbound, outbound_size);
+	if (!op)
+		goto out;
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false,
+						obj_request, op);
+	rbd_osd_req_op_destroy(op);
+	if (!obj_request->osd_req)
+		goto out;
+
+	osdc = &rbd_dev->rbd_client->client->osdc;
+	ret = rbd_obj_request_submit(osdc, obj_request);
+	if (ret)
+		goto out;
+	ret = rbd_obj_request_wait(obj_request);
+	if (ret)
+		goto out;
+
+	ret = obj_request->result;
+	if (ret < 0)
+		goto out;
+	ret = ceph_copy_from_page_vector(pages, inbound, 0,
+					obj_request->xferred);
+	if (version)
+		*version = obj_request->version;
+out:
+	if (obj_request)
+		rbd_obj_request_put(obj_request);
+	else
+		ceph_release_page_vector(pages, page_count);
+
+	return ret;
+}
+
 static void rbd_request_fn(struct request_queue *q)
 {
 	struct rbd_device *rbd_dev = q->queuedata;
@@ -2753,11 +2829,12 @@ static int _rbd_dev_v2_snap_size(struct
rbd_device *rbd_dev, u64 snap_id,
 		__le64 size;
 	} __attribute__ ((packed)) size_buf = { 0 };

-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+	(void) rbd_req_sync_exec;	/* Avoid a warning */
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_size",
 				(char *) &snapid, sizeof (snapid),
 				(char *) &size_buf, sizeof (size_buf), NULL);
-	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;

@@ -2788,14 +2865,14 @@ static int rbd_dev_v2_object_prefix(struct
rbd_device *rbd_dev)
 	if (!reply_buf)
 		return -ENOMEM;

-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_object_prefix",
 				NULL, 0,
 				reply_buf, RBD_OBJ_PREFIX_LEN_MAX, NULL);
-	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
-	ret = 0;    /* rbd_req_sync_exec() can return positive */
+	ret = 0;    /* rbd_obj_method_sync() can return positive */

 	p = reply_buf;
 	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
@@ -2826,12 +2903,12 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,
 	u64 incompat;
 	int ret;

-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_features",
 				(char *) &snapid, sizeof (snapid),
 				(char *) &features_buf, sizeof (features_buf),
 				NULL);
-	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;

@@ -2882,11 +2959,11 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	}

 	snapid = cpu_to_le64(CEPH_NOSNAP);
-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_parent",
 				(char *) &snapid, sizeof (snapid),
 				(char *) reply_buf, size, NULL);
-	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out_err;

@@ -2953,7 +3030,7 @@ static char *rbd_dev_image_name(struct rbd_device
*rbd_dev)
 	if (!reply_buf)
 		goto out;

-	ret = rbd_req_sync_exec(rbd_dev, RBD_DIRECTORY,
+	ret = rbd_obj_method_sync(rbd_dev, RBD_DIRECTORY,
 				"rbd", "dir_get_name",
 				image_id, image_id_size,
 				(char *) reply_buf, size, NULL);
@@ -3059,11 +3136,11 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 	if (!reply_buf)
 		return -ENOMEM;

-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_snapcontext",
 				NULL, 0,
 				reply_buf, size, ver);
-	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;

@@ -3128,11 +3205,11 @@ static char *rbd_dev_v2_snap_name(struct
rbd_device *rbd_dev, u32 which)
 		return ERR_PTR(-ENOMEM);

 	snap_id = cpu_to_le64(rbd_dev->header.snapc->snaps[which]);
-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_snapshot_name",
 				(char *) &snap_id, sizeof (snap_id),
 				reply_buf, size, NULL);
-	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;

@@ -3720,14 +3797,14 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 		goto out;
 	}

-	ret = rbd_req_sync_exec(rbd_dev, object_name,
+	ret = rbd_obj_method_sync(rbd_dev, object_name,
 				"rbd", "get_id",
 				NULL, 0,
 				response, RBD_IMAGE_ID_LEN_MAX, NULL);
-	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
-	ret = 0;    /* rbd_req_sync_exec() can return positive */
+	ret = 0;    /* rbd_obj_method_sync() can return positive */

 	p = response;
 	rbd_dev->spec->image_id = ceph_extract_encoded_string(&p,
-- 
1.7.9.5

