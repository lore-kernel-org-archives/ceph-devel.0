From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 09/14] mds: take export lock set before sending MExportDirDiscover
Date: Tue, 11 Dec 2012 16:30:55 +0800
Message-ID: <1355214660-26354-10-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2LKIbN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:13 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Migrator::export_dir() only check if it can lock the export lock set
but not take the lock set. So someone else can change the path to
the exporting dir and confuse Migrator::handle_export_discover().

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index c157279..5db21cd 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -236,6 +236,8 @@ void Migrator::handle_mds_failure_or_stop(int who)
 	dir->unfreeze_tree();  // cancel the freeze
 	dir->auth_unpin(this);
 	export_state.erase(dir); // clean up
+	export_unlock(dir);
+	export_locks.erase(dir);
 	dir->state_clear(CDir::STATE_EXPORTING);
 	if (export_peer[dir] != who) // tell them.
 	  mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
@@ -663,6 +665,8 @@ void Migrator::export_dir(CDir *dir, int dest)
     dout(7) << "export_dir can't rdlock needed locks, failing." << dendl;
     return;
   }
+  mds->locker->rdlock_take_set(locks);
+  export_locks[dir].swap(locks);
 
   // ok.
   assert(export_state.count(dir) == 0);
@@ -705,6 +709,9 @@ void Migrator::handle_export_discover_ack(MExportDirDiscoverAck *m)
       export_peer[dir] != m->get_source().num()) {
     dout(7) << "must have aborted" << dendl;
   } else {
+    // release locks to avoid deadlock
+    export_unlock(dir);
+    export_locks.erase(dir);
     // freeze the subtree
     export_state[dir] = EXPORT_FREEZING;
     dir->auth_unpin(this);
-- 
1.7.11.7

