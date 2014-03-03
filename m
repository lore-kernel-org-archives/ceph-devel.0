From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: fix error paths in rbd_img_request_fill()
Date: Mon,  3 Mar 2014 17:38:22 +0200
Message-ID: <1393861102-5123-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:40699 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbaCCPi0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 10:38:26 -0500
Received: by mail-ee0-f53.google.com with SMTP id e51so3098391eek.12
        for <ceph-devel@vger.kernel.org>; Mon, 03 Mar 2014 07:38:25 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id w6sm13469818eex.9.2014.03.03.07.38.24
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Mar 2014 07:38:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Doing rbd_obj_request_put() in rbd_img_request_fill() error paths is
not only insufficient, but also triggers an rbd_assert() in
rbd_obj_request_destroy():

Assertion failure in rbd_obj_request_destroy() at line 1867:
rbd_assert(obj_request->img_request == NULL);

rbd_img_obj_request_add() adds obj_requests to the img_request, the
opposite is rbd_img_obj_request_del().  Use it.

While at it, commit 03507db631c94 ("rbd: fix buffer size for writes to
images with snapshots") moved the call to rbd_img_obj_request_add() up,
making the out_partial label bogus.  Remove it.

Fixes: http://tracker.ceph.com/issues/7327

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b365e0dfccb6..53d492e83586 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2191,6 +2191,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		rbd_segment_name_free(object_name);
 		if (!obj_request)
 			goto out_unwind;
+
 		/*
 		 * set obj_request->img_request before creating the
 		 * osd_request so that it gets the right snapc
@@ -2208,7 +2209,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 								clone_size,
 								GFP_ATOMIC);
 			if (!obj_request->bio_list)
-				goto out_partial;
+				goto out_unwind;
 		} else {
 			unsigned int page_count;
 
@@ -2223,7 +2224,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		osd_req = rbd_osd_req_create(rbd_dev, write_request,
 						obj_request);
 		if (!osd_req)
-			goto out_partial;
+			goto out_unwind;
 		obj_request->osd_req = osd_req;
 		obj_request->callback = rbd_img_obj_callback;
 
@@ -2250,11 +2251,9 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 
 	return 0;
 
-out_partial:
-	rbd_obj_request_put(obj_request);
 out_unwind:
 	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
-		rbd_obj_request_put(obj_request);
+		rbd_img_obj_request_del(img_request, obj_request);
 
 	return -ENOMEM;
 }
-- 
1.7.10.4

