From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: fix copyup completion race
Date: Fri, 17 Jul 2015 13:36:40 +0300
Message-ID: <1437129400-12392-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33431 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757588AbbGQKgz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2015 06:36:55 -0400
Received: by wgmn9 with SMTP id n9so78998081wgm.0
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jul 2015 03:36:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

For write/discard obj_requests that involved a copyup method call, the
opcode of the first op is CEPH_OSD_OP_CALL and the ->callback is
rbd_img_obj_copyup_callback().  The latter frees copyup pages, sets
->xferred and delegates to rbd_img_obj_callback(), the "normal" image
object callback, for reporting to block layer and putting refs.

rbd_osd_req_callback() however treats CEPH_OSD_OP_CALL as a trivial op,
which means obj_request is marked done in rbd_osd_trivial_callback(),
*before* ->callback is invoked and rbd_img_obj_copyup_callback() has
a chance to run.  Marking obj_request done essentially means giving
rbd_img_obj_callback() a license to end it at any moment, so if another
obj_request from the same img_request is being completed concurrently,
rbd_img_obj_end_request() may very well be called on such prematurally
marked done request:

<obj_request-1/2 reply>
handle_reply()
  rbd_osd_req_callback()
    rbd_osd_trivial_callback()
    rbd_obj_request_complete()
    rbd_img_obj_copyup_callback()
    rbd_img_obj_callback()
                                    <obj_request-2/2 reply>
                                    handle_reply()
                                      rbd_osd_req_callback()
                                        rbd_osd_trivial_callback()
      for_each_obj_request(obj_request->img_request) {
        rbd_img_obj_end_request(obj_request-1/2)
        rbd_img_obj_end_request(obj_request-2/2) <--
      }

Calling rbd_img_obj_end_request() on such a request leads to trouble,
in particular because its ->xfferred is 0.  We report 0 to the block
layer with blk_update_request(), get back 1 for "this request has more
data in flight" and then trip on

    rbd_assert(more ^ (which == img_request->obj_request_count));

with rhs (which == ...) being 1 because rbd_img_obj_end_request() has
been called for both requests and lhs (more) being 1 because we haven't
got a chance to set ->xfferred in rbd_img_obj_copyup_callback() yet.

To fix this, leverage that rbd wants to call class methods in only two
cases: one is a generic method call wrapper (obj_request is standalone)
and the other is a copyup (obj_request is part of an img_request).  So
make a dedicated handler for CEPH_OSD_OP_CALL and directly invoke
rbd_img_obj_copyup_callback() from it if obj_request is part of an
img_request, similar to how CEPH_OSD_OP_READ handler invokes
rbd_img_obj_request_read_callback().

Cc: Alex Elder <elder@linaro.org>
Cc: stable@vger.kernel.org # 3.10+, needs backporting for < 3.18
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d94529d5c8e9..007e5d0cadaf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -523,6 +523,7 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
 #  define rbd_assert(expr)	((void) 0)
 #endif /* !RBD_DEBUG */
 
+static void rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request);
 static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request);
 static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
@@ -1818,6 +1819,16 @@ static void rbd_osd_stat_callback(struct rbd_obj_request *obj_request)
 	obj_request_done_set(obj_request);
 }
 
+static void rbd_osd_call_callback(struct rbd_obj_request *obj_request)
+{
+	dout("%s: obj %p\n", __func__, obj_request);
+
+	if (obj_request_img_data_test(obj_request))
+		rbd_img_obj_copyup_callback(obj_request);
+	else
+		obj_request_done_set(obj_request);
+}
+
 static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 				struct ceph_msg *msg)
 {
@@ -1866,6 +1877,8 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 		rbd_osd_discard_callback(obj_request);
 		break;
 	case CEPH_OSD_OP_CALL:
+		rbd_osd_call_callback(obj_request);
+		break;
 	case CEPH_OSD_OP_NOTIFY_ACK:
 	case CEPH_OSD_OP_WATCH:
 		rbd_osd_trivial_callback(obj_request);
@@ -2537,6 +2550,8 @@ rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request)
 	struct page **pages;
 	u32 page_count;
 
+	dout("%s: obj %p\n", __func__, obj_request);
+
 	rbd_assert(obj_request->type == OBJ_REQUEST_BIO ||
 		obj_request->type == OBJ_REQUEST_NODATA);
 	rbd_assert(obj_request_img_data_test(obj_request));
@@ -2563,9 +2578,7 @@ rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request)
 	if (!obj_request->result)
 		obj_request->xferred = obj_request->length;
 
-	/* Finish up with the normal image object callback */
-
-	rbd_img_obj_callback(obj_request);
+	obj_request_done_set(obj_request);
 }
 
 static void
@@ -2650,7 +2663,6 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 
 	/* All set, send it off. */
 
-	orig_request->callback = rbd_img_obj_copyup_callback;
 	osdc = &rbd_dev->rbd_client->client->osdc;
 	img_result = rbd_obj_request_submit(osdc, orig_request);
 	if (!img_result)
-- 
1.9.3

