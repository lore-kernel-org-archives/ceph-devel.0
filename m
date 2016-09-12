From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 46/47] block-rbd: Rename jump labels in rbd_init()
Date: Mon, 12 Sep 2016 21:35:12 +0200
Message-ID: <5183e609-e94b-8041-e69e-4424e30ae45d@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 20:06:54 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8802a06..8897815 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6506,20 +6506,20 @@ static int __init rbd_init(void)
 	rbd_wq = alloc_workqueue(RBD_DRV_NAME, WQ_MEM_RECLAIM, 0);
 	if (!rbd_wq) {
 		rc = -ENOMEM;
-		goto err_out_slab;
+		goto exit_slab;
 	}
 
 	if (single_major) {
 		rbd_major = register_blkdev(0, RBD_DRV_NAME);
 		if (rbd_major < 0) {
 			rc = rbd_major;
-			goto err_out_wq;
+			goto destroy_workqueue;
 		}
 	}
 
 	rc = rbd_sysfs_init();
 	if (rc)
-		goto err_out_blkdev;
+		goto check_single;
 
 	if (single_major)
 		pr_info("loaded (major %d)\n", rbd_major);
@@ -6527,13 +6527,12 @@ static int __init rbd_init(void)
 		pr_info("loaded\n");
 
 	return 0;
-
-err_out_blkdev:
+ check_single:
 	if (single_major)
 		unregister_blkdev(rbd_major, RBD_DRV_NAME);
-err_out_wq:
+ destroy_workqueue:
 	destroy_workqueue(rbd_wq);
-err_out_slab:
+ exit_slab:
 	rbd_slab_exit();
 	return rc;
 }
-- 
2.10.0
