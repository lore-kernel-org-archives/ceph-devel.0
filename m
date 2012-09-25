From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH v3] mds: Adjust mydir auth when starting MDS that was stopped cleanly
Date: Tue, 25 Sep 2012 13:46:06 +0800
Message-ID: <1348551966-14718-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3345 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab2IYFqJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Sep 2012 01:46:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When starting a MDS that was stopped cleanly, we need manually
adjust mydir's auth. This is because MDS log is empty in this case,
mydir's auth can not be adjusted during log replay.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 1 +
 src/mds/MDS.cc     | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index da3affb..3784b14 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -565,6 +565,7 @@ void MDCache::open_root()
   }
   CDir *mydir = myin->get_or_open_dirfrag(this, frag_t());
   assert(mydir);
+  adjust_subtree_auth(mydir, mds->whoami);
 
   populate_mydir();
 }
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index d0aac30..8ad901a 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1229,10 +1229,10 @@ void MDS::starting_done()
   assert(is_starting());
   request_state(MDSMap::STATE_ACTIVE);
 
+  mdcache->open_root();
+
   // start new segment
   mdlog->start_new_segment(0);
-
-  mdcache->open_root();
 }
 
 
-- 
1.7.11.4

