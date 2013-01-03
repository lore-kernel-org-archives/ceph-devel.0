From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/2] rbd: a little more cleanup of rbd_rq_fn()
Date: Thu, 03 Jan 2013 16:43:28 -0600
Message-ID: <50E60990.90109@inktank.com>
References: <50E6094F.9080101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56158 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab3ACWnc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 17:43:32 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so19063697iea.12
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 14:43:30 -0800 (PST)
In-Reply-To: <50E6094F.9080101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Now that a big hunk in the middle of rbd_rq_fn() has been moved
into its own routine we can simplify it a little more.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   50
+++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 88b9b2e..0a35c34 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1647,53 +1647,49 @@ static int rbd_dev_do_request(struct request *rq,
 static void rbd_rq_fn(struct request_queue *q)
 {
 	struct rbd_device *rbd_dev = q->queuedata;
+	bool read_only = rbd_dev->mapping.read_only;
 	struct request *rq;

 	while ((rq = blk_fetch_request(q))) {
-		struct bio *bio;
-		bool do_write;
-		unsigned int size;
-		u64 ofs;
-		struct ceph_snap_context *snapc;
+		struct ceph_snap_context *snapc = NULL;
 		int result;

 		dout("fetched request\n");

-		/* filter out block requests we don't understand */
+		/* Filter out block requests we don't understand */
+
 		if ((rq->cmd_type != REQ_TYPE_FS)) {
 			__blk_end_request_all(rq, 0);
 			continue;
 		}
+		spin_unlock_irq(q->queue_lock);

-		/* deduce our operation (read, write) */
-		do_write = (rq_data_dir(rq) == WRITE);
-		if (do_write && rbd_dev->mapping.read_only) {
-			__blk_end_request_all(rq, -EROFS);
-			continue;
-		}
+		/* Stop writes to a read-only device */

-		spin_unlock_irq(q->queue_lock);
+		result = -EROFS;
+		if (read_only && rq_data_dir(rq) == WRITE)
+			goto out_end_request;
+
+		/* Grab a reference to the snapshot context */

 		down_read(&rbd_dev->header_rwsem);
+		if (rbd_dev->exists) {
+			snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+			rbd_assert(snapc != NULL);
+		}
+		up_read(&rbd_dev->header_rwsem);

-		if (!rbd_dev->exists) {
+		if (!snapc) {
 			rbd_assert(rbd_dev->spec->snap_id != CEPH_NOSNAP);
-			up_read(&rbd_dev->header_rwsem);
 			dout("request for non-existent snapshot");
-			spin_lock_irq(q->queue_lock);
-			__blk_end_request_all(rq, -ENXIO);
-			continue;
+			result = -ENXIO;
+			goto out_end_request;
 		}

-		snapc = ceph_get_snap_context(rbd_dev->header.snapc);
-
-		up_read(&rbd_dev->header_rwsem);
-
-		size = blk_rq_bytes(rq);
-		ofs = blk_rq_pos(rq) * SECTOR_SIZE;
-		bio = rq->bio;
-
-		result = rbd_dev_do_request(rq, rbd_dev, snapc, ofs, size, bio);
+		result = rbd_dev_do_request(rq, rbd_dev, snapc,
+				blk_rq_pos(rq) * SECTOR_SIZE,
+				blk_rq_bytes(rq), rq->bio);
+out_end_request:
 		ceph_put_snap_context(snapc);
 		spin_lock_irq(q->queue_lock);
 		if (result < 0)
-- 
1.7.9.5

