From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] rbd: fix invalid img_request dereference
Date: Thu,  1 Sep 2016 16:59:18 +0200
Message-ID: <1472741959-1786-2-git-send-email-ddiss@suse.de>
References: <1472741959-1786-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755166AbcIAPNp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Sep 2016 11:13:45 -0400
In-Reply-To: <1472741959-1786-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@linaro.org, David Disseldorp <ddiss@suse.de>

To obtain the snap_id, rbd_osd_req_format_read() dereferences
rbd_obj_request->img_request if non-null. This should never happen in
the rbd_img_obj_exists_submit() call path, as stat_request->img_request
is invalid - it's overwritten by stat_request->obj_request, which is
stored in the same union.

Fixes: c5b5ef6c5 ("rbd: issue stat request before layered write")

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/rbd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6c6519f..93d6200 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1875,9 +1875,9 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req)
 		rbd_obj_request_complete(obj_request);
 }
 
-static void rbd_osd_req_format_read(struct rbd_obj_request *obj_request)
+static void rbd_osd_req_format_read(struct rbd_obj_request *obj_request,
+				    struct rbd_img_request *img_request)
 {
-	struct rbd_img_request *img_request = obj_request->img_request;
 	struct ceph_osd_request *osd_req = obj_request->osd_req;
 
 	if (img_request)
@@ -2420,7 +2420,7 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
 	if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD)
 		rbd_osd_req_format_write(obj_request);
 	else
-		rbd_osd_req_format_read(obj_request);
+		rbd_osd_req_format_read(obj_request, img_request);
 }
 
 /*
@@ -2877,7 +2877,11 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT, 0);
 	osd_req_op_raw_data_in_pages(stat_request->osd_req, 0, pages, size, 0,
 					false, false);
-	rbd_osd_req_format_read(stat_request);
+	/*
+	 * Use img_request from original obj_request - stat_request->img_request
+	 * is invalid (in a union with stat_request->obj_request).
+	 */
+	rbd_osd_req_format_read(stat_request, obj_request->img_request);
 
 	osdc = &rbd_dev->rbd_client->client->osdc;
 	ret = rbd_obj_request_submit(osdc, stat_request);
@@ -3242,7 +3246,7 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
 					obj_request->pages, inbound_size,
 					0, false, false);
-	rbd_osd_req_format_read(obj_request);
+	rbd_osd_req_format_read(obj_request, obj_request->img_request);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
@@ -3448,7 +3452,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 					obj_request->length,
 					obj_request->offset & ~PAGE_MASK,
 					false, false);
-	rbd_osd_req_format_read(obj_request);
+	rbd_osd_req_format_read(obj_request, obj_request->img_request);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
-- 
2.6.6

