From: Guangliang Zhao <guangliang@unitedstack.com>
Subject: [PATCH v3] rbd: add ioctl for rbd
Date: Wed, 18 Sep 2013 14:35:51 +0800
Message-ID: <1379486151-8939-1-git-send-email-guangliang@unitedstack.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51583 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab3IRGgF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Sep 2013 02:36:05 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so7848701pab.22
        for <ceph-devel@vger.kernel.org>; Tue, 17 Sep 2013 23:36:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, josh.durgin@inktank.com, alex.elder@linaro.org, lucienchao@gmail.com

When running the following commands:
    [root@ceph0 mnt]# blockdev --setro /dev/rbd1
    [root@ceph0 mnt]# blockdev --getro /dev/rbd1
    0

The block setro didn't take effect, it is because
the rbd doesn't support ioctl of block driver.

The results with this patch:
root@ceph-client01:~# rbd map img
root@ceph-client01:~# blockdev --getro /dev/rbd1
0
root@ceph-client01:~# cat /sys/block/rbd1/ro
0
root@ceph-client01:~# blockdev --setro /dev/rbd1
root@ceph-client01:~# blockdev --getro /dev/rbd1
1
root@ceph-client01:~# cat /sys/block/rbd1/ro
1
root@ceph-client01:~# dd if=/dev/zero of=/dev/rbd1 count=1
dd: opening `/dev/rbd1': Read-only file system`
root@ceph-client01:~# blockdev --setrw /dev/rbd1
root@ceph-client01:~# blockdev --getro /dev/rbd1
0
root@ceph-client01:~# cat /sys/block/rbd1/ro
0
root@ceph-client01:~# dd if=/dev/zero of=/dev/rbd1 count=1
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.14989 s, 3.4 kB/s

This resolves:
	http://tracker.ceph.com/issues/6265

Signed-off-by: Guangliang Zhao <guangliang@unitedstack.com>
---
 drivers/block/rbd.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2f00778..fea826d 100644
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
-- 
1.7.9.5

