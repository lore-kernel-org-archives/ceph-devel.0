From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 41/47] block-rbd: Rename jump labels in rbd_dev_device_setup()
Date: Mon, 12 Sep 2016 21:30:02 +0200
Message-ID: <1b51a821-c06c-4ee5-aff3-d1ed23abdebb@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:55449 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932764AbcILTaS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 15:30:18 -0400
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 20:01:03 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a037a5d..80983f6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6002,7 +6002,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	if (!single_major) {
 		ret = register_blkdev(0, rbd_dev->name);
 		if (ret < 0)
-			goto err_out_unlock;
+			goto unlock;
 
 		rbd_dev->major = ret;
 		rbd_dev->minor = 0;
@@ -6015,11 +6015,11 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 
 	ret = rbd_init_disk(rbd_dev);
 	if (ret)
-		goto err_out_blkdev;
+		goto check_single;
 
 	ret = rbd_dev_mapping_set(rbd_dev);
 	if (ret)
-		goto err_out_disk;
+		goto free_disk;
 
 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
@@ -6027,7 +6027,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	dev_set_name(&rbd_dev->dev, "%d", rbd_dev->dev_id);
 	ret = device_add(&rbd_dev->dev);
 	if (ret)
-		goto err_out_mapping;
+		goto clear_mapping;
 
 	/* Everything's ready.  Announce the disk to the world. */
 
@@ -6044,15 +6044,14 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 		rbd_dev->header.features);
 
 	return ret;
-
-err_out_mapping:
+ clear_mapping:
 	rbd_dev_mapping_clear(rbd_dev);
-err_out_disk:
+ free_disk:
 	rbd_free_disk(rbd_dev);
-err_out_blkdev:
+ check_single:
 	if (!single_major)
 		unregister_blkdev(rbd_dev->major, rbd_dev->name);
-err_out_unlock:
+ unlock:
 	up_write(&rbd_dev->header_rwsem);
 	return ret;
 }
-- 
2.10.0

