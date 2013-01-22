From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] rbd: don't retry setting up header watch
Date: Tue, 22 Jan 2013 15:58:34 -0600
Message-ID: <50FF0B8A.6080007@inktank.com>
References: <50FF0B22.5060201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:49447 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab3AVV6h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:58:37 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so12422442iea.38
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:58:37 -0800 (PST)
In-Reply-To: <50FF0B22.5060201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When an rbd image is initially mapped a watch event is registered so
we can do something if the header object changes.  Right now if that
returns ERANGE we loop back and try to initiate it again.  However
the code that sets up the watch event doesn't clean up after itself
very well, and doing that properly will require some work.

For now, just stop retrying, and if ERANGE gets returned, fail the
map request.

This resolves (for the near term):
    http://tracker.newdream.net/issues/3860

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 58d01e3..6689363 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1474,6 +1474,9 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev, int start)
 	struct ceph_osd_req_op *op;
 	int ret = 0;

+	rbd_assert(start ^ !!rbd_dev->watch_event);
+	rbd_assert(start ^ !!rbd_dev->watch_request);
+
 	if (start) {
 		struct ceph_osd_client *osdc;

@@ -1482,8 +1485,6 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev, int start)
 						&rbd_dev->watch_event);
 		if (ret < 0)
 			return ret;
-	} else {
-		rbd_assert(rbd_dev->watch_request != NULL);
 	}

 	op = rbd_osd_req_op_create(CEPH_OSD_OP_WATCH,
@@ -3023,22 +3024,6 @@ static void rbd_bus_del_dev(struct rbd_device
*rbd_dev)
 	device_unregister(&rbd_dev->dev);
 }

-static int rbd_init_watch_dev(struct rbd_device *rbd_dev)
-{
-	int ret, rc;
-
-	do {
-		ret = rbd_req_sync_watch(rbd_dev, 1);
-		if (ret == -ERANGE) {
-			rc = rbd_dev_refresh(rbd_dev, NULL);
-			if (rc < 0)
-				return rc;
-		}
-	} while (ret == -ERANGE);
-
-	return ret;
-}
-
 static atomic64_t rbd_dev_id_max = ATOMIC64_INIT(0);

 /*
@@ -3584,7 +3569,7 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto err_out_bus;

-	ret = rbd_init_watch_dev(rbd_dev);
+	ret = rbd_req_sync_watch(rbd_dev, 1);
 	if (ret)
 		goto err_out_bus;

-- 
1.7.9.5

