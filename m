From: mchristi@redhat.com
Subject: [PATCH 2/5] target: add cluster device init hooks
Date: Tue,  5 May 2015 04:56:15 -0500
Message-ID: <1430819778-24483-3-git-send-email-mchristi@redhat.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50275 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757321AbbEEJ4X (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 05:56:23 -0400
In-Reply-To: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This adds the ability for devices like rbd that support clustering
to be able to hook into lio and execute operations across nodes. This
patch just allows a user to specify a module, like rbd, to hook into lio's
device init code.

The next patches will hook it into the device reset support.

Note: we will need support for distributed PRs, but I am still
working on them.

Note2: In this patchset I took the approach is just adding a new
target module that hooks into the places we need to in lio. I made
it se_device based, because I thought we might want to be able to
support clustered files too one day.

Some alternatives are:

1. I could export functions in backend files like target_core_iblock.c,
target_core_file.c, etc then implement my own backend which for rbd would
call the exported functions from target_core_iblock.c and implement
new callouts for operations like lun reset.

For block device specific implementations:
2. I could add callouts to the request_queue or block_device or gendisk,
then we could have lio call those callouts.

3. I could add a new block req type for PRs and resets.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/target/Makefile               |  3 +-
 drivers/target/target_core_cluster.c  | 87 +++++++++++++++++++++++++++++++++++
 drivers/target/target_core_configfs.c | 38 +++++++++++++++
 drivers/target/target_core_device.c   |  4 ++
 include/target/target_core_base.h     |  3 ++
 include/target/target_core_cluster.h  | 33 +++++++++++++
 6 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/target/target_core_cluster.c
 create mode 100644 include/target/target_core_cluster.h

diff --git a/drivers/target/Makefile b/drivers/target/Makefile
index bbb4a7d..f74be30 100644
--- a/drivers/target/Makefile
+++ b/drivers/target/Makefile
@@ -14,7 +14,8 @@ target_core_mod-y		:= target_core_configfs.o \
 				   target_core_ua.o \
 				   target_core_rd.o \
 				   target_core_stat.o \
-				   target_core_xcopy.o
+				   target_core_xcopy.o \
+				   target_core_cluster.o
 
 obj-$(CONFIG_TARGET_CORE)	+= target_core_mod.o
 
diff --git a/drivers/target/target_core_cluster.c b/drivers/target/target_core_cluster.c
new file mode 100644
index 0000000..8dbbd77
--- /dev/null
+++ b/drivers/target/target_core_cluster.c
@@ -0,0 +1,87 @@
+/*
+ * Target core clustered api
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
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/list.h>
+
+#include <target/target_core_base.h>
+#include <target/target_core_cluster.h>
+
+static LIST_HEAD(cluster_api_list);
+static DEFINE_MUTEX(cluster_api_mutex);
+
+int core_cluster_api_register(struct se_cluster_api *api)
+{
+	struct se_cluster_api *a;
+
+	INIT_LIST_HEAD(&api->api_list);
+
+	mutex_lock(&cluster_api_mutex);
+	list_for_each_entry(a, &cluster_api_list, api_list) {
+		if (!strcmp(a->name, api->name)) {
+			pr_err("%p is already registered with duplicate name "
+				"%s, unable to process request\n", a, a->name);
+			mutex_unlock(&cluster_api_mutex);
+			return -EEXIST;
+		}
+	}
+
+	list_add_tail(&api->api_list, &cluster_api_list);
+	mutex_unlock(&cluster_api_mutex);
+	return 0;
+}
+EXPORT_SYMBOL(core_cluster_api_register);
+
+void core_cluster_api_unregister(struct se_cluster_api *api)
+{
+        mutex_lock(&cluster_api_mutex);
+        list_del(&api->api_list);
+        mutex_unlock(&cluster_api_mutex);
+}
+EXPORT_SYMBOL(core_cluster_api_unregister);
+
+int core_cluster_attach(struct se_device *dev, char *name)
+{
+	struct se_cluster_api *api;
+	int ret = -EINVAL;
+
+	mutex_lock(&cluster_api_mutex);
+	list_for_each_entry(api, &cluster_api_list, api_list) {
+		if (!strcmp(api->name, name)) {
+			ret = api->attach_device(dev);
+			if (!ret) {
+				dev->cluster_api = api;
+				if (!try_module_get(api->owner)) {
+					api->detach_device(dev);
+					ret = -EBUSY;
+				}
+			}
+			break;
+		}
+	}
+	mutex_unlock(&cluster_api_mutex);
+	return ret;
+}
+
+void core_cluster_detach(struct se_device *dev)
+{
+	mutex_lock(&cluster_api_mutex);
+	if (dev->cluster_api) {
+		dev->cluster_api->detach_device(dev);
+		module_put(dev->cluster_api->owner);
+		dev->cluster_api = NULL;
+	}
+       mutex_unlock(&cluster_api_mutex);
+}
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 75d89ad..c48f080 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -40,6 +40,7 @@
 #include <target/target_core_base.h>
 #include <target/target_core_backend.h>
 #include <target/target_core_fabric.h>
+#include <target/target_core_cluster.h>
 #include <target/target_core_fabric_configfs.h>
 #include <target/target_core_configfs.h>
 #include <target/configfs_macros.h>
@@ -1762,6 +1763,42 @@ static struct target_core_configfs_attribute target_core_attr_dev_lba_map = {
 	.store	= target_core_store_dev_lba_map,
 };
 
+static ssize_t target_core_store_dev_cluster_api(
+	void *p,
+	const char *page,
+	size_t count)
+{
+	struct se_device *dev = p;
+	char name[16], newline;
+	int ret;
+
+	memset(name, 0, sizeof(name));
+	ret = sscanf(page, "%16s %c", name, &newline);
+	if (!strlen(name))
+		return -EINVAL;
+
+	ret = core_cluster_attach(dev, name);
+	if (ret)
+		return ret;
+	return count;
+}
+
+static ssize_t target_core_show_dev_cluster_api(void *p, char *page)
+{
+	struct se_device *dev = p;
+
+	return snprintf(page, PAGE_SIZE, "%s\n", dev->cluster_api ?
+			dev->cluster_api->name : "none");
+}
+
+static struct target_core_configfs_attribute target_core_attr_dev_cluster_api = {
+	.attr	= { .ca_owner = THIS_MODULE,
+		    .ca_name = "cluster_api",
+		    .ca_mode =  S_IRUGO | S_IWUSR },
+	.show	= target_core_show_dev_cluster_api,
+	.store	= target_core_store_dev_cluster_api,
+};
+
 static struct configfs_attribute *target_core_dev_attrs[] = {
 	&target_core_attr_dev_info.attr,
 	&target_core_attr_dev_control.attr,
@@ -1770,6 +1807,7 @@ static struct configfs_attribute *target_core_dev_attrs[] = {
 	&target_core_attr_dev_enable.attr,
 	&target_core_attr_dev_alua_lu_gp.attr,
 	&target_core_attr_dev_lba_map.attr,
+	&target_core_attr_dev_cluster_api.attr,
 	NULL,
 };
 
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 7faa6ae..3c1ad1d 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -40,6 +40,7 @@
 
 #include <target/target_core_base.h>
 #include <target/target_core_backend.h>
+#include <target/target_core_cluster.h>
 #include <target/target_core_fabric.h>
 
 #include "target_core_internal.h"
@@ -1638,6 +1639,9 @@ void target_free_device(struct se_device *dev)
 
 	WARN_ON(!list_empty(&dev->dev_sep_list));
 
+	if (dev->cluster_api)
+		core_cluster_detach(dev);
+
 	if (dev->dev_flags & DF_CONFIGURED) {
 		destroy_workqueue(dev->tmr_wq);
 
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 672150b..d6653ed 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -818,6 +818,9 @@ struct se_device {
 	struct se_lun		xcopy_lun;
 	/* Protection Information */
 	int			prot_length;
+	/* cluster api template */
+	struct se_cluster_api	*cluster_api;
+	void			*cluster_dev_data;
 };
 
 struct se_hba {
diff --git a/include/target/target_core_cluster.h b/include/target/target_core_cluster.h
new file mode 100644
index 0000000..4860c2e
--- /dev/null
+++ b/include/target/target_core_cluster.h
@@ -0,0 +1,33 @@
+#ifndef TARGET_CORE_CLUSTER_H
+#define TARGET_CORE_CLUSTER_H
+
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+
+struct se_device;
+
+struct se_cluster_api {
+	char *name;
+	struct module *owner;
+	struct list_head api_list;
+
+	int (*attach_device)(struct se_device *dev);
+	int (*detach_device)(struct se_device *dev);
+	/**
+	 * reset_device - stop and cleanup running commands on all nodes.
+	 * @dev: LU's request queue to execute reset for
+	 * @timeout: timeout for reset operation
+	 *
+	 * Return 0 for success or -Exyz error code. If the operation
+	 * takes longer than timeout seconds then -ETIMEDOUT should be returned.
+	 */
+	int (*reset_device)(struct se_device *dev, u32 timeout);
+};
+
+extern int core_cluster_api_register(struct se_cluster_api *);
+extern void core_cluster_api_unregister(struct se_cluster_api *api);
+extern int core_cluster_attach(struct se_device *dev, char *name);
+extern void core_cluster_detach(struct se_device *dev);
+
+#endif
-- 
1.8.3.1

