From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 16/16] rbd: add force close option
Date: Wed, 24 Aug 2016 15:18:40 +0200
Message-ID: <1472044720-29116-17-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33619 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yw0-f194.google.com with SMTP id z8so793955ywa.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:19:09 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.19.07
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:19:08 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

This adds a force close option, so we can force the unmapping
of a rbd device that is open. If a path/device is blacklisted, apps
like multipathd can map a new device and then unmap the old one.
The unmapping cleanup would then be handled by the generic hotunplug
code paths in multipahd like is done for iSCSI, FC/FCOE, SAS, etc.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd | 10 +++++++---
 drivers/block/rbd.c                     | 35 ++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 6dccbf82fcf4..f208ac58d613 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -6,7 +6,7 @@ Description:
 
 Being used for adding and removing rbd block devices.
 
-Usage: <mon ip addr> <options> <pool name> <rbd image name> [snap name]
+Usage: <mon ip addr> <options> <pool name> <rbd image name> [<snap name>]
 
  $ echo "192.168.0.1 name=admin rbd foo" > /sys/bus/rbd/add
 
@@ -14,9 +14,13 @@ The snapshot name can be "-" or omitted to map the image read/write. A <dev-id>
 will be assigned for any registered block device. If snapshot is used, it will
 be mapped read-only.
 
-Removal of a device:
+Usage: <dev-id> [force]
 
-  $ echo <dev-id> > /sys/bus/rbd/remove
+ $ echo 2 > /sys/bus/rbd/remove
+
+Optional "force" argument which when passed will wait for running requests and
+then unmap the image. Requests sent to the driver after initiating the removal
+will be failed.  (August 2016, since 4.9.)
 
 What:		/sys/bus/rbd/add_single_major
 Date:		December 2013
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8ff2dc872008..35fc1da6c83d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6347,18 +6347,26 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	struct rbd_device *rbd_dev = NULL;
 	struct list_head *tmp;
 	int dev_id;
-	unsigned long ul;
+	char opt_buf[6];
 	bool already = false;
+	bool force = false;
 	int ret;
 
-	ret = kstrtoul(buf, 10, &ul);
-	if (ret)
-		return ret;
-
-	/* convert to int; abort if we lost anything in the conversion */
-	dev_id = (int)ul;
-	if (dev_id != ul)
+	dev_id = -1;
+	opt_buf[0] = '\0';
+	sscanf(buf, "%d %5s", &dev_id, opt_buf);
+	if (dev_id < 0) {
+		pr_err("dev_id out of range\n");
 		return -EINVAL;
+	}
+	if (opt_buf[0] != '\0') {
+		if (!strcmp(opt_buf, "force")) {
+			force = true;
+		} else {
+			pr_err("bad remove option at '%s'\n", opt_buf);
+			return -EINVAL;
+		}
+	}
 
 	ret = -ENOENT;
 	spin_lock(&rbd_dev_list_lock);
@@ -6371,7 +6379,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	}
 	if (!ret) {
 		spin_lock_irq(&rbd_dev->lock);
-		if (rbd_dev->open_count)
+		if (rbd_dev->open_count && !force)
 			ret = -EBUSY;
 		else
 			already = test_and_set_bit(RBD_DEV_FLAG_REMOVING,
@@ -6382,6 +6390,15 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	if (ret < 0 || already)
 		return ret;
 
+	if (force) {
+		/*
+		 * Prevent new IO from being queued and wait for existing
+		 * IO to complete/fail.
+		 */
+		blk_mq_freeze_queue(rbd_dev->disk->queue);
+		blk_set_queue_dying(rbd_dev->disk->queue);
+	}
+
 	down_write(&rbd_dev->lock_rwsem);
 	if (__rbd_is_lock_owner(rbd_dev))
 		rbd_unlock(rbd_dev);
-- 
2.4.3

