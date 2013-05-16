From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] rbd: drop original request earlier for existence check
Date: Thu, 16 May 2013 16:29:21 -0500
Message-ID: <51954FB1.9060902@inktank.com>
References: <519195DC.1060609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:56522 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3EPV3Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 17:29:24 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so4412458oag.9
        for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 14:29:23 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id x10sm9093208oes.6.2013.05.16.14.29.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 16 May 2013 14:29:22 -0700 (PDT)
In-Reply-To: <519195DC.1060609@inktank.com>
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
v2: rebased to reflect changes in earlier patches

 drivers/block/rbd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fdbcf04..b4c5e47 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2529,6 +2529,7 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 	 */
 	orig_request = obj_request->obj_request;
 	obj_request->obj_request = NULL;
+	rbd_obj_request_put(orig_request);
 	rbd_assert(orig_request);
 	rbd_assert(orig_request->img_request);

@@ -2549,7 +2550,6 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 	if (!rbd_dev->parent_overlap) {
 		struct ceph_osd_client *osdc;

-		rbd_obj_request_put(orig_request);
 		osdc = &rbd_dev->rbd_client->client->osdc;
 		result = rbd_obj_request_submit(osdc, orig_request);
 		if (!result)
@@ -2579,7 +2579,6 @@ static void rbd_img_obj_exists_callback(struct
rbd_obj_request *obj_request)
 out:
 	if (orig_request->result)
 		rbd_obj_request_complete(orig_request);
-	rbd_obj_request_put(orig_request);
 }

 static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
-- 
1.7.9.5

