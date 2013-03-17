From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/39] mds: fix MDCache::adjust_bounded_subtree_auth()
Date: Sun, 17 Mar 2013 22:51:06 +0800
Message-ID: <1363531902-24909-4-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab3CQOv6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:51:58 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

There are cases that need both create new bound and swallow intervening
subtree. For example: A MDS exports subtree A with bound B and imports
subtree B with bound C at the same time. The MDS crashes, exporting
subtree A fails, but importing subtree B succeed. During recovery, the
MDS may create new bound C and swallow subtree B.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 684e70b..19dc60b 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -980,15 +980,21 @@ void MDCache::adjust_bounded_subtree_auth(CDir *dir, set<CDir*>& bounds, pair<in
       }
       else {
 	dout(10) << "  want bound " << *bound << dendl;
+	CDir *t = get_subtree_root(bound->get_parent_dir());
+	if (subtrees[t].count(bound) == 0) {
+	  assert(t != dir);
+	  dout(10) << "  new bound " << *bound << dendl;
+	  adjust_subtree_auth(bound, t->authority());
+	}
 	// make sure it's nested beneath ambiguous subtree(s)
 	while (1) {
-	  CDir *t = get_subtree_root(bound->get_parent_dir());
-	  if (t == dir) break;
 	  while (subtrees[dir].count(t) == 0)
 	    t = get_subtree_root(t->get_parent_dir());
 	  dout(10) << "  swallowing intervening subtree at " << *t << dendl;
 	  adjust_subtree_auth(t, auth);
 	  try_subtree_merge_at(t);
+	  t = get_subtree_root(bound->get_parent_dir());
+	  if (t == dir) break;
 	}
       }
     }
-- 
1.7.11.7

