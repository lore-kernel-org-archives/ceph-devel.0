From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/15] rbd: switch to blk-mq
Date: Fri, 31 Jan 2020 11:37:39 +0100
Message-ID: <20200131103739.136098-16-hare@suse.de>
References: <20200131103739.136098-1-hare@suse.de>
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200131103739.136098-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: ceph-devel.vger.kernel.org

Allocate one queue per CPU and get a performance boost from
higher parallelism.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cc3e5116fe58..dc3b44177fea 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5094,7 +5094,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
 	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
 	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	rbd_dev->tag_set.nr_hw_queues = 1;
+	rbd_dev->tag_set.nr_hw_queues = num_present_cpus();
 	rbd_dev->tag_set.cmd_size = sizeof(struct rbd_img_request);
 
 	err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
-- 
2.16.4
