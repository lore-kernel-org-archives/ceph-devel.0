From: Alex Elder <elder@inktank.com>
Subject: [PATCH 09/12] rbd: get rid of rbd_req_sync_notify_ack()
Date: Tue, 22 Jan 2013 16:30:33 -0600
Message-ID: <50FF1309.7050006@inktank.com>
References: <50FF11EA.3000808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:55587 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab3AVWay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 17:30:54 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so3622158iag.27
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 14:30:53 -0800 (PST)
In-Reply-To: <50FF11EA.3000808@inktank.com>
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
index 08465ae..a6ca5db 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1228,12 +1228,6 @@ done_err:
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
@@ -1295,32 +1289,6 @@ static int rbd_obj_request_wait(struct
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
@@ -1857,7 +1825,6 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		rbd_warn(rbd_dev, "got notification but failed to "
 			   " update snaps: %d\n", rc);

-	(void) rbd_req_sync_notify_ack;	/* avoid a warning */
 	rbd_obj_notify_ack_sync(rbd_dev, hver, notify_id);
 }

-- 
1.7.9.5

