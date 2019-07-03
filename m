From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 04/35] block: Use kmemdup rather than duplicating its implementation
Date: Thu,  4 Jul 2019 00:26:50 +0800
Message-ID: <20190703162650.32045-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: ceph-devel.vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/block/rbd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e5009a34f9c2..47ad3772dc58 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1068,7 +1068,7 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 
 		if (snap_names_len > (u64)SIZE_MAX)
 			goto out_2big;
-		snap_names = kmalloc(snap_names_len, GFP_KERNEL);
+		snap_names = kmemdup(&ondisk->snaps[snap_count], snap_names_len, GFP_KERNEL);
 		if (!snap_names)
 			goto out_err;
 
@@ -1088,7 +1088,6 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 		 * snap_names_len bytes beyond the end of the
 		 * snapshot id array, this memcpy() is safe.
 		 */
-		memcpy(snap_names, &ondisk->snaps[snap_count], snap_names_len);
 		snaps = ondisk->snaps;
 		for (i = 0; i < snap_count; i++) {
 			snapc->snaps[i] = le64_to_cpu(snaps[i].id);
-- 
2.11.0
