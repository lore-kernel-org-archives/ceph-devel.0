From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: decrement obj request count when deleting
Date: Sat, 26 Jan 2013 14:41:08 -0600
Message-ID: <51043F64.6020800@inktank.com>
References: <51043EF2.4070305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:54190 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab3AZUlK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Jan 2013 15:41:10 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so2374700iaj.6
        for <ceph-devel@vger.kernel.org>; Sat, 26 Jan 2013 12:41:09 -0800 (PST)
In-Reply-To: <51043EF2.4070305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Decrement the obj_request_count value when deleting an object
request from its image request's list.  Rearrange a few lines
in the surrounding code.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4e78402..340773f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1071,22 +1071,29 @@ static void rbd_img_request_put(struct
rbd_img_request *img_request)
 static inline void rbd_img_obj_request_add(struct rbd_img_request
*img_request,
 					struct rbd_obj_request *obj_request)
 {
+	rbd_assert(obj_request->img_request == NULL);
+
 	rbd_obj_request_get(obj_request);
 	obj_request->img_request = img_request;
-	list_add_tail(&obj_request->links, &img_request->obj_requests);
-	obj_request->which = img_request->obj_request_count++;
+	obj_request->which = img_request->obj_request_count;
 	rbd_assert(obj_request->which != BAD_WHICH);
+	img_request->obj_request_count++;
+	list_add_tail(&obj_request->links, &img_request->obj_requests);
 }

 static inline void rbd_img_obj_request_del(struct rbd_img_request
*img_request,
 					struct rbd_obj_request *obj_request)
 {
 	rbd_assert(obj_request->which != BAD_WHICH);
-	obj_request->which = BAD_WHICH;
+
 	list_del(&obj_request->links);
+	rbd_assert(img_request->obj_request_count > 0);
+	img_request->obj_request_count--;
+	rbd_assert(obj_request->which == img_request->obj_request_count);
+	obj_request->which = BAD_WHICH;
 	rbd_assert(obj_request->img_request == img_request);
-	obj_request->callback = NULL;
 	obj_request->img_request = NULL;
+	obj_request->callback = NULL;
 	rbd_obj_request_put(obj_request);
 }

@@ -1482,6 +1489,7 @@ static void rbd_img_request_destroy(struct kref *kref)

 	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
 		rbd_img_obj_request_del(img_request, obj_request);
+	rbd_assert(img_request->obj_request_count == 0);

 	if (img_request->write_request)
 		ceph_put_snap_context(img_request->snapc);
-- 
1.7.9.5

