From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 8/8] rbd: img_data requests don't own their page array
Date: Mon, 19 Sep 2016 19:03:28 +0200
Message-ID: <1474304608-17958-9-git-send-email-idryomov@gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36312 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbcISRDw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:03:52 -0400
Received: by mail-yw0-f195.google.com with SMTP id v2so8594844ywg.3
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:03:52 -0700 (PDT)
In-Reply-To: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

Move the check into rbd_obj_request_destroy(), to avoid use-after-free
on errors in rbd_img_request_fill().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8907ee6342ac..d305b9ebe2cf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2139,7 +2139,9 @@ static void rbd_obj_request_destroy(struct kref *kref)
 			bio_chain_put(obj_request->bio_list);
 		break;
 	case OBJ_REQUEST_PAGES:
-		if (obj_request->pages)
+		/* img_data requests don't own their page array */
+		if (obj_request->pages &&
+		    !obj_request_img_data_test(obj_request))
 			ceph_release_page_vector(obj_request->pages,
 						obj_request->page_count);
 		break;
@@ -2360,13 +2362,6 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 		xferred = obj_request->length;
 	}
 
-	/* Image object requests don't own their page array */
-
-	if (obj_request->type == OBJ_REQUEST_PAGES) {
-		obj_request->pages = NULL;
-		obj_request->page_count = 0;
-	}
-
 	if (img_request_child_test(img_request)) {
 		rbd_assert(img_request->obj_request != NULL);
 		more = obj_request->which < img_request->obj_request_count - 1;
-- 
2.4.3

