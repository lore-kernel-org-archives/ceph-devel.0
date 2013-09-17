From: Guangliang Zhao <guangliang@unitedstack.com>
Subject: [PATCH v2] rbd: add ioctl for rbd
Date: Tue, 17 Sep 2013 15:04:03 +0800
Message-ID: <1379401443-13569-1-git-send-email-guangliang@unitedstack.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35878 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3IQHGD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Sep 2013 03:06:03 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so5184974pdj.34
        for <ceph-devel@vger.kernel.org>; Tue, 17 Sep 2013 00:06:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, josh.durgin@inktank.com, alex.elder@linaro.org, lucienchao@gmail.com

When running the following commands:
    [root@ceph0 mnt]# blockdev --setro /dev/rbd2
    [root@ceph0 mnt]# blockdev --getro /dev/rbd2
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
 drivers/block/rbd.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2f00778..f700f7c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -508,10 +508,65 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
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
+			set_disk_ro(rbd_dev->disk, ro);
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

