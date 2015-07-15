From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 1/2] target/iscsi: discoverable_while_disabled TPGT attr
Date: Wed, 15 Jul 2015 13:00:18 +0200
Message-ID: <1436958019-16937-2-git-send-email-ddiss@suse.de>
References: <1436958019-16937-1-git-send-email-ddiss@suse.de>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1436958019-16937-1-git-send-email-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: target-devel@vger.kernel.org, mchristi@redhat.com, David Disseldorp <ddiss@suse.de>
List-Id: ceph-devel.vger.kernel.org

Add a new discoverable_while_disabled target portal group attribute,
which will in future be used to govern whether entries for disabled
TPGTs are present in SendTargets responses.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/iscsi/iscsi_target_configfs.c |  6 ++++++
 drivers/target/iscsi/iscsi_target_tpg.c      | 20 ++++++++++++++++++++
 drivers/target/iscsi/iscsi_target_tpg.h      |  2 ++
 include/target/iscsi/iscsi_target_core.h     |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index c1898c8..0953bac 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1010,6 +1010,11 @@ TPG_ATTR(t10_pi, S_IRUGO | S_IWUSR);
  */
 DEF_TPG_ATTRIB(fabric_prot_type);
 TPG_ATTR(fabric_prot_type, S_IRUGO | S_IWUSR);
+/*
+ * Define iscsi_tpg_attrib_s_discoverable_while_disabled,
+ */
+DEF_TPG_ATTRIB(discoverable_while_disabled);
+TPG_ATTR(discoverable_while_disabled, S_IRUGO | S_IWUSR);
 
 static struct configfs_attribute *lio_target_tpg_attrib_attrs[] = {
 	&iscsi_tpg_attrib_authentication.attr,
@@ -1024,6 +1029,7 @@ static struct configfs_attribute *lio_target_tpg_attrib_attrs[] = {
 	&iscsi_tpg_attrib_default_erl.attr,
 	&iscsi_tpg_attrib_t10_pi.attr,
 	&iscsi_tpg_attrib_fabric_prot_type.attr,
+	&iscsi_tpg_attrib_discoverable_while_disabled.attr,
 	NULL,
 };
 
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 968068f..91c2e7f 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -226,6 +226,7 @@ static void iscsit_set_default_tpg_attribs(struct iscsi_portal_group *tpg)
 	a->default_erl = TA_DEFAULT_ERL;
 	a->t10_pi = TA_DEFAULT_T10_PI;
 	a->fabric_prot_type = TA_DEFAULT_FABRIC_PROT_TYPE;
+	a->discoverable_while_disabled = TA_DEFAULT_DISCOVERABLE_WHILE_DISABLED;
 }
 
 int iscsit_tpg_add_portal_group(struct iscsi_tiqn *tiqn, struct iscsi_portal_group *tpg)
@@ -892,3 +893,22 @@ int iscsit_ta_fabric_prot_type(
 
 	return 0;
 }
+
+int iscsit_ta_discoverable_while_disabled(
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
+	a->discoverable_while_disabled = flag;
+	pr_debug("iSCSI_TPG[%hu] - Discoverable while disabled:"
+		" %s\n", tpg->tpgt, (a->discoverable_while_disabled) ?
+		"ON" : "OFF");
+
+	return 0;
+}
diff --git a/drivers/target/iscsi/iscsi_target_tpg.h b/drivers/target/iscsi/iscsi_target_tpg.h
index 95ff5bd..9aaf66e 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.h
+++ b/drivers/target/iscsi/iscsi_target_tpg.h
@@ -40,5 +40,7 @@ extern int iscsit_ta_demo_mode_discovery(struct iscsi_portal_group *, u32);
 extern int iscsit_ta_default_erl(struct iscsi_portal_group *, u32);
 extern int iscsit_ta_t10_pi(struct iscsi_portal_group *, u32);
 extern int iscsit_ta_fabric_prot_type(struct iscsi_portal_group *, u32);
+extern int iscsit_ta_discoverable_while_disabled(struct iscsi_portal_group *,
+			u32);
 
 #endif /* ISCSI_TARGET_TPG_H */
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 34117b8..0cb7733 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -62,6 +62,7 @@
 /* T10 protection information disabled by default */
 #define TA_DEFAULT_T10_PI		0
 #define TA_DEFAULT_FABRIC_PROT_TYPE	0
+#define TA_DEFAULT_DISCOVERABLE_WHILE_DISABLED 0
 
 #define ISCSI_IOV_DATA_BUFFER		5
 
@@ -763,6 +764,7 @@ struct iscsi_tpg_attrib {
 	u32			default_erl;
 	u8			t10_pi;
 	u32			fabric_prot_type;
+	u32			discoverable_while_disabled;
 	struct iscsi_portal_group *tpg;
 };
 
-- 
2.1.4
