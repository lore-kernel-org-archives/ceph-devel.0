From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 2/2] target/iscsi: discoverable_while_disabled SendTargets
Date: Wed, 15 Jul 2015 13:00:19 +0200
Message-ID: <1436958019-16937-3-git-send-email-ddiss@suse.de>
References: <1436958019-16937-1-git-send-email-ddiss@suse.de>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1436958019-16937-1-git-send-email-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: target-devel@vger.kernel.org, mchristi@redhat.com, David Disseldorp <ddiss@suse.de>
List-Id: ceph-devel.vger.kernel.org

If the discoverable_while_disabled TPGT attribute is set, then add a
corresponding entry to the SendTargets response, regardless of whether
the TPGT is enabled or not.

This functionality is usefull for clustered iSCSI targets, where TPGTs
handled on remote cluster nodes should be advertised in the SendTargets
response.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/iscsi/iscsi_target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 4e68b62..affc4f0 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -3453,7 +3453,8 @@ iscsit_build_sendtargets_response(struct iscsi_cmd *cmd,
 
 			spin_lock(&tpg->tpg_state_lock);
 			if ((tpg->tpg_state == TPG_STATE_FREE) ||
-			    (tpg->tpg_state == TPG_STATE_INACTIVE)) {
+			    ((tpg->tpg_state == TPG_STATE_INACTIVE)
+		       && (tpg->tpg_attrib.discoverable_while_disabled == 0))) {
 				spin_unlock(&tpg->tpg_state_lock);
 				continue;
 			}
-- 
2.1.4
