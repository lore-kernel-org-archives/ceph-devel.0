From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] rbd: Avoid calling BUG() when object_map is not empty
Date: Sun, 15 Dec 2019 10:35:27 -0600
Message-ID: <20191215163527.25203-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

In __rbd_object_map_load, if object_map contains data, return
error -EINVAL upstream, instead of crashing, via BUG. The patch
fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/block/rbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b184563cd32..6e9a11f32a94 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1892,7 +1892,8 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 	int num_pages;
 	int ret;
 
-	rbd_assert(!rbd_dev->object_map && !rbd_dev->object_map_size);
+	if (rbd_dev->object_map || rbd_dev->object_map_size)
+		return -EINVAL;
 
 	num_objects = ceph_get_num_objects(&rbd_dev->layout,
 					   rbd_dev->mapping.size);
-- 
2.20.1
