From: juncheng bai <baijuncheng@unitedstack.com>
Subject: [PATCH RFC]  storage:rbd: make the size of request is equal to the,
 size of the object
Date: Mon, 15 Jun 2015 19:18:23 +0800
Message-ID: <557EB47F.6090708@unitedstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@redhat.com, elder@linaro.org, josh.durgin@inktank.com, lucienchao@gmail.com
Cc: jeff@garzik.org, yehuda@hq.newdream.net, sage@newdream.net, elder@inktank.com, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

 From 6213215bd19926d1063d4e01a248107dab8a899b Mon Sep 17 00:00:00 2001
From: juncheng bai <baijuncheng@unitedstack.com>
Date: Mon, 15 Jun 2015 18:34:00 +0800
Subject: [PATCH] storage:rbd: make the size of request is equal to the
  size of the object

ensures that the merged size of request can achieve the size of
the object.
when merge a bio to request or merge a request to request, the
sum of the segment number of the current request and the segment
number of the bio is not greater than the max segments of the request,
so the max size of request is 512k if the max segments of request is
BLK_MAX_SEGMENTS.

Signed-off-by: juncheng bai <baijuncheng@unitedstack.com>
---
  drivers/block/rbd.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0a54c58..dec6045 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3757,6 +3757,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
  	segment_size = rbd_obj_bytes(&rbd_dev->header);
  	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
  	blk_queue_max_segment_size(q, segment_size);
+	if (segment_size > BLK_MAX_SEGMENTS * PAGE_SIZE)
+		blk_queue_max_segments(q, segment_size / PAGE_SIZE);
  	blk_queue_io_min(q, segment_size);
  	blk_queue_io_opt(q, segment_size);

-- 
