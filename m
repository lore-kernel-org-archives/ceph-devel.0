From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/4] mds: Send mdsdir as base inode for rejoins
Date: Thu, 25 Oct 2012 20:26:51 +0800
Message-ID: <1351168012-4981-3-git-send-email-zheng.z.yan@intel.com>
References: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50693 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758904Ab2JYM1B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Oct 2012 08:27:01 -0400
In-Reply-To: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Stray dir inodes are no longer base inodes, they are in the mdsdir
and the mdrdir is base inode.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 8598f46..8c83abc 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -3315,10 +3315,9 @@ void MDCache::rejoin_send_rejoins()
 	  p->second->add_scatterlock_state(root);
 	}
       }
-      for (int i = 0; i < NUM_STRAY; ++i) {
-	CInode *s = get_inode(MDS_INO_STRAY(p->first, i)); 
-	if (s)
-	  p->second->add_weak_inode(s->vino());
+      if (CInode *in = get_inode(MDS_INO_MDSDIR(p->first))) { 
+	if (in)
+	  p->second->add_weak_inode(in->vino());
       }
     } else {
       // strong
@@ -3334,15 +3333,14 @@ void MDCache::rejoin_send_rejoins()
 	  p->second->add_scatterlock_state(root);
 	}
       }
-      for (int i = 0; i < NUM_STRAY; ++i) {
-	if (CInode *in = get_inode(MDS_INO_STRAY(p->first, i))) {
-	  p->second->add_weak_inode(in->vino());
-	  p->second->add_strong_inode(in->vino(),
-				      in->get_caps_wanted(),
-				      in->filelock.get_state(),
-				      in->nestlock.get_state(),
-				      in->dirfragtreelock.get_state());
-	}
+
+      if (CInode *in = get_inode(MDS_INO_MDSDIR(p->first))) {
+	p->second->add_weak_inode(in->vino());
+	p->second->add_strong_inode(in->vino(),
+				    in->get_caps_wanted(),
+				    in->filelock.get_state(),
+				    in->nestlock.get_state(),
+				    in->dirfragtreelock.get_state());
       }
     }
   }  
-- 
1.7.11.7

