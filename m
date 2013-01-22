From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/12] rbd: get rid of rbd_req_sync_read()
Date: Tue, 22 Jan 2013 16:29:34 -0600
Message-ID: <50FF12CE.9080300@inktank.com>
References: <50FF11EA.3000808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38169 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3AVW3h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 17:29:37 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so12610784iec.27
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 14:29:37 -0800 (PST)
In-Reply-To: <50FF11EA.3000808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Delete rbd_req_sync_read() is no longer used, so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5a8fef4..6193c69 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1294,29 +1294,6 @@ static int rbd_obj_request_wait(struct
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
@@ -2109,7 +2086,6 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
u64 *version)
 		if (!ondisk)
 			return ERR_PTR(-ENOMEM);

-		(void) rbd_req_sync_read;	/* avoid a warning */
 		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
 				       0, size,
 				       (char *) ondisk, version);
-- 
1.7.9.5

