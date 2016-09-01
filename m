From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/2] rbd: fix rbd_img_obj_exists_submit() error path
Date: Thu,  1 Sep 2016 16:59:19 +0200
Message-ID: <1472741959-1786-3-git-send-email-ddiss@suse.de>
References: <1472741959-1786-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44748 "EHLO mx2.suse.de"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S933012AbcIAPAO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Sep 2016 11:00:14 -0400
In-Reply-To: <1472741959-1786-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@linaro.org, David Disseldorp <ddiss@suse.de>

A couple of issues addressed:
- obj_request put before get.
- stat_request leaked, including payload pages.

Fixes: c5b5ef6c5 ("rbd: issue stat request before layered write")

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/rbd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 93d6200..970fea6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2858,8 +2858,10 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	ret = -ENOMEM;
 	stat_request = rbd_obj_request_create(obj_request->object_name, 0, 0,
 							OBJ_REQUEST_PAGES);
-	if (!stat_request)
+	if (!stat_request) {
+		ceph_release_page_vector(pages, page_count);
 		goto out;
+	}
 
 	rbd_obj_request_get(obj_request);
 	stat_request->obj_request = obj_request;
@@ -2871,7 +2873,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
 						   stat_request);
 	if (!stat_request->osd_req)
-		goto out;
+		goto out_cleanup;
 	stat_request->callback = rbd_img_obj_exists_callback;
 
 	osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT, 0);
@@ -2885,10 +2887,13 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 
 	osdc = &rbd_dev->rbd_client->client->osdc;
 	ret = rbd_obj_request_submit(osdc, stat_request);
-out:
-	if (ret)
+out_cleanup:
+	if (ret) {
 		rbd_obj_request_put(obj_request);
-
+		stat_request->img_request = NULL;
+		rbd_obj_request_put(stat_request);
+	}
+out:
 	return ret;
 }
 
-- 
2.6.6

