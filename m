From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 30/39] mds: check MDS peer's state through mdsmap
Date: Sun, 17 Mar 2013 22:51:33 +0800
Message-ID: <1363531902-24909-31-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932712Ab3CQOxo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:44 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index d626cb1..143d71e 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -238,7 +238,7 @@ void Migrator::handle_mds_failure_or_stop(int who)
 	export_unlock(dir);
 	export_locks.erase(dir);
 	dir->state_clear(CDir::STATE_EXPORTING);
-	if (export_peer[dir] != who) // tell them.
+	if (mds->mdsmap->is_clientreplay_or_active_or_stopping(export_peer[dir])) // tell them.
 	  mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
 	break;
 	
@@ -247,7 +247,7 @@ void Migrator::handle_mds_failure_or_stop(int who)
 	dir->unfreeze_tree();  // cancel the freeze
 	export_state.erase(dir); // clean up
 	dir->state_clear(CDir::STATE_EXPORTING);
-	if (export_peer[dir] != who) // tell them.
+	if (mds->mdsmap->is_clientreplay_or_active_or_stopping(export_peer[dir])) // tell them.
 	  mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
 	break;
 
@@ -278,7 +278,7 @@ void Migrator::handle_mds_failure_or_stop(int who)
 	export_unlock(dir);
 	export_locks.erase(dir);
 	dir->state_clear(CDir::STATE_EXPORTING);
-	if (export_peer[dir] != who) // tell them.
+	if (mds->mdsmap->is_clientreplay_or_active_or_stopping(export_peer[dir])) // tell them.
 	  mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
 	break;
 	
-- 
1.7.11.7

