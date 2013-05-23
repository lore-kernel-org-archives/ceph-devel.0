From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/30] mds: adjust subtree auth if import aborts in PREPPED state
Date: Thu, 23 May 2013 16:06:32 +0800
Message-ID: <1369296418-14871-5-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3EWING (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:06 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 565d45d..8103a52 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -397,7 +397,7 @@ void Migrator::handle_mds_failure_or_stop(int who)
 	  cache->get_subtree_bounds(dir, bounds);
 	  import_remove_pins(dir, bounds);
 	  
-	  // adjust auth back to me
+	  // adjust auth back to the exporter
 	  cache->adjust_subtree_auth(dir, import_peer[df]);
 	  cache->try_subtree_merge(dir);   // NOTE: may journal subtree_map as side-effect
 
@@ -1684,6 +1684,12 @@ void Migrator::handle_export_cancel(MExportDirCancel *m)
   } else if (import_state[df] == IMPORT_PREPPED) {
     CDir *dir = mds->mdcache->get_dirfrag(df);
     assert(dir);
+    set<CDir*> bounds;
+    cache->get_subtree_bounds(dir, bounds);
+    import_remove_pins(dir, bounds);
+    // adjust auth back to the exportor
+    cache->adjust_subtree_auth(dir, import_peer[df]);
+    cache->try_subtree_merge(dir);
     import_reverse_unfreeze(dir);
   } else {
     assert(0 == "got export_cancel in weird state");
-- 
1.8.1.4

