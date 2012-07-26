From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/7] rbd: drop "object_name" from rbd_req_sync_notify_ack()
Date: Thu, 26 Jul 2012 13:57:49 -0500
Message-ID: <5011932D.1060005@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34518 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab2GZS5u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:57:50 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so2332418yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:57:50 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_req_sync_notify_ack() only ever uses rbd_dev->header_name as the
value of its "object_name" parameter, and that value is available
within the function already.  So get rid of the parameter.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b9aa377..48a7927 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1185,8 +1185,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
  */
 static int rbd_req_sync_notify_ack(struct rbd_device *rbd_dev,
 				   u64 ver,
-				   u64 notify_id,
-				   const char *object_name)
+				   u64 notify_id)
 {
 	struct ceph_osd_req_op *ops;
 	int ret;
@@ -1200,7 +1199,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 	ops[0].watch.flag = 0;

 	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
-			  object_name, 0, 0, NULL,
+			  rbd_dev->header_name, 0, 0, NULL,
 			  NULL, 0,
 			  CEPH_OSD_FLAG_READ,
 			  ops,
@@ -1230,7 +1229,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
 			   " update snaps: %d\n", rbd_dev->major, rc);

-	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id, rbd_dev->header_name);
+	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id);
 }

 /*
-- 
1.7.9.5

