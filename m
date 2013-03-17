From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 35/39] mds: clear dirty inode rstat if import fails
Date: Sun, 17 Mar 2013 22:51:38 +0800
Message-ID: <1363531902-24909-36-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932724Ab3CQOyA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:54:00 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc     | 1 +
 src/mds/Migrator.cc | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 34bd8d3..47b6753 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1022,6 +1022,7 @@ void CDir::assimilate_dirty_rstat_inodes()
   for (elist<CInode*>::iterator p = dirty_rstat_inodes.begin_use_current();
        !p.end(); ++p) {
     CInode *in = *p;
+    assert(in->is_auth());
     if (in->is_frozen())
       continue;
 
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 0672d03..f563b8d 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -2052,6 +2052,8 @@ void Migrator::import_reverse(CDir *dir)
 	in->clear_replica_map();
 	if (in->is_dirty()) 
 	  in->mark_clean();
+	in->clear_dirty_rstat();
+
 	in->authlock.clear_gather();
 	in->linklock.clear_gather();
 	in->dirfragtreelock.clear_gather();
-- 
1.7.11.7

