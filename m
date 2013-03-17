From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 36/39] mds: try merging subtree after clear EXPORTBOUND
Date: Sun, 17 Mar 2013 22:51:39 +0800
Message-ID: <1363531902-24909-37-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932744Ab3CQOyE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:54:04 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index f563b8d..9cbad87 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1340,10 +1340,6 @@ void Migrator::export_reverse(CDir *dir)
   set<CDir*> bounds;
   cache->get_subtree_bounds(dir, bounds);
 
-  // adjust auth, with possible subtree merge.
-  cache->adjust_subtree_auth(dir, mds->get_nodeid());
-  cache->try_subtree_merge(dir);  // NOTE: may journal subtree_map as side-effect
-
   // remove exporting pins
   list<CDir*> rq;
   rq.push_back(dir);
@@ -1371,6 +1367,10 @@ void Migrator::export_reverse(CDir *dir)
     bd->state_clear(CDir::STATE_EXPORTBOUND);
   }
 
+  // adjust auth, with possible subtree merge.
+  cache->adjust_subtree_auth(dir, mds->get_nodeid());
+  cache->try_subtree_merge(dir);  // NOTE: may journal subtree_map as side-effect
+
   // notify bystanders
   export_notify_abort(dir, bounds);
 
-- 
1.7.11.7

