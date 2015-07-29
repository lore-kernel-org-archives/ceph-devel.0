From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 5/5] target/core_sbc: use cluster API hooks for COMPARE AND WRITE
Date: Wed, 29 Jul 2015 03:15:52 +0200
Message-ID: <1438132552-14673-6-git-send-email-ddiss@suse.de>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35685 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbbG2BQB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 21:16:01 -0400
In-Reply-To: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>

If a device cluster API is configured, then defer COMPARE AND WRITE lock
handling to the cluster back-end using the newly added caw_[un]lock()
hooks.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/target_core_sbc.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 751b935..d94aaf4 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -31,6 +31,7 @@
 #include <target/target_core_base.h>
 #include <target/target_core_backend.h>
 #include <target/target_core_fabric.h>
+#include <target/target_core_cluster.h>
 
 #include "target_core_internal.h"
 #include "target_core_ua.h"
@@ -405,6 +406,24 @@ sbc_execute_rw(struct se_cmd *cmd)
 			       cmd->data_direction);
 }
 
+static int
+sbc_caw_lock(struct se_device *dev)
+{
+	if (dev->cluster_api)
+		return dev->cluster_api->caw_lock(dev);
+
+	return down_interruptible(&dev->caw_sem);
+}
+
+static void
+sbc_caw_unlock(struct se_device *dev)
+{
+	if (dev->cluster_api)
+		dev->cluster_api->caw_unlock(dev);
+	else
+		up(&dev->caw_sem);
+}
+
 static sense_reason_t compare_and_write_post(struct se_cmd *cmd, bool success)
 {
 	struct se_device *dev = cmd->se_dev;
@@ -423,7 +442,7 @@ static sense_reason_t compare_and_write_post(struct se_cmd *cmd, bool success)
 	 * Unlock ->caw_sem originally obtained during sbc_compare_and_write()
 	 * before the original READ I/O submission.
 	 */
-	up(&dev->caw_sem);
+	sbc_caw_unlock(dev);
 
 	return TCM_NO_SENSE;
 }
@@ -571,7 +590,7 @@ out:
 	 * In the MISCOMPARE or failure case, unlock ->caw_sem obtained in
 	 * sbc_compare_and_write() before the original READ I/O submission.
 	 */
-	up(&dev->caw_sem);
+	sbc_caw_unlock(dev);
 	kfree(write_sg);
 	kfree(buf);
 	return ret;
@@ -588,11 +607,12 @@ sbc_compare_and_write(struct se_cmd *cmd)
 	 * Submit the READ first for COMPARE_AND_WRITE to perform the
 	 * comparision using SGLs at cmd->t_bidi_data_sg..
 	 */
-	rc = down_interruptible(&dev->caw_sem);
+	rc = sbc_caw_lock(dev);
 	if (rc != 0) {
 		cmd->transport_complete_callback = NULL;
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 	}
+
 	/*
 	 * Reset cmd->data_length to individual block_size in order to not
 	 * confuse backend drivers that depend on this value matching the
@@ -604,7 +624,7 @@ sbc_compare_and_write(struct se_cmd *cmd)
 			      DMA_FROM_DEVICE);
 	if (ret) {
 		cmd->transport_complete_callback = NULL;
-		up(&dev->caw_sem);
+		sbc_caw_unlock(dev);
 		return ret;
 	}
 	/*
-- 
2.1.4

