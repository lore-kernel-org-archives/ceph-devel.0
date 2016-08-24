From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 14/16] rbd: add 'snap_id' sysfs rbd device attribute
Date: Wed, 24 Aug 2016 15:18:38 +0200
Message-ID: <1472044720-29116-15-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36534 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yb0-f193.google.com with SMTP id f60so443668ybi.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:19:07 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.19.05
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:19:05 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

Export snap id in sysfs, so tools like multipathd can use it in a uuid.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |  4 ++++
 drivers/block/rbd.c                     | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 9a655f3f4386..7bf8d4fa6f63 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -102,6 +102,10 @@ current_snap
 
 	The current snapshot for which the device is mapped.
 
+snap_id
+
+	The current snapshot's id.  (August 2016, since 4.9.)
+
 parent
 
 	Information identifying the chain of parent images in a layered rbd
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c95104a80065..36ebec19dc20 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4669,6 +4669,14 @@ static ssize_t rbd_snap_show(struct device *dev,
 	return sprintf(buf, "%s\n", rbd_dev->spec->snap_name);
 }
 
+static ssize_t rbd_snap_id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+
+	return sprintf(buf, "%llu\n", rbd_dev->spec->snap_id);
+}
+
 /*
  * For a v2 image, shows the chain of parent images, separated by empty
  * lines.  For v1 images or if there is no parent, shows "(no parent
@@ -4730,6 +4738,7 @@ static DEVICE_ATTR(name, S_IRUGO, rbd_name_show, NULL);
 static DEVICE_ATTR(image_id, S_IRUGO, rbd_image_id_show, NULL);
 static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
 static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
+static DEVICE_ATTR(snap_id, S_IRUGO, rbd_snap_id_show, NULL);
 static DEVICE_ATTR(parent, S_IRUGO, rbd_parent_show, NULL);
 
 static struct attribute *rbd_attrs[] = {
@@ -4745,6 +4754,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_image_id.attr,
 	&dev_attr_current_snap.attr,
+	&dev_attr_snap_id.attr,
 	&dev_attr_parent.attr,
 	&dev_attr_refresh.attr,
 	NULL
-- 
2.4.3

