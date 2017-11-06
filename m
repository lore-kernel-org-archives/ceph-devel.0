From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/2] rbd: fix and simplify rbd_ioctl_set_ro()
Date: Mon,  6 Nov 2017 16:49:29 +0100
Message-ID: <1509983370-1853-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53516 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdKFPty (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 10:49:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id r196so15203880wmf.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 07:49:53 -0800 (PST)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t66sm3349198wme.33.2017.11.06.07.49.52
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2017 07:49:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

->open_count/-EBUSY check is bogus and wrong: when an open device is
set read-only, blkdev_write_iter() refuses further writes with -EPERM.
This is standard behaviour and all other block devices allow this.

set_disk_ro() call is also problematic: we affect the entire device
when called on a single partition.

All rbd_ioctl_set_ro() needs to do is refuse ro -> rw transition for
mapped snapshots.  Everything else can be handled by generic code.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6347ac194e90..832b235b2dc3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -640,46 +640,24 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
 
 static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
 {
-	int ret = 0;
-	int val;
-	bool ro;
-	bool ro_changed = false;
+	int ro;
 
-	/* get_user() may sleep, so call it before taking rbd_dev->lock */
-	if (get_user(val, (int __user *)(arg)))
+	if (get_user(ro, (int __user *)arg))
 		return -EFAULT;
 
-	ro = val ? true : false;
-	/* Snapshot doesn't allow to write*/
+	/* Snapshots can't be marked read-write */
 	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !ro)
 		return -EROFS;
 
-	spin_lock_irq(&rbd_dev->lock);
-	/* prevent others open this device */
-	if (rbd_dev->open_count > 1) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	if (rbd_dev->mapping.read_only != ro) {
-		rbd_dev->mapping.read_only = ro;
-		ro_changed = true;
-	}
-
-out:
-	spin_unlock_irq(&rbd_dev->lock);
-	/* set_disk_ro() may sleep, so call it after releasing rbd_dev->lock */
-	if (ret == 0 && ro_changed)
-		set_disk_ro(rbd_dev->disk, ro ? 1 : 0);
-
-	return ret;
+	/* Let blkdev_roset() handle it */
+	return -ENOTTY;
 }
 
 static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
 			unsigned int cmd, unsigned long arg)
 {
 	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
-	int ret = 0;
+	int ret;
 
 	switch (cmd) {
 	case BLKROSET:
-- 
2.4.3

