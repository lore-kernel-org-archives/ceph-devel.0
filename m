From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mon: fix pg state logging
Date: Mon, 11 Jun 2012 10:33:00 +0800
Message-ID: <1339381980-11571-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32181 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145Ab2FKCdD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Jun 2012 22:33:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

PGMap->num_pg_by_state is a PG state to number of PG in the state
mapping. PGMonitor::update_logger wrongly interprets the mapping.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mon/PGMonitor.cc |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/mon/PGMonitor.cc b/src/mon/PGMonitor.cc
index 97fbb1b..1b0a210 100644
--- a/src/mon/PGMonitor.cc
+++ b/src/mon/PGMonitor.cc
@@ -96,13 +96,13 @@ void PGMonitor::update_logger()
   for (hash_map<int,int>::iterator p = pg_map.num_pg_by_state.begin();
        p != pg_map.num_pg_by_state.end();
        ++p) {
-    if (p->second & PG_STATE_ACTIVE) {
-      active++;
-      if (p->second & PG_STATE_CLEAN)
-	active_clean++;
+    if (p->first & PG_STATE_ACTIVE) {
+      active += p->second;
+      if (p->first & PG_STATE_CLEAN)
+	active_clean += p->second;
     }
-    if (p->second & PG_STATE_PEERING)
-      peering++;
+    if (p->first & PG_STATE_PEERING)
+      peering += p->second;
   }
   mon->cluster_logger->set(l_cluster_num_pg_active_clean, active_clean);
   mon->cluster_logger->set(l_cluster_num_pg_active, active);
-- 
1.7.10.2

