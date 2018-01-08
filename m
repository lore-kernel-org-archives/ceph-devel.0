From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: set max_segments to USHRT_MAX
Date: Mon,  8 Jan 2018 19:51:15 +0100
Message-ID: <1515437475-25789-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33284 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755969AbeAHSvj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 13:51:39 -0500
Received: by mail-wr0-f194.google.com with SMTP id p6so11797334wrd.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jan 2018 10:51:39 -0800 (PST)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 90sm12588605wrp.39.2018.01.08.10.51.37
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 10:51:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Commit d3834fefcfe5 ("rbd: bump queue_max_segments") bumped
max_segments (unsigned short) to max_hw_sectors (unsigned int).
max_hw_sectors is set to the number of 512-byte sectors in an object
and overflows unsigned short for 32M (largest possible) objects, making
the block layer resort to handing us single segment (i.e. single page
or even smaller) bios in that case.

Cc: stable@vger.kernel.org
Fixes: d3834fefcfe5 ("rbd: bump queue_max_segments")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f40050c97bb3..0bda823a90ca 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4381,7 +4381,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	segment_size = rbd_obj_bytes(&rbd_dev->header);
 	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
 	q->limits.max_sectors = queue_max_hw_sectors(q);
-	blk_queue_max_segments(q, segment_size / SECTOR_SIZE);
+	blk_queue_max_segments(q, USHRT_MAX);
 	blk_queue_max_segment_size(q, segment_size);
 	blk_queue_io_min(q, segment_size);
 	blk_queue_io_opt(q, segment_size);
-- 
2.4.3

