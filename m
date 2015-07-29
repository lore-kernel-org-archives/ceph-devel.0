From: mchristi@redhat.com
Subject: [PATCH 18/18] target: add lio rbd to makefile/Kconfig
Date: Wed, 29 Jul 2015 04:23:55 -0500
Message-ID: <1438161835-27960-18-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbbG2JYJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:24:09 -0400
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

Add lio rbd backend module to target Makefile and Kconfig.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/target/Kconfig  | 6 ++++++
 drivers/target/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/target/Kconfig b/drivers/target/Kconfig
index 2573612..29c51c2 100644
--- a/drivers/target/Kconfig
+++ b/drivers/target/Kconfig
@@ -39,6 +39,12 @@ config TCM_USER2
 	process to handle requests. This is version 2 of the ABI; version 1
 	is obsolete.
 
+config TCM_RBD
+	tristate "TCM/RBD Subsystem Plugin for Linux/RBD"
+	help
+	Say Y here to enable the TCM/RBD subsystem plugin for Ceph RBD
+	access.
+
 source "drivers/target/loopback/Kconfig"
 source "drivers/target/tcm_fc/Kconfig"
 source "drivers/target/iscsi/Kconfig"
diff --git a/drivers/target/Makefile b/drivers/target/Makefile
index e619c02..6011d05 100644
--- a/drivers/target/Makefile
+++ b/drivers/target/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_TCM_IBLOCK)	+= target_core_iblock.o
 obj-$(CONFIG_TCM_FILEIO)	+= target_core_file.o
 obj-$(CONFIG_TCM_PSCSI)		+= target_core_pscsi.o
 obj-$(CONFIG_TCM_USER2)		+= target_core_user.o
+obj-$(CONFIG_TCM_RBD)		+= target_core_rbd.o
 
 # Fabric modules
 obj-$(CONFIG_LOOPBACK_TARGET)	+= loopback/
-- 
1.8.3.1

