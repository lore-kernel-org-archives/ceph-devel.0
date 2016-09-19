From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7/8] rbd: don't call rbd_osd_req_format_read() for !img_data requests
Date: Mon, 19 Sep 2016 19:03:27 +0200
Message-ID: <1474304608-17958-8-git-send-email-idryomov@gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34470 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbcISRDv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:03:51 -0400
Received: by mail-yw0-f195.google.com with SMTP id t67so8397755ywg.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:03:51 -0700 (PDT)
In-Reply-To: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

Accessing obj_request->img_request union field is only valid for object
requests associated with an image (i.e. if obj_request_img_data_test()
returns true).  rbd_osd_req_format_read() used to do more, but now it
just sets osd_req->snap_id.  Standalone and stat object requests always
go to the HEAD revision and are fine with CEPH_NOSNAP set by libceph,
so get around the invalid union field use by simply not calling
rbd_osd_req_format_read() in those places.

Reported-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 03f171067e08..8907ee6342ac 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1943,11 +1943,10 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req)
 
 static void rbd_osd_req_format_read(struct rbd_obj_request *obj_request)
 {
-	struct rbd_img_request *img_request = obj_request->img_request;
 	struct ceph_osd_request *osd_req = obj_request->osd_req;
 
-	if (img_request)
-		osd_req->r_snapid = img_request->snap_id;
+	rbd_assert(obj_request_img_data_test(obj_request));
+	osd_req->r_snapid = obj_request->img_request->snap_id;
 }
 
 static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
@@ -2929,8 +2928,6 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	stat_request->page_count = page_count;
 	stat_request->callback = rbd_img_obj_exists_callback;
 
-	rbd_osd_req_format_read(stat_request);
-
 	rbd_obj_request_submit(stat_request);
 	return 0;
 
@@ -4026,7 +4023,6 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
 					obj_request->pages, inbound_size,
 					0, false, false);
-	rbd_osd_req_format_read(obj_request);
 
 	rbd_obj_request_submit(obj_request);
 	ret = rbd_obj_request_wait(obj_request);
@@ -4265,7 +4261,6 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 					obj_request->length,
 					obj_request->offset & ~PAGE_MASK,
 					false, false);
-	rbd_osd_req_format_read(obj_request);
 
 	rbd_obj_request_submit(obj_request);
 	ret = rbd_obj_request_wait(obj_request);
-- 
2.4.3

