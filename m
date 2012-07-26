From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/7] rbd: drop "object_name" from rbd_req_sync_unwatch()
Date: Thu, 26 Jul 2012 13:57:55 -0500
Message-ID: <50119333.50908@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54228 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab2GZS54 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:57:56 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so2338429yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:57:56 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_req_sync_unwatch() only ever uses rbd_dev->header_name as the
value of its "object_name" parameter, and that value is available
within the function already.  So get rid of the parameter.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 48a7927..fd5f3038 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1279,8 +1279,7 @@ fail:
 /*
  * Request sync osd unwatch
  */
-static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev,
-				const char *object_name)
+static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_req_op *ops;

@@ -1297,7 +1296,9 @@ static int rbd_req_sync_unwatch(struct rbd_device
*rbd_dev,
 			      0,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
-			      object_name, 0, 0, NULL, NULL, NULL);
+			      rbd_dev->header_name,
+			      0, 0, NULL, NULL, NULL);
+

 	rbd_destroy_ops(ops);
 	ceph_osdc_cancel_event(rbd_dev->watch_event);
@@ -2563,7 +2564,7 @@ static void rbd_dev_release(struct device *dev)
 						    rbd_dev->watch_request);
 	}
 	if (rbd_dev->watch_event)
-		rbd_req_sync_unwatch(rbd_dev, rbd_dev->header_name);
+		rbd_req_sync_unwatch(rbd_dev);

 	rbd_put_client(rbd_dev);

-- 
1.7.9.5

