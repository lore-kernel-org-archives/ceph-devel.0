From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 02/11] rbd: skip the copyup when an entire object writing
Date: Tue,  8 Apr 2014 13:42:46 -0700
Message-ID: <e8c928e7bb03d2bb934a64a8d558319d9a76b35c.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56375 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105AbaDHWCZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:25 -0400
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Guangliang Zhao <lucienchao@gmail.com>

From: Guangliang Zhao <lucienchao@gmail.com>

It need to copyup the parent's content when layered writing,
but an entire object write would overwrite it, so skip it.

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 drivers/block/rbd.c |   49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b6676b6..282bfcd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2645,34 +2645,53 @@ out:
 	return ret;
 }
 
-static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
+static bool rbd_img_obj_request_simple(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request;
 	struct rbd_device *rbd_dev;
-	bool known;
+	u64 obj_size;
 
 	rbd_assert(obj_request_img_data_test(obj_request));
 
 	img_request = obj_request->img_request;
 	rbd_assert(img_request);
 	rbd_dev = img_request->rbd_dev;
+	obj_size = (u64) 1 << rbd_dev->header.obj_order;
 
+	/* Read requests didn't need special handling */
+	if (!img_request_write_test(img_request))
+		return true;
+	/* No-layered writes are simple requests*/
+	if (!img_request_layered_test(img_request))
+		return true;
 	/*
-	 * Only writes to layered images need special handling.
-	 * Reads and non-layered writes are simple object requests.
 	 * Layered writes that start beyond the end of the overlap
-	 * with the parent have no parent data, so they too are
-	 * simple object requests.  Finally, if the target object is
-	 * known to already exist, its parent data has already been
-	 * copied, so a write to the object can also be handled as a
-	 * simple object request.
+	 * with the parent have no parent data, so they are simple
+	 * object requests.
 	 */
-	if (!img_request_write_test(img_request) ||
-		!img_request_layered_test(img_request) ||
-		rbd_dev->parent_overlap <= obj_request->img_offset ||
-		((known = obj_request_known_test(obj_request)) &&
-			obj_request_exists_test(obj_request))) {
+	if (rbd_dev->parent_overlap <= obj_request->img_offset)
+		return true;
+	/*
+	 * If the obj_request aligns with the boundary and equals
+	 * to the size of an object, it doesn't need copyup, because
+	 * the obj_request will overwrite it finally.
+	 */
+	if ((!obj_request->offset) && (obj_request->length == obj_size))
+		return true;
+	/*
+	 * If the target object is known to already exist, its parent
+	 * data has already been copied, so a write to the object can
+	 * also be handled as a simple object request
+	 */
+	if (obj_request_known_test(obj_request) &&
+			obj_request_exists_test(obj_request))
+		return true;
+	return false;
+}
 
+static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
+{
+	if (rbd_img_obj_request_simple(obj_request)) {
 		struct rbd_device *rbd_dev;
 		struct ceph_osd_client *osdc;
 
@@ -2688,7 +2707,7 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
 	 * start by reading the data for the full target object from
 	 * the parent so we can use it for a copyup to the target.
 	 */
-	if (known)
+	if (obj_request_known_test(obj_request))
 		return rbd_img_obj_parent_read_full(obj_request);
 
 	/* We don't know whether the target exists.  Go find out. */
-- 
1.7.10.4

