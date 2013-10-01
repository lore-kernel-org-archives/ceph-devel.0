From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 1/2] rbd: move calls that may sleep out of spin lock range
Date: Mon, 30 Sep 2013 22:15:58 -0700
Message-ID: <1380604559-5331-2-git-send-email-josh.durgin@inktank.com>
References: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55871 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab3JAF7p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Oct 2013 01:59:45 -0400
In-Reply-To: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>

get_user() and set_disk_ro() may allocate memory, leading to a
potential deadlock if theye are called while a spin lock is held.

Move the acquisition and release of rbd_dev->lock from rbd_ioctl()
into rbd_ioctl_set_ro(), so it can occur between get_user() and
set_disk_ro().

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   36 +++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 34bcdb7..b3b1b57 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -510,23 +510,42 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
 
 static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
 {
+	int ret = 0;
 	int val;
 	bool ro;
+	bool ro_changed = false;
 
+	/* get_user() may sleep, so call it before taking rbd_dev->lock */
 	if (get_user(val, (int __user *)(arg)))
 		return -EFAULT;
 
+	spin_lock_irq(&rbd_dev->lock);
+	/* prevent others open this device */
+	if (rbd_dev->open_count > 1) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	ro = val ? true : false;
 	/* Snapshot doesn't allow to write*/
-	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !ro)
-		return -EROFS;
+	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !ro) {
+		ret = -EROFS;
+		goto out;
+	}
 
 	if (rbd_dev->mapping.read_only != ro) {
 		rbd_dev->mapping.read_only = ro;
-		set_disk_ro(rbd_dev->disk, ro ? 1 : 0);
+		ro_changed = true;
 	}
 
-	return 0;
+out:
+	spin_unlock_irq(&rbd_dev->lock);
+	/* set_disk_ro() may sleep, so call it after releasing rbd_dev->lock */
+	if (ret == 0 && ro_changed)
+		set_disk_ro(rbd_dev->disk, ro ? 1 : 0);
+
+
+	return ret;
 }
 
 static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
@@ -535,13 +554,6 @@ static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
 	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
 	int ret = 0;
 
-	spin_lock_irq(&rbd_dev->lock);
-	/* prevent others open this device */
-	if (rbd_dev->open_count > 1) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	switch (cmd) {
 	case BLKROSET:
 		ret = rbd_ioctl_set_ro(rbd_dev, arg);
@@ -550,8 +562,6 @@ static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
 		ret = -ENOTTY;
 	}
 
-out:
-	spin_unlock_irq(&rbd_dev->lock);
 	return ret;
 }
 
-- 
1.7.2.5

