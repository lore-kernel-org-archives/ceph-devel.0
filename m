From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] rbd: set the 'device' link in sysfs
Date: Thu, 23 Jan 2020 13:44:33 +0100
Message-ID: <20200123124433.121939-1-hare@suse.de>
Return-path: <linux-block-owner@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dromov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>, David Disseldorp <ddiss@suse.com>, Hannes Reinecke <hare@suse.com>
List-Id: ceph-devel.vger.kernel.org

The rbd driver already provides additional information in sysfs
under /sys/bus/rbd, so we should set the 'device' link in the block
device to reference this information.

Cc: David Disseldorp <ddiss@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9f1f8689e316..3240b7744aeb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6938,7 +6938,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	if (rc)
 		goto err_out_image_lock;
 
-	add_disk(rbd_dev->disk);
+	device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
 	/* see rbd_init_disk() */
 	blk_put_queue(rbd_dev->disk->queue);
 
-- 
2.16.4
