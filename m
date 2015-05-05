From: mchristi@redhat.com
Subject: [PATCH 3/5] target: lun reset cluster hook into support
Date: Tue,  5 May 2015 04:56:16 -0500
Message-ID: <1430819778-24483-4-git-send-email-mchristi@redhat.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch allows a module to hook into the lun reset support.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/target/target_core_tmr.c    | 18 ++++++++++++++++--
 include/target/target_core_fabric.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index fa5e157..fdaa391 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -33,6 +33,7 @@
 #include <target/target_core_base.h>
 #include <target/target_core_backend.h>
 #include <target/target_core_fabric.h>
+#include <target/target_core_cluster.h>
 #include <target/target_core_configfs.h>
 
 #include "target_core_internal.h"
@@ -323,7 +324,7 @@ static void core_tmr_drain_state_list(
 	}
 }
 
-int core_tmr_lun_reset(
+int target_local_tmr_lun_reset(
         struct se_device *dev,
         struct se_tmr_req *tmr,
         struct list_head *preempt_and_abort_list,
@@ -380,10 +381,23 @@ int core_tmr_lun_reset(
 	}
 
 	atomic_long_inc(&dev->num_resets);
-
 	pr_debug("LUN_RESET: %s for [%s] Complete\n",
 			(preempt_and_abort_list) ? "Preempt" : "TMR",
 			dev->transport->name);
 	return 0;
 }
+EXPORT_SYMBOL(target_local_tmr_lun_reset);
 
+int core_tmr_lun_reset(
+        struct se_device *dev,
+        struct se_tmr_req *tmr,
+        struct list_head *preempt_and_abort_list,
+        struct se_cmd *prout_cmd)
+{
+	if (dev->cluster_api)
+		return dev->cluster_api->reset_device(dev, 0);
+	else
+		return target_local_tmr_lun_reset(dev, tmr,
+						  preempt_and_abort_list,
+						  prout_cmd);
+}
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index 22a4e98e..36fc3ac 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -133,6 +133,9 @@ void	target_wait_for_sess_cmds(struct se_session *);
 
 int	core_alua_check_nonop_delay(struct se_cmd *);
 
+
+int	target_local_tmr_lun_reset(struct se_device *, struct se_tmr_req *,
+		struct list_head *, struct se_cmd *);
 int	core_tmr_alloc_req(struct se_cmd *, void *, u8, gfp_t);
 void	core_tmr_release_req(struct se_tmr_req *);
 int	transport_generic_handle_tmr(struct se_cmd *);
-- 
1.8.3.1
