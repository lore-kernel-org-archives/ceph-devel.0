From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 5/7] rbd: add 'minor' sysfs rbd device attribute
Date: Mon, 16 Dec 2013 19:16:31 +0200
Message-ID: <1387214193-18489-6-git-send-email-ilya.dryomov@inktank.com>
References: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:39104 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab3LPRR3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:17:29 -0500
Received: by mail-ea0-f174.google.com with SMTP id b10so2380732eae.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:17:28 -0800 (PST)
In-Reply-To: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Introduce /sys/bus/rbd/devices/<id>/minor sysfs attribute for exporting
rbd whole disk minor numbers.  This is a step towards single-major
device number allocation scheme, but also a good thing on its own.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |    4 ++++
 drivers/block/rbd.c                     |   13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 0a306476424e..17b119c692da 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -33,6 +33,10 @@ major
 
 	The block device major number.
 
+minor
+
+	The block device minor number.  (December 2013, since 3.14.)
+
 name
 
 	The name of the rbd image.
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d250549d27a4..01ed7672a076 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -323,6 +323,7 @@ struct rbd_device {
 	int			dev_id;		/* blkdev unique id */
 
 	int			major;		/* blkdev assigned major */
+	int			minor;
 	struct gendisk		*disk;		/* blkdev's gendisk and rq */
 
 	u32			image_format;	/* Either 1 or 2 */
@@ -3397,7 +3398,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
 		 rbd_dev->dev_id);
 	disk->major = rbd_dev->major;
-	disk->first_minor = 0;
+	disk->first_minor = rbd_dev->minor;
 	disk->fops = &rbd_bd_ops;
 	disk->private_data = rbd_dev;
 
@@ -3469,7 +3470,14 @@ static ssize_t rbd_major_show(struct device *dev,
 		return sprintf(buf, "%d\n", rbd_dev->major);
 
 	return sprintf(buf, "(none)\n");
+}
+
+static ssize_t rbd_minor_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
 
+	return sprintf(buf, "%d\n", rbd_dev->minor);
 }
 
 static ssize_t rbd_client_id_show(struct device *dev,
@@ -3591,6 +3599,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
 static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
 static DEVICE_ATTR(features, S_IRUGO, rbd_features_show, NULL);
 static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
+static DEVICE_ATTR(minor, S_IRUGO, rbd_minor_show, NULL);
 static DEVICE_ATTR(client_id, S_IRUGO, rbd_client_id_show, NULL);
 static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
 static DEVICE_ATTR(pool_id, S_IRUGO, rbd_pool_id_show, NULL);
@@ -3604,6 +3613,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_features.attr,
 	&dev_attr_major.attr,
+	&dev_attr_minor.attr,
 	&dev_attr_client_id.attr,
 	&dev_attr_pool.attr,
 	&dev_attr_pool_id.attr,
@@ -4848,6 +4858,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	if (ret < 0)
 		goto err_out_id;
 	rbd_dev->major = ret;
+	rbd_dev->minor = 0;
 
 	/* Set up the blkdev mapping. */
 
-- 
1.7.10.4

