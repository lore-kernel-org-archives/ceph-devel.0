From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] rbd: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Fri, 11 Apr 2014 16:38:12 +0800
Message-ID: <1397205492-24447-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yehuda@inktank.com, sage@inktank.com, elder@kernel.org, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>
List-Id: ceph-devel.vger.kernel.org

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4c95b50..552a2ed 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4752,7 +4752,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
 
 		image_id = ceph_extract_encoded_string(&p, p + ret,
 						NULL, GFP_NOIO);
-		ret = IS_ERR(image_id) ? PTR_ERR(image_id) : 0;
+		ret = PTR_ERR_OR_ZERO(image_id);
 		if (!ret)
 			rbd_dev->image_format = 2;
 	} else {
-- 
1.8.3.1
