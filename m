From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: set max_sectors explicitly
Date: Wed,  7 Oct 2015 19:00:32 +0200
Message-ID: <1444237232-9574-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36075 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbJGPUl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Oct 2015 11:20:41 -0400
Received: by wicgb1 with SMTP id gb1so216394375wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 07 Oct 2015 08:20:40 -0700 (PDT)
Received: from orange.localdomain (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hx4sm39884510wjb.31.2015.10.07.08.20.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2015 08:20:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Commit 30e2bc08b2bb ("Revert "block: remove artifical max_hw_sectors
cap"") restored a clamp on max_sectors.  It's now 2560 sectors instead
of 1024, but it's not good enough: we set max_hw_sectors to rbd object
size because we don't want object sized I/Os to be split, and the
default object size is 4M.

So, set max_sectors to max_hw_sectors in rbd at queue init time.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 05072464d25e..04e69b4df664 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3760,6 +3760,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	/* set io sizes to object size */
 	segment_size = rbd_obj_bytes(&rbd_dev->header);
 	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
+	q->limits.max_sectors = queue_max_hw_sectors(q);
 	blk_queue_max_segments(q, segment_size / SECTOR_SIZE);
 	blk_queue_max_segment_size(q, segment_size);
 	blk_queue_io_min(q, segment_size);
-- 
2.4.3

