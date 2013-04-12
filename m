From: Alex Elder <elder@inktank.com>
Subject: [PATCH 07/11] rbd: encapsulate image object end request handling
Date: Thu, 11 Apr 2013 21:18:15 -0500
Message-ID: <51676EE7.6070103@inktank.com>
References: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:32996 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3DLCSP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:18:15 -0400
Received: by mail-ia0-f180.google.com with SMTP id l29so1965710iag.25
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:18:15 -0700 (PDT)
In-Reply-To: <51676E0F.2010504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Encapsulate the code that completes processing of an object request
that's part of an image request.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   54
+++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a77157d..2d27115 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1603,6 +1603,34 @@ static void rbd_img_request_destroy(struct kref
*kref)
 	kfree(img_request);
 }

+static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
+{
+	struct rbd_img_request *img_request = obj_request->img_request;
+	unsigned int xferred;
+	int result;
+
+	rbd_assert(!img_request_child_test(img_request));
+	rbd_assert(img_request->rq != NULL);
+
+	rbd_assert(obj_request->xferred <= (u64)UINT_MAX);
+	xferred = (unsigned int)obj_request->xferred;
+	result = obj_request->result;
+	if (result) {
+		struct rbd_device *rbd_dev = img_request->rbd_dev;
+
+		rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
+			img_request_write_test(img_request) ? "write" : "read",
+			obj_request->length, obj_request->img_offset,
+			obj_request->offset);
+		rbd_warn(rbd_dev, "  result %d xferred %x\n",
+			result, xferred);
+		if (!img_request->result)
+			img_request->result = result;
+	}
+
+	return blk_end_request(img_request->rq, result, xferred);
+}
+
 static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request;
@@ -1613,9 +1641,6 @@ static void rbd_img_obj_callback(struct
rbd_obj_request *obj_request)

 	dout("%s: img %p obj %p\n", __func__, img_request, obj_request);
 	rbd_assert(img_request != NULL);
-	rbd_assert(!img_request_child_test(img_request))
-	rbd_assert(img_request->rq != NULL);
-
 	rbd_assert(img_request->obj_request_count > 0);
 	rbd_assert(which != BAD_WHICH);
 	rbd_assert(which < img_request->obj_request_count);
@@ -1626,33 +1651,12 @@ static void rbd_img_obj_callback(struct
rbd_obj_request *obj_request)
 		goto out;

 	for_each_obj_request_from(img_request, obj_request) {
-		unsigned int xferred;
-		int result;
-
 		rbd_assert(more);
 		rbd_assert(which < img_request->obj_request_count);

 		if (!obj_request_done_test(obj_request))
 			break;
-
-		rbd_assert(obj_request->xferred <= (u64)UINT_MAX);
-		xferred = (unsigned int)obj_request->xferred;
-		result = obj_request->result;
-		if (result) {
-			struct rbd_device *rbd_dev = img_request->rbd_dev;
-
-			rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
-				img_request_write_test(img_request) ? "write"
-								    : "read",
-				obj_request->length, obj_request->img_offset,
-				obj_request->offset);
-			rbd_warn(rbd_dev, "  result %d xferred %x\n",
-				result, xferred);
-			if (!img_request->result)
-				img_request->result = result;
-		}
-
-		more = blk_end_request(img_request->rq, result, xferred);
+		more = rbd_img_obj_end_request(obj_request);
 		which++;
 	}

-- 
1.7.9.5

