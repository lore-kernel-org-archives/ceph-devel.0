From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] rbd: use reference counting for the snap context
Date: Thu, 19 Jul 2012 07:35:00 -0500
Message-ID: <5007FEF4.5060401@inktank.com>
References: <5007FDEA.9010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39184 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2GSMfC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:35:02 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so2682359ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:35:01 -0700 (PDT)
In-Reply-To: <5007FDEA.9010605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This prevents a race between requests with a given snap context and
header updates that free it. The osd client was already expecting the
snap context to be reference counted, since it get()s it in
ceph_osdc_build_request and put()s it when the request completes.

Also remove the second down_read()/up_read() on header_rwsem in
rbd_do_request, which wasn't actually preventing this race or
protecting any other data.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a6bbda2..988f944 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -626,7 +626,7 @@ static void rbd_header_free(struct rbd_image_header
*header)
 	kfree(header->object_prefix);
 	kfree(header->snap_sizes);
 	kfree(header->snap_names);
-	kfree(header->snapc);
+	ceph_put_snap_context(header->snapc);
 }

 /*
@@ -902,13 +902,10 @@ static int rbd_do_request(struct request *rq,
 	dout("rbd_do_request object_name=%s ofs=%lld len=%lld\n",
 		object_name, len, ofs);

-	down_read(&rbd_dev->header_rwsem);
-
 	osdc = &rbd_dev->rbd_client->client->osdc;
 	req = ceph_osdc_alloc_request(osdc, flags, snapc, ops,
 					false, GFP_NOIO, pages, bio);
 	if (!req) {
-		up_read(&rbd_dev->header_rwsem);
 		ret = -ENOMEM;
 		goto done_pages;
 	}
@@ -942,7 +939,6 @@ static int rbd_do_request(struct request *rq,
 				snapc,
 				&mtime,
 				req->r_oid, req->r_oid_len);
-	up_read(&rbd_dev->header_rwsem);

 	if (linger_req) {
 		ceph_osdc_set_request_linger(osdc, req);
@@ -1448,6 +1444,7 @@ static void rbd_rq_fn(struct request_queue *q)
 		u64 ofs;
 		int num_segs, cur_seg = 0;
 		struct rbd_req_coll *coll;
+		struct ceph_snap_context *snapc;

 		/* peek at request from block layer */
 		if (!rq)
@@ -1474,21 +1471,20 @@ static void rbd_rq_fn(struct request_queue *q)

 		spin_unlock_irq(q->queue_lock);

-		if (rbd_dev->snap_id != CEPH_NOSNAP) {
-			bool snap_exists;
+		down_read(&rbd_dev->header_rwsem);

-			down_read(&rbd_dev->header_rwsem);
-			snap_exists = rbd_dev->snap_exists;
+		if (rbd_dev->snap_id != CEPH_NOSNAP && !rbd_dev->snap_exists) {
 			up_read(&rbd_dev->header_rwsem);
-
-			if (!snap_exists) {
-				dout("request for non-existent snapshot");
-				spin_lock_irq(q->queue_lock);
-				__blk_end_request_all(rq, -ENXIO);
-				continue;
-			}
+			dout("request for non-existent snapshot");
+			spin_lock_irq(q->queue_lock);
+			__blk_end_request_all(rq, -ENXIO);
+			continue;
 		}

+		snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+
+		up_read(&rbd_dev->header_rwsem);
+
 		dout("%s 0x%x bytes at 0x%llx\n",
 		     do_write ? "write" : "read",
 		     size, blk_rq_pos(rq) * SECTOR_SIZE);
@@ -1498,6 +1494,7 @@ static void rbd_rq_fn(struct request_queue *q)
 		if (!coll) {
 			spin_lock_irq(q->queue_lock);
 			__blk_end_request_all(rq, -ENOMEM);
+			ceph_put_snap_context(snapc);
 			continue;
 		}

@@ -1521,7 +1518,7 @@ static void rbd_rq_fn(struct request_queue *q)
 			/* init OSD command: write or read */
 			if (do_write)
 				rbd_req_write(rq, rbd_dev,
-					      rbd_dev->header.snapc,
+					      snapc,
 					      ofs,
 					      op_size, bio,
 					      coll, cur_seg);
@@ -1544,6 +1541,8 @@ next_seg:
 		if (bp)
 			bio_pair_release(bp);
 		spin_lock_irq(q->queue_lock);
+
+		ceph_put_snap_context(snapc);
 	}
 }

@@ -1744,7 +1743,8 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 	/* rbd_dev->header.object_prefix shouldn't change */
 	kfree(rbd_dev->header.snap_sizes);
 	kfree(rbd_dev->header.snap_names);
-	kfree(rbd_dev->header.snapc);
+	/* osd requests may still refer to snapc */
+	ceph_put_snap_context(rbd_dev->header.snapc);

 	rbd_dev->header.image_size = h.image_size;
 	rbd_dev->header.total_snaps = h.total_snaps;
-- 
1.7.5.4

