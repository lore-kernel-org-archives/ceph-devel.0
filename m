From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/6] mds: add projected rename's subtree bounds to ESubtreeMap
Date: Mon, 28 Jan 2013 10:28:22 +0800
Message-ID: <1359340106-24257-3-git-send-email-zheng.z.yan@intel.com>
References: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58841 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab3A1C2b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 21:28:31 -0500
In-Reply-To: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5d88075..9ad6919 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2343,11 +2343,17 @@ ESubtreeMap *MDCache::create_subtree_map()
 	  if (oldparent->get_dir_auth() != newparent->get_dir_auth()) {
 	    dout(10) << " creating subtree for " << dir->dirfrag() << dendl;
 	    // if oldparent is auth, subtree is mine; include it.
-	    if (oldparent->get_dir_auth().first == mds->whoami)
+	    if (oldparent->get_dir_auth().first == mds->whoami) {
 	      le->subtrees[dir->dirfrag()].clear();
+	      le->metablob.add_dir_context(dir, EMetaBlob::TO_ROOT);
+	      le->metablob.add_dir(dir, false);
+	    }
 	    // if newparent is auth, subtree is a new bound
-	    if (le->subtrees.count(newparent->dirfrag()))
+	    if (le->subtrees.count(newparent->dirfrag())) {
 	      le->subtrees[newparent->dirfrag()].push_back(dir->dirfrag());  // newparent is auth; new bound
+	      le->metablob.add_dir_context(dir, EMetaBlob::TO_ROOT);
+	      le->metablob.add_dir(dir, false);
+	    }
 	    newparent = dir;
 	}
 	  
-- 
1.7.11.7

