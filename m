From: mchristi@redhat.com
Subject: [PATCH 5/5] rbd: implment lio cluster api module
Date: Tue,  5 May 2015 04:56:18 -0500
Message-ID: <1430819778-24483-6-git-send-email-mchristi@redhat.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757336AbbEEJ4Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 05:56:25 -0400
In-Reply-To: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This has rbd implement support for the lio cluster api added in the
previous
patches.

The patch is a little messy. In the next revision I will
break it up better. I am mostly trying to make sure that
the module interface is ok here.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/Kconfig    |  12 +++++
 drivers/block/Makefile   |   1 +
 drivers/block/rbd.h      |  51 ++++++++++++++++++
 drivers/block/rbd_main.c |  55 +++++++++++--------
 drivers/block/rbd_tcm.c  | 135 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 233 insertions(+), 21 deletions(-)
 create mode 100644 drivers/block/rbd.h
 create mode 100644 drivers/block/rbd_tcm.c

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1b8094d..d517744 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -548,6 +548,18 @@ config BLK_DEV_RBD
 
 	  If unsure, say N.
 
+config BLK_DEV_RBD_TCM
+       bool "Clustered TCM using Rados block devices (RBD)"
+       depends on BLK_DEV_RBD
+       select TARGET_CORE
+       select TCM_IBLOCK
+       default n
+       help
+         Say Y here if you want to export a RBD device through multiple
+         TCM nodes.
+
+         If unsure, say N.
+
 config BLK_DEV_RSXX
 	tristate "IBM Flash Adapter 900GB Full Height PCIe Device Driver"
 	depends on PCI
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 5ab25b2..354f731 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_BLK_DEV_DRBD)     += drbd/
 
 obj-$(CONFIG_BLK_DEV_RBD)     += rbd.o
 rbd-objs		      := rbd_main.o
+rbd-$(CONFIG_BLK_DEV_RBD_TCM) += rbd_tcm.o
 
 obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
diff --git a/drivers/block/rbd.h b/drivers/block/rbd.h
new file mode 100644
index 0000000..60c6b85
--- /dev/null
+++ b/drivers/block/rbd.h
@@ -0,0 +1,51 @@
+#ifndef __RBD_H
+#define __RBD_H
+
+enum rbd_notify_op {
+	RBD_NOTIFY_OP_ACQUIRED_LOCK	= 0,
+	RBD_NOTIFY_OP_RELEASED_LOCK	= 1,
+	RBD_NOTIFY_OP_REQUEST_LOCK	= 2,
+	RBD_NOTIFY_OP_HEADER_UPDATE	= 3,
+	RBD_NOTIFY_OP_ASYNC_PROGRESS	= 4,
+	RBD_NOTIFY_OP_ASYNC_COMPLETE	= 5,
+	RBD_NOTIFY_OP_FLATTEN		= 6,
+	RBD_NOTIFY_OP_RESIZE		= 7,
+	RBD_NOTIFY_OP_SNAP_CREATE	= 8,
+	RBD_NOTIFY_OP_SCSI_PR_UPDATE	= 9,
+	RBD_NOTIFY_OP_SCSI_LUN_RESET	= 10,
+};
+
+struct rbd_device;
+
+/* rbd.c helpers */
+void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...);
+extern int rbd_obj_notify_scsi_event_sync(struct rbd_device *rbd_dev, u32 event,
+					  u32 notify_timeout);
+extern int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id);
+extern int rbd_attach_tcm_dev(struct rbd_device *rbd_dev, void *data);
+extern int rbd_detach_tcm_dev(struct rbd_device *rbd_dev);
+
+#if defined(CONFIG_TCM_IBLOCK) || defined(CONFIG_TCM_IBLOCK_MODULE)
+
+extern void rbd_tcm_reset_notify_handle(void *data, u64 notify_id);
+extern int rbd_tcm_register(void);
+extern void rbd_tcm_unregister(void);
+
+#else
+
+void rbd_tcm_reset_notify_handle(void *data, u64 notify_id)
+{
+}
+
+int rbd_tcm_register(void)
+{
+	return 0;
+}
+
+void rbd_tcm_unregister(void)
+{
+}
+
+#endif /* CONFIG_TARGET_CORE */
+
+#endif /* __RBD_H */
diff --git a/drivers/block/rbd_main.c b/drivers/block/rbd_main.c
index 1fa4fd0..a15632f 100644
--- a/drivers/block/rbd_main.c
+++ b/drivers/block/rbd_main.c
@@ -48,6 +48,7 @@
 #include <linux/in6.h>
 
 #include "rbd_types.h"
+#include "rbd.h"
 
 #define RBD_DEBUG	/* Activate rbd_assert() calls */
 
@@ -136,21 +137,6 @@ static int atomic_dec_return_safe(atomic_t *v)
 #define DEV_NAME_LEN		32
 #define MAX_INT_FORMAT_WIDTH	((5 * sizeof (int)) / 2 + 1)
 
-enum rbd_notify_op {
-	RBD_NOTIFY_OP_ACQUIRED_LOCK	= 0,
-	RBD_NOTIFY_OP_RELEASED_LOCK	= 1,
-	RBD_NOTIFY_OP_REQUEST_LOCK	= 2,
-	RBD_NOTIFY_OP_HEADER_UPDATE	= 3,
-	RBD_NOTIFY_OP_ASYNC_PROGRESS	= 4,
-	RBD_NOTIFY_OP_ASYNC_COMPLETE	= 5,
-	RBD_NOTIFY_OP_FLATTEN		= 6,
-	RBD_NOTIFY_OP_RESIZE		= 7,
-	RBD_NOTIFY_OP_SNAP_CREATE	= 8,
-	RBD_NOTIFY_OP_SCSI_PR_UPDATE	= 9,
-	RBD_NOTIFY_OP_SCSI_LUN_RESET_START	= 10,
-	RBD_NOTIFY_OP_SCSI_LUN_RESET_COMPLETE	= 11,
-};
-
 /*
  * block device image metadata (in-memory version)
  */
@@ -391,6 +377,9 @@ struct rbd_device {
 	/* sysfs related */
 	struct device		dev;
 	unsigned long		open_count;	/* protected by lock */
+
+	/* LIO mapping */
+	void			*tcm_device;
 };
 
 /*
@@ -506,7 +495,7 @@ static struct device rbd_root_dev = {
 	.release =      rbd_root_dev_release,
 };
 
-static __printf(2, 3)
+__printf(2, 3)
 void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -3075,7 +3064,7 @@ out_err:
 	obj_request_done_set(obj_request);
 }
 
-static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
+int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
 {
 	struct rbd_obj_request *obj_request;
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -3137,6 +3126,12 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
 	switch (notify_op) {
 	case RBD_NOTIFY_OP_SCSI_PR_UPDATE:
 		break;
+	case RBD_NOTIFY_OP_SCSI_LUN_RESET:
+		if (!rbd_dev->tcm_device)
+			goto decode_fail;
+
+		rbd_tcm_reset_notify_handle(rbd_dev->tcm_device, notify_id);
+		break;
 	default:
 		/*
 		 * Until adequate refresh error handling is in place, there is
@@ -3409,9 +3404,8 @@ out:
 	return ret;
 }
 
-static int rbd_obj_notify_scsi_event_sync(struct rbd_device *rbd_dev,
-					  u32 notify_op,
-					  u32 notify_timeout)
+int rbd_obj_notify_scsi_event_sync(struct rbd_device *rbd_dev, u32 notify_op,
+				   u32 notify_timeout)
 {
 	struct rbd_obj_request *obj_request;
 	int ret = -ENOMEM;
@@ -4094,6 +4088,18 @@ static ssize_t rbd_image_refresh(struct device *dev,
 	return size;
 }
 
+int rbd_detach_tcm_dev(struct rbd_device *rbd_dev)
+{
+	rbd_dev->tcm_device = NULL;
+	return 0;
+}
+
+int rbd_attach_tcm_dev(struct rbd_device *rbd_dev, void *data)
+{
+	rbd_dev->tcm_device = data;
+	return 0;
+}
+
 /**
  * rbd_dev_lock - grab rados lock for device
  * @rbd_dev: device to take lock for
@@ -6389,10 +6395,14 @@ static int __init rbd_init(void)
 		}
 	}
 
-	rc = rbd_sysfs_init();
+	rc = rbd_tcm_register();
 	if (rc)
 		goto err_out_blkdev;
 
+	rc = rbd_sysfs_init();
+	if (rc)
+		goto err_out_tcm;
+
 	if (single_major)
 		pr_info("loaded (major %d)\n", rbd_major);
 	else
@@ -6400,6 +6410,8 @@ static int __init rbd_init(void)
 
 	return 0;
 
+err_out_tcm:
+	rbd_tcm_unregister();
 err_out_blkdev:
 	if (single_major)
 		unregister_blkdev(rbd_major, RBD_DRV_NAME);
@@ -6416,6 +6428,7 @@ static void __exit rbd_exit(void)
 	rbd_sysfs_cleanup();
 	if (single_major)
 		unregister_blkdev(rbd_major, RBD_DRV_NAME);
+	rbd_tcm_unregister();
 	destroy_workqueue(rbd_wq);
 	rbd_slab_exit();
 }
diff --git a/drivers/block/rbd_tcm.c b/drivers/block/rbd_tcm.c
new file mode 100644
index 0000000..061fbea
--- /dev/null
+++ b/drivers/block/rbd_tcm.c
@@ -0,0 +1,135 @@
+/*
+ * rbd callouts for clustered target core support
+ *
+ * Copyright (C) 2015 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/blkdev.h>
+#include <linux/workqueue.h>
+
+#include <linux/delay.h>
+
+#include <target/target_core_cluster.h>
+#include <target/target_core_base.h>
+#include <target/target_core_backend.h>
+#include <target/target_core_fabric.h>
+#include <target/target_core_backend.h>
+
+#include "rbd.h"
+
+struct rbd_tcm_device;
+struct rbd_device;
+
+struct rbd_tcm_reset_event {
+	struct work_struct work;
+	struct rbd_tcm_device *rbd_tcm_dev;
+	u64 notify_id;
+};
+
+struct rbd_tcm_device {
+	struct rbd_device *rbd_dev;
+	struct se_device *se_dev;
+
+	struct rbd_tcm_reset_event reset_evt;
+};
+
+static int rbd_tcm_start_reset(struct se_device *se_dev, u32 timeout)
+{
+	struct rbd_tcm_device *rbd_tcm_dev = se_dev->cluster_dev_data;
+	int rc;
+
+	if (!timeout)
+		/* lio wants an infinite timeout */
+		timeout = 300;
+	rc = rbd_obj_notify_scsi_event_sync(rbd_tcm_dev->rbd_dev,
+					    RBD_NOTIFY_OP_SCSI_LUN_RESET,
+					    timeout);
+	if (rc < 0)
+		return -EIO;
+	else
+		return 0;
+}
+
+static void rbd_tcm_reset_event_workfn(struct work_struct *work)
+{
+	struct rbd_tcm_reset_event *evt = container_of(work,
+					struct rbd_tcm_reset_event, work);
+	struct rbd_tcm_device *rbd_tcm_dev = evt->rbd_tcm_dev;
+	struct rbd_device *rbd_dev = rbd_tcm_dev->rbd_dev;
+	int ret;
+
+	/* currently always succeeds since it just waits */
+	target_local_tmr_lun_reset(rbd_tcm_dev->se_dev, NULL, NULL, NULL);
+
+	/* TODO - return a scsi error code in payload when needed */
+	ret = rbd_obj_notify_ack_sync(rbd_dev, evt->notify_id);
+	if (ret)
+		rbd_warn(rbd_dev, "Could not ack reset completion. "
+			 "Error %d",  ret);
+}
+
+void rbd_tcm_reset_notify_handle(void *data, u64 notify_id)
+{
+	struct rbd_tcm_device *rbd_tcm_dev = data;
+
+	cancel_work_sync(&rbd_tcm_dev->reset_evt.work);
+	rbd_tcm_dev->reset_evt.notify_id = notify_id;
+	schedule_work(&rbd_tcm_dev->reset_evt.work);
+}
+
+static int rbd_tcm_detach_device(struct se_device *se_dev)
+{
+	struct request_queue *q = ibock_se_device_to_q(se_dev);
+	struct rbd_tcm_device *rbd_tcm_dev = se_dev->cluster_dev_data;
+
+	cancel_work_sync(&rbd_tcm_dev->reset_evt.work);
+	se_dev->cluster_dev_data = NULL;
+	rbd_detach_tcm_dev(q->queuedata);
+	kfree(rbd_tcm_dev);
+	return 0;
+}
+
+static int rbd_tcm_attach_device(struct se_device *se_dev)
+{
+	struct request_queue *q = ibock_se_device_to_q(se_dev);
+	struct rbd_tcm_device *rbd_tcm_dev;
+
+	rbd_tcm_dev = kzalloc(sizeof(*rbd_tcm_dev), GFP_KERNEL);
+	if (!rbd_tcm_dev)
+		return -ENOMEM;
+	rbd_tcm_dev->rbd_dev = q->queuedata;
+	rbd_tcm_dev->se_dev = se_dev;
+	INIT_WORK(&rbd_tcm_dev->reset_evt.work, rbd_tcm_reset_event_workfn);
+	rbd_tcm_dev->reset_evt.rbd_tcm_dev = rbd_tcm_dev;
+
+	se_dev->cluster_dev_data = rbd_tcm_dev;
+	return rbd_attach_tcm_dev(q->queuedata, rbd_tcm_dev);
+}
+
+static struct se_cluster_api rbd_tcm_template = {
+	.name		= "rbd",
+	.owner		= THIS_MODULE,
+	.reset_device	= rbd_tcm_start_reset,
+	.attach_device	= rbd_tcm_attach_device,
+	.detach_device	= rbd_tcm_detach_device,
+};
+
+int rbd_tcm_register(void)
+{
+	return core_cluster_api_register(&rbd_tcm_template);
+}
+
+void rbd_tcm_unregister(void)
+{
+	core_cluster_api_unregister(&rbd_tcm_template);
+}
-- 
1.8.3.1

