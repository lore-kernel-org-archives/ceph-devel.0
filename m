From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: do a safe list traversal in rbd_img_request_submit()
Date: Wed, 10 Apr 2013 17:49:23 -0500
Message-ID: <5165EC73.5000600@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:56278 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934682Ab3DJWt0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Apr 2013 18:49:26 -0400
Received: by mail-ia0-f169.google.com with SMTP id h23so768188iae.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Apr 2013 15:49:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's possible that the reference to the object request dropped
inside the loop in rbd_img_request_submit() will be the last
one, in which case the content of the object pointer can't be
trusted.

Use a safe form of the object request list traversal to avoid
problems.

This resolves:
    http://tracker.ceph.com/issues/4705

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3c0abe6..7eb1032 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1652,9 +1652,10 @@ static int rbd_img_request_submit(struct
rbd_img_request *img_request)
 	struct rbd_device *rbd_dev = img_request->rbd_dev;
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
+	struct rbd_obj_request *next_obj_request;

 	dout("%s: img %p\n", __func__, img_request);
-	for_each_obj_request(img_request, obj_request) {
+	for_each_obj_request_safe(img_request, obj_request, next_obj_request) {
 		int ret;

 		ret = rbd_obj_request_submit(osdc, obj_request);
-- 
1.7.9.5

