From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 07/15] rbd: remove now unused rbd_obj_request_wait() and helpers
Date: Tue, 14 Feb 2017 21:11:56 +0100
Message-ID: <1487103124-2974-8-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34914 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754954AbdBNUMm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:42 -0500
Received: by mail-qk0-f195.google.com with SMTP id u25so20603971qki.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:41 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2967b50b48fc..68036c29c07c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1619,44 +1619,6 @@ static void rbd_obj_request_submit(struct rbd_obj_request *obj_request)
 	ceph_osdc_start_request(osd_req->r_osdc, osd_req, false);
 }
 
-static void rbd_obj_request_end(struct rbd_obj_request *obj_request)
-{
-	dout("%s %p\n", __func__, obj_request);
-	ceph_osdc_cancel_request(obj_request->osd_req);
-}
-
-/*
- * Wait for an object request to complete.  If interrupted, cancel the
- * underlying osd request.
- *
- * @timeout: in jiffies, 0 means "wait forever"
- */
-static int __rbd_obj_request_wait(struct rbd_obj_request *obj_request,
-				  unsigned long timeout)
-{
-	long ret;
-
-	dout("%s %p\n", __func__, obj_request);
-	ret = wait_for_completion_interruptible_timeout(
-					&obj_request->completion,
-					ceph_timeout_jiffies(timeout));
-	if (ret <= 0) {
-		if (ret == 0)
-			ret = -ETIMEDOUT;
-		rbd_obj_request_end(obj_request);
-	} else {
-		ret = 0;
-	}
-
-	dout("%s %p ret %d\n", __func__, obj_request, (int)ret);
-	return ret;
-}
-
-static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
-{
-	return __rbd_obj_request_wait(obj_request, 0);
-}
-
 static void rbd_img_request_complete(struct rbd_img_request *img_request)
 {
 
-- 
2.4.3

