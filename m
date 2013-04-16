From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/7] rbd: always check IMG_DATA flag
Date: Mon, 15 Apr 2013 22:38:29 -0500
Message-ID: <516CC7B5.2060802@inktank.com>
References: <516CC6E4.6070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:43343 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDib (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 23:38:31 -0400
Received: by mail-ia0-f178.google.com with SMTP id w21so45775iac.23
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:38:30 -0700 (PDT)
In-Reply-To: <516CC6E4.6070307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In a few spots, whether the an object request's img_request pointer
is null is used to determine whether an object request is being done
as part of an image data request.

Stop doing that, and instead always use the object request IMG_DATA
flag for that purpose.  Swap the order of the definition of the
IMG_DATA and DONE flag helpers, because obj_request_done_set() now
refers to obj_request_img_data_set() to get its rbd_dev value.

This will become important because the img_request pointer is
about to become part of a union.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   51
++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 81751cd..211baa7f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1094,40 +1094,39 @@ out_err:
  * each flag, once its value is set to 1 it is never reset to 0
  * again.
  */
-static void obj_request_done_set(struct rbd_obj_request *obj_request)
+static void obj_request_img_data_set(struct rbd_obj_request *obj_request)
 {
-	if (test_and_set_bit(OBJ_REQ_DONE, &obj_request->flags)) {
-		struct rbd_img_request *img_request = obj_request->img_request;
+	if (test_and_set_bit(OBJ_REQ_IMG_DATA, &obj_request->flags)) {
 		struct rbd_device *rbd_dev;

-		rbd_dev = img_request ? img_request->rbd_dev : NULL;
-		rbd_warn(rbd_dev, "obj_request %p already marked done\n",
+		rbd_dev = obj_request->img_request->rbd_dev;
+		rbd_warn(rbd_dev, "obj_request %p already marked img_data\n",
 			obj_request);
 	}
 }

-static bool obj_request_done_test(struct rbd_obj_request *obj_request)
+static bool obj_request_img_data_test(struct rbd_obj_request *obj_request)
 {
 	smp_mb();
-	return test_bit(OBJ_REQ_DONE, &obj_request->flags) != 0;
+	return test_bit(OBJ_REQ_IMG_DATA, &obj_request->flags) != 0;
 }

-static void obj_request_img_data_set(struct rbd_obj_request *obj_request)
+static void obj_request_done_set(struct rbd_obj_request *obj_request)
 {
-	if (test_and_set_bit(OBJ_REQ_IMG_DATA, &obj_request->flags)) {
-		struct rbd_img_request *img_request = obj_request->img_request;
-		struct rbd_device *rbd_dev;
+	if (test_and_set_bit(OBJ_REQ_DONE, &obj_request->flags)) {
+		struct rbd_device *rbd_dev = NULL;

-		rbd_dev = img_request ? img_request->rbd_dev : NULL;
-		rbd_warn(rbd_dev, "obj_request %p already marked img_data\n",
+		if (obj_request_img_data_test(obj_request))
+			rbd_dev = obj_request->img_request->rbd_dev;
+		rbd_warn(rbd_dev, "obj_request %p already marked done\n",
 			obj_request);
 	}
 }

-static bool obj_request_img_data_test(struct rbd_obj_request *obj_request)
+static bool obj_request_done_test(struct rbd_obj_request *obj_request)
 {
 	smp_mb();
-	return test_bit(OBJ_REQ_IMG_DATA, &obj_request->flags) != 0;
+	return test_bit(OBJ_REQ_DONE, &obj_request->flags) != 0;
 }

 static void rbd_obj_request_get(struct rbd_obj_request *obj_request)
@@ -1338,8 +1337,16 @@ static void rbd_osd_trivial_callback(struct
rbd_obj_request *obj_request)

 static void rbd_osd_read_callback(struct rbd_obj_request *obj_request)
 {
-	struct rbd_img_request *img_request = obj_request->img_request;
-	bool layered = img_request && img_request_layered_test(img_request);
+	struct rbd_img_request *img_request = NULL;
+	bool layered = false;
+
+	if (obj_request_img_data_test(obj_request)) {
+		img_request = obj_request->img_request;
+		layered = img_request && img_request_layered_test(img_request);
+	} else {
+		img_request = NULL;
+		layered = false;
+	}

 	dout("%s: obj %p img %p result %d %llu/%llu\n", __func__,
 		obj_request, img_request, obj_request->result,
@@ -1382,10 +1389,12 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,

 	dout("%s: osd_req %p msg %p\n", __func__, osd_req, msg);
 	rbd_assert(osd_req == obj_request->osd_req);
-	rbd_assert(obj_request_img_data_test(obj_request) ^
-				!obj_request->img_request);
-	rbd_assert(obj_request_img_data_test(obj_request) ^
-				(obj_request->which == BAD_WHICH));
+	if (obj_request_img_data_test(obj_request)) {
+		rbd_assert(obj_request->img_request);
+		rbd_assert(obj_request->which != BAD_WHICH);
+	} else {
+		rbd_assert(obj_request->which == BAD_WHICH);
+	}

 	if (osd_req->r_result < 0)
 		obj_request->result = osd_req->r_result;
-- 
1.7.9.5

