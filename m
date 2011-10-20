From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [RFC PATCH v3 3/4] qemu: pass virConnectPtr into Domain{Attach,Detach}*
Date: Thu, 20 Oct 2011 11:01:26 -0700
Message-ID: <4e26cbcba8e3c97941311abbc172b894626b8f96.1319072460.git.josh.durgin@dreamhost.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38050 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab1JTSBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2011 14:01:54 -0400
In-Reply-To: <cover.1319072460.git.josh.durgin@dreamhost.com>
In-Reply-To: <cover.1319072460.git.josh.durgin@dreamhost.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, berrange@redhat.com

From: Sage Weil <sage@newdream.net>

The qemu RBD driver needs access to the conn in order to get the secret
needed for connecting to the ceph cluster.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 src/qemu/qemu_command.c |    5 +++--
 src/qemu/qemu_command.h |    3 ++-
 src/qemu/qemu_driver.c  |   17 ++++++++---------
 src/qemu/qemu_hotplug.c |   15 +++++++++------
 src/qemu/qemu_hotplug.h |    9 ++++++---
 5 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
index 30c0be6..4dfce88 100644
--- a/src/qemu/qemu_command.c
+++ b/src/qemu/qemu_command.c
@@ -1491,7 +1491,8 @@ qemuSafeSerialParamValue(const char *value)
 
 
 char *
-qemuBuildDriveStr(virDomainDiskDefPtr disk,
+qemuBuildDriveStr(virConnectPtr conn,
+                  virDomainDiskDefPtr disk,
                   bool bootable,
                   virBitmapPtr qemuCaps)
 {
@@ -3908,7 +3909,7 @@ qemuBuildCommandLine(virConnectPtr conn,
                     deviceFlagMasked = true;
                 }
             }
-            optstr = qemuBuildDriveStr(disk,
+            optstr = qemuBuildDriveStr(conn, disk,
                                        emitBootindex ? false : !!bootindex,
                                        qemuCaps);
             if (deviceFlagMasked)
diff --git a/src/qemu/qemu_command.h b/src/qemu/qemu_command.h
index 00e58a2..cd0c850 100644
--- a/src/qemu/qemu_command.h
+++ b/src/qemu/qemu_command.h
@@ -75,7 +75,8 @@ char *qemuDeviceDriveHostAlias(virDomainDiskDefPtr disk,
                                virBitmapPtr qemuCaps);
 
 /* Both legacy & current support */
-char *qemuBuildDriveStr(virDomainDiskDefPtr disk,
+char *qemuBuildDriveStr(virConnectPtr conn,
+                        virDomainDiskDefPtr disk,
                         bool bootable,
                         virBitmapPtr qemuCaps);
 char *qemuBuildFSStr(virDomainFSDefPtr fs,
diff --git a/src/qemu/qemu_driver.c b/src/qemu/qemu_driver.c
index 84ef4dd..4b707d1 100644
--- a/src/qemu/qemu_driver.c
+++ b/src/qemu/qemu_driver.c
@@ -5038,7 +5038,8 @@ qemudDomainUndefine(virDomainPtr dom)
 }
 
 static int
-qemuDomainAttachDeviceDiskLive(struct qemud_driver *driver,
+qemuDomainAttachDeviceDiskLive(virConnectPtr conn,
+                               struct qemud_driver *driver,
                                virDomainObjPtr vm,
                                virDomainDeviceDefPtr dev)
 {
@@ -5070,12 +5071,12 @@ qemuDomainAttachDeviceDiskLive(struct qemud_driver *driver,
         break;
     case VIR_DOMAIN_DISK_DEVICE_DISK:
         if (disk->bus == VIR_DOMAIN_DISK_BUS_USB)
-            ret = qemuDomainAttachUsbMassstorageDevice(driver, vm,
+            ret = qemuDomainAttachUsbMassstorageDevice(conn, driver, vm,
                                                        disk);
         else if (disk->bus == VIR_DOMAIN_DISK_BUS_VIRTIO)
-            ret = qemuDomainAttachPciDiskDevice(driver, vm, disk);
+            ret = qemuDomainAttachPciDiskDevice(conn, driver, vm, disk);
         else if (disk->bus == VIR_DOMAIN_DISK_BUS_SCSI)
-            ret = qemuDomainAttachSCSIDisk(driver, vm, disk);
+            ret = qemuDomainAttachSCSIDisk(conn, driver, vm, disk);
         else
             qemuReportError(VIR_ERR_CONFIG_UNSUPPORTED,
                             _("disk bus '%s' cannot be hotplugged."),
@@ -5131,7 +5132,7 @@ qemuDomainAttachDeviceLive(virDomainObjPtr vm,
     switch (dev->type) {
     case VIR_DOMAIN_DEVICE_DISK:
         qemuDomainObjCheckDiskTaint(driver, vm, dev->data.disk, -1);
-        ret = qemuDomainAttachDeviceDiskLive(driver, vm, dev);
+        ret = qemuDomainAttachDeviceDiskLive(dom->conn, driver, vm, dev);
         if (!ret)
             dev->data.disk = NULL;
         break;
@@ -5692,8 +5693,7 @@ static int qemuDomainAttachDeviceFlags(virDomainPtr dom, const char *xml,
 
 static int qemuDomainAttachDevice(virDomainPtr dom, const char *xml)
 {
-    return qemuDomainAttachDeviceFlags(dom, xml,
-                                       VIR_DOMAIN_AFFECT_LIVE);
+    return qemuDomainAttachDeviceFlags(dom, xml, VIR_DOMAIN_AFFECT_LIVE);
 }
 
 
@@ -5712,8 +5712,7 @@ static int qemuDomainDetachDeviceFlags(virDomainPtr dom, const char *xml,
 
 static int qemuDomainDetachDevice(virDomainPtr dom, const char *xml)
 {
-    return qemuDomainDetachDeviceFlags(dom, xml,
-                                       VIR_DOMAIN_AFFECT_LIVE);
+    return qemuDomainDetachDeviceFlags(dom, xml, VIR_DOMAIN_AFFECT_LIVE);
 }
 
 static int qemudDomainGetAutostart(virDomainPtr dom,
diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c
index bfa524b..98f9850 100644
--- a/src/qemu/qemu_hotplug.c
+++ b/src/qemu/qemu_hotplug.c
@@ -185,7 +185,8 @@ cleanup:
 }
 
 
-int qemuDomainAttachPciDiskDevice(struct qemud_driver *driver,
+int qemuDomainAttachPciDiskDevice(virConnectPtr conn,
+                                  struct qemud_driver *driver,
                                   virDomainObjPtr vm,
                                   virDomainDiskDefPtr disk)
 {
@@ -221,7 +222,7 @@ int qemuDomainAttachPciDiskDevice(struct qemud_driver *driver,
         if (qemuAssignDeviceDiskAlias(disk, priv->qemuCaps) < 0)
             goto error;
 
-        if (!(drivestr = qemuBuildDriveStr(disk, false, priv->qemuCaps)))
+        if (!(drivestr = qemuBuildDriveStr(conn, disk, false, priv->qemuCaps)))
             goto error;
 
         if (!(devstr = qemuBuildDriveDevStr(disk, 0, priv->qemuCaps)))
@@ -414,7 +415,8 @@ qemuDomainFindOrCreateSCSIDiskController(struct qemud_driver *driver,
 }
 
 
-int qemuDomainAttachSCSIDisk(struct qemud_driver *driver,
+int qemuDomainAttachSCSIDisk(virConnectPtr conn,
+                             struct qemud_driver *driver,
                              virDomainObjPtr vm,
                              virDomainDiskDefPtr disk)
 {
@@ -458,7 +460,7 @@ int qemuDomainAttachSCSIDisk(struct qemud_driver *driver,
             goto error;
     }
 
-    if (!(drivestr = qemuBuildDriveStr(disk, false, priv->qemuCaps)))
+    if (!(drivestr = qemuBuildDriveStr(conn, disk, false, priv->qemuCaps)))
         goto error;
 
     for (i = 0 ; i <= disk->info.addr.drive.controller ; i++) {
@@ -537,7 +539,8 @@ error:
 }
 
 
-int qemuDomainAttachUsbMassstorageDevice(struct qemud_driver *driver,
+int qemuDomainAttachUsbMassstorageDevice(virConnectPtr conn,
+                                         struct qemud_driver *driver,
                                          virDomainObjPtr vm,
                                          virDomainDiskDefPtr disk)
 {
@@ -574,7 +577,7 @@ int qemuDomainAttachUsbMassstorageDevice(struct qemud_driver *driver,
     if (qemuCapsGet(priv->qemuCaps, QEMU_CAPS_DEVICE)) {
         if (qemuAssignDeviceDiskAlias(disk, priv->qemuCaps) < 0)
             goto error;
-        if (!(drivestr = qemuBuildDriveStr(disk, false, priv->qemuCaps)))
+        if (!(drivestr = qemuBuildDriveStr(conn, disk, false, priv->qemuCaps)))
             goto error;
         if (!(devstr = qemuBuildDriveDevStr(disk, 0, priv->qemuCaps)))
             goto error;
diff --git a/src/qemu/qemu_hotplug.h b/src/qemu/qemu_hotplug.h
index aaaed88..8353f14 100644
--- a/src/qemu/qemu_hotplug.h
+++ b/src/qemu/qemu_hotplug.h
@@ -33,16 +33,19 @@ int qemuDomainChangeEjectableMedia(struct qemud_driver *driver,
                                    bool force);
 int qemuDomainCheckEjectableMedia(struct qemud_driver *driver,
                                   virDomainObjPtr vm);
-int qemuDomainAttachPciDiskDevice(struct qemud_driver *driver,
+int qemuDomainAttachPciDiskDevice(virConnectPtr conn,
+                                  struct qemud_driver *driver,
                                   virDomainObjPtr vm,
                                   virDomainDiskDefPtr disk);
 int qemuDomainAttachPciControllerDevice(struct qemud_driver *driver,
                                         virDomainObjPtr vm,
                                         virDomainControllerDefPtr controller);
-int qemuDomainAttachSCSIDisk(struct qemud_driver *driver,
+int qemuDomainAttachSCSIDisk(virConnectPtr conn,
+                             struct qemud_driver *driver,
                              virDomainObjPtr vm,
                              virDomainDiskDefPtr disk);
-int qemuDomainAttachUsbMassstorageDevice(struct qemud_driver *driver,
+int qemuDomainAttachUsbMassstorageDevice(virConnectPtr conn,
+                                         struct qemud_driver *driver,
                                          virDomainObjPtr vm,
                                          virDomainDiskDefPtr disk);
 int qemuDomainAttachNetDevice(virConnectPtr conn,
-- 
1.7.1

