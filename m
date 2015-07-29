From: mchristi@redhat.com
Subject: [PATCH 11/18] target: add compare and write callback
Date: Wed, 29 Jul 2015 04:23:48 -0500
Message-ID: <1438161835-27960-11-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

Add a sbc ops callout for compare and write commands, so backends
like rbd which support that commmand can execute it natively.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/target/target_core_sbc.c     | 9 +++++++--
 include/target/target_core_backend.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index e318ddb..9a001e6 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -968,8 +968,13 @@ sbc_parse_cdb(struct se_cmd *cmd, struct sbc_ops *ops)
 		cmd->t_task_lba = get_unaligned_be64(&cdb[2]);
 		cmd->t_task_nolb = sectors;
 		cmd->se_cmd_flags |= SCF_SCSI_DATA_CDB | SCF_COMPARE_AND_WRITE;
-		cmd->execute_cmd = sbc_compare_and_write;
-		cmd->transport_complete_callback = compare_and_write_callback;
+		if (ops->execute_compare_and_write) {
+			cmd->execute_cmd = ops->execute_compare_and_write;
+		} else {
+			cmd->execute_cmd = sbc_compare_and_write;
+			cmd->transport_complete_callback =
+						compare_and_write_callback;
+		}
 		break;
 	case READ_CAPACITY:
 		size = READ_CAP_LEN;
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index 1e5c8f9..ec5a09f 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -51,6 +51,7 @@ struct sbc_ops {
 	sense_reason_t (*execute_write_same)(struct se_cmd *cmd);
 	sense_reason_t (*execute_unmap)(struct se_cmd *cmd,
 				sector_t lba, sector_t nolb);
+	sense_reason_t (*execute_compare_and_write)(struct se_cmd *cmd);
 };
 
 int	transport_backend_register(const struct target_backend_ops *);
-- 
1.8.3.1
