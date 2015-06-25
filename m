From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: bump queue_max_segments
Date: Thu, 25 Jun 2015 12:01:08 +0300
Message-ID: <1435222868-34966-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34226 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbFYJBT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 05:01:19 -0400
Received: by lagx9 with SMTP id x9so40864636lag.1
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 02:01:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

The default queue_limits::max_segments value (BLK_MAX_SEGMENTS = 128)
unnecessarily limits bio sizes to 512k (assuming 4k pages).  rbd, being
a virtual block device, doesn't have any restrictions on the number of
physical segments, so bump max_segments to max_hw_sectors, in theory
allowing a sector per segment (although the only case this matters that
I can think of is some readv/writev style thing).  In practice this is
going to give us 1M bios - the number of segments in a bio is limited
in bio_get_nr_vecs() by BIO_MAX_PAGES = 256.

Note that this doesn't result in any improvement on a typical direct
sequential test.  This is because on a box with a not too badly
fragmented memory the default BLK_MAX_SEGMENTS is enough to see nice
rbd object size sized requests.  The only difference is the size of
bios being merged - 512k vs 1M for something like

    $ dd if=/dev/zero of=/dev/rbd0 oflag=direct bs=$RBD_OBJ_SIZE
    $ dd if=/dev/rbd0 iflag=direct of=/dev/null bs=$RBD_OBJ_SIZE

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 89fe8a4bc02e..bc88fbcb9715 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3791,6 +3791,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	/* set io sizes to object size */
 	segment_size = rbd_obj_bytes(&rbd_dev->header);
 	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
+	blk_queue_max_segments(q, segment_size / SECTOR_SIZE);
 	blk_queue_max_segment_size(q, segment_size);
 	blk_queue_io_min(q, segment_size);
 	blk_queue_io_opt(q, segment_size);
-- 
1.9.3

