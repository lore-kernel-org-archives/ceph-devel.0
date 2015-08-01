From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC PATCH 0/2] target/iscsi: clustered SendTargets handling
Date: Sat, 01 Aug 2015 00:45:18 -0700
Message-ID: <1438415118.16598.33.camel@haakon3.risingtidesystems.com>
References: <1436958019-16937-1-git-send-email-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1436958019-16937-1-git-send-email-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org, mchristi@redhat.com
List-Id: ceph-devel.vger.kernel.org

Hi David,

Apologies for the delayed follow-up on your original patch.

On Wed, 2015-07-15 at 13:00 +0200, David Disseldorp wrote:
> For active/active clustered iSCSI targets (e.g. LIO + Ceph RBD),
> SendTargets responses from any single node should include portal details
> for remote cluster nodes.
> 
> This patch-set adds a TPG discoverable_while_disabled attribute, which
> when set sees LIO include details for a disabled TPG in SendTargets
> responses.
> 
> This allows for the use of a common configuration for cluster nodes,
> with TPGT/enable set on a node specific basis.
> 
> A patch-set to ensure that LIO doesn't listen/accept connections via
> disabled TPGs will follow once I've finished cleaning it up.
> 
> Feedback appreciated.

No objections to adding an attribute to allow disabled TPGs to be
included in sendtargets discovery information, but I think this
particular configfs attribute can use a better name..

How about the following instead..?

--nab

From 688da43134cddb8ff12ab1056c636cf1eb4f4f8f Mon Sep 17 00:00:00 2001
From: David Disseldorp <ddiss@suse.de>
Date: Sat, 1 Aug 2015 00:10:12 -0700
Subject: [PATCH] iscsi-target: Add tpg_enabled_sendtargets for disabled
 discovery

This patch adds a new tpg_enabled_sendtargets configfs attribute
to allow in-band sendtargets discovery information to include
target-portal-groups (TPGs) in !TPG_STATE_ACTIVE state.

This functionality is useful for clustered iSCSI targets, where
TPGTs handled on remote cluster nodes should be advertised in
the SendTargets response.

By default, this new attribute retains the default behaviour of
existing code which to ignore portal-groups in !TPG_STATE_ACTIVE
state.

Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 drivers/target/iscsi/iscsi_target.c          | 10 +++++-----
 drivers/target/iscsi/iscsi_target_configfs.c |  6 ++++++
 drivers/target/iscsi/iscsi_target_tpg.c      | 19 +++++++++++++++++++
 drivers/target/iscsi/iscsi_target_tpg.h      |  1 +
 include/target/iscsi/iscsi_target_core.h     |  3 +++
 5 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index a4cf58c..986518c 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -3398,6 +3398,7 @@ iscsit_build_sendtargets_response(struct iscsi_cmd *cmd,
 	int target_name_printed;
 	unsigned char buf[ISCSI_IQN_LEN+12]; /* iqn + "TargetName=" + \0 */
 	unsigned char *text_in = cmd->text_in_ptr, *text_ptr = NULL;
+	bool active;
 
 	buffer_len = min(conn->conn_ops->MaxRecvDataSegmentLength,
 			 SENDTARGETS_BUF_LIMIT);
@@ -3451,13 +3452,12 @@ iscsit_build_sendtargets_response(struct iscsi_cmd *cmd,
 			}
 
 			spin_lock(&tpg->tpg_state_lock);
-			if ((tpg->tpg_state == TPG_STATE_FREE) ||
-			    (tpg->tpg_state == TPG_STATE_INACTIVE)) {
-				spin_unlock(&tpg->tpg_state_lock);
-				continue;
-			}
+			active = (tpg->tpg_state == TPG_STATE_ACTIVE);
 			spin_unlock(&tpg->tpg_state_lock);
 
+			if (!active && tpg->tpg_attrib.tpg_enabled_sendtargets)
+				continue;
+
 			spin_lock(&tpg->tpg_np_lock);
 			list_for_each_entry(tpg_np, &tpg->tpg_gnp_list,
 						tpg_np_list) {
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index c1898c8..05f1664 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1010,6 +1010,11 @@ TPG_ATTR(t10_pi, S_IRUGO | S_IWUSR);
  */
 DEF_TPG_ATTRIB(fabric_prot_type);
 TPG_ATTR(fabric_prot_type, S_IRUGO | S_IWUSR);
+/*
+ * Define iscsi_tpg_attrib_s_tpg_enabled_sendtargets
+ */
+DEF_TPG_ATTRIB(tpg_enabled_sendtargets);
+TPG_ATTR(tpg_enabled_sendtargets, S_IRUGO | S_IWUSR);
 
 static struct configfs_attribute *lio_target_tpg_attrib_attrs[] = {
 	&iscsi_tpg_attrib_authentication.attr,
@@ -1024,6 +1029,7 @@ static struct configfs_attribute *lio_target_tpg_attrib_attrs[] = {
 	&iscsi_tpg_attrib_default_erl.attr,
 	&iscsi_tpg_attrib_t10_pi.attr,
 	&iscsi_tpg_attrib_fabric_prot_type.attr,
+	&iscsi_tpg_attrib_tpg_enabled_sendtargets.attr,
 	NULL,
 };
 
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 968068f..8262a85 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -226,6 +226,7 @@ static void iscsit_set_default_tpg_attribs(struct iscsi_portal_group *tpg)
 	a->default_erl = TA_DEFAULT_ERL;
 	a->t10_pi = TA_DEFAULT_T10_PI;
 	a->fabric_prot_type = TA_DEFAULT_FABRIC_PROT_TYPE;
+	a->tpg_enabled_sendtargets = TA_DEFAULT_TPG_ENABLED_SENDTARGETS;
 }
 
 int iscsit_tpg_add_portal_group(struct iscsi_tiqn *tiqn, struct iscsi_portal_group *tpg)
@@ -892,3 +893,21 @@ int iscsit_ta_fabric_prot_type(
 
 	return 0;
 }
+
+int iscsit_ta_tpg_enabled_sendtargets(
+	struct iscsi_portal_group *tpg,
+	u32 flag)
+{
+	struct iscsi_tpg_attrib *a = &tpg->tpg_attrib;
+
+	if ((flag != 0) && (flag != 1)) {
+		pr_err("Illegal value %d\n", flag);
+		return -EINVAL;
+	}
+
+	a->tpg_enabled_sendtargets = flag;
+	pr_debug("iSCSI_TPG[%hu] - TPG enabled bit required for SendTargets:"
+		" %s\n", tpg->tpgt, (a->tpg_enabled_sendtargets) ? "ON" : "OFF");
+
+	return 0;
+}
diff --git a/drivers/target/iscsi/iscsi_target_tpg.h b/drivers/target/iscsi/iscsi_target_tpg.h
index 95ff5bd..a2790fd 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.h
+++ b/drivers/target/iscsi/iscsi_target_tpg.h
@@ -40,5 +40,6 @@ extern int iscsit_ta_demo_mode_discovery(struct iscsi_portal_group *, u32);
 extern int iscsit_ta_default_erl(struct iscsi_portal_group *, u32);
 extern int iscsit_ta_t10_pi(struct iscsi_portal_group *, u32);
 extern int iscsit_ta_fabric_prot_type(struct iscsi_portal_group *, u32);
+extern int iscsit_ta_tpg_enabled_sendtargets(struct iscsi_portal_group *, u32);
 
 #endif /* ISCSI_TARGET_TPG_H */
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 34117b8..ab46585 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -62,6 +62,8 @@
 /* T10 protection information disabled by default */
 #define TA_DEFAULT_T10_PI		0
 #define TA_DEFAULT_FABRIC_PROT_TYPE	0
+/* TPG status needs to be enabled to return sendtargets discovery endpoint info */
+#define TA_DEFAULT_TPG_ENABLED_SENDTARGETS 1
 
 #define ISCSI_IOV_DATA_BUFFER		5
 
@@ -763,6 +765,7 @@ struct iscsi_tpg_attrib {
 	u32			default_erl;
 	u8			t10_pi;
 	u32			fabric_prot_type;
+	u32			tpg_enabled_sendtargets;
 	struct iscsi_portal_group *tpg;
 };
 
-- 
1.9.1
