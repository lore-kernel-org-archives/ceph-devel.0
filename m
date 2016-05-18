From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: get/put img_request in rbd_img_request_submit()
Date: Wed, 18 May 2016 17:28:45 +0200
Message-ID: <1463585325-24631-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33802 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbcERP3K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 11:29:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so13847163wmn.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2016 08:29:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

By the time we get to checking for_each_obj_request_safe(img_request)
terminating condition, all obj_requests may be complete and img_request
ref, that rbd_img_request_submit() takes away from its caller, may be
put.  Moving the next_obj_request cursor is then a use-after-free on
img_request.

It's totally benign, as the value that's read is never used, but
I think it's still worth fixing.

Cc: Alex Elder <elder@linaro.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 465c839e0a65..b1e68dacba18 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2973,17 +2973,20 @@ static int rbd_img_request_submit(struct rbd_img_request *img_request)
 {
 	struct rbd_obj_request *obj_request;
 	struct rbd_obj_request *next_obj_request;
+	int ret = 0;
 
 	dout("%s: img %p\n", __func__, img_request);
-	for_each_obj_request_safe(img_request, obj_request, next_obj_request) {
-		int ret;
 
+	rbd_img_request_get(img_request);
+	for_each_obj_request_safe(img_request, obj_request, next_obj_request) {
 		ret = rbd_img_obj_request_submit(obj_request);
 		if (ret)
-			return ret;
+			goto out_put_ireq;
 	}
 
-	return 0;
+out_put_ireq:
+	rbd_img_request_put(img_request);
+	return ret;
 }
 
 static void rbd_img_parent_read_callback(struct rbd_img_request *img_request)
-- 
2.4.3

