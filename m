From: Guangliang Zhao <guangliang@unitedstack.com>
Subject: [PATCH] rbd: add ioctl for rbd
Date: Mon, 16 Sep 2013 13:42:33 +0800
Message-ID: <1379310153-8799-1-git-send-email-guangliang@unitedstack.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:37202 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab3IPFmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Sep 2013 01:42:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so4957652pad.0
        for <ceph-devel@vger.kernel.org>; Sun, 15 Sep 2013 22:42:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: josh.durgin@inktank.com, alex.elder@linaro.org, lucienchao@gmail.com

When running the following commands:
    [root@ceph0 mnt]# blockdev --setro /dev/rbd2
    [root@ceph0 mnt]# blockdev --getro /dev/rbd2
    0

The block setro didn't take effect, it is because
the rbd doesn't support ioctl of block driver.

This resolves:
	http://tracker.ceph.com/issues/6265

Signed-off-by: Guangliang Zhao <guangliang@unitedstack.com>
---
 drivers/block/rbd.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2f00778..9f2057a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -508,10 +508,64 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
 	put_device(&rbd_dev->dev);
 }
 
+static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned int cmd, unsigned long arg)
+{
+	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
+	int ro, ret = 0;
+
+	BUG_ON(!rbd_dev);
+	spin_lock_irq(&rbd_dev->lock);
+	if (rbd_dev->open_count > 1) {
+		spin_unlock_irq(&rbd_dev->lock);
+		ret = -EBUSY;
+		goto out;
+	}
+	spin_unlock_irq(&rbd_dev->lock);
+
+	switch (cmd) {
+	case BLKROSET:
+		if (get_user(ro, (int __user *)(arg))) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		/* Snapshot doesn't allow to write*/
+		if (rbd_dev->spec->snap_id != CEPH_NOSNAP && ro) {
+			ret = -EROFS;
+			goto out;
+		}
+
+		if (rbd_dev->mapping.read_only != ro) {
+			rbd_dev->mapping.read_only = ro;
+			goto out;
+		}
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+out:
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static int rbd_compat_ioctl(struct block_device *bdev, fmode_t mode,
+				unsigned int cmd, unsigned long arg)
+{
+	return rbd_ioctl(bdev, mode, cmd, arg);
+}
+#endif /* CONFIG_COMPAT */
+
 static const struct block_device_operations rbd_bd_ops = {
 	.owner			= THIS_MODULE,
 	.open			= rbd_open,
 	.release		= rbd_release,
+	.ioctl			= rbd_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= rbd_compat_ioctl,
+#endif
 };
 
 /*
-- 
1.7.9.5

