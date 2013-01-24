From: Alex Elder <elder@inktank.com>
Subject: [PATCH 09/12, v2] rbd: get rid of rbd_req_sync_notify_ack()
Date: Thu, 24 Jan 2013 10:35:09 -0600
Message-ID: <510162BD.20800@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38736 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab3AXQfM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 11:35:12 -0500
Received: by mail-ob0-f171.google.com with SMTP id lz20so4336722obb.30
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 08:35:12 -0800 (PST)
In-Reply-To: <5101406E.4060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Get rid rbd_req_sync_notify_ack() because it is no longer used.
As a result rbd_simple_req_cb() becomes unreferenced, so get rid
of that too.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e2b6230..b952b2f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1240,12 +1240,6 @@ done_err:
 	return ret;
 }

-static void rbd_simple_req_cb(struct ceph_osd_request *osd_req,
-				struct ceph_msg *msg)
-{
-	ceph_osdc_put_request(osd_req);
-}
-
 /*
  * Do a synchronous ceph osd operation
  */
@@ -1322,32 +1316,6 @@ static void rbd_obj_request_complete(struct
rbd_obj_request *obj_request)
 }

 /*
- * Request sync osd watch
- */
-static int rbd_req_sync_notify_ack(struct rbd_device *rbd_dev,
-				   u64 ver,
-				   u64 notify_id)
-{
-	struct ceph_osd_req_op *op;
-	int ret;
-
-	op = rbd_osd_req_op_create(CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver);
-	if (!op)
-		return -ENOMEM;
-
-	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
-			  rbd_dev->header_name, 0, 0, NULL,
-			  NULL, 0,
-			  CEPH_OSD_FLAG_READ,
-			  op,
-			  rbd_simple_req_cb, NULL);
-
-	rbd_osd_req_op_destroy(op);
-
-	return ret;
-}
-
-/*
  * Synchronous osd object method call
  */
 static int rbd_req_sync_exec(struct rbd_device *rbd_dev,
@@ -1866,7 +1834,6 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		rbd_warn(rbd_dev, "got notification but failed to "
 			   " update snaps: %d\n", rc);

-	(void) rbd_req_sync_notify_ack;	/* avoid a warning */
 	rbd_obj_notify_ack_sync(rbd_dev, hver, notify_id);
 }

-- 
1.7.9.5

