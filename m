From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/5] rbd: get rid of img_request_layered_clear()
Date: Thu, 13 Feb 2020 20:26:03 +0100
Message-ID: <20200213192606.31194-3-idryomov@gmail.com>
References: <20200213192606.31194-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36356 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgBMTZo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 14:25:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so8144757wru.3
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 11:25:44 -0800 (PST)
In-Reply-To: <20200213192606.31194-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>

No need to clear IMG_REQ_LAYERED before destroying the request.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 22d524a0e98b..96aa0133fb40 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1358,11 +1358,6 @@ static void img_request_layered_set(struct rbd_img_request *img_request)
 	set_bit(IMG_REQ_LAYERED, &img_request->flags);
 }
 
-static void img_request_layered_clear(struct rbd_img_request *img_request)
-{
-	clear_bit(IMG_REQ_LAYERED, &img_request->flags);
-}
-
 static bool img_request_layered_test(struct rbd_img_request *img_request)
 {
 	return test_bit(IMG_REQ_LAYERED, &img_request->flags) != 0;
@@ -1661,10 +1656,8 @@ static void rbd_img_request_destroy(struct rbd_img_request *img_request)
 	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
 		rbd_img_obj_request_del(img_request, obj_request);
 
-	if (img_request_layered_test(img_request)) {
-		img_request_layered_clear(img_request);
+	if (img_request_layered_test(img_request))
 		rbd_dev_parent_put(img_request->rbd_dev);
-	}
 
 	if (rbd_img_is_write(img_request))
 		ceph_put_snap_context(img_request->snapc);
-- 
2.19.2
