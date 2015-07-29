From: mchristi@redhat.com
Subject: [PATCH 13/18] target: add COMPARE_AND_WRITE sg creation helper
Date: Wed, 29 Jul 2015 04:23:50 -0500
Message-ID: <1438161835-27960-13-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

bc core and the rbd backend driver want seperate scatterlists
for the write phase of COMPARE_AND_WRITE. This moves the sbc
code to a helper function.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/target/target_core_sbc.c     | 73 ++++++++++++++++++++++++------------
 include/target/target_core_backend.h |  1 +
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 9a001e6..f803068 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -428,12 +428,58 @@ static sense_reason_t compare_and_write_post(struct se_cmd *cmd, bool success)
 	return TCM_NO_SENSE;
 }
 
+/**
+ * sbc_create_compare_and_write_sg - alloc and prep a sg for the write phase
+ * @cmd: se_cmd to copy scatterlist from.
+ *
+ * Takes the cmd's scatterlist and creates a new sg with only the write
+ * portion.
+*/
+struct scatterlist *sbc_create_compare_and_write_sg(struct se_cmd *cmd)
+{
+	struct se_device *dev = cmd->se_dev;
+	unsigned int block_size = dev->dev_attrib.block_size;
+	unsigned int len = cmd->t_task_nolb * block_size;
+	struct scatterlist *write_sg;
+	struct sg_mapping_iter m;
+	int i = 0;
+
+	write_sg = kmalloc(sizeof(struct scatterlist) * cmd->t_data_nents,
+			   GFP_KERNEL);
+	if (!write_sg) {
+		pr_err("Unable to allocate compare_and_write sg\n");
+		return NULL;
+	}
+	sg_init_table(write_sg, cmd->t_data_nents);
+
+	sg_miter_start(&m, cmd->t_data_sg, cmd->t_data_nents, SG_MITER_TO_SG);
+	/*
+	 * Currently assumes NoLB=1 and SGLs are PAGE_SIZE..
+	 */
+	while (len) {
+		sg_miter_next(&m);
+
+		if (block_size < PAGE_SIZE) {
+			sg_set_page(&write_sg[i], m.page, block_size,
+				    block_size);
+		} else {
+			sg_miter_next(&m);
+			sg_set_page(&write_sg[i], m.page, block_size, 0);
+		}
+		len -= block_size;
+		i++;
+	}
+	sg_miter_stop(&m);
+
+	return write_sg;
+}
+EXPORT_SYMBOL(sbc_create_compare_and_write_sg);
+
 static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool success)
 {
 	struct se_device *dev = cmd->se_dev;
 	struct scatterlist *write_sg = NULL, *sg;
 	unsigned char *buf = NULL, *addr;
-	struct sg_mapping_iter m;
 	unsigned int offset = 0, len;
 	unsigned int nlbas = cmd->t_task_nolb;
 	unsigned int block_size = dev->dev_attrib.block_size;
@@ -469,14 +515,12 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 		goto out;
 	}
 
-	write_sg = kmalloc(sizeof(struct scatterlist) * cmd->t_data_nents,
-			   GFP_KERNEL);
+	write_sg = sbc_create_compare_and_write_sg(cmd);
 	if (!write_sg) {
 		pr_err("Unable to allocate compare_and_write sg\n");
 		ret = TCM_OUT_OF_RESOURCES;
 		goto out;
 	}
-	sg_init_table(write_sg, cmd->t_data_nents);
 	/*
 	 * Setup verify and write data payloads from total NumberLBAs.
 	 */
@@ -513,27 +557,6 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 			break;
 	}
 
-	i = 0;
-	len = cmd->t_task_nolb * block_size;
-	sg_miter_start(&m, cmd->t_data_sg, cmd->t_data_nents, SG_MITER_TO_SG);
-	/*
-	 * Currently assumes NoLB=1 and SGLs are PAGE_SIZE..
-	 */
-	while (len) {
-		sg_miter_next(&m);
-
-		if (block_size < PAGE_SIZE) {
-			sg_set_page(&write_sg[i], m.page, block_size,
-				    block_size);
-		} else {
-			sg_miter_next(&m);
-			sg_set_page(&write_sg[i], m.page, block_size,
-				    0);
-		}
-		len -= block_size;
-		i++;
-	}
-	sg_miter_stop(&m);
 	/*
 	 * Save the original SGL + nents values before updating to new
 	 * assignments, to be released in transport_free_pages() ->
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index c98f6e6..d8895e2 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -61,6 +61,7 @@ void	target_complete_cmd(struct se_cmd *, u8);
 void	target_complete_cmd_with_sense(struct se_cmd *, sense_reason_t);
 void	target_complete_cmd_with_length(struct se_cmd *, u8, int);
 
+struct scatterlist *sbc_create_compare_and_write_sg(struct se_cmd *);
 sense_reason_t	spc_parse_cdb(struct se_cmd *cmd, unsigned int *size);
 sense_reason_t	spc_emulate_report_luns(struct se_cmd *cmd);
 sense_reason_t	spc_emulate_inquiry_std(struct se_cmd *, unsigned char *);
-- 
1.8.3.1
