From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 31/39] mds: unfreeze subtree if import aborts in PREPPED state
Date: Sun, 17 Mar 2013 22:51:34 +0800
Message-ID: <1363531902-24909-32-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932673Ab3CQOxr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:47 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 143d71e..963706c 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1658,11 +1658,14 @@ void Migrator::handle_export_cancel(MExportDirCancel *m)
     CInode *in = cache->get_inode(df.ino);
     assert(in);
     import_reverse_discovered(df, in);
-  } else if (import_state[df] == IMPORT_PREPPING ||
-	     import_state[df] == IMPORT_PREPPED) {
+  } else if (import_state[df] == IMPORT_PREPPING) {
     CDir *dir = mds->mdcache->get_dirfrag(df);
     assert(dir);
     import_reverse_prepping(dir);
+  } else if (import_state[df] == IMPORT_PREPPED) {
+    CDir *dir = mds->mdcache->get_dirfrag(df);
+    assert(dir);
+    import_reverse_unfreeze(dir);
   } else {
     assert(0 == "got export_cancel in weird state");
   }
-- 
1.7.11.7

