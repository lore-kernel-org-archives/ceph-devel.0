From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 17/47] block-rbd: Rename jump labels in rbd_init_disk()
Date: Mon, 12 Sep 2016 21:03:03 +0200
Message-ID: <fbc4c5ad-5337-fa8d-e31d-0424e71ebcb8@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 18:26:28 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0b6f0f9..97d4d63 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4500,12 +4500,12 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 
 	err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
 	if (err)
-		goto out_disk;
+		goto put_disk;
 
 	q = blk_mq_init_queue(&rbd_dev->tag_set);
 	if (IS_ERR(q)) {
 		err = PTR_ERR(q);
-		goto out_tag_set;
+		goto free_tag_set;
 	}
 
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
@@ -4537,9 +4537,9 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	rbd_dev->disk = disk;
 
 	return 0;
-out_tag_set:
+ free_tag_set:
 	blk_mq_free_tag_set(&rbd_dev->tag_set);
-out_disk:
+ put_disk:
 	put_disk(disk);
 	return err;
 }
-- 
2.10.0
