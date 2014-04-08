From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 11/11] rbd: set the remaining discard properties to enable support
Date: Tue,  8 Apr 2014 13:42:55 -0700
Message-ID: <bb124876ef478f371f1b972ffdc7e22f83c9d2b4.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56382 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349AbaDHWC0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:26 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 13351267D8
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:32 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id F0F17267E2
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

max_discard_sectors must be set for the queue to support discard.
Operations implementing discard for rbd zero data, so report that.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c8fc8fc..8f908c4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3595,6 +3595,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 	q->limits.discard_granularity = segment_size;
 	q->limits.discard_alignment = segment_size;
+	q->limits.max_discard_sectors = segment_size / SECTOR_SIZE;
+	q->limits.discard_zeroes_data = 1;
 
 	blk_queue_merge_bvec(q, rbd_merge_bvec);
 	disk->queue = q;
-- 
1.7.10.4

