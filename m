From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/12, v2] rbd: get rid of rbd_req_sync_read()
Date: Thu, 24 Jan 2013 10:33:37 -0600
Message-ID: <51016261.8010609@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:60985 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3AXQdj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 11:33:39 -0500
Received: by mail-ia0-f173.google.com with SMTP id l29so5080645iag.32
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 08:33:39 -0800 (PST)
In-Reply-To: <5101406E.4060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Delete rbd_req_sync_read() is no longer used, so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 742236b..750fc73 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1315,29 +1315,6 @@ static void rbd_obj_request_complete(struct
rbd_obj_request *obj_request)
 }

 /*
- * Synchronously read a range from an object into a provided buffer
- */
-static int rbd_req_sync_read(struct rbd_device *rbd_dev,
-			  const char *object_name,
-			  u64 ofs, u64 len,
-			  char *buf,
-			  u64 *ver)
-{
-	struct ceph_osd_req_op *op;
-	int ret;
-
-	op = rbd_osd_req_op_create(CEPH_OSD_OP_READ, ofs, len);
-	if (!op)
-		return -ENOMEM;
-
-	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
-			       op, object_name, ofs, len, buf, ver);
-	rbd_osd_req_op_destroy(op);
-
-	return ret;
-}
-
-/*
  * Request sync osd watch
  */
 static int rbd_req_sync_notify_ack(struct rbd_device *rbd_dev,
@@ -2113,7 +2090,6 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
u64 *version)
 		if (!ondisk)
 			return ERR_PTR(-ENOMEM);

-		(void) rbd_req_sync_read;	/* avoid a warning */
 		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
 				       0, size,
 				       (char *) ondisk, version);
-- 
1.7.9.5

