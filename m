From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] rbd: set discard alignment to zero
Date: Thu,  2 Nov 2017 01:05:11 +0100
Message-ID: <20171102000511.29106-1-ddiss@suse.de>
References: <20171102004338.39d87dea@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42171 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752258AbdKBAF2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Nov 2017 20:05:28 -0400
In-Reply-To: <20171102004338.39d87dea@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mike Christie <mchristi@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, David Disseldorp <ddiss@suse.de>

RBD devices are currently incorrectly initialised with the block queue
discard_alignment set to the underlying RADOS object size.

As per Documentation/ABI/testing/sysfs-block:
  The discard_alignment parameter indicates how many bytes the beginning
  of the device is offset from the internal allocation unit's natural
  alignment.

Correcting the discard_alignment parameter from the RADOS object size to
zero (the blk_set_default_limits() default) has no effect on how discard
requests are propagated through the block layer - @alignment in
__blkdev_issue_discard() remains zero. However, it does fix the UNMAP
granularity alignment value advertised to SCSI initiators via the Block
Limits VPD.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/rbd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b640ad8a6d20..016542c75e1f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4423,7 +4423,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	/* enable the discard support */
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 	q->limits.discard_granularity = segment_size;
-	q->limits.discard_alignment = segment_size;
 	blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
 	blk_queue_max_write_zeroes_sectors(q, segment_size / SECTOR_SIZE);
 
-- 
2.13.6

