From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH] security: don't try to label network disks
Date: Fri,  9 Dec 2011 19:49:40 -0800
Message-ID: <f80b111522e8dc7069ade8d5aacb4d05c2a8fed2.1323488550.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33928 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1LJDuI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2011 22:50:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org

Network disks don't have paths to be resolved or files to be checked
for ownership. ee3efc41e6233e625aa03003bf3127319ccd546f checked this
for some image label functions, but was partially reverted in a
refactor.  This finishes adding the check to each security driver's
set and restore label methods for images.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 src/security/security_apparmor.c |    3 +++
 src/security/security_dac.c      |    6 ++++++
 src/security/security_selinux.c  |    3 +++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/security/security_apparmor.c b/src/security/security_apparmor.c
index db7e7dc..3a01a21 100644
--- a/src/security/security_apparmor.c
+++ b/src/security/security_apparmor.c
@@ -606,6 +606,9 @@ AppArmorRestoreSecurityImageLabel(virSecurityManagerPtr mgr,
                                   virDomainObjPtr vm,
                                   virDomainDiskDefPtr disk ATTRIBUTE_UNUSED)
 {
+    if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK)
+        return 0;
+
     return reload_profile(mgr, vm, NULL, false);
 }
 
diff --git a/src/security/security_dac.c b/src/security/security_dac.c
index 0e75319..9f8a320 100644
--- a/src/security/security_dac.c
+++ b/src/security/security_dac.c
@@ -180,6 +180,9 @@ virSecurityDACSetSecurityImageLabel(virSecurityManagerPtr mgr,
     if (!priv->dynamicOwnership)
         return 0;
 
+    if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK)
+        return 0;
+
     return virDomainDiskDefForeachPath(disk,
                                        virSecurityManagerGetAllowDiskFormatProbing(mgr),
                                        false,
@@ -199,6 +202,9 @@ virSecurityDACRestoreSecurityImageLabelInt(virSecurityManagerPtr mgr,
     if (!priv->dynamicOwnership)
         return 0;
 
+    if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK)
+        return 0;
+
     /* Don't restore labels on readoly/shared disks, because
      * other VMs may still be accessing these
      * Alternatively we could iterate over all running
diff --git a/src/security/security_selinux.c b/src/security/security_selinux.c
index 78c0d45..6ef61c7 100644
--- a/src/security/security_selinux.c
+++ b/src/security/security_selinux.c
@@ -636,6 +636,9 @@ SELinuxSetSecurityImageLabel(virSecurityManagerPtr mgr,
     if (secdef->norelabel)
         return 0;
 
+    if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK)
+        return 0;
+
     return virDomainDiskDefForeachPath(disk,
                                        allowDiskFormatProbing,
                                        true,
-- 
1.7.1

