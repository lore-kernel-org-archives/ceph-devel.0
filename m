From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/6] rbd: don't assign extent info in rbd_req_sync_op()
Date: Fri, 04 Jan 2013 09:06:11 -0600
Message-ID: <50E6EFE3.1040103@inktank.com>
References: <50E6EF5F.9080200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34089 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab3ADPGO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 10:06:14 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so19717643iej.4
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 07:06:14 -0800 (PST)
In-Reply-To: <50E6EF5F.9080200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Move the assignment of the extent offset and length and payload
length out of rbd_req_sync_op() and into its caller in the one spot
where a read (and note--no write) operation might be initiated.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4ce9981..49e500f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1262,13 +1262,6 @@ static int rbd_req_sync_op(struct rbd_device
*rbd_dev,
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);

-	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
-		op->extent.offset = ofs;
-		op->extent.length = inbound_size;
-		if (op->op == CEPH_OSD_OP_WRITE)
-			op->payload_len = inbound_size;
-	}
-
 	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
 			  object_name, ofs, inbound_size, NULL,
 			  pages, num_pages,
@@ -1373,6 +1366,9 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 	op = rbd_create_rw_op(CEPH_OSD_OP_READ, 0);
 	if (!op)
 		return -ENOMEM;
+	op->extent.offset = ofs;
+	op->extent.length = len;
+	op->payload_len = 0;

 	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
 			       op, object_name, ofs, len, buf, NULL, ver);
-- 
1.7.9.5

