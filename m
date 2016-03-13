From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 1/3] rbd: use KMEM_CACHE macro
Date: Sun, 13 Mar 2016 15:18:37 +0800
Message-ID: <9242267d62daeec8a0de5a1230f750ca486d62cd.1457853190.git.geliangtang@163.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:44061 "EHLO m12-14.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbcCMHSu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 13 Mar 2016 03:18:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>
Cc: Geliang Tang <geliangtang@163.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Use KMEM_CACHE() instead of kmem_cache_create() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/block/rbd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4a87678..70eba86 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5643,18 +5643,12 @@ static void rbd_sysfs_cleanup(void)
 static int rbd_slab_init(void)
 {
 	rbd_assert(!rbd_img_request_cache);
-	rbd_img_request_cache = kmem_cache_create("rbd_img_request",
-					sizeof (struct rbd_img_request),
-					__alignof__(struct rbd_img_request),
-					0, NULL);
+	rbd_img_request_cache = KMEM_CACHE(rbd_img_request, 0);
 	if (!rbd_img_request_cache)
 		return -ENOMEM;
 
 	rbd_assert(!rbd_obj_request_cache);
-	rbd_obj_request_cache = kmem_cache_create("rbd_obj_request",
-					sizeof (struct rbd_obj_request),
-					__alignof__(struct rbd_obj_request),
-					0, NULL);
+	rbd_obj_request_cache = KMEM_CACHE(rbd_obj_request, 0);
 	if (!rbd_obj_request_cache)
 		goto out_err;
 
-- 
2.5.0


