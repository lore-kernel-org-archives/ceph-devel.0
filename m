From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: enforce parent overlap
Date: Sun, 21 Apr 2013 00:34:13 -0500
Message-ID: <51737A55.7040602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58767 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3DUFeQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 01:34:16 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so2429037iec.15
        for <ceph-devel@vger.kernel.org>; Sat, 20 Apr 2013 22:34:16 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xf4sm10365691igb.8.2013.04.20.22.34.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 22:34:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(This patch is available in branch "review/wip-overlap" of
the ceph-client git repository.)



A clone image has a defined overlap point with its parent image.
That is the byte offset beyond which the parent image has no
defined data to back the clone, and anything thereafter can be
viewed as being zero-filled by the clone image.

This is needed because a clone image can be resized.  If it gets
resized larger than the snapshot it is based on, the overlap defines
the original size.  If the clone gets resized downward below the
original size the new clone size defines the overlap.  If the clone
is subsequently resized to be larger, the overlap won't be increased
because the previous resize invalidated any parent data beyond that
point.

This resolves:
    http://tracker.ceph.com/issues/4724

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   64
+++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5bf125c..5724d41 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1437,20 +1437,20 @@ static void rbd_osd_trivial_callback(struct
rbd_obj_request *obj_request)
 static void rbd_osd_read_callback(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request = NULL;
+	struct rbd_device *rbd_dev = NULL;
 	bool layered = false;

 	if (obj_request_img_data_test(obj_request)) {
 		img_request = obj_request->img_request;
 		layered = img_request && img_request_layered_test(img_request);
-	} else {
-		img_request = NULL;
-		layered = false;
+		rbd_dev = img_request->rbd_dev;
 	}

 	dout("%s: obj %p img %p result %d %llu/%llu\n", __func__,
 		obj_request, img_request, obj_request->result,
 		obj_request->xferred, obj_request->length);
-	if (layered && obj_request->result == -ENOENT)
+	if (layered && obj_request->result == -ENOENT &&
+			obj_request->img_offset < rbd_dev->parent_overlap)
 		rbd_img_parent_read(obj_request);
 	else if (img_request)
 		rbd_img_obj_request_read_callback(obj_request);
@@ -2166,6 +2166,16 @@ static int rbd_img_obj_parent_read_full(struct
rbd_obj_request *obj_request)
 	length = (u64)1 << rbd_dev->header.obj_order;

 	/*
+	 * There is no defined parent data beyond the parent
+	 * overlap, so limit what we read at that boundary if
+	 * necessary.
+	 */
+	if (img_offset + length > rbd_dev->parent_overlap) {
+		rbd_assert(img_offset < rbd_dev->parent_overlap);
+		length = obj_request->offset - obj_request->img_offset;
+	}
+
+	/*
 	 * Allocate a page array big enough to receive the data read
 	 * from the parent.
 	 */
@@ -2325,21 +2335,28 @@ out:
 static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request;
+	struct rbd_device *rbd_dev;
 	bool known;

 	rbd_assert(obj_request_img_data_test(obj_request));

 	img_request = obj_request->img_request;
 	rbd_assert(img_request);
+	rbd_dev = img_request->rbd_dev;

 	/*
-	 * Only layered writes need special handling.  If it's not a
-	 * layered write, or it is a layered write but we know the
-	 * target object exists, it's no different from any other
-	 * object request.
+	 * Only writes to layered images need special handling.
+	 * Reads and non-layered writes are simple object requests.
+	 * Layered writes that start beyond the end of the overlap
+	 * with the parent have no parent data, so they too are
+	 * simple object requests.  Finally, if the target object is
+	 * known to already exist, its parent data has already been
+	 * copied, so a write to the object can also be handled as a
+	 * simple object request.
 	 */
 	if (!img_request_write_test(img_request) ||
 		!img_request_layered_test(img_request) ||
+		rbd_dev->parent_overlap <= obj_request->img_offset ||
 		((known = obj_request_known_test(obj_request)) &&
 			obj_request_exists_test(obj_request))) {

@@ -2386,14 +2403,41 @@ static int rbd_img_request_submit(struct
rbd_img_request *img_request)
 static void rbd_img_parent_read_callback(struct rbd_img_request
*img_request)
 {
 	struct rbd_obj_request *obj_request;
+	struct rbd_device *rbd_dev;
+	u64 obj_end;

 	rbd_assert(img_request_child_test(img_request));

 	obj_request = img_request->obj_request;
-	rbd_assert(obj_request != NULL);
+	rbd_assert(obj_request);
+	rbd_assert(obj_request->img_request);
+
 	obj_request->result = img_request->result;
-	obj_request->xferred = img_request->xferred;
+	if (obj_request->result)
+		goto out;

+	/*
+	 * We need to zero anything beyond the parent overlap
+	 * boundary.  Since rbd_img_obj_request_read_callback()
+	 * will zero anything beyond the end of a short read, an
+	 * easy way to do this is to pretend the data from the
+	 * parent came up short--ending at the overlap boundary.
+	 */
+	rbd_assert(obj_request->img_offset < U64_MAX - obj_request->length);
+	obj_end = obj_request->img_offset + obj_request->length;
+	rbd_dev = obj_request->img_request->rbd_dev;
+	if (obj_end > rbd_dev->parent_overlap) {
+		u64 xferred = 0;
+
+		if (obj_request->img_offset < rbd_dev->parent_overlap)
+			xferred = rbd_dev->parent_overlap -
+					obj_request->img_offset;
+
+		obj_request->xferred = min(img_request->xferred, xferred);
+	} else {
+		obj_request->xferred = img_request->xferred;
+	}
+out:
 	rbd_img_obj_request_read_callback(obj_request);
 	rbd_obj_request_complete(obj_request);
 }
-- 
1.7.9.5

