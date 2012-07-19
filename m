From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] rbd: return errors for mapped but deleted snapshot
Date: Thu, 19 Jul 2012 07:34:36 -0500
Message-ID: <5007FEDC.8070602@inktank.com>
References: <5007FDEA.9010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39184 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GSMei (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:34:38 -0400
Received: by ghrr11 with SMTP id r11so2682359ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:34:38 -0700 (PDT)
In-Reply-To: <5007FDEA.9010605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When a snapshot is deleted, the OSD will return ENOENT when reading
from it. This is normally interpreted as a hole by rbd, which will
return zeroes. To minimize the time in which this can happen, stop
requests early when we are notified that our snapshot no longer
exists.

[elder@inktank.com: updated __rbd_init_snaps_header() logic]

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b124442..730d0ce 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -172,9 +172,13 @@ struct rbd_device {

 	/* protects updating the header */
 	struct rw_semaphore     header_rwsem;
+	/* name of the snapshot this device reads from */
 	char                    *snap_name;
+	/* id of the snapshot this device reads from */
 	u64                     snap_id;	/* current snapshot id */
-	int read_only;
+	/* whether the snap_id this device reads from still exists */
+	bool                    snap_exists;
+	int                     read_only;

 	struct list_head	node;

@@ -597,6 +601,7 @@ static int rbd_header_set_snap(struct rbd_device
*rbd_dev, u64 *size)
 		else
 			snapc->seq = 0;
 		rbd_dev->snap_id = CEPH_NOSNAP;
+		rbd_dev->snap_exists = false;
 		rbd_dev->read_only = 0;
 		if (size)
 			*size = header->image_size;
@@ -606,6 +611,7 @@ static int rbd_header_set_snap(struct rbd_device
*rbd_dev, u64 *size)
 		if (ret < 0)
 			goto done;
 		rbd_dev->snap_id = snapc->seq;
+		rbd_dev->snap_exists = true;
 		rbd_dev->read_only = 1;
 	}

@@ -1468,6 +1474,21 @@ static void rbd_rq_fn(struct request_queue *q)

 		spin_unlock_irq(q->queue_lock);

+		if (rbd_dev->snap_id != CEPH_NOSNAP) {
+			bool snap_exists;
+
+			down_read(&rbd_dev->header_rwsem);
+			snap_exists = rbd_dev->snap_exists;
+			up_read(&rbd_dev->header_rwsem);
+
+			if (!snap_exists) {
+				dout("request for non-existent snapshot");
+				spin_lock_irq(q->queue_lock);
+				__blk_end_request_all(rq, -ENXIO);
+				continue;
+			}
+		}
+
 		dout("%s 0x%x bytes at 0x%llx\n",
 		     do_write ? "write" : "read",
 		     size, blk_rq_pos(rq) * SECTOR_SIZE);
@@ -2088,7 +2109,14 @@ static int __rbd_init_snaps_header(struct
rbd_device *rbd_dev)
 			cur_id = rbd_dev->header.snapc->snaps[i - 1];

 		if (!i || old_snap->id < cur_id) {
-			/* old_snap->id was skipped, thus was removed */
+			/*
+			 * old_snap->id was skipped, thus was
+			 * removed.  If this rbd_dev is mapped to
+			 * the removed snapshot, record that it no
+			 * longer exists, to prevent further I/O.
+			 */
+			if (rbd_dev->snap_id == old_snap->id)
+				rbd_dev->snap_exists = false;
 			__rbd_remove_snap_dev(rbd_dev, old_snap);
 			continue;
 		}
-- 
1.7.5.4

