From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/5] rbd: enable multiple blk-mq queues
Date: Thu, 13 Feb 2020 20:26:06 +0100
Message-ID: <20200213192606.31194-6-idryomov@gmail.com>
References: <20200213192606.31194-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41379 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgBMTZr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 14:25:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so8125509wrw.8
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 11:25:46 -0800 (PST)
In-Reply-To: <20200213192606.31194-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>

From: Hannes Reinecke <hare@suse.de>

Allocate one queue per CPU and get a performance boost from
higher parallelism.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9ff4355fe48a..a4e7b494344c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4970,7 +4970,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
 	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
 	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	rbd_dev->tag_set.nr_hw_queues = 1;
+	rbd_dev->tag_set.nr_hw_queues = num_present_cpus();
 	rbd_dev->tag_set.cmd_size = sizeof(struct rbd_img_request);
 
 	err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
-- 
2.19.2
