From: mchristi@redhat.com
Subject: [PATCH 12/18] target: compare and write backend driver sense handling
Date: Wed, 29 Jul 2015 04:23:49 -0500
Message-ID: <1438161835-27960-12-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

Currently, backend drivers seem to only fail IO with
SAM_STAT_CHECK_CONDITION which gets us
TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE.
For compare and write support we will want to be able to fail with
TCM_MISCOMPARE_VERIFY. This patch adds a new helper that allows backend
drivers to fail with specific sense codes.

It also allows the backend driver to set the miscompare offset.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/target/target_core_transport.c | 33 ++++++++++++++++++++++++++++-----
 include/target/target_core_backend.h   |  1 +
 include/target/target_core_base.h      |  5 ++++-
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index ce8574b..f9b0527 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -639,8 +639,7 @@ static void target_complete_failure_work(struct work_struct *work)
 {
 	struct se_cmd *cmd = container_of(work, struct se_cmd, work);
 
-	transport_generic_request_failure(cmd,
-			TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE);
+	transport_generic_request_failure(cmd, cmd->sense_reason);
 }
 
 /*
@@ -666,14 +665,15 @@ static unsigned char *transport_get_sense_buffer(struct se_cmd *cmd)
 	return cmd->sense_buffer;
 }
 
-void target_complete_cmd(struct se_cmd *cmd, u8 scsi_status)
+static void __target_complete_cmd(struct se_cmd *cmd, u8 scsi_status,
+				  sense_reason_t sense_reason)
 {
 	struct se_device *dev = cmd->se_dev;
 	int success = scsi_status == GOOD;
 	unsigned long flags;
 
 	cmd->scsi_status = scsi_status;
-
+	cmd->sense_reason = sense_reason;
 
 	spin_lock_irqsave(&cmd->t_state_lock, flags);
 	cmd->transport_state &= ~CMD_T_BUSY;
@@ -716,8 +716,22 @@ void target_complete_cmd(struct se_cmd *cmd, u8 scsi_status)
 
 	queue_work(target_completion_wq, &cmd->work);
 }
+
+void target_complete_cmd(struct se_cmd *cmd, u8 scsi_status)
+{
+	__target_complete_cmd(cmd, scsi_status, scsi_status ?
+			     TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE :
+			     TCM_NO_SENSE);
+}
 EXPORT_SYMBOL(target_complete_cmd);
 
+void target_complete_cmd_with_sense(struct se_cmd *cmd,
+				    sense_reason_t sense_reason)
+{
+	__target_complete_cmd(cmd, SAM_STAT_CHECK_CONDITION, sense_reason);
+}
+EXPORT_SYMBOL(target_complete_cmd_with_sense);
+
 void target_complete_cmd_with_length(struct se_cmd *cmd, u8 scsi_status, int length)
 {
 	if (scsi_status == SAM_STAT_GOOD && length < cmd->data_length) {
@@ -1650,6 +1664,7 @@ void transport_generic_request_failure(struct se_cmd *cmd,
 	case TCM_LOGICAL_BLOCK_GUARD_CHECK_FAILED:
 	case TCM_LOGICAL_BLOCK_APP_TAG_CHECK_FAILED:
 	case TCM_LOGICAL_BLOCK_REF_TAG_CHECK_FAILED:
+	case TCM_MISCOMPARE_VERIFY:
 		break;
 	case TCM_OUT_OF_RESOURCES:
 		sense_reason = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
@@ -2633,12 +2648,19 @@ void transport_err_sector_info(unsigned char *buffer, sector_t bad_sector)
 	buffer[SPC_ADD_SENSE_LEN_OFFSET] = 0xc;
 	buffer[SPC_DESC_TYPE_OFFSET] = 0; /* Information */
 	buffer[SPC_ADDITIONAL_DESC_LEN_OFFSET] = 0xa;
-	buffer[SPC_VALIDITY_OFFSET] = 0x80;
+	buffer[SPC_CMD_INFO_VALIDITY_OFFSET] = 0x80;
 
 	/* Descriptor Information: failing sector */
 	put_unaligned_be64(bad_sector, &buffer[12]);
 }
 
+static void transport_err_sense_info(unsigned char *buffer, u32 info)
+{
+	buffer[SPC_INFO_VALIDITY_OFFSET] |= 0x80;
+	/* Sense Information */
+	put_unaligned_be32(info, &buffer[3]);
+}
+
 int
 transport_send_check_condition_and_sense(struct se_cmd *cmd,
 		sense_reason_t reason, int from_transport)
@@ -2831,6 +2853,7 @@ transport_send_check_condition_and_sense(struct se_cmd *cmd,
 		/* MISCOMPARE DURING VERIFY OPERATION */
 		buffer[SPC_ASC_KEY_OFFSET] = 0x1d;
 		buffer[SPC_ASCQ_KEY_OFFSET] = 0x00;
+		transport_err_sense_info(buffer, cmd->sense_info);
 		break;
 	case TCM_LOGICAL_BLOCK_GUARD_CHECK_FAILED:
 		/* CURRENT ERROR */
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index ec5a09f..c98f6e6 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -58,6 +58,7 @@ int	transport_backend_register(const struct target_backend_ops *);
 void	target_backend_unregister(const struct target_backend_ops *);
 
 void	target_complete_cmd(struct se_cmd *, u8);
+void	target_complete_cmd_with_sense(struct se_cmd *, sense_reason_t);
 void	target_complete_cmd_with_length(struct se_cmd *, u8, int);
 
 sense_reason_t	spc_parse_cdb(struct se_cmd *cmd, unsigned int *size);
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 17ae2d6..b83a8ec 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -22,11 +22,12 @@
  */
 #define TRANSPORT_SENSE_BUFFER			96
 /* Used by transport_send_check_condition_and_sense() */
+#define SPC_INFO_VALIDITY_OFFSET		0
 #define SPC_SENSE_KEY_OFFSET			2
 #define SPC_ADD_SENSE_LEN_OFFSET		7
 #define SPC_DESC_TYPE_OFFSET			8
 #define SPC_ADDITIONAL_DESC_LEN_OFFSET		9
-#define SPC_VALIDITY_OFFSET			10
+#define SPC_CMD_INFO_VALIDITY_OFFSET		10
 #define SPC_ASC_KEY_OFFSET			12
 #define SPC_ASCQ_KEY_OFFSET			13
 #define TRANSPORT_IQN_LEN			224
@@ -439,6 +440,8 @@ struct se_dif_v1_tuple {
 #define TCM_ACA_TAG	0x24
 
 struct se_cmd {
+	sense_reason_t		sense_reason;
+	u32			sense_info;
 	/* SAM response code being sent to initiator */
 	u8			scsi_status;
 	u8			scsi_asc;
-- 
1.8.3.1
