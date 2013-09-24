From: Guangliang Zhao <guangliang@unitedstack.com>
Subject: [PATCH v4] rbd: add ioctl for rbd
Date: Tue, 24 Sep 2013 11:25:36 +0800
Message-ID: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:43615 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3IXDZk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 23:25:40 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so4038084pbb.28
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 20:25:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: josh.durgin@inktank.com, alex.elder@linaro.org, lucienchao@gmail.com, sage@inktank.com

When running the following commands:
    [root@ceph0 mnt]# blockdev --setro /dev/rbd1
    [root@ceph0 mnt]# blockdev --getro /dev/rbd1
    0

The block setro didn't take effect, it is because
the rbd doesn't support ioctl of block driver.

This resolves:
	http://tracker.ceph.com/issues/6265

Signed-off-by: Guangliang Zhao <guangliang@unitedstack.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2f00778..34bcdb7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -508,10 +508,69 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
 	put_device(&rbd_dev->dev);
 }
 
+static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
+{
+	int val;
+	bool ro;
+
+	if (get_user(val, (int __user *)(arg)))
+		return -EFAULT;
+
+	ro = val ? true : false;
+	/* Snapshot doesn't allow to write*/
+	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !ro)
+		return -EROFS;
+
+	if (rbd_dev->mapping.read_only != ro) {
+		rbd_dev->mapping.read_only = ro;
+		set_disk_ro(rbd_dev->disk, ro ? 1 : 0);
+	}
+
+	return 0;
+}
+
+static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned int cmd, unsigned long arg)
+{
+	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
+	int ret = 0;
+
+	spin_lock_irq(&rbd_dev->lock);
+	/* prevent others open this device */
+	if (rbd_dev->open_count > 1) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	switch (cmd) {
+	case BLKROSET:
+		ret = rbd_ioctl_set_ro(rbd_dev, arg);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+out:
+	spin_unlock_irq(&rbd_dev->lock);
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
@@ -3027,7 +3086,6 @@ static void rbd_request_fn(struct request_queue *q)
 		__releases(q->queue_lock) __acquires(q->queue_lock)
 {
 	struct rbd_device *rbd_dev = q->queuedata;
-	bool read_only = rbd_dev->mapping.read_only;
 	struct request *rq;
 	int result;
 
@@ -3063,7 +3121,7 @@ static void rbd_request_fn(struct request_queue *q)
 
 		if (write_request) {
 			result = -EROFS;
-			if (read_only)
+			if (rbd_dev->mapping.read_only)
 				goto end_request;
 			rbd_assert(rbd_dev->spec->snap_id == CEPH_NOSNAP);
 		}
-- 
1.7.9.5

