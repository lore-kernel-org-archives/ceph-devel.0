From: Sage Weil <sage@newdream.net>
Subject: [PATCH 15/23] rbd: set blk_queue request sizes to object size
Date: Fri, 22 Jul 2011 17:02:54 -0700
Message-ID: <1311379382-9218-16-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44319 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab1GWAFz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:55 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@dreamhost.com>

From: Josh Durgin <josh.durgin@dreamhost.com>

This improves performance since more requests can be merged.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 drivers/block/rbd.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7392d7a..15f65b5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -630,6 +630,14 @@ static int rbd_get_num_segments(struct rbd_image_header *header,
 }
 
 /*
+ * returns the size of an object in the image
+ */
+static u64 rbd_obj_bytes(struct rbd_image_header *header)
+{
+	return 1 << header->obj_order;
+}
+
+/*
  * bio helpers
  */
 
@@ -1765,6 +1773,13 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	q = blk_init_queue(rbd_rq_fn, &rbd_dev->lock);
 	if (!q)
 		goto out_disk;
+
+	/* set io sizes to object size */
+	blk_queue_max_hw_sectors(q, rbd_obj_bytes(&rbd_dev->header) / 512ULL);
+	blk_queue_max_segment_size(q, rbd_obj_bytes(&rbd_dev->header));
+	blk_queue_io_min(q, rbd_obj_bytes(&rbd_dev->header));
+	blk_queue_io_opt(q, rbd_obj_bytes(&rbd_dev->header));
+
 	blk_queue_merge_bvec(q, rbd_merge_bvec);
 	disk->queue = q;
 
-- 
1.7.0

