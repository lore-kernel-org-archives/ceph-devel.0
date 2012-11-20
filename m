From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] rbd: don't assign extent info in rbd_do_request()
Date: Tue, 20 Nov 2012 13:54:57 -0600
Message-ID: <50ABE011.2090604@inktank.com>
References: <50ABDF8A.4080206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47014 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2KTTza (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 14:55:30 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so9199379iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 11:55:30 -0800 (PST)
In-Reply-To: <50ABDF8A.4080206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In rbd_do_request() there's a sort of last-minute assignment of the
extent offset and length and payload length for read and write
operations.  Move those assignments into the caller (in those spots
that might initiate read or write operations)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 223a401..37b39c1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1158,13 +1158,6 @@ static int rbd_do_request(struct request *rq,
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

 	osd_req->r_file_layout = rbd_dev->layout;	/* struct */
-
-	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
-		op->extent.offset = ofs;
-		op->extent.length = len;
-		if (op->op == CEPH_OSD_OP_WRITE)
-			op->payload_len = len;
-	}
 	osd_req->r_num_pages = calc_pages_for(ofs, len);
 	osd_req->r_page_alignment = ofs & ~PAGE_MASK;

@@ -1269,6 +1262,13 @@ static int rbd_req_sync_op(struct rbd_device
*rbd_dev,
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);

+	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
+		op->extent.offset = ofs;
+		op->extent.length = inbound_size;
+		if (op->op == CEPH_OSD_OP_WRITE)
+			op->payload_len = inbound_size;
+	}
+
 	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
 			  object_name, ofs, inbound_size, NULL,
 			  pages, num_pages,
@@ -1332,6 +1332,9 @@ static int rbd_do_op(struct request *rq,
 	op = rbd_create_rw_op(opcode, payload_len);
 	if (!op)
 		goto done;
+	op->extent.offset = seg_ofs;
+	op->extent.length = seg_len;
+	op->payload_len = payload_len;

 	/* we've taken care of segment sizes earlier when we
 	   cloned the bios. We should never have a segment
-- 
1.7.9.5

