From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: encapsulate submission of image object requests
Date: Fri, 19 Apr 2013 17:50:02 -0500
Message-ID: <5171CA1A.6010908@inktank.com>
References: <5171C963.2050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64670 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964846Ab3DSWuF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 18:50:05 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so5241221iea.32
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 15:50:04 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wn10sm4973570igb.2.2013.04.19.15.50.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 15:50:03 -0700 (PDT)
In-Reply-To: <5171C963.2050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Object requests that are part of an image request are subject to
some additional handling.  Define rbd_img_obj_request_submit() to
encapsulate that, and use it when initially submitting an image
object request, and when re-submitting it during callback of
an object existence check.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   65
++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a185239..894af4f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -423,6 +423,7 @@ void rbd_warn(struct rbd_device *rbd_dev, const char
*fmt, ...)
 #endif /* !RBD_DEBUG */

 static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
+static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request);

 static int rbd_dev_refresh(struct rbd_device *rbd_dev, u64 *hver);
 static int rbd_dev_v2_refresh(struct rbd_device *rbd_dev, u64 *hver);
@@ -1874,8 +1875,6 @@ out_unwind:

 static void rbd_img_obj_exists_callback(struct rbd_obj_request
*obj_request)
 {
-	struct rbd_device *rbd_dev;
-	struct ceph_osd_client *osdc;
 	struct rbd_obj_request *orig_request;
 	int result;

@@ -1901,8 +1900,6 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)

 	rbd_assert(orig_request);
 	rbd_assert(orig_request->img_request);
-	rbd_dev = orig_request->img_request->rbd_dev;
-	osdc = &rbd_dev->rbd_client->client->osdc;

 	/*
 	 * Our only purpose here is to determine whether the object
@@ -1923,7 +1920,7 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 	 * Resubmit the original request now that we have recorded
 	 * whether the target object exists.
 	 */
-	orig_request->result = rbd_obj_request_submit(osdc, orig_request);
+	orig_request->result = rbd_img_obj_request_submit(orig_request);
 out_err:
 	if (orig_request->result)
 		rbd_obj_request_complete(orig_request);
@@ -1987,32 +1984,56 @@ out:
 	return ret;
 }

+static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
+{
+	struct rbd_img_request *img_request;
+
+	rbd_assert(obj_request_img_data_test(obj_request));
+
+	img_request = obj_request->img_request;
+	rbd_assert(img_request);
+
+	/* (At the moment we don't care whether it exists or not...) */
+	(void) obj_request_exists_test;
+
+	/*
+	 * Only layered writes need special handling.  If it's not a
+	 * layered write, or it is a layered write but we know the
+	 * target object exists, it's no different from any other
+	 * object request.
+	 */
+	if (!img_request_write_test(img_request) ||
+		!img_request_layered_test(img_request) ||
+		obj_request_known_test(obj_request)) {
+
+		struct rbd_device *rbd_dev;
+		struct ceph_osd_client *osdc;
+
+		rbd_dev = obj_request->img_request->rbd_dev;
+		osdc = &rbd_dev->rbd_client->client->osdc;
+
+		return rbd_obj_request_submit(osdc, obj_request);
+	}
+
+	/*
+	 * It's a layered write and we don't know whether the target
+	 * exists.  Issue existence check; once that completes the
+	 * original request will be submitted again.
+	 */
+
+	return rbd_img_obj_exists_submit(obj_request);
+}
+
 static int rbd_img_request_submit(struct rbd_img_request *img_request)
 {
-	struct rbd_device *rbd_dev = img_request->rbd_dev;
-	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
 	struct rbd_obj_request *next_obj_request;
-	bool write_request = img_request_write_test(img_request);
-	bool layered = img_request_layered_test(img_request);

 	dout("%s: img %p\n", __func__, img_request);
 	for_each_obj_request_safe(img_request, obj_request, next_obj_request) {
-		bool known;
-		bool object_exists;
 		int ret;

-		/*
-		 * We need to know whether the target object exists
-		 * for a layered write.  Issue an existence check
-		 * first if we need to.
-		 */
-		known = obj_request_known_test(obj_request);
-		object_exists = known && obj_request_exists_test(obj_request);
-		if (!write_request || !layered || object_exists)
-			ret = rbd_obj_request_submit(osdc, obj_request);
-		else
-			ret = rbd_img_obj_exists_submit(obj_request);
+		ret = rbd_img_obj_request_submit(obj_request);
 		if (ret)
 			return ret;
 	}
-- 
1.7.9.5

