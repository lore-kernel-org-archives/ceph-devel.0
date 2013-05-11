From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: re-submit flattened write request (part 2)
Date: Sat, 11 May 2013 12:47:46 -0500
Message-ID: <518E8442.9020305@inktank.com>
References: <518E83D3.4050709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:56766 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3EKRrr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:47:47 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so10109908iea.31
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:47:47 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wx2sm6117415igb.4.2013.05.11.10.47.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:47:46 -0700 (PDT)
In-Reply-To: <518E83D3.4050709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add code to rbd_img_obj_exists_callback() to detect when a clone's
parent image has disappeared, and re-submit the original write
request in that case.

Kill off some redundant assertions.

This completes the resolution for:
    http://tracker.ceph.com/issues/3763

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index dfa6bfc..59bf75a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2508,6 +2508,7 @@ out_err:
 static void rbd_img_obj_exists_callback(struct rbd_obj_request
*obj_request)
 {
 	struct rbd_obj_request *orig_request;
+	struct rbd_device *rbd_dev;
 	int result;

 	rbd_assert(!obj_request_img_data_test(obj_request));
@@ -2530,8 +2531,20 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 		obj_request->xferred, obj_request->length);
 	rbd_obj_request_put(obj_request);

-	rbd_assert(orig_request);
-	rbd_assert(orig_request->img_request);
+	/*
+	 * If the overlap has become 0 (most likely because the
+	 * image has been flattened) we need to free the pages
+	 * and re-submit the original write request.
+	 */
+	rbd_dev = orig_request->img_request->rbd_dev;
+	if (!rbd_dev->parent_overlap) {
+		struct ceph_osd_client *osdc;
+
+		osdc = &rbd_dev->rbd_client->client->osdc;
+		result = rbd_obj_request_submit(osdc, orig_request);
+		if (!result)
+			return;
+	}

 	/*
 	 * Our only purpose here is to determine whether the object
-- 
1.7.9.5

