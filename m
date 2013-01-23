From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 18/25] mds: fix for MDCache::adjust_bounded_subtree_auth
Date: Wed, 23 Jan 2013 11:08:54 +0800
Message-ID: <1358910541-15535-19-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51770 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab3AWDJV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:21 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

After swallowing extra subtrees, subtree bounds may change, so it
should re-check.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 542f4a6..e951a39 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -999,17 +999,19 @@ void MDCache::adjust_bounded_subtree_auth(CDir *dir, set<CDir*>& bounds, pair<in
     }
   }
   // merge stray bounds?
-  set<CDir*>::iterator p = subtrees[dir].begin();
-  while (p != subtrees[dir].end()) {
-    set<CDir*>::iterator n = p;
-    n++;
-    if (bounds.count(*p) == 0) {
-      CDir *stray = *p;
-      dout(10) << "  swallowing extra subtree at " << *stray << dendl;
-      adjust_subtree_auth(stray, auth);
-      try_subtree_merge_at(stray);
-    }
-    p = n;
+  while (!subtrees[dir].empty()) {
+    set<CDir*> copy = subtrees[dir];
+    for (set<CDir*>::iterator p = copy.begin(); p != copy.end(); p++) {
+      if (bounds.count(*p) == 0) {
+	CDir *stray = *p;
+	dout(10) << "  swallowing extra subtree at " << *stray << dendl;
+	adjust_subtree_auth(stray, auth);
+	try_subtree_merge_at(stray);
+      }
+    }
+    // swallowing subtree may add new subtree bounds
+    if (copy == subtrees[dir])
+      break;
   }
 
   // bound should now match.
-- 
1.7.11.7

