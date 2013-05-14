From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: drop original request earlier for existence check
Date: Mon, 13 May 2013 20:39:40 -0500
Message-ID: <519195DC.1060609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:54606 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab3ENBjn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 21:39:43 -0400
Received: by mail-ob0-f178.google.com with SMTP id v19so3565072obq.23
        for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 18:39:42 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c20sm19837623oez.4.2013.05.13.18.39.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 18:39:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The reference to the original request dropped at the end of
rbd_img_obj_exists_callback() corresponds to the reference taken
in rbd_img_obj_exists_submit() to account for the stat request
referring to it.  Move the put of that reference up right after
clearing that pointer to make its purpose more obvious.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 632dd35..b2f5c96 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2528,6 +2528,7 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 	 */
 	orig_request = obj_request->obj_request;
 	obj_request->obj_request = NULL;
+	rbd_obj_request_put(orig_request);
 	rbd_assert(orig_request);
 	rbd_assert(orig_request->img_request);

@@ -2548,7 +2549,6 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 	if (!rbd_dev->parent_overlap) {
 		struct ceph_osd_client *osdc;

-		rbd_obj_request_put(orig_request);
 		osdc = &rbd_dev->rbd_client->client->osdc;
 		result = rbd_obj_request_submit(osdc, orig_request);
 		if (!result)
@@ -2578,7 +2578,6 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 out:
 	if (orig_request->result)
 		rbd_obj_request_complete(orig_request);
-	rbd_obj_request_put(orig_request);
 }

 static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
-- 
1.7.9.5

