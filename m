From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/8] rbd: move bumping img_request refcount into rbd_obj_request_submit()
Date: Mon, 19 Sep 2016 19:03:24 +0200
Message-ID: <1474304608-17958-5-git-send-email-idryomov@gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33669 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbcISRDs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:03:48 -0400
Received: by mail-yw0-f195.google.com with SMTP id g192so8608277ywh.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:03:48 -0700 (PDT)
In-Reply-To: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

Commit 0f2d5be792b0 ("rbd: use reference counts for image requests")
added rbd_img_request_get(), which rbd_img_request_fill() calls for
each obj_request added to img_request.  It was an urgent band-aid for
the uglyness that is rbd_img_obj_callback() and none of the error paths
were updated.

Given that this img_request reference is meant to represent an
obj_request that hasn't passed through rbd_img_obj_callback() yet,
proper cleanup in appropriate destructors is a challenge.  However,
noting that if we don't get a chance to call rbd_obj_request_complete(),
there is not going to be a call to rbd_img_obj_callback(), we can move
rbd_img_request_get() into rbd_obj_request_submit() and fixup the two
places that call rbd_obj_request_complete() directly and not through
rbd_obj_request_submit() to temporarily bump img_request, so that
rbd_img_obj_callback() can put as usual.

This takes care of img_request leaks on errors on the submit side.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b247200a0f28..d8070bd29fd1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1610,11 +1610,17 @@ static bool obj_request_type_valid(enum obj_request_type type)
 	}
 }
 
+static void rbd_img_obj_callback(struct rbd_obj_request *obj_request);
+
 static void rbd_obj_request_submit(struct rbd_obj_request *obj_request)
 {
 	struct ceph_osd_request *osd_req = obj_request->osd_req;
 
 	dout("%s %p osd_req %p\n", __func__, obj_request, osd_req);
+	if (obj_request_img_data_test(obj_request)) {
+		WARN_ON(obj_request->callback != rbd_img_obj_callback);
+		rbd_img_request_get(obj_request->img_request);
+	}
 	ceph_osdc_start_request(osd_req->r_osdc, osd_req, false);
 }
 
@@ -2580,8 +2586,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 
 		rbd_img_obj_request_fill(obj_request, osd_req, op_type, 0);
 
-		rbd_img_request_get(img_request);
-
 		img_offset += length;
 		resid -= length;
 	}
@@ -2715,10 +2719,9 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	return;
 
 out_err:
-	/* Record the error code and complete the request */
-
 	orig_request->result = img_result;
 	orig_request->xferred = 0;
+	rbd_img_request_get(orig_request->img_request);
 	obj_request_done_set(orig_request);
 	rbd_obj_request_complete(orig_request);
 }
@@ -2873,6 +2876,7 @@ static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
 fail_orig_request:
 	orig_request->result = result;
 	orig_request->xferred = 0;
+	rbd_img_request_get(orig_request->img_request);
 	obj_request_done_set(orig_request);
 	rbd_obj_request_complete(orig_request);
 }
-- 
2.4.3

