From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/8] rbd: mark the original request as done if stat request fails
Date: Mon, 19 Sep 2016 19:03:23 +0200
Message-ID: <1474304608-17958-4-git-send-email-idryomov@gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33666 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbcISRDr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:03:47 -0400
Received: by mail-yw0-f195.google.com with SMTP id g192so8608262ywh.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:03:46 -0700 (PDT)
In-Reply-To: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

If stat request fails with something other than -ENOENT (which just
means that we need to copyup), the original object request is never
marked as done and therefore never completed.  Fix this by moving the
mark done + complete snippet from rbd_img_obj_parent_read_full() into
rbd_img_obj_exists_callback().  The former remains covered, as the
latter is its only caller (through rbd_img_obj_request_submit()).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 027e0817a118..b247200a0f28 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2805,10 +2805,6 @@ out_err:
 		ceph_release_page_vector(pages, page_count);
 	if (parent_request)
 		rbd_img_request_put(parent_request);
-	obj_request->result = result;
-	obj_request->xferred = 0;
-	obj_request_done_set(obj_request);
-
 	return result;
 }
 
@@ -2860,19 +2856,25 @@ static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
 		obj_request_existence_set(orig_request, true);
 	} else if (result == -ENOENT) {
 		obj_request_existence_set(orig_request, false);
-	} else if (result) {
-		orig_request->result = result;
-		goto out;
+	} else {
+		goto fail_orig_request;
 	}
 
 	/*
 	 * Resubmit the original request now that we have recorded
 	 * whether the target object exists.
 	 */
-	orig_request->result = rbd_img_obj_request_submit(orig_request);
-out:
-	if (orig_request->result)
-		rbd_obj_request_complete(orig_request);
+	result = rbd_img_obj_request_submit(orig_request);
+	if (result)
+		goto fail_orig_request;
+
+	return;
+
+fail_orig_request:
+	orig_request->result = result;
+	orig_request->xferred = 0;
+	obj_request_done_set(orig_request);
+	rbd_obj_request_complete(orig_request);
 }
 
 static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
-- 
2.4.3

